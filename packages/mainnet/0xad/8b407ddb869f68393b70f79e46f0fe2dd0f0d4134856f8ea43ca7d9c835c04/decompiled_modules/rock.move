module 0xad8b407ddb869f68393b70f79e46f0fe2dd0f0d4134856f8ea43ca7d9c835c04::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROCK>, arg1: 0x2::coin::Coin<ROCK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROCK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROCK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 6, b"ROCK", b"Rock Sui", b"This is a coin that I created along my journey to learn Sui Move!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d3hnfqimznafg0.cloudfront.net/image-handler/ts/20200218065624/ri/950/src/images/Article_Images/ImageForArticle_227_15820269818147731.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ROCK>, arg1: 0x2::coin::Coin<ROCK>) : u64 {
        0x2::coin::burn<ROCK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ROCK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ROCK> {
        0x2::coin::mint<ROCK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

