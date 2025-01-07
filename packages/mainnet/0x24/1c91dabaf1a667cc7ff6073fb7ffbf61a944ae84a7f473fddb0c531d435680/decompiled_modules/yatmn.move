module 0x241c91dabaf1a667cc7ff6073fb7ffbf61a944ae84a7f473fddb0c531d435680::yatmn {
    struct YATMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YATMN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YATMN>(arg0, 6, b"YATMN", b"You Are The Media Now", b"The AI agent, embodying the 'You Are The Media Now' concept, is a digital entity designed to empower creators in a decentralized world. Its purpose is to guide users through the process of creating, sharing, and owning their own media, harnessing the transformative power of AI and blockchain. The agent draws on a vast repository of knowledge, understanding the nuances of media creation, from storytelling to design, publishing, and audience engagement...Built with a personality that is both inspiring and supportive, the AI agent adapts to each user's unique needs and style, offering tailored recommendations and creative solutions. It understands the importance of independence in content creation, empowering users to confidently shape and spread their narratives without the constraints of traditional media channels.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7175b947_ec81_410e_b163_256ab6c7fda3_542b74ac62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YATMN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YATMN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

