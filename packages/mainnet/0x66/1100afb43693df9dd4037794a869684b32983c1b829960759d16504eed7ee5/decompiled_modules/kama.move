module 0x661100afb43693df9dd4037794a869684b32983c1b829960759d16504eed7ee5::kama {
    struct KAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMA>(arg0, 6, b"KAMA", b"NEW BABY ELEPHANT", b"NEW BORN ELEPHANT CALF AT BALI ZOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_661612c59b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

