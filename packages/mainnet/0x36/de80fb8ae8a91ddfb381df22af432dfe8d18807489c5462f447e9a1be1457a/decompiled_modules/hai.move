module 0x36de80fb8ae8a91ddfb381df22af432dfe8d18807489c5462f447e9a1be1457a::hai {
    struct HAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAI>(arg0, 6, b"HAI", b"Harmonia AI by SuiAI", b"An advanced AI-powered music platform is being developed on the Sui blockchain, revolutionizing the way music is created, shared, and monetized. This agent leverages artificial intelligence to generate unique musical compositions, enabling creators to collaborate with AI to produce original tracks effortlessly. Once a track is created, it is published on the platform, where listeners can access and enjoy the music by locking MSC tokens...MSC tokens, the native utility asset of the platform, are designed to facilitate a seamless and rewarding ecosystem. Listeners are required to lock MSC tokens to unlock access to the music, creating a dynamic engagement model that benefits both creators and token holders. Every time a track is played, creators earn a share of the revenue, ensuring they are directly rewarded for their content...The platform also incorporates an innovative tokenomics model to incentivize MSC token holders. As the token's distribution curve reaches specific milestones, holders who remain engaged in the ecosystem receive additional rewards. This mechanism encourages active participation and aligns the interests of creators, listeners, and investors, fostering a vibrant and sustainable music ecosystem...By combining the creativity of AI, the accessibility of blockchain technology, and an equitable revenue-sharing model, this platform aims to redefine the music industry, empowering artists and rewarding listeners while setting new standards for decentralized content creation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/x_bd3f0c5423.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

