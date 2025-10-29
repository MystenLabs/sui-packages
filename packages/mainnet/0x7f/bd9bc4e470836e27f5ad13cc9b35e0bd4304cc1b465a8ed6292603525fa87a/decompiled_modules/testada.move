module 0x7fbd9bc4e470836e27f5ad13cc9b35e0bd4304cc1b465a8ed6292603525fa87a::testada {
    struct TESTADA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTADA>, arg1: 0x2::coin::Coin<TESTADA>) {
        0x2::coin::burn<TESTADA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTADA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTADA>>(0x2::coin::mint<TESTADA>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<TESTADA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTADA>>(0x2::coin::split<TESTADA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTADA>(arg0, 9, trim_right(b"ADA"), trim_right(b"TESTADA"), trim_right(b"test coin"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreieuuii5a2l6l27yjloixf3pio4whwf6hgmk4lba3dl6jdxgt2lozm"))), arg1);
        let v2 = v0;
        if (10000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTADA>>(0x2::coin::mint<TESTADA>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTADA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTADA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<TESTADA>, arg1: 0x2::coin::Coin<TESTADA>) {
        0x2::coin::join<TESTADA>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<TESTADA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTADA>>(0x2::coin::mint<TESTADA>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

