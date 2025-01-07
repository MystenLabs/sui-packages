module 0xbb7a48bdad6f1c1a084254018cd766de26dbececec13eee24b019b9c4d228def::shibaguard {
    struct SHIBAGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAGUARD>(arg0, 6, b"SHIBAGUARD", b"Peace-seeking Shiba", b"The Guardian Shiba - Protecting Peace in the Crypto Universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4b4e0614_d4c0_4c7a_9c2c_37153a387f88_6431d62a30.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAGUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

