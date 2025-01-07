module 0xbc449d7037ad3120124e0036a427a36fb7e649c0e3366c9f1ad59c6d0ce278d8::WOJAK {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WOJAK>>(0x2::coin::mint<WOJAK>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 9, b"WSB", b"Baby SUI WBS", b"I was born to lead all MEME. https://twitter.com/WSB_BABY_SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654035865583390720/B1GqUz77_400x400.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOJAK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<WOJAK>(&mut v2, 100000000000000000, @0xbdedba87cb17d32f782b7c07a56c85fbd4223c0bac6500a7e6ece0cf0cbe4548, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOJAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WOJAK>>(0x2::coin::mint<WOJAK>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

