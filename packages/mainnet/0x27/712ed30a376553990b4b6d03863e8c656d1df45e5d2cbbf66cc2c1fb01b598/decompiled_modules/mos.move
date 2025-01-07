module 0x27712ed30a376553990b4b6d03863e8c656d1df45e5d2cbbf66cc2c1fb01b598::mos {
    struct MOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOS>(arg0, 6, b"MOS", b"MLS on sui", x"546865206f6666696369616c206d6173636f74206f66206d616a6f72206c656167756520736f63636572206f6e207375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731050070593.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

