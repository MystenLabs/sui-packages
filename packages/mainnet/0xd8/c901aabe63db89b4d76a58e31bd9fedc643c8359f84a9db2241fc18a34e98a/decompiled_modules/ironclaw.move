module 0xd8c901aabe63db89b4d76a58e31bd9fedc643c8359f84a9db2241fc18a34e98a::ironclaw {
    struct IRONCLAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRONCLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1781019179321-59d09a516e8ad1853fe1dbde7d68a687.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1781019179321-59d09a516e8ad1853fe1dbde7d68a687.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<IRONCLAW>(arg0, 9, b"IRONCLAW", b"IronclawAI", b"IronClawAI", v1, arg1);
        let v4 = v2;
        if (10000000000000 > 0) {
            0x2::coin::mint_and_transfer<IRONCLAW>(&mut v4, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRONCLAW>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IRONCLAW>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

