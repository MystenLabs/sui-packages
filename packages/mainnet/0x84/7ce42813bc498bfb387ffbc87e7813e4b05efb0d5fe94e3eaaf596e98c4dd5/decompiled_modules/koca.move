module 0x847ce42813bc498bfb387ffbc87e7813e4b05efb0d5fe94e3eaaf596e98c4dd5::koca {
    struct KOCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOCA>(arg0, 6, b"KOCA", b"KOKA KOALA", b"KOCA snorts Cocaine for happiness. KOCA KOALA is no ordinary marsupial!  He's the ultimate party animal of the crypto jungle! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8_5c2045034e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

