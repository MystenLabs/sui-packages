module 0xf54e4e7f94ab5bdf0b48a4040787f6f5a3c27db26c4d0158668615f2bfbea513::yana {
    struct YANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YANA>(arg0, 6, b"YANA", x"59414e412062616279206d616d6d6f746820f09fa6a3", b"YANA is inspired by the discovery of a baby mammoth named after the Yana River in Siberia (50,000 years ago)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735018509424.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

