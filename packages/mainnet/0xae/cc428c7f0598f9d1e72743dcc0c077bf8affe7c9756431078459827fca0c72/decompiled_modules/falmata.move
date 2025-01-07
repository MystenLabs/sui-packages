module 0xaecc428c7f0598f9d1e72743dcc0c077bf8affe7c9756431078459827fca0c72::falmata {
    struct FALMATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALMATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALMATA>(arg0, 9, b"FALMATA", b"RIERIE", b"RIERIE is a nickname of someone girlfriend inspired by him and took it personal to drive it on wave Blockchain to prove the existance of love and care.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/636f99b7-870d-4362-8617-5701369f2552.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALMATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALMATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

