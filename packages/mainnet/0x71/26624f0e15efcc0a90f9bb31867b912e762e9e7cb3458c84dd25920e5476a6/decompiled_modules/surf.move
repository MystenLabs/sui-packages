module 0x7126624f0e15efcc0a90f9bb31867b912e762e9e7cb3458c84dd25920e5476a6::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 9, b"SURF", b"SUIRFING", b"Stay Unthirsty, Rehydrate Fast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2bb2b9b-46cb-4b61-8c56-e5a0f8cb2d80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

