module 0xf61f5c1d4a188ffab8335ec8a3d59ad7c279424c26d9e6cb1413fecf2e6bbb50::wsdcoin {
    struct WSDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSDCOIN>(arg0, 9, b"WSDCOIN", b"WAVESAD", b"WSDCOIN THE BEST COIN IN DREAM ABOUT LIFE AND THANK YOU WAVE OSEN FOR CHOSE ME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36dbba5d-7a96-4f9f-a437-a4079c95ef3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSDCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSDCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

