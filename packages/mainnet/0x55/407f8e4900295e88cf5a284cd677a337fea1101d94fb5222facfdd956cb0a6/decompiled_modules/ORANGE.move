module 0x55407f8e4900295e88cf5a284cd677a337fea1101d94fb5222facfdd956cb0a6::ORANGE {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<ORANGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ORANGE>>(0x2::coin::split<ORANGE>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<ORANGE>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ORANGE>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ORANGE>(arg0);
        };
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 9, b"Orange", x"f09f9fa7", b"Orange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/b6nmFqY/png3.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ORANGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ORANGE>>(0x2::coin::mint<ORANGE>(&mut v2, 6500000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

