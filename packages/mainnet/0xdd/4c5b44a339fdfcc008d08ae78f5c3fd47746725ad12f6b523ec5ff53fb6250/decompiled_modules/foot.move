module 0xdd4c5b44a339fdfcc008d08ae78f5c3fd47746725ad12f6b523ec5ff53fb6250::foot {
    struct FOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOT>(arg0, 6, b"FOOT", b"FOOT IN WATER", b"just a foot under water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_26_102626_f9b1f04eaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

