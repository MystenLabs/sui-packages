module 0x1510d4a84e6f8f867024daeea00079c08e6383c06f35e563c1de302f4d98beac::myblue {
    struct MYBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYBLUE>(arg0, 9, b"MyBlue", b"Team Liquid Fan Token", b"MyBlue utility token - named after the official Blue team mascot. The platform allows users to complete various social quests that spread the word about Team Liquid's activities in exchange for rewards. Integration with Sui blockchain will now give fans the option to acquire a soulbound NFT avatar of Blue and collect a variety of digital items for him to wear as they level up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://inventory-cdn.gamerbase.gg/25m7km05p1phlfr0/avatar/a437aae6-2a4f-46e0-b178-60c522e4fae0.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYBLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MYBLUE>>(0x2::coin::mint<MYBLUE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYBLUE>>(v2);
    }

    // decompiled from Move bytecode v6
}

