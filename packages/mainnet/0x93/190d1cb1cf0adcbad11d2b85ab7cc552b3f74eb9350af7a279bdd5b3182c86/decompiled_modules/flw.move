module 0x93190d1cb1cf0adcbad11d2b85ab7cc552b3f74eb9350af7a279bdd5b3182c86::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLW>(arg0, 9, b"FLW", b"FLOWER", b"FLOWER IS NICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25b9ad33-7c5f-4f9d-8cf3-cbecb6616723.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

