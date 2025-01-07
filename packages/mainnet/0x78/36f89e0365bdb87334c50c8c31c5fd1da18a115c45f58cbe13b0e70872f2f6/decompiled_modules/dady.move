module 0x7836f89e0365bdb87334c50c8c31c5fd1da18a115c45f58cbe13b0e70872f2f6::dady {
    struct DADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADY>(arg0, 9, b"DADY", b"Lil Dady", b"Lil Dady Token (DADY) is a community-focused token on the Sui blockchain, offering governance rights and access to exclusive features within the Lil Dady ecosystem. Designed for user engagement and innovation, DADY empowers holders to participate in project decisions and benefit from its growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1797645372371750912/Xt3ITFJr.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DADY>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

