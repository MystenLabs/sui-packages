module 0x68cc38b8635532cd87db1ecd722b4d8b417e81cc35a1d2de3a747818644529d6::sariel {
    struct SARIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARIEL>(arg0, 6, b"SARIEL", b"Sariel Sei's Cat Thief", b"Sariel Sei's Cat Thief is a cunning and elusive feline, skilled in the art of stealth and mischief. Known for sneaking into the most secure digital vaults, this cat thief navigates the shadows of the blockchain, leaving no trace behind. Sariel Seis prized companion, the cat thief is a master of digital heists, slipping through the cracks with grace and agility, always one step ahead of the game. In a world of crypto and secrets, this clever cat is both feared and admired for its daring exploits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PER_ba33118c1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

