from CTFd.cache import cache
from CTFd.utils import _get_asset_json, _get_config

def load(app):
    # Force cahce reload of /utils/_init.py
    cache.delete_memoized(_get_asset_json)
    cache.delete_memoized(_get_config)
    
    return
