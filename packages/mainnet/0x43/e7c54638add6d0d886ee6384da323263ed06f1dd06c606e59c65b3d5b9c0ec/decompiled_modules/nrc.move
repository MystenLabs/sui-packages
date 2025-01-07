module 0x43e7c54638add6d0d886ee6384da323263ed06f1dd06c606e59c65b3d5b9c0ec::nrc {
    struct NRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRC>(arg0, 9, b"NRC", b"No Rug ", b"No Rug Campaign. This coin is created to inspire developers to bring good coins to the market and stop Rug Pull which badly affects the crypto market. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/182066f6-ce42-4f87-97e7-6e833418dc71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

