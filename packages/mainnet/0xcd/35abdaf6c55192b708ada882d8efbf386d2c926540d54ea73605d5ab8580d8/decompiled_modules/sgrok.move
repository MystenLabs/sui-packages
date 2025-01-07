module 0xcd35abdaf6c55192b708ada882d8efbf386d2c926540d54ea73605d5ab8580d8::sgrok {
    struct SGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGROK>(arg0, 6, b"SGROK", b"SuiGrok", b"Where crypto meets meme magic! Dive into the world of SUI Grok, the meme coin thats as groovy as it sounds. Join our community and get ready to laugh your way to the moon! With quirky memes, fun rewards, and a vibrant community, SUI Grok is not just a coin its a lifestyle! Lets make SUI Grok the next big thing in the crypto universe because who said crypto can't be fun?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/grokgrok_c2b700d096.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

