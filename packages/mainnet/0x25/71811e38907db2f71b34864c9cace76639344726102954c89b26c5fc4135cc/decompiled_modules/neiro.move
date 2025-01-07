module 0x2571811e38907db2f71b34864c9cace76639344726102954c89b26c5fc4135cc::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEIRO>, arg1: 0x2::coin::Coin<NEIRO>) {
        0x2::coin::burn<NEIRO>(arg0, arg1);
    }

    public entry fun join(arg0: &mut 0x2::coin::Coin<NEIRO>, arg1: 0x2::coin::Coin<NEIRO>) {
        0x2::coin::join<NEIRO>(arg0, arg1);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<NEIRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEIRO>>(0x2::coin::split<NEIRO>(arg0, arg1, arg3), arg2);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<NEIRO>, arg1: &mut 0x2::coin::CoinMetadata<NEIRO>, arg2: 0x1::string::String) {
        0x2::coin::update_description<NEIRO>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<NEIRO>, arg1: &mut 0x2::coin::CoinMetadata<NEIRO>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<NEIRO>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<NEIRO>, arg1: &mut 0x2::coin::CoinMetadata<NEIRO>, arg2: 0x1::string::String) {
        0x2::coin::update_name<NEIRO>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<NEIRO>, arg1: &mut 0x2::coin::CoinMetadata<NEIRO>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<NEIRO>(arg0, arg1, arg2);
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"neiro", b"neiro", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEIRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEIRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

