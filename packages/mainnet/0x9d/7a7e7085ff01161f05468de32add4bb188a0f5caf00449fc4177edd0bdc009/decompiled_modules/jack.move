module 0x9d7a7e7085ff01161f05468de32add4bb188a0f5caf00449fc4177edd0bdc009::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 6, b"JACK", b"JACK BLACK", b"Meet Mr. Jack, a black cat with a serious gambling addiction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0957_b429334007.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

