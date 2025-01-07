module 0xc343cc0501cb3650480f390c3561765065022c87161c49bdb71741cb72059675::ercnft {
    struct ERCNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERCNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERCNFT>(arg0, 9, b"ERCNFT", b"ERC", b"Complex heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c4f9eb4-22e8-4a3c-8239-84d72503f301.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERCNFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERCNFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

