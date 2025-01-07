module 0xfaae4a2df61b21c28ce2a1a5ca2fb2265f5ed3f934ce44b1ade06aeb0a226061::tad {
    struct TAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAD>(arg0, 6, b"Tad", b"Tadpole", b"Tadpole Tad official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5198_82b54f073c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

