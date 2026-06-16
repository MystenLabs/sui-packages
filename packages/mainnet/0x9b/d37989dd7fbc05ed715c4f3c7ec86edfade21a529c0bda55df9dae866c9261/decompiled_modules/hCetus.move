module 0x9bd37989dd7fbc05ed715c4f3c7ec86edfade21a529c0bda55df9dae866c9261::hCetus {
    struct HCETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCETUS>(arg0, 9, b"hCetus", b"hCetus Coin", b"hCetus Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/images/cetus.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

