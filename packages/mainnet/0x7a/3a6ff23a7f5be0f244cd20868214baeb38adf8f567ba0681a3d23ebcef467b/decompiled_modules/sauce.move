module 0x7a3a6ff23a7f5be0f244cd20868214baeb38adf8f567ba0681a3d23ebcef467b::sauce {
    struct SAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUCE>(arg0, 6, b"SAUCE", b"SuiSauce", b"Sui $Sauce is capturing the palate of the entire space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_M_Rbcz_DE_400x400_cfb20ee4de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

