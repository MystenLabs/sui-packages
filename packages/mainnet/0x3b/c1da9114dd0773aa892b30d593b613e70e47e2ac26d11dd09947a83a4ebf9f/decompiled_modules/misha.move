module 0x3bc1da9114dd0773aa892b30d593b613e70e47e2ac26d11dd09947a83a4ebf9f::misha {
    struct MISHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISHA>(arg0, 6, b"MISHA", b"Vitalik's Dog", b"Misha is Vitalik's first dog. We launched on September 22nd, making us the first Misha on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_22_12_07_51_0daf13798e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

