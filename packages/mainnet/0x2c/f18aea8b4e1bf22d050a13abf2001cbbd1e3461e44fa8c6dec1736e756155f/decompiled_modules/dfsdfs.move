module 0x2cf18aea8b4e1bf22d050a13abf2001cbbd1e3461e44fa8c6dec1736e756155f::dfsdfs {
    struct DFSDFS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DFSDFS>, arg1: 0x2::coin::Coin<DFSDFS>) {
        0x2::coin::burn<DFSDFS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DFSDFS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DFSDFS>>(0x2::coin::mint<DFSDFS>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<DFSDFS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DFSDFS>>(0x2::coin::split<DFSDFS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DFSDFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFSDFS>(arg0, 9, trim_right(b"SDF"), trim_right(b"DFSDFS"), trim_right(b"XXXXX"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreifuyqyuojzd2bfjd2ufw47mgzq333joltxwvqjb5f3wezch5dkqna"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<DFSDFS>>(0x2::coin::mint<DFSDFS>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFSDFS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFSDFS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<DFSDFS>, arg1: 0x2::coin::Coin<DFSDFS>) {
        0x2::coin::join<DFSDFS>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<DFSDFS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DFSDFS>>(0x2::coin::mint<DFSDFS>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

