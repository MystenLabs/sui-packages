module 0xb4530edc7f46efdc004d9c7bb1d6eb241640c39f5dd1dadeca5dc701910d5db6::kew {
    struct KEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEW>(arg0, 6, b"KEW", b"KkheowzooSUI", x"6b68656f777a6f6f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7d51c214_ed41_44b4_8082_0a252dd3bd77_logo_fb6728c493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

