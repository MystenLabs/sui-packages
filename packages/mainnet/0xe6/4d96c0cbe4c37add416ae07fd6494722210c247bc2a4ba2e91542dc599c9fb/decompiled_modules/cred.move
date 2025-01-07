module 0xe64d96c0cbe4c37add416ae07fd6494722210c247bc2a4ba2e91542dc599c9fb::cred {
    struct CRED has drop {
        dummy_field: bool,
    }

    public fun update_description(arg0: &mut 0x2::coin::TreasuryCap<CRED>, arg1: &mut 0x2::coin::CoinMetadata<CRED>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::coin::update_description<CRED>(arg0, arg1, 0x1::string::utf8(arg2));
    }

    public fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<CRED>, arg1: &mut 0x2::coin::CoinMetadata<CRED>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::coin::update_icon_url<CRED>(arg0, arg1, 0x1::ascii::string(arg2));
    }

    public fun update_name(arg0: &mut 0x2::coin::TreasuryCap<CRED>, arg1: &mut 0x2::coin::CoinMetadata<CRED>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::coin::update_name<CRED>(arg0, arg1, 0x1::string::utf8(arg2));
    }

    public fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<CRED>, arg1: &mut 0x2::coin::CoinMetadata<CRED>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::coin::update_symbol<CRED>(arg0, arg1, 0x1::ascii::string(arg2));
    }

    fun init(arg0: CRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe64d96c0cbe4c37add416ae07fd6494722210c247bc2a4ba2e91542dc599c9fb::sellable::create_config<CRED>(arg0, arg1);
        0x2::transfer::public_share_object<0xe64d96c0cbe4c37add416ae07fd6494722210c247bc2a4ba2e91542dc599c9fb::sellable::CredenzaSellableConfig<CRED>>(v1);
        let (v2, v3) = 0x2::coin::create_currency<CRED>(v0, 6, b"CRED", b"Credenza token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRED>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRED>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

