module 0x25a3fb1ec094a237ceffead5f70a9a80ff7fe8e3d3b2defb4128e8e7e795eebb::beibei {
    struct BEIBEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEIBEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEIBEI>(arg0, 6, b"BEIBEI", b"Bei Bei SUI Network", b"SUI Network BEIBEI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bei_Bei_df2f9c9251.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEIBEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEIBEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

