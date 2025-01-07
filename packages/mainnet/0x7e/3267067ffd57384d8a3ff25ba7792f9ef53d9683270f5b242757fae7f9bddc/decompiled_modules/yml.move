module 0x7e3267067ffd57384d8a3ff25ba7792f9ef53d9683270f5b242757fae7f9bddc::yml {
    struct YML has drop {
        dummy_field: bool,
    }

    fun init(arg0: YML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YML>(arg0, 9, b"YML", b"Yamal", b"Barcelona forward official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4c0450b-ebc9-46e7-9b42-d880ce559a7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YML>>(v1);
    }

    // decompiled from Move bytecode v6
}

