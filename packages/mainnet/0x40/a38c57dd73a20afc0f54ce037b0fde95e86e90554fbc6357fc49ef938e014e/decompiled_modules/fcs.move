module 0x40a38c57dd73a20afc0f54ce037b0fde95e86e90554fbc6357fc49ef938e014e::fcs {
    struct FCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCS>(arg0, 6, b"FCS", b"FATCAT", b"FAT CAT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rt5_E9_V_p_400x400_cbb7365a78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

