module 0xa7e5f9dd28708eafdc006eb4461e953e725810c76ae18193148b4cb1f948e28b::testusdc {
    struct TESTUSDC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTUSDC>, arg1: 0x2::coin::Coin<TESTUSDC>) {
        0x2::coin::burn<TESTUSDC>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTUSDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSDC>>(0x2::coin::mint<TESTUSDC>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<TESTUSDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSDC>>(0x2::coin::split<TESTUSDC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTUSDC>(arg0, 9, trim_right(b"USDC"), trim_right(b"TESTUSDC"), trim_right(b""), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreihyw47yif6zpfe3wrmkca77rjw4enubhcggtwrdwbcgigf2xt7b74"))), arg1);
        let v2 = v0;
        if (1000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSDC>>(0x2::coin::mint<TESTUSDC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTUSDC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<TESTUSDC>, arg1: 0x2::coin::Coin<TESTUSDC>) {
        0x2::coin::join<TESTUSDC>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<TESTUSDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSDC>>(0x2::coin::mint<TESTUSDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

