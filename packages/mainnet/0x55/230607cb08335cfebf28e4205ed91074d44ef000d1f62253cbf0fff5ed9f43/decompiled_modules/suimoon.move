module 0x55230607cb08335cfebf28e4205ed91074d44ef000d1f62253cbf0fff5ed9f43::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 6, b"SUIMOON", b"Suifemoon", x"53756966656d6f6f6e3a205265616368696e67206e657720686569676874732c2068656164696e6720746f20746865206d6f6f6e206f6e2074686520537569206e6574776f726b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_05_214008_removebg_preview_4eaddd97a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

