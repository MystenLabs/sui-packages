module 0x8556238dc509131621d1aa6420a31e031d398a01544ac9d950d8b38d7b3110c5::whatever {
    struct WHATEVER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHATEVER>, arg1: 0x2::coin::Coin<WHATEVER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHATEVER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WHATEVER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: WHATEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATEVER>(arg0, 9, b"POOP", b"WHATEVER", b"This is a coin will make you POOP your pants off!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d3hnfqimznafg0.cloudfront.net/image-handler/ts/20200218065624/ri/950/src/images/Article_Images/ImageForArticle_227_15820269818147731.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHATEVER>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<WHATEVER>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHATEVER>>(v2, v3);
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<WHATEVER>, arg1: 0x2::coin::Coin<WHATEVER>) : u64 {
        0x2::coin::burn<WHATEVER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<WHATEVER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WHATEVER> {
        0x2::coin::mint<WHATEVER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

