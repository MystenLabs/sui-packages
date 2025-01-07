module 0xcef077ace7fd079f920f052aa8e59c1f885899d69e6283a43cda354352592bdc::allahuakbar {
    struct ALLAHUAKBAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLAHUAKBAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLAHUAKBAR>(arg0, 6, b"ALLAHUAKBAR", b"SUITAN", b"Allahu Akbar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sultan_b0aaa4bf00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLAHUAKBAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALLAHUAKBAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

