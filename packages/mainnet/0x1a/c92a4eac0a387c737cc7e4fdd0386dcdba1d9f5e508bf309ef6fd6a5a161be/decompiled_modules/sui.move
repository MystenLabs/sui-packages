module 0x1ac92a4eac0a387c737cc7e4fdd0386dcdba1d9f5e508bf309ef6fd6a5a161be::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Sui On Sui", b"Sui On Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_506bf84459.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

