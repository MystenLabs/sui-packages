module 0x2856f63e745c8f76dff8dbfe6f9744e2542138e195096cc9c79ece4f0193c065::doss {
    struct DOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSS>(arg0, 6, b"DOSs", b"DOGS", b"dog dog dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogssss_be5282e4d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

