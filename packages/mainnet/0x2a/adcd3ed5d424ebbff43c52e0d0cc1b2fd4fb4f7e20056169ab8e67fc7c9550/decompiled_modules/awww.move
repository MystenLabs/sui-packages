module 0x2aadcd3ed5d424ebbff43c52e0d0cc1b2fd4fb4f7e20056169ab8e67fc7c9550::awww {
    struct AWWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWWW>(arg0, 6, b"AWWW", b"AWKWARD SEAL", b"AWWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956307089.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWWW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWWW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

