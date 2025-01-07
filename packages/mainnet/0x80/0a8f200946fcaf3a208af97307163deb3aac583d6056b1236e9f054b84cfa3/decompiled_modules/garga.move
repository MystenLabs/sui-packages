module 0x800a8f200946fcaf3a208af97307163deb3aac583d6056b1236e9f054b84cfa3::garga {
    struct GARGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARGA>(arg0, 6, b"gARGA", b"Kont Gargamelo", b"Kont is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_A3_D7_E91_2057_4468_92_C9_7_C3730_D048_A4_2132836e46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

