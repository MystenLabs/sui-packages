module 0x5674dbeccfc4d82b77ece7037d4b88aa8d705cb15576589365b288f8cfaade1e::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BLOW>, arg1: 0x2::coin::Coin<BLOW>) {
        0x2::coin::burn<BLOW>(arg0, arg1);
    }

    public entry fun change_icon_url(arg0: &mut 0x2::coin::CoinMetadata<BLOW>, arg1: &0x2::coin::TreasuryCap<BLOW>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<BLOW>(arg1, arg0, arg2);
    }

    public entry fun change_name(arg0: &mut 0x2::coin::CoinMetadata<BLOW>, arg1: &0x2::coin::TreasuryCap<BLOW>, arg2: 0x1::string::String) {
        0x2::coin::update_name<BLOW>(arg1, arg0, arg2);
    }

    public entry fun change_symbol(arg0: &mut 0x2::coin::CoinMetadata<BLOW>, arg1: &0x2::coin::TreasuryCap<BLOW>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<BLOW>(arg1, arg0, arg2);
    }

    public entry fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<BLOW>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOW>>(arg0);
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOW>(arg0, 9, b"Blow", b"BLOW", b"Currency of Blow protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://mainnet-walrus-aggregator.kiliglab.io/v1/blobs/aJ5gUbaP2kXvkPg20aM9MxMq1YBkyW3cW6jndsLIUdMBaABpAA"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOW>(&mut v2, 10000000000000000000, @0xef72cb4baaf878f0db211273d230842db87c36ecf1f9493a77a9c5af1c596df5, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

