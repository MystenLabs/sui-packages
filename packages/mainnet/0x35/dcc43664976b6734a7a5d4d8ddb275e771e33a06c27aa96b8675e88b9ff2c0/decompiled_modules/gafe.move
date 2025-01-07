module 0x35dcc43664976b6734a7a5d4d8ddb275e771e33a06c27aa96b8675e88b9ff2c0::gafe {
    struct GAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAFE>(arg0, 6, b"GaFe", b"CatGarField", b"Cats GarField cutes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_fotor_bg_remover_2024092191053_bba24720bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

