module 0x81915b918d47ac10b3b59d98ba2719d9c718620eed6c08372d521c80ce1bb266::pixieai {
    struct PIXIEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXIEAI>(arg0, 6, b"PixieAi", b"PixieAI", b"Unleash the full potential of your creativity with PixieAI. Our powerful AI generator transforms your ideas into unique, high-quality visuals effortlessly. Create, customize, and download your artwork in just a few clicks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2134_33db0caef3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXIEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

