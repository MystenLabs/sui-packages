module 0xbf368c5a1fd664478a414b6cc6bc90ea43f06b15a8a6e7406294ef6b2acf486f::pnsf {
    struct PNSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNSF>(arg0, 6, b"PNSF", b"PENISFISH", b"Just a bullish, long, hard and erectile fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PENISFISHLFG_2_24a92ce811.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

