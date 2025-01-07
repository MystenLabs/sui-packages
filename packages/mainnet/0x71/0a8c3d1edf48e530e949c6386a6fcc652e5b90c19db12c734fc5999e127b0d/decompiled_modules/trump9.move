module 0x710a8c3d1edf48e530e949c6386a6fcc652e5b90c19db12c734fc5999e127b0d::trump9 {
    struct TRUMP9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP9>(arg0, 6, b"Trump9", b"trump", b"trump trump trump trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730895505616.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP9>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP9>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

