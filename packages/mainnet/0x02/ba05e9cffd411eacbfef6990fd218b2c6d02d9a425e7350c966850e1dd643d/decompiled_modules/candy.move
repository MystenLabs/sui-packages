module 0x2ba05e9cffd411eacbfef6990fd218b2c6d02d9a425e7350c966850e1dd643d::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"CANDY", b"CANDY CRUSH", b"Candy Crush Memecoin is a playful, colorful cryptocurrency inspired by the addictive fun of mobile games and the sweet allure of candy. With vibrant, candy-themed visuals and a whimsical design, this coin taps into the nostalgic charm of matching candy tiles and rewards. Candy Crush Memecoin brings a sense of joy and lightheartedness to the crypto world, appealing to enthusiasts who appreciate a fun, approachable project with a sweet twist. The coins community celebrates light-hearted fun and rewards, making Candy Crush Memecoin a delicious addition to the world of meme tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Candy_crush_463f423ac0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

