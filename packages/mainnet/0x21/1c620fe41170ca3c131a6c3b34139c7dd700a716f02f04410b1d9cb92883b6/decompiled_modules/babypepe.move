module 0x211c620fe41170ca3c131a6c3b34139c7dd700a716f02f04410b1d9cb92883b6::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"BabyPepe", b"Baby pepe", b"BabyPepe, from the mobile game BabyPepe, became a viral TikTok meme, symbolizing relatable feelings of neglect and depression. More than just a pet, BabyPepe represents us and our struggles. Now, as a memecoin, BabyPepe is set to take over Sui, embodying a movement where digital culture, mental health, and connection merge. Its a $BabyPepe world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/roulette_ce89898c71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

