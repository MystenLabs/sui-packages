module 0x83013208999aa22adc40c1fbb5bca2b334219d605e8f39ac448dc8d8f8a2dd77::vfrog {
    struct VFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFROG>(arg0, 6, b"VFROG", b"VAN FROG GOGH", b"A tribute to one of the greatest icons, the STARRY NIHGT by VAN GOGH, this starry night frog will reach for the sky for the love of art", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_frog_03a9bb9d6e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

