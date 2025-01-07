module 0x1511bb236ae07d2ef0a1d84dbc8449acef237668a4cb303e56b4ab35e982896::sdmnd {
    struct SDMND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDMND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDMND>(arg0, 6, b"SDMND", b"SUI DIAMOND", b"SUI Diamond is a revolutionary cryptocurrency token deployed on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xa4e825dd94bd236e29f9a0cda6bd45ebe7246300f4825db5349a05d5cc114a87_dmnd_dmnd_5cfa2d58ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDMND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDMND>>(v1);
    }

    // decompiled from Move bytecode v6
}

