module 0x904a637f7d9a01945b6ae6f4c2fa511ea8245347ee0204e1341b28bcf3c195c4::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"MINI", b"mini", b"mini gang now on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8438_2920ce3f85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

