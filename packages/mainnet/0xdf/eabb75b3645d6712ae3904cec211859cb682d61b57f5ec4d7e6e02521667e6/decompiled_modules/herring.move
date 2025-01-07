module 0xdfeabb75b3645d6712ae3904cec211859cb682d61b57f5ec4d7e6e02521667e6::herring {
    struct HERRING has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERRING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERRING>(arg0, 6, b"HERRING", b"Herring con Rainbow", b"Herring con Rainbow. Muchos colores", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030714_064c885d9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERRING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERRING>>(v1);
    }

    // decompiled from Move bytecode v6
}

