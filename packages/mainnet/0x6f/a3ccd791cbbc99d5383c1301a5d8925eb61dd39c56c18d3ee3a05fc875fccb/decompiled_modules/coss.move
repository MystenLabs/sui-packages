module 0x6fa3ccd791cbbc99d5383c1301a5d8925eb61dd39c56c18d3ee3a05fc875fccb::coss {
    struct COSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSS>(arg0, 6, b"COSS", b"CROC ON SUI STREET", b"SNAP UP ON SUCCESS, WITH CROC ON SUI STREET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_24_35_df6b274dab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

