module 0xa3c6487ef70efae43dfc6a43eb4830bcd0cc278660b9df693d09b9eaf3747569::tupac {
    struct TUPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUPAC>(arg0, 6, b"TUPAC", b"OFFICIAL TUPAC SHAKUR", b"If you can't find something to live for, you best find something to die for", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Photoroom_20250109_020559_e12e2df7e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

