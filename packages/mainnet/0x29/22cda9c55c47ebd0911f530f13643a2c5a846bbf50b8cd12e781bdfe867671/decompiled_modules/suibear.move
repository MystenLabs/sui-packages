module 0x2922cda9c55c47ebd0911f530f13643a2c5a846bbf50b8cd12e781bdfe867671::suibear {
    struct SUIBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAR>(arg0, 6, b"SUIBEAR", b"SuiBear", b"SUIBEAR intense drive and unflinching conviction will undoubtedly have a long-term impact on the market this season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_02_50_52_7aabec9ae3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

