module 0xb49f2e4c6ae8d1fc7214105a46726b3945369efcf4f63df43a62cc6cd0c20cc6::pusui {
    struct PUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSUI>(arg0, 6, b"PUSUI", b"PUSSUI", b"Just For PUSSUIS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flat_750x_075_f_pad_750x1000_f8f8f8_7c0932b664.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

