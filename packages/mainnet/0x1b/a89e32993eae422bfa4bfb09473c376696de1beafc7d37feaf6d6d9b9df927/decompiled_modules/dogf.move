module 0x1ba89e32993eae422bfa4bfb09473c376696de1beafc7d37feaf6d6d9b9df927::dogf {
    struct DOGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGF>(arg0, 6, b"DOGF", b"The Dogfather", b"Im gonna make you an offer you cant refuse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1318_dffb6674b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

