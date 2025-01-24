module 0x597ccf3500937b4abcf38c8a3f68324df406d6cdb6d84a30b454c02c0e91c3e9::frokai {
    struct FROKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROKAI>(arg0, 9, b"FROKAI", b"FrokDaoAI", b"At FrokAI, we harness the power of advanced artificial intelligence to revolutionize creative expression. Our platform empowers users to generate captivating and imaginative content effortlessly, spanning images, videos, and beyond. Through state-of-the-art AI technology inspired by DALL-E, we enable individuals to unleash their creativity like never before. Whether you're an artist, designer, or content creator, Frok AI provides the tools and resources you need to explore the depths of your imagination and transform your vision into reality. Join us and discover the limitless possibilities of AI-powered creativity. You can visit our website at frokai.com.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/3756e3c0-da43-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROKAI>>(v1);
        0x2::coin::mint_and_transfer<FROKAI>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROKAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

