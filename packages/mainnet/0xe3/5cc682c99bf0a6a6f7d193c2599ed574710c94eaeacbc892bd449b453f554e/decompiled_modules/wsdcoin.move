module 0xe35cc682c99bf0a6a6f7d193c2599ed574710c94eaeacbc892bd449b453f554e::wsdcoin {
    struct WSDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSDCOIN>(arg0, 9, b"WSDCOIN", b"WAVESAD", b"WSDCOIN THE BEST COIN IN DREAM ABOUT LIFE AND THANK YOU WAVE OSEN FOR CHOSE ME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6209f88e-05aa-4dfd-9435-ad5e2f4fef34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSDCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSDCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

