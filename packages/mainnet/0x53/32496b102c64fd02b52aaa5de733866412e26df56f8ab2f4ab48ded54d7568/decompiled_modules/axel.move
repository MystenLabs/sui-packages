module 0x5332496b102c64fd02b52aaa5de733866412e26df56f8ab2f4ab48ded54d7568::axel {
    struct AXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXEL>(arg0, 6, b"AXEL", b"SUI INU", b"You totally have to be part of the amazing journey with AXEL! WOOF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/axel_063423a0c0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

