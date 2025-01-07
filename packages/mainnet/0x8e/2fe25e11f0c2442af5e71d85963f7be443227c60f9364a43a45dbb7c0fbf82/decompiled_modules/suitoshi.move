module 0x8e2fe25e11f0c2442af5e71d85963f7be443227c60f9364a43a45dbb7c0fbf82::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"WEAREALLSUITOSHI", x"576520616c6c20617265205361746f7368692020576520616c6c2061726520537569746f7368690a0a5468697320697320796f75722053554954434f494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_3_15_48_PM_2b42ba0a55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

