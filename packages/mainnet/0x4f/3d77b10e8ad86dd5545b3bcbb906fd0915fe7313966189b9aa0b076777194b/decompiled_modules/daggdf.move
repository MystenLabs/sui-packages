module 0x4f3d77b10e8ad86dd5545b3bcbb906fd0915fe7313966189b9aa0b076777194b::daggdf {
    struct DAGGDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGGDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGGDF>(arg0, 6, b"Daggdf", b"gfda", b"gafdgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_20_01_32_e655bbe2a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGGDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGGDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

