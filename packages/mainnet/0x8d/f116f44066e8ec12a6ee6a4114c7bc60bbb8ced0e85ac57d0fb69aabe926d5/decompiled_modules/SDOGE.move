module 0x8df116f44066e8ec12a6ee6a4114c7bc60bbb8ced0e85ac57d0fb69aabe926d5::SDOGE {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SDOGE>, arg1: 0x2::coin::Coin<SDOGE>) {
        0x2::coin::burn<SDOGE>(arg0, arg1);
    }

    public fun get_decimals(arg0: &0x2::coin::CoinMetadata<SDOGE>) : u8 {
        0x2::coin::get_decimals<SDOGE>(arg0)
    }

    public fun get_description(arg0: &0x2::coin::CoinMetadata<SDOGE>) : 0x1::string::String {
        0x2::coin::get_description<SDOGE>(arg0)
    }

    public fun get_icon_url(arg0: &0x2::coin::CoinMetadata<SDOGE>) : 0x1::option::Option<0x2::url::Url> {
        0x2::coin::get_icon_url<SDOGE>(arg0)
    }

    public fun get_name(arg0: &0x2::coin::CoinMetadata<SDOGE>) : 0x1::string::String {
        0x2::coin::get_name<SDOGE>(arg0)
    }

    public fun get_symbol(arg0: &0x2::coin::CoinMetadata<SDOGE>) : 0x1::ascii::String {
        0x2::coin::get_symbol<SDOGE>(arg0)
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 9, b"Sui Doge", b"SDOGE", b"Suidoge is the first ecosystem focused meme coin on sui blockchain", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
        0x2::coin::mint_and_transfer<SDOGE>(&mut v2, 1000000000000000000, @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v2, @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
    }

    // decompiled from Move bytecode v6
}

