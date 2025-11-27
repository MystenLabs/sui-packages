module 0xb064419f29bebff5be05f424e05ecb407654755ae772a8b2e32ace666a27cbcc::upside {
    struct UPSIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPSIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<UPSIDE>(arg0, 6, b"UPSIDE", b"Upside", b"Official Community Token of The Upside ", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRjwCAABXRUJQVlA4IDACAACQEACdASqAAIAAPm02l0kkIyIhIxgIsIANiWMAeDfary/XJ8FB1nyrzgNsB5gP2S6hvnM9Qf+t3sgfpn1nflRavYsO0QHueWKVHouFBwoOFEoY4PCGiQF1iQQMFcnbuSmubcOyaaXnvJ3Tm8gr3J5yX/7DAGxYAoQPQg2BWgXd1UFP1mK8pWPQdYVIIgAA/vxAHVNs7oYlqSfKf9HBAEAhEP4/3eAy/z6pVn2CDYpVVAfuOHq4+mu4vn6eySOGchbs+bqZqT7C5ypC+VWV/VClngoCG835tHtDYegJHKr27xm3Fj1y9i79LiLNIpGiX/Fo5NGn07Eqniw4yYfwz9I8OFtlv5K7zRv7m8ZsQFNYpKaJko5rjhKf9HDoc9FRiA/fGYbM6iVqXlbVuJWLSOBN3yJld3pW920BiC+ySzpue0aJtDB+P9y+rQBtyTIDin+vM68AWAdwJnKHn9U1vAJ4sKlEa4qu1TgAq5yaZvjumpcoGm/h+dLMWWSbI0L8HU4pLrApr9kmrj6TwqiW3V35sj6wE+cZzXX05vlnI0E6iFb0zOfOUzryTLO+/KPkVNWJ5v5HcksBXTburtgz59DA/sR4g/9T7WEBrUXtrM6hXsSb2Bqy2GgFCrtAEkEPjd82y/jQmf5T/Ipobfi+49cvEfkMvPxFe2dg245I50A2K8xb+PnP83Q4YvwW9El2NtHolTMUsOK+8SK9MglilahODpReNVPczAHMgNvIAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPSIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPSIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

