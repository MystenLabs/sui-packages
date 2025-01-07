module 0x8c83ce3350c573dc6f41cbd6a9a3e1a5ece4572b58d36b877de3f1c8d4ccb9e9::lensas {
    struct LENSAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENSAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENSAS>(arg0, 9, b"LENSAS", b"Creator", b"It is a creator of Bitcoin, but probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/caf221de-344b-4151-90da-f8509de6b99b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENSAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENSAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

