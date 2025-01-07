module 0xdf3c201974d0d0a2123a57672a24d2d31398d111b8c4bda79f20b3c5ddd8d7d0::ercnft {
    struct ERCNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERCNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERCNFT>(arg0, 9, b"ERCNFT", b"ERC", b"Complex heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62c8de1e-e3ea-4629-9741-a4d912532f64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERCNFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERCNFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

