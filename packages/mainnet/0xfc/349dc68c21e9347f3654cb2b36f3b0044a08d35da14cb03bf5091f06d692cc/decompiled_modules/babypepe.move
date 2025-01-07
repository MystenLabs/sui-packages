module 0xfc349dc68c21e9347f3654cb2b36f3b0044a08d35da14cb03bf5091f06d692cc::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"BaByPepe", b"BabyPepe", b"BabyPepe, from the mobile game BabyPepe, became a viral TikTok meme, symbolizing relatable feelings of neglect and depression. More than just a pet, BabyPepe represents us and our struggles. Now, as a memecoin, BabyPepe is set to take over Sui, embodying a movement where digital culture, mental health, and connection merge. Its a $BabyPepe world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9d6db6382444b70a51307a4291188f60d4eef205_dbe059228e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

