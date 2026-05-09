module 0x316c222a7ac1f4d0f69e5bd06b66299377136f9013280f14f2e763ad9b919911::genesis_ai {
    struct GENESIS_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1778363888019-4389d9b5e3ba297410a11afc0b8e101b.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1778363888019-4389d9b5e3ba297410a11afc0b8e101b.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<GENESIS_AI>(arg0, 9, b"GENESIS AI", b"GENESIS AI", b"Genesis AI", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<GENESIS_AI>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENESIS_AI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENESIS_AI>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

