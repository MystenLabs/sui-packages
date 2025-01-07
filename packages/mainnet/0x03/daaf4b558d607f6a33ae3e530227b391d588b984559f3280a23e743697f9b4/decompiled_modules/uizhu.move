module 0x3daaf4b558d607f6a33ae3e530227b391d588b984559f3280a23e743697f9b4::uizhu {
    struct UIZHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIZHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIZHU>(arg0, 6, b"uiZhu", b"Zhu", b"\"May fortune shine upon you like the $uiZhu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_02_36_52_0403ce01_19b8fa79d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIZHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UIZHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

