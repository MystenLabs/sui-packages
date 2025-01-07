module 0x122600aa4db8f21564f484106126d57147d01099faeb13ce6a4566b8c46c5485::cmoon {
    struct CMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMOON>(arg0, 6, b"CMOON", b"CatMooon", b"CAT MOON FIRST SUI TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_29_at_17_04_17_0e267e9dae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

