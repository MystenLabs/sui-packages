module 0xdb9a2c62efb8732fbf05e7a0b2690cd492eaa73508a207daa8ca02ac8cef179b::aaafrog {
    struct AAAFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFROG>(arg0, 6, b"aaaFrog", b"SUI aaaFrog", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_40e21d5afd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

