module 0xcc5982d961ca2bdf547d6a2a79c95e2348c6d2608f5f3cb4971b17b5dffad89b::suicap {
    struct SUICAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAP>(arg0, 6, b"SUICAP", b"CAP", b"real token no cap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicap_3165f11a6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

