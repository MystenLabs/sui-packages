module 0x7606bc979b6517f73cd8cd3884dca0b9fdc4d86f3c3fba9f376ab8d6c714732e::romacis {
    struct ROMACIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMACIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMACIS>(arg0, 9, b"ROMACIS", b"romabis", b"the new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5bb93d3-bd52-4f84-82ab-1007cf65c3a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMACIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROMACIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

