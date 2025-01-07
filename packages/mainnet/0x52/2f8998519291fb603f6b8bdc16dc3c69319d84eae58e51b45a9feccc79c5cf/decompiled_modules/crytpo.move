module 0x522f8998519291fb603f6b8bdc16dc3c69319d84eae58e51b45a9feccc79c5cf::crytpo {
    struct CRYTPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYTPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYTPO>(arg0, 9, b"CRYTPO", b"SOUL", b"Lo beli gua kaya mwehe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8538dab1-d661-4631-bc92-3597374da066.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYTPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYTPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

