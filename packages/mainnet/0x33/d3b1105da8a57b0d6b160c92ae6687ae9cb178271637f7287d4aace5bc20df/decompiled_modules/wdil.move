module 0x33d3b1105da8a57b0d6b160c92ae6687ae9cb178271637f7287d4aace5bc20df::wdil {
    struct WDIL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WDIL>, arg1: 0x2::coin::Coin<WDIL>) {
        0x2::coin::burn<WDIL>(arg0, arg1);
    }

    public entry fun finalize_token(arg0: &mut 0x2::coin::TreasuryCap<WDIL>, arg1: 0x2::coin::CoinMetadata<WDIL>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::coin::update_name<WDIL>(arg0, &mut arg1, 0x1::string::utf8(arg2));
        0x2::coin::update_symbol<WDIL>(arg0, &mut arg1, 0x1::ascii::string(arg3));
        0x2::coin::update_description<WDIL>(arg0, &mut arg1, 0x1::string::utf8(arg4));
        if (!0x1::vector::is_empty<u8>(&arg5)) {
            0x2::coin::update_icon_url<WDIL>(arg0, &mut arg1, 0x1::ascii::string(arg5));
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDIL>>(arg1);
        if (arg6 > 0) {
            0x2::coin::mint_and_transfer<WDIL>(arg0, arg6, arg7, arg8);
        };
    }

    fun init(arg0: WDIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDIL>(arg0, 9, b"TMPL", b"Template Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDIL>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WDIL>>(v1, v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WDIL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WDIL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

