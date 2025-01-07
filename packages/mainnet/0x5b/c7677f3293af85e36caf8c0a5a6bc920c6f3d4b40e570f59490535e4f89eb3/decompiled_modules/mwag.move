module 0x5bc7677f3293af85e36caf8c0a5a6bc920c6f3d4b40e570f59490535e4f89eb3::mwag {
    struct MWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWAG>(arg0, 6, b"MWAG", b"MWAG ON SUI", b"An unknown force, attracting degenerates, such as FWOGS, DWOGS, and all kinds to unite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_fcc48032e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

