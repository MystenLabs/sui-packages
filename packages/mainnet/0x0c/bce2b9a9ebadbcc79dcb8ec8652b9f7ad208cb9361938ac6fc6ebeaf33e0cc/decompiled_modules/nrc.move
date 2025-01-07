module 0xcbce2b9a9ebadbcc79dcb8ec8652b9f7ad208cb9361938ac6fc6ebeaf33e0cc::nrc {
    struct NRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRC>(arg0, 9, b"NRC", b"No Rug ", b"No Rug Campaign. This coin is created to inspire developers to bring good coins to the market and stop Rug Pull which badly affects the crypto market. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b96428e7-8ce8-4a7c-a7ca-4a5d21c33b6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

