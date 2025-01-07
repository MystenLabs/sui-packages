module 0x1483556e97b282aa189a4e30a178164b2c9039d5ec1d1ddc7255707dbbe30cf9::sofas_hm {
    struct SOFAS_HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFAS_HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFAS_HM>(arg0, 9, b"SOFAS_HM", b"SZOFA", b"Great news SOFA is coming in market and it is boooooom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/193fb536-c70a-490a-a2e0-c4c92beb0738.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFAS_HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFAS_HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

