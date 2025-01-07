module 0xe748b737372b839ff2bca9fe291b2844f295e1ef8277d7a329a4b7db7780971::kitcatmeme {
    struct KITCATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITCATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITCATMEME>(arg0, 9, b"KITCATMEME", b"Kitcat", b"So wonderfull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d155fde1-a9d1-44e5-b4ee-8820de6baf3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITCATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITCATMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

