module 0x8a6d6cb50e30fb67c30e3b4dacef24e40c0d445fde14feeb037951ff06381918::trump24 {
    struct TRUMP24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP24>(arg0, 9, b"TRUMP24", b"TrumpSui", b"If you are a fan of Trump and a buyer of Sui. Please support it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb331c1e-32a8-4d85-afaf-4d12d0d5e2e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP24>>(v1);
    }

    // decompiled from Move bytecode v6
}

