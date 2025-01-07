module 0x9ea95a0efa36856429ca4792d348d9e3255dfdf2fa0e9ae97eb8709b0f1ca0be::orac {
    struct ORAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORAC>(arg0, 6, b"ORAC", b"OraclexAI", b"The AI Oracle on the SUI blockchain is an innovative solution designed to serve as a vital link for monitoring, analyzing, and disseminating information about the growing SUIAI ecosystem. Its primary function is to track, in real time, the artificial intelligence agents being launched, providing accurate data and detailed insights about each project.  ..This oracle stands as an essential reference point for anyone looking to understand the trends and advancements within the SUIAI universe. It has the capability to monitor and interpret trending tweets and discussions related to the ecosystem, capturing key trends and innovations shaping the landscape. By transforming the vast flow of information into practical and accessible insights, it allows the SUI community to stay informed about the sector's developments.  ..In addition to tracking AI agents, the Oracle facilitates detailed inquiries about ongoing projects, offering a clear view of their purposes, features, and performance. It also provides up-to-date technical information on smart contracts, enabling developers, investors, and end-users to understand the technical and legal aspects of each initiative.  ..This tool is designed to enhance interaction between developers and the community, acting as a bridge to connect people with data and projects within the SUI ecosystem. Its integration with social networks and reliable data sources broadens access to relevant information, fostering an environment of transparency and collaboration.  ..With the AI Oracle, the SUI blockchain takes a significant step forward in creating a robust ecosystem where innovation, technology, and community come together to drive the future of decentralized artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/quem_controla_criptomoedas_1_49b7ce745c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORAC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORAC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

