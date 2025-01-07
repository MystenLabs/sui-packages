module 0x3ae260b55c9374e8b61b590b8ea9f0807b4beb5d271ba1660f694b838ccff83e::s10_ {
    struct S10_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: S10_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S10_>(arg0, 9, b"S10_", b"mrsi", b"Be ok and warrior", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34c74f90-3485-4d57-968f-3e6e22e507b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S10_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S10_>>(v1);
    }

    // decompiled from Move bytecode v6
}

