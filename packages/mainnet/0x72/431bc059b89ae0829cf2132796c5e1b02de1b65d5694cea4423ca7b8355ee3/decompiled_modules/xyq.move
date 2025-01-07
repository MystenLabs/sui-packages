module 0x72431bc059b89ae0829cf2132796c5e1b02de1b65d5694cea4423ca7b8355ee3::xyq {
    struct XYQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYQ>(arg0, 9, b"XYQ", b"We-X", x"576520617265202e2e2e204368616d70696f6e7320f09f8f86", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2de6f555-7ba1-4fac-bfd6-0cc012461821.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

