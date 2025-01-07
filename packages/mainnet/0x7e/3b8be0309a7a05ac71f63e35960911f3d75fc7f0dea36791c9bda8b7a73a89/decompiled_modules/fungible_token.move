module 0x7e3b8be0309a7a05ac71f63e35960911f3d75fc7f0dea36791c9bda8b7a73a89::fungible_token {
    struct FUNGIBLE_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>, arg1: 0x2::coin::Coin<FUNGIBLE_TOKEN>) {
        0x2::coin::burn<FUNGIBLE_TOKEN>(arg0, arg1);
    }

    public entry fun join(arg0: &mut 0x2::coin::Coin<FUNGIBLE_TOKEN>, arg1: 0x2::coin::Coin<FUNGIBLE_TOKEN>) {
        0x2::coin::join<FUNGIBLE_TOKEN>(arg0, arg1);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<FUNGIBLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUNGIBLE_TOKEN>>(0x2::coin::split<FUNGIBLE_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>, arg1: &mut 0x2::coin::CoinMetadata<FUNGIBLE_TOKEN>, arg2: 0x1::string::String) {
        0x2::coin::update_description<FUNGIBLE_TOKEN>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>, arg1: &mut 0x2::coin::CoinMetadata<FUNGIBLE_TOKEN>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<FUNGIBLE_TOKEN>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>, arg1: &mut 0x2::coin::CoinMetadata<FUNGIBLE_TOKEN>, arg2: 0x1::string::String) {
        0x2::coin::update_name<FUNGIBLE_TOKEN>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>, arg1: &mut 0x2::coin::CoinMetadata<FUNGIBLE_TOKEN>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<FUNGIBLE_TOKEN>(arg0, arg1, arg2);
    }

    fun init(arg0: FUNGIBLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNGIBLE_TOKEN>(arg0, 6, b"Silly Salmon", b"SILLY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNGIBLE_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUNGIBLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FUNGIBLE_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

