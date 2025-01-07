module 0xcde8e75de7b20e17b5773dd6555aa9147cf148a79d4bf5c84f5f13537f5c9695::fuel {
    struct FUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUEL>(arg0, 6, b"FUEL", b"SUI FUEL", b"300 MG of SUI in every scoop.  Watch your investments level up faster than your in-game character.  Zero crash! Unlike your energy drink, SUI FUEL keeps you on a steady climb with no sudden drops.  Endorsed by top gamers and traders who know the importance of staying fueled both in-game and in the market.  Ready to power up? Grab your SUI FUEL and lets hit those high scores in the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050601_911e2199d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

