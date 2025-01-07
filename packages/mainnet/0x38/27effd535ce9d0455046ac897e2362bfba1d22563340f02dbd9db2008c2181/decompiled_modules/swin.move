module 0x3827effd535ce9d0455046ac897e2362bfba1d22563340f02dbd9db2008c2181::swin {
    struct SWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIN>(arg0, 6, b"SWIN", b"Winter", b"Winter ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_23_173034_a185408c87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

