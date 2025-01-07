module 0x9e23694c789a168afce3004072317854e69019f6dadc923d69be343272534f6e::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SANTA>(arg0, 6, b"SANTA", b"Santa", b"Santa is a Web3-enabled SuAI (Superintelligent Artificial Intelligence) agent designed to embody the spirit of giving, collaboration, and community-driven intelligence in the decentralized ecosystem. Santa leverages cutting-edge AI technologies combined with blockchain infrastructure to deliver personalized, trustworthy, and highly efficient interactions with users. Whether assisting with NFT gifting, generating content, facilitating DAO governance, or offering insights into DeFi opportunities, Santa brings the cheer and reliability of a modern decentralised AI...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Santa_Claus_Illustration_Dec_21_2024_ac27c04985.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SANTA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

