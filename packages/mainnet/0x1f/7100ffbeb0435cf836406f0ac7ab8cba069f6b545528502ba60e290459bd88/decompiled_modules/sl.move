module 0x1f7100ffbeb0435cf836406f0ac7ab8cba069f6b545528502ba60e290459bd88::sl {
    struct SL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SL>(arg0, 6, b"SL", b"Suilight", b"the lights and the water are very hostile, but we're here to deal with the commotion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreict2licksm6fy5ooslqf7fmnp3tcozfevjltxldao4ert5vu3w6xu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

