module 0xc1f214c468fe43f05451dbe706711fce4e49910914d06c0074255b9e6e4a62e4::bhai {
    struct BHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHAI>(arg0, 9, b"BHAI", b"ELVISH BHAI", b"Elvish Bhai Ke Saamne Koi Kuch Bol Sakta Hai Kya?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1ttqxosekmk9r.cloudfront.net/posts/argusnews-collage-maker-03-oct-2023-02-37-pm-4800-3cd329a8-8b2c-4006-b01c-6698f662e7b6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BHAI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

