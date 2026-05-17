module 0x2f838c169071c690206a6f243fa765b14240cc0ac727315de9cd0fa3fd289e50::bepe {
    struct BEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BEPE>(arg0, 6, b"BEPE", b"BEPE ON SUI", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgYEAABXRUJQVlA4IPoDAACQEgCdASpAAEAAPm0ylEekIqIhJhVbsIANiWQAqSfozDFYwkv87TOfs5GbWefQr/QCOd8HOJGs57BbjI/Jp1Me/rL/5flzYKVzwDZz5iqi1AdjsqSPgZ2SIGuOsyju0XUaGshgBkqDlFkFnKbYH7YBmdtxp4/jDFkUZG726/TWaF5rJRSXu0lV9bGORBk294PBTpud7GJNs8bYVvkgAP6gAJ+gxEeetaZhy2egs/o29bRJHd5BbeMR7MVy4zH7XMUULJ/cm1S6MaV//rRtJw3/sVhG3/1Rz3a3Yqava2s840UP5LDV+zbY7sPC20jXqCHk1DfIqibBdZ4PnYiIRoEZrHeLquQp1ZtqMAp51n4ZvHI/xFlZ/zD5AWxo14a3+Ua9ZbmLmD3LVZ1y5aKa9U/IYCcYYO4BLnihgyi9lxVQnMhlmbjxxjAqfu6IKmJl9M6Mo0ZC8cLCa5Rlho7eZdJ2/3V9gGet//V+wf3qmMpcgupKwJUhttEcd8WKHh7pqiaVyZCYtZpLDKYSEHHbq9hhyhkfl4R76FsxEWjK80dB48emu/A/754n5N+r69z1POcgIdPdekq3/6ij3CsGEjFjsD9bwHFn5/OhtXjtW1f6DPc0WxOon4br53Z5e9ydavatAeLIBg6xBrypYnvsZzKb9hE2Ws/wp7XZY41rUSdIfey27BKlmIJS/ygOnb5/mvsL1qWgVvHlU7wAM6UwPI3dbA/RWyt+YPu7JAdWev0blBlf1Jsabap3A94ZnBNMzQ7ib06z1uSoxdE/idlmw08/HsGCigeQeAKVliz8W9+GcUkLPTKzK9H14foAeGlUV6I6vFElHKIajezO5rE3arYIhe8vXI3iK/61fbOH93RUgJWZEc5MkYqda6xZTqTIEVhjSk8D7S2uZwYlCTv/f5EE0aDPd14c/Rg8xIGY4Q2OP6/vu+Im9O30mlfisALcv3JoWYsnAUBX+sfmoe3wqkrkBc8ZgaavOhuPcMEsuscnCnn/d3HZjXtZevikfMMNYP14HA2h64Xrm0CTzU9BFgiem7X+e9vXJ3uC0lXkDzohj4FHFgItWvB/blNYUPSprNmloatDekj3+RhqI4DvMZkEx31b1OvZ1yE0XMKULh1IImBCdkOPbSrRSoUpcbtubEopXAZFodzVvU169VILlCq5fbIRBdKlUz9DpdAtAvmjqQztZco8zbLzbaSud9zC7hpA+6Dlm6g4vcK5TZMVLqJXvCmetmk6e3S15/wNgX0C2EZtc8tMaLeQ6pnhsF+R/JH5OQIr2uJyg6ixZ6x4C/VKeo+UwrHHT1fzZRZgn+oSI5eKo7IxVALFMDFYQjzAuWJITxKrz4enwAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

