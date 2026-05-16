module 0x9fb55069615006982a485a7c0c372f5904ec2e662ffc0455d9e46630ae6fb2e1::baby_troll {
    struct BABY_TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1778918196278-7e071dac490b1f7bda2e26857c5614fb.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1778918196278-7e071dac490b1f7bda2e26857c5614fb.jpeg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<BABY_TROLL>(arg0, 9, b"Baby Troll", b"Baby Troll Sui", b"Baby Troll On Sui", v1, arg1);
        let v4 = v2;
        if (100000000000000000 > 0) {
            0x2::coin::mint_and_transfer<BABY_TROLL>(&mut v4, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_TROLL>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABY_TROLL>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

