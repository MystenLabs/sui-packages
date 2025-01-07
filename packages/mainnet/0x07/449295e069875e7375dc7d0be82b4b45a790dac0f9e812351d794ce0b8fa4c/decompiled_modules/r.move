module 0x7449295e069875e7375dc7d0be82b4b45a790dac0f9e812351d794ce0b8fa4c::r {
    struct R has drop {
        dummy_field: bool,
    }

    fun init(arg0: R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R>(arg0, 8, b"R", b"Raul", b"ui/ux", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<R>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<R>>(v1);
    }

    // decompiled from Move bytecode v6
}

