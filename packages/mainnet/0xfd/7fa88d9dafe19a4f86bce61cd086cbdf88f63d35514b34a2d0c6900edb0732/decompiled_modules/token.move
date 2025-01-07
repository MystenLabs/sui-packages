module 0xfd7fa88d9dafe19a4f86bce61cd086cbdf88f63d35514b34a2d0c6900edb0732::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    public entry fun get_decimals(arg0: &0x2::coin::CoinMetadata<TOKEN>) : u8 {
        0x2::coin::get_decimals<TOKEN>(arg0)
    }

    public entry fun get_description(arg0: &0x2::coin::CoinMetadata<TOKEN>) : 0x1::string::String {
        0x2::coin::get_description<TOKEN>(arg0)
    }

    public entry fun get_icon_url(arg0: &0x2::coin::CoinMetadata<TOKEN>) : 0x1::option::Option<0x2::url::Url> {
        0x2::coin::get_icon_url<TOKEN>(arg0)
    }

    public entry fun get_name(arg0: &0x2::coin::CoinMetadata<TOKEN>) : 0x1::string::String {
        0x2::coin::get_name<TOKEN>(arg0)
    }

    public entry fun get_symbol(arg0: &0x2::coin::CoinMetadata<TOKEN>) : 0x1::ascii::String {
        0x2::coin::get_symbol<TOKEN>(arg0)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"test2", b"test2", b"description1", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

