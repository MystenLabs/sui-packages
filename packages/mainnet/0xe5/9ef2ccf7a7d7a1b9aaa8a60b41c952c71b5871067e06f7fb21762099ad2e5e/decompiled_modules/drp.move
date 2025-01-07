module 0xe59ef2ccf7a7d7a1b9aaa8a60b41c952c71b5871067e06f7fb21762099ad2e5e::drp {
    struct DRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRP>(arg0, 9, b"DRP", b"drop", b"little drop ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acf725b8-b8e8-4b58-921e-54f95bd0a786.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

