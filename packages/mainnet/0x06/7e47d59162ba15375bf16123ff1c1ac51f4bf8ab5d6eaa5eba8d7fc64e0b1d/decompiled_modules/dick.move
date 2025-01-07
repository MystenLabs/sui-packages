module 0x67e47d59162ba15375bf16123ff1c1ac51f4bf8ab5d6eaa5eba8d7fc64e0b1d::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 6, b"DICK", b"LET ME PUT MY DICK INU", b"Just a funny little dick.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003609_468d34a607.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

