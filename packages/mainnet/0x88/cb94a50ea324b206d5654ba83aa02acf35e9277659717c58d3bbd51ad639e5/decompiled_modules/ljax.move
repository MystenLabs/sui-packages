module 0x88cb94a50ea324b206d5654ba83aa02acf35e9277659717c58d3bbd51ad639e5::ljax {
    struct LJAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LJAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LJAX>(arg0, 9, b"LJAX", b"LamarToken", b"Inspired by NFL MVP Lamar Jackson", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"Inspired by NFL MVP Lamar Jackson https://pbs.twimg.com/profile_images/1796166576380555265/ZMjAeqjG.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LJAX>(&mut v2, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LJAX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LJAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

