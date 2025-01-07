module 0x28e77c37b5024e8f0a8cde4fb2b83afa1b917f09c286133a5b6bcd6ef099c159::ctb {
    struct CTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTB>(arg0, 9, b"CTB", b"Nioctib ", b"Nioctib=Bitcoin CTB=BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdef32f2-ae9e-4aa9-8440-d413b944e909.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

