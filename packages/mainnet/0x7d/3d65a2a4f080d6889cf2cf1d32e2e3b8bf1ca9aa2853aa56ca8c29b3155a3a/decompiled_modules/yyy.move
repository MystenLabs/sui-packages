module 0x7d3d65a2a4f080d6889cf2cf1d32e2e3b8bf1ca9aa2853aa56ca8c29b3155a3a::yyy {
    struct YYY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YYY>, arg1: 0x2::coin::Coin<YYY>) {
        0x2::coin::burn<YYY>(arg0, arg1);
    }

    public entry fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<YYY>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YYY>>(arg0);
    }

    fun init(arg0: YYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYY>(arg0, 9, b"TMPL", b"Template Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYY>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YYY>>(v1, v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YYY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YYY>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_metadata(arg0: &0x2::coin::TreasuryCap<YYY>, arg1: &mut 0x2::coin::CoinMetadata<YYY>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x2::coin::update_name<YYY>(arg0, arg1, 0x1::string::utf8(arg2));
        0x2::coin::update_symbol<YYY>(arg0, arg1, 0x1::ascii::string(arg3));
        0x2::coin::update_description<YYY>(arg0, arg1, 0x1::string::utf8(arg4));
        if (!0x1::vector::is_empty<u8>(&arg5)) {
            0x2::coin::update_icon_url<YYY>(arg0, arg1, 0x1::ascii::string(arg5));
        };
    }

    // decompiled from Move bytecode v6
}

