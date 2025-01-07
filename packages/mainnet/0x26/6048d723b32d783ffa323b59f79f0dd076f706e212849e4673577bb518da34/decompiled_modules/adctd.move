module 0x266048d723b32d783ffa323b59f79f0dd076f706e212849e4673577bb518da34::adctd {
    struct ADCTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADCTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADCTD>(arg0, 9, b"ADCTD", b"Addicted", b"Addicted Frenz Addicted New Trendz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0390b62-12d4-4324-99f7-d42526da1fae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADCTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADCTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

