module 0x39dafd08707c347521bd7293e4d8b6c10bdcec1640fa507df88484ce3cfed63f::peg {
    struct PEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<PEG>(arg0, 6, b"PEG", b"Jpeg", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRvIEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBoAAAABDzD/ERHCTNs2ZlL+DPcFxaSI/gdcVQ28e1ZQOCCyBAAAMBgAnQEqgACAAD5tMpVIJCKiISYWqpiADYlnANbcxr51zeFAORt0F8Ha4kJA5ZQIeRRdDJiVmd8jF3aR5HQJVpeluSzcKXbYy8va3g3gC8nbshAHsc5NzsRz+z9JjxTysZ/4N05TUeojYdAFr+XeWZHW21DVA+n9KBVG96UpPx91IEw7gtu4ELfw8yr5aOehHsK6zdZmVh4+Kf82HsLC0Wg6KUPByLGMOnBh+rK1XvWCCRWY12aQXPZC7VVGSDiXxP62rGxDYBTCAAD+/PhAAe/9wb36+BLcc6QA7C2t2C97G8k03P8yjeLp2ww/zBw4UV+eOnE/XUGc9k/rnyA/6EZqLy6xpUZLVf5mEnGoTjsx8n5RezeT6bvyY7snICvCJs7NRNayOiElP/XqBnux/t3QB9meHdd/+nWHyw3a52deCY/j4XvMOGg5iCpqAfBOnRACH4ODUGRlc++fjSwmrix55s9hG5dnNmtt11B/pbHcoJZHgrv3Gh30ytbK8soj7tCw1l58sBvpN+xjOyQY5YtJRNX3bE5nI+nVDZBy5+MseG0m27Bp78cG/bVkmd5gdfOHXrw/ceglckW9/fhMPMvxZoGyyeMCsJSU5g5ZqqA3uQ2RE+wEzsJkOi9/3lMJdUajGCPHglmlgtJuzASqAMU/4LOvZLtSiKXs7RRbiwwLoZLW3OY63LD6rlPiOQtdKqngxW3zpjCSO5MAPAZHZ7wKADK0eWyIadbiKauraje3cnWKwNlZD3RAnhhIKTgK+RiqBDlkAXdfF5z7Xg/XDAsZPy/TWBWk6M1lz67v8OC/e3VDLmqGnzxsWwnF5zPPVBFOYXT98KNkQoIdtnb126QUtWm2qHnlR/91sVCQB9pdWEOZXsyos291kaiHepKAA8YSRJspifEROnO3hvxljEkzvXcGH3ziflUyyIj9mW/+RxImdy96oYoFNnVqt2MwmtuB6V1gBF6ju6dviifmUgvKh9+i+maYhtG3HJtTd2gFfrEWHQYx+ZKsviiZtMJhUUfgg+j4LKkNVDME+6tUUbfxg8qU6s64k9NV4IyGZkQIq9X8DuiX0hujf/0Df1d8hnpZ6j9vt7rPhdQYWR3DxyYkg1y3v/YqvvIHWlmNTE/ikJ0iNdEgQyXqh8PIOpWlHElm7skus20cz2U5QBZO270wscVfpXn1aWaBV10Rv5e9Fgtih16rJso9uVMAy0qDjVVE/oOxwaZWEZPtaPAtNpjBYdOTEy5B21nfXsZc4sMqPYqP2zdrW2r8GiDTL/Vv4zVrMRgx9kLmyJ4wZUElwqE5YuJls6BaB3lUhjimj0LuhjXijPK2yyWT27eI5uP67+bVTPu6E7LaSeAD42Hd0wvFJSVZGhoYUWOmyircwtMphUaiFRQ9+CpuTJXEyjha/nLxLFlLskfARDMTPplFfokRpBTM/EZ9UqKD1HDx2d391tgx+gmutavnTCnFUEDvkVZoxXhcrUapeBbHyWIxC29wAjvREgeS/LuMLglu8jVadxaEO700zffQAnDtugdfWxOY+i8UHR39g7+AEZV8ZSH7JPdBAxJ/KAv4ygMOenjDu7i5zuVFkMAx3M7gAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

