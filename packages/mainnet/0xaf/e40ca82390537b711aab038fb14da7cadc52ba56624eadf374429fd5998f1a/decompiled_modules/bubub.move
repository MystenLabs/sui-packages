module 0xafe40ca82390537b711aab038fb14da7cadc52ba56624eadf374429fd5998f1a::bubub {
    struct BUBUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBUB>(arg0, 6, b"BUBUB", b"BUBSUI", b"fter making her online debut in 2011, BUBUB took the world by storm. The adorable felines unique appearance captured hearts and pioneered the internets cat obsession.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BU_7zw2_Gvabhq_Gnrq_MMH_1m2_Kabafehan_Dmtnr_CS_Zipump_copy_55b82837ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

