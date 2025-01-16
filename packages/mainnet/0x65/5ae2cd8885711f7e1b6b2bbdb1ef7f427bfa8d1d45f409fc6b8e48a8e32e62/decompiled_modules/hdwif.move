module 0x655ae2cd8885711f7e1b6b2bbdb1ef7f427bfa8d1d45f409fc6b8e48a8e32e62::hdwif {
    struct HDWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDWIF>(arg0, 6, b"HDWIF", b"Headless Dogwifhat", b"Headless dog has been identified. Send it to billions. Tg to follow to filter out the noisy non investors asking for DMs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1410_866c0c494d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

