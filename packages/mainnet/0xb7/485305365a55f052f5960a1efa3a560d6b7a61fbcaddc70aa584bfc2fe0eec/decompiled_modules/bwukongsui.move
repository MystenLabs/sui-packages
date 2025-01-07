module 0xb7485305365a55f052f5960a1efa3a560d6b7a61fbcaddc70aa584bfc2fe0eec::bwukongsui {
    struct BWUKONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWUKONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWUKONGSUI>(arg0, 6, b"BWuKongSUI", b"Black Wukong", b"Black Wukong ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016304_3c0c35fb32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWUKONGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWUKONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

