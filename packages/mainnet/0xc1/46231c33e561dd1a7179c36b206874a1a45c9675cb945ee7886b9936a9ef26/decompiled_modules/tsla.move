module 0xc146231c33e561dd1a7179c36b206874a1a45c9675cb945ee7886b9936a9ef26::tsla {
    struct TSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLA>(arg0, 6, b"TSLA", b"TSLA6900", b"Tesla makes a new Bitcoin transaction in 2 years ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000975297_8bf3913749.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

