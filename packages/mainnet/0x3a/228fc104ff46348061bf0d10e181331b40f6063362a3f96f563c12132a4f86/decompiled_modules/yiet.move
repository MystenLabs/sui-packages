module 0x3a228fc104ff46348061bf0d10e181331b40f6063362a3f96f563c12132a4f86::yiet {
    struct YIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIET>(arg0, 6, b"YIET", b"YIET BEAR", b"Eat, Sleep, Yiet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2222222_68e6b67335.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

