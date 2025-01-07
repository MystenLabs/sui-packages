module 0x7c831be1822deea75e7d181863e1d4693852002c9dc1d4b131532fe9cde92412::sdidy {
    struct SDIDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDIDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDIDY>(arg0, 6, b"SDIDY", b"SUIDIDDY", b"WANNA PARTY???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIDIIDY_596d1d8a2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDIDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDIDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

