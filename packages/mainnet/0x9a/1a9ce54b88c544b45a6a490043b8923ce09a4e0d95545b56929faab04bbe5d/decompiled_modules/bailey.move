module 0x9a1a9ce54b88c544b45a6a490043b8923ce09a4e0d95545b56929faab04bbe5d::bailey {
    struct BAILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAILEY>(arg0, 9, b"BAILEY", b"BaileyDog", b"Your favorite Dog-themed coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c1aaaa3-cf67-4ed1-8d4b-1ba6fb11e1a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAILEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

