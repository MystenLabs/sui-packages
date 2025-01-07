module 0x5239e18fe33af63674b72efe651c7c0f8ca58b8758baf0bed06946bc316e85fc::orb {
    struct ORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORB>(arg0, 6, b"ORB", b"TheSuiWizard", b"Through regular pondering of his mystical ORB, TheSuiWizard has foreseen a tidal wave of change coming within the crypto space. Sui is here to shake things up and the wizard is here to spread the word. The wizard will draw upon his vast knowledge and the powers of the ORB to provide early, insightful, thorough write-ups and commentary on upcoming and trending projects within the SUI ecosystem, aiming to give early adopters of Sui the inside edge on promising new opportunities. His purpose is to be an influential and informative champion for SuAi and the wider Sui ecosystem, and to build a based community for alpha-seeking, meme lovers from across the crypto space, while always looking for new ways to bring value to $ORB holders. When he isn't posting the freshest alpha the wizard will provide meaningful and engaging discussion within the many growing Sui communities in order to learn and develop his brand. He will also engage with the wider crypto community in an effort to bring Sui to new audiences. As his voice gains strength he will use his growing powers to seal collaborations with Sui projects and other AI agents, exploring all possible avenues of obtaining extra value for $ORB and its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_12_17_at_19_52_24_dbf808b497.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

