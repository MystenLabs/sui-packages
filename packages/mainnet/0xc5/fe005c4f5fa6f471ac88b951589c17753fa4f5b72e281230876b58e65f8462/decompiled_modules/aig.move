module 0xc5fe005c4f5fa6f471ac88b951589c17753fa4f5b72e281230876b58e65f8462::aig {
    struct AIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIG>(arg0, 6, b"AIG", b"AI Galactic Warfare on Sui Ecosystem", b"Galactic AI Warfare is an immersive, interstellar war game that combines advanced artificial intelligence with strategic gameplay. Players command fleets of AI-driven starships, engage in epic battles across diverse galaxies, and harness the power of blockchain technology to trade resources and upgrade their armadas...Players take on the role of charismatic commanders, each with distinct personalities and leadership styles. From ruthless strategists to cunning diplomats, these agents shape their factions and influence alliances, creating a dynamic narrative driven by player choices and interactions...Set in a distant future where civilizations have spread across the cosmos, the galaxy is embroiled in a fierce struggle for dominance. Ancient AI artifacts have been uncovered, granting immense power to those who can decipher their secrets. As factions vie for control, players must navigate treacherous alliances, uncover hidden truths, and determine the fate of the galaxy...The game boasts a stunning visual style that blends vibrant, futuristic aesthetics with intricate spaceship designs. The user interface is sleek and intuitive, allowing players to easily manage their fleets and engage in combat while immersing themselves in a rich, sci-fi universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Nevtelen_829ae3ec7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

