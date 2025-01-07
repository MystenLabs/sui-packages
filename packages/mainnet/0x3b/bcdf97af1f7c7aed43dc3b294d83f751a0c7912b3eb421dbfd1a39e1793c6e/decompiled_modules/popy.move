module 0x3bbcdf97af1f7c7aed43dc3b294d83f751a0c7912b3eb421dbfd1a39e1793c6e::popy {
    struct POPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPY>(arg0, 6, b"POPY", b"Sui Popy", b"The king of sea deep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_45_d6278be667.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

