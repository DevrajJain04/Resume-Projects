from django.shortcuts import render
from django.http import JsonResponse
import requests

def pokemon_types(request):
    # Make a request to the PokeAPI to fetch Pokemon types
    api_url = 'https://pokeapi.co/api/v2/type'
    response = requests.get(api_url)

    if response.status_code == 200:
        data = response.json()
        types = []

        # Iterate through each Pokemon type
        for entry in data['results']:
            type_name = entry['name']

            # Make a request to fetch Pokemon data for the current type
            type_url = entry['url']
            type_response = requests.get(type_url)

            if type_response.status_code == 200:
                type_data = type_response.json()
                # Extract and store Pokemon names for the current type
                pokemon_names = [pokemon['pokemon']['name'] for pokemon in type_data['pokemon']]
                types.append({type_name: pokemon_names})
            else:
                types.append({type_name: []})

        return JsonResponse({'types':types})
    else:
        return JsonResponse({'error': 'Failed to fetch Pokemon types'}, status=500)

