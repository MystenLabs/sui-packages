module 0xa65e2eb295ae423e5b2521e83b815430b15bd2d8c018b1991d3749a4ef1a6c90::ercnft {
    struct ERCNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERCNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERCNFT>(arg0, 9, b"ERCNFT", b"ERC", b"Complex heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51127404-61bb-4026-bfbe-285e1e90ca41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERCNFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERCNFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

