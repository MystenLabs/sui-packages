module 0xc35fc14922c1f1661cf2452af464002624add7eee400a040783376fe1abc7059::em {
    struct EM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EM>(arg0, 9, b"EM", b"Elon musk", x"456c6f6e206d75736b20636f696e20f09faa99205465736c61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/945d8d57-0d73-4bc3-bbca-eac08d50c13d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EM>>(v1);
    }

    // decompiled from Move bytecode v6
}

