module 0xc6ae051fdb0c0f98e5f246d792d3d9dc8f4fa02cb46917b42e0815d56291f21::people {
    struct PEOPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOPLE>(arg0, 6, b"PEOPLE", b"Sui People AI", b"Sui People AI leverages blockchain technology and advanced AI algorithms to create a decentralized platform where individuals can interact with AI-powered virtual assistants tailored to their specific needs and preferences. These virtual assistants, known as \"People,\" are designed to assist users in various aspects of their daily lives, from productivity and organization to entertainment and social interactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Simple_Dog_Instagram_Post_20240331_090019_0000_0fe633cd2e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

