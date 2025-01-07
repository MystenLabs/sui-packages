module 0x303360827a12a2b46f95e1ca5943c60dd8dc435f1d738370bed2400bb67b47cc::mamba {
    struct MAMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMBA>(arg0, 6, b"MAMBA", b"SUI MAMBA", b"The KING of $MAMBA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAMBA_128352e65c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

