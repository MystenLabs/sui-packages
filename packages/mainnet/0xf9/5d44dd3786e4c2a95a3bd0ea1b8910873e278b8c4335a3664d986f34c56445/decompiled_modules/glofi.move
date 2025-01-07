module 0xf95d44dd3786e4c2a95a3bd0ea1b8910873e278b8c4335a3664d986f34c56445::glofi {
    struct GLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOFI>(arg0, 6, b"GLOFI", b"GOD OF LOFI", b"Don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735930090684.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

