module 0x23edc7729985ba041710ae2f5829d16b4fbe894076e094c7ce272c2e53a56cca::frokai {
    struct FROKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROKAI>(arg0, 9, b"FROKAI", b"Frok Dao AI on SUI", b"Our platform empowers users to generate captivating and imaginative content effortlessly, spanning images, videos, and beyond. Through state-of-the-art AI technology inspired by DALL-E, we enable individuals to unleash their creativity like never before. Whether you're an artist, designer, or content creator, Frok AI provides the tools and resources you need to explore the depths of your imagination and transform your vision into reality. You can visit us at frokai.com.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/de6c05a0-da43-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROKAI>>(v1);
        0x2::coin::mint_and_transfer<FROKAI>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROKAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

