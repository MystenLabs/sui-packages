module 0xc540eb01fa3c98beb9532498c6938c713347a3a931d8cbba4406f9571c169b60::pend {
    struct PEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEND>(arg0, 9, b"PEND", b"dbnd", b"dbn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0d63b13-d820-4548-a195-65ad629b39e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

