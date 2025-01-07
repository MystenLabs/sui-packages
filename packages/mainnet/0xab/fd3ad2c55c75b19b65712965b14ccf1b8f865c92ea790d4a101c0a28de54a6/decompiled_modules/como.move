module 0xabfd3ad2c55c75b19b65712965b14ccf1b8f865c92ea790d4a101c0a28de54a6::como {
    struct COMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMO>(arg0, 9, b"COMO", b"Comolokko", b"Best como", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b321ccff-50cd-4445-86ef-eb06105a0ff0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

