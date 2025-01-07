module 0xc0ca9d26a12eb6d3734475eecc307aa5d948bdd6a8139f00d2548e7a06032b9f::ttr {
    struct TTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTR>(arg0, 9, b"TTR", b"the truth ", b"the truth token by cak nug ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd222e23-81bc-4b8a-9377-b2e56e365d46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

