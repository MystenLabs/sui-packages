module 0xff9098fbe3b09ea01d6f1c7a361520f8c197f3dd7e7edf98623c5b36a4aad0ff::alm {
    struct ALM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALM>(arg0, 9, b"ALM", b"Almanac ", b"Gaming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a4c8671-1934-4b17-96d4-3358c25b7016.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALM>>(v1);
    }

    // decompiled from Move bytecode v6
}

