module 0xcdf05008e38d7b3274fb49d91aea1de9bf55be4518f465841ffadbf1701cbbc5::thtear_usdt {
    struct THTEAR_USDT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THTEAR_USDT>, arg1: 0x2::coin::Coin<THTEAR_USDT>) {
        0x2::coin::burn<THTEAR_USDT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THTEAR_USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THTEAR_USDT>>(0x2::coin::mint<THTEAR_USDT>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<THTEAR_USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THTEAR_USDT>>(0x2::coin::split<THTEAR_USDT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: THTEAR_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THTEAR_USDT>(arg0, 9, trim_right(b"USDT"), trim_right(b"Thtear USDT"), trim_right(b"my coin"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreicbmczfunilkzp7c73sl7bfbar2jncttdixne2pvl73powk33x4k4"))), arg1);
        let v2 = v0;
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<THTEAR_USDT>>(0x2::coin::mint<THTEAR_USDT>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THTEAR_USDT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THTEAR_USDT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<THTEAR_USDT>, arg1: 0x2::coin::Coin<THTEAR_USDT>) {
        0x2::coin::join<THTEAR_USDT>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<THTEAR_USDT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THTEAR_USDT>>(0x2::coin::mint<THTEAR_USDT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

