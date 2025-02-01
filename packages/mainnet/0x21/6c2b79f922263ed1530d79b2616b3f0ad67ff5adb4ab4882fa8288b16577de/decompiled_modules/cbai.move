module 0x216c2b79f922263ed1530d79b2616b3f0ad67ff5adb4ab4882fa8288b16577de::cbai {
    struct CBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBAI>(arg0, 6, b"CBAI", b"Celo Bot AI", b"Celo Bot AI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_01_1f692a1931.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

