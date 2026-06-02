module 0x94bc47eaa2552eca473ad7856c710af7e47dc62bbff362db9e037a53f948beec::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLO>, arg1: 0x2::coin::Coin<HELLO>) {
        0x2::coin::burn<HELLO>(arg0, arg1);
    }

    public entry fun finalize_token(arg0: &mut 0x2::coin::TreasuryCap<HELLO>, arg1: 0x2::coin::CoinMetadata<HELLO>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::coin::update_name<HELLO>(arg0, &mut arg1, 0x1::string::utf8(arg2));
        0x2::coin::update_symbol<HELLO>(arg0, &mut arg1, 0x1::ascii::string(arg3));
        0x2::coin::update_description<HELLO>(arg0, &mut arg1, 0x1::string::utf8(arg4));
        if (!0x1::vector::is_empty<u8>(&arg5)) {
            0x2::coin::update_icon_url<HELLO>(arg0, &mut arg1, 0x1::ascii::string(arg5));
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO>>(arg1);
        if (arg6 > 0) {
            0x2::coin::mint_and_transfer<HELLO>(arg0, arg6, arg7, arg8);
        };
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 9, b"TMPL", b"Template Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v1, v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HELLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

