module 0xa4ef5579049f18559117d564e626def0c3ce40ecc415ed696448377bbbcd0ecd::x20 {
    struct X20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X20>(arg0, 9, b"X20", b"XAi", b"Xai funny sui Tsunami festival", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64eb4ac7-eb3d-4628-8a82-51762d680463.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X20>>(v1);
    }

    // decompiled from Move bytecode v6
}

