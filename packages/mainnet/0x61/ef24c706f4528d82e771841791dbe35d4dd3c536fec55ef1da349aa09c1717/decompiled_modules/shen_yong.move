module 0x61ef24c706f4528d82e771841791dbe35d4dd3c536fec55ef1da349aa09c1717::shen_yong {
    struct SHEN_YONG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHEN_YONG>, arg1: 0x2::coin::Coin<SHEN_YONG>) {
        0x2::coin::burn<SHEN_YONG>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEN_YONG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEN_YONG>>(0x2::coin::mint<SHEN_YONG>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<SHEN_YONG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEN_YONG>>(0x2::coin::split<SHEN_YONG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHEN_YONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEN_YONG>(arg0, 9, trim_right(b"Apiao"), trim_right(b"ShenYong"), trim_right(b""), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b" "))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SHEN_YONG>>(0x2::coin::mint<SHEN_YONG>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEN_YONG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHEN_YONG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<SHEN_YONG>, arg1: 0x2::coin::Coin<SHEN_YONG>) {
        0x2::coin::join<SHEN_YONG>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<SHEN_YONG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEN_YONG>>(0x2::coin::mint<SHEN_YONG>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

