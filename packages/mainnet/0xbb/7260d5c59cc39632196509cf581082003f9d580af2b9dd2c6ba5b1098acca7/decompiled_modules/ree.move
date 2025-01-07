module 0xbb7260d5c59cc39632196509cf581082003f9d580af2b9dd2c6ba5b1098acca7::ree {
    struct REE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REE>(arg0, 6, b"REE", b"REEREE", b"ree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/random_a8aecf06f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REE>>(v1);
    }

    // decompiled from Move bytecode v6
}

