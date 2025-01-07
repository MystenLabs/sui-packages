module 0x87b040de3cbc07f92826f8f2b49c98d0708bb3c7d1545f943b96d38662fb3b18::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 6, b"MM", b"mima", b"mimamamamimmi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsf_2_scaled_260b5b73dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MM>>(v1);
    }

    // decompiled from Move bytecode v6
}

