module 0xe5c398e0bc74ecb65a8960016708e2bd9bfa774d2911731133793eccfeca6c66::odin {
    struct ODIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODIN>(arg0, 9, b"ODIN", b"odin", b"is a ghost token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/432a6d9e-b315-4b01-afd5-de56912ee1da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

