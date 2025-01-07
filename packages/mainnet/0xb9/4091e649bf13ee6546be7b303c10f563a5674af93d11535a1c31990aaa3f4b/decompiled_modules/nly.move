module 0xb94091e649bf13ee6546be7b303c10f563a5674af93d11535a1c31990aaa3f4b::nly {
    struct NLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLY>(arg0, 9, b"NLY", b"Nalley", b"Nalley on Sui BLOCKCHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/862edefa-9bf9-4391-b88a-64f168b91de6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

