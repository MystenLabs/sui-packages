module 0x7739d4490874be3fc1d20a280855ee1274c28e489878eab26731ff64224611f7::ssssso {
    struct SSSSSO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSSSSO>, arg1: 0x2::coin::Coin<SSSSSO>) {
        0x2::coin::burn<SSSSSO>(arg0, arg1);
    }

    public entry fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<SSSSSO>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSSSSO>>(arg0);
    }

    fun init(arg0: SSSSSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSSSO>(arg0, 9, b"TMPL", b"Template Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSSSO>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSSSSO>>(v1, v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSSSSO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSSSSO>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_metadata(arg0: &0x2::coin::TreasuryCap<SSSSSO>, arg1: &mut 0x2::coin::CoinMetadata<SSSSSO>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x2::coin::update_name<SSSSSO>(arg0, arg1, 0x1::string::utf8(arg2));
        0x2::coin::update_symbol<SSSSSO>(arg0, arg1, 0x1::ascii::string(arg3));
        0x2::coin::update_description<SSSSSO>(arg0, arg1, 0x1::string::utf8(arg4));
        if (!0x1::vector::is_empty<u8>(&arg5)) {
            0x2::coin::update_icon_url<SSSSSO>(arg0, arg1, 0x1::ascii::string(arg5));
        };
    }

    // decompiled from Move bytecode v6
}

