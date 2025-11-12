module 0x32d7d0befd453a59b0bdf70601799c90c353a6f9d54e5f85f88d4affa7b8529a::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SDF>, arg1: 0x2::coin::Coin<SDF>) {
        0x2::coin::burn<SDF>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SDF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDF>>(0x2::coin::mint<SDF>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<SDF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDF>>(0x2::coin::split<SDF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 9, trim_right(b"DFS"), trim_right(b"SDF"), trim_right(b"DFSDF"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreifuyqyuojzd2bfjd2ufw47mgzq333joltxwvqjb5f3wezch5dkqna"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SDF>>(0x2::coin::mint<SDF>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<SDF>, arg1: 0x2::coin::Coin<SDF>) {
        0x2::coin::join<SDF>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<SDF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDF>>(0x2::coin::mint<SDF>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (*0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != 32) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

