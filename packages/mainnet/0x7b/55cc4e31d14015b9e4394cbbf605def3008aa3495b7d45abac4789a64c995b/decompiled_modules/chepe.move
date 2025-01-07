module 0x7b55cc4e31d14015b9e4394cbbf605def3008aa3495b7d45abac4789a64c995b::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"CHEPE", b"chad pepe", b"Flex so chard, even Pepe rekts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_x2o6_Fa_WI_1726156903519_raw_e37017537f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

