module 0x2b8076c0dadf50c00159188fdf6cc7b1690857c780b3cbcc8ca5ca560f57710::scidecen {
    struct SCIDECEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCIDECEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCIDECEN>(arg0, 6, b"SCIDECEN", b"SciDecentral", b"SciDecentral is an AI agent designed to operate within a decentralized science ecosystem, leveraging blockchain technology, peer-to-peer networks, and advanced AI to facilitate open-source scientific research and innovation. Here's how it functions..SciDecentral allows scientists and researchers to share their data securely on a blockchain, ensuring data integrity, privacy, and accessibility. This removes barriers to data access, enabling a global pool of knowledge where participants can contribute and retrieve data anonymously if desired...AI-Driven Analysis: Utilizing advanced machine learning models, SciDecentral analyzes vast datasets from various scientific fields. It can identify patterns, predict outcomes, and suggest research directions, all while being continuously updated and improved by the community...Smart Contracts for Research Funding: Researchers can propose projects through smart contracts, where the community or institutions can fund", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/b092b5bf_ea4b_4b9a_bf76_4bd041c720e7_8e087800a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCIDECEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCIDECEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

