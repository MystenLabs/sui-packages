module 0xa403e5d3509a2cc8e1538570cb4f40a7a1c1eabb3ac6eddf8d4eefae4186d659::frope {
    struct FROPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROPE>(arg0, 6, b"FROPE", b"Frosty Pengu", b"The coolest penguin on sui, wait... I mean the coldest!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Pantalla_2025_01_16_a_las_18_59_30_1991785e8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

