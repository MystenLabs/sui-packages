module 0xbd60a9dd06a4579ec872648f32ab1d11ade7987e53c6eaed547bb481ae9ad5f2::crytpo {
    struct CRYTPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYTPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYTPO>(arg0, 9, b"CRYTPO", b"SOUL", b"Lo beli gua kaya mwehe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf7354d4-5acb-4828-9162-1aa8176d948b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYTPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYTPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

