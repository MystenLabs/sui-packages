module 0x3d38612d9a240822ff1d1037847929b9ff2763c9f435cb6669f8da35e689ea09::barra {
    struct BARRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRA>(arg0, 6, b"BARRA", b"Barracuda", b"The Fiercest Fish On Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_1_23_27_PM_39c7062c87.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

