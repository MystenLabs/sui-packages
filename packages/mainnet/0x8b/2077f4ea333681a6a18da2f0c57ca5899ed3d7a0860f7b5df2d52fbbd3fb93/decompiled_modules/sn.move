module 0x8b2077f4ea333681a6a18da2f0c57ca5899ed3d7a0860f7b5df2d52fbbd3fb93::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN>(arg0, 9, b"SN", b"Seen", x"5468697320697320746865206d656d6520636f696e20f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fb81bcc-b8ca-44dd-84a0-914f9b65f9ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SN>>(v1);
    }

    // decompiled from Move bytecode v6
}

