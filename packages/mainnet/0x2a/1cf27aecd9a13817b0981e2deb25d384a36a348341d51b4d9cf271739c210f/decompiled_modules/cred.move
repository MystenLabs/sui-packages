module 0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::cred {
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
        let (v0, v1) = 0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::sellable::create_config<CRED>(arg0, arg1);
        0x2::transfer::public_share_object<0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::sellable::CredenzaSellableConfig<CRED>>(v1);
        let (v2, v3) = 0x2::coin::create_currency<CRED>(v0, 6, b"OHT", b"One Health token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRED>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRED>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

