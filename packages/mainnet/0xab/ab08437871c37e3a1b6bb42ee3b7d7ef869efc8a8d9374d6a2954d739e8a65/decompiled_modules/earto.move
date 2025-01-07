module 0xabab08437871c37e3a1b6bb42ee3b7d7ef869efc8a8d9374d6a2954d739e8a65::earto {
    struct EARTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARTO>(arg0, 9, b"EARTO", b"Earn", b"Earn token with Wave Wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1a07e3b-a0e9-4418-a3dd-930f15d2c94f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

