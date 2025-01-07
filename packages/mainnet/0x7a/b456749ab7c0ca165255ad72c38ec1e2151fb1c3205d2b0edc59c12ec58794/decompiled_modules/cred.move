module 0x7ab456749ab7c0ca165255ad72c38ec1e2151fb1c3205d2b0edc59c12ec58794::cred {
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
        let (v0, v1) = 0x2::coin::create_currency<CRED>(arg0, 6, b"CRED", b"Credenza token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRED>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x7ab456749ab7c0ca165255ad72c38ec1e2151fb1c3205d2b0edc59c12ec58794::sellable::CredenzaSellableConfig<CRED>>(0x7ab456749ab7c0ca165255ad72c38ec1e2151fb1c3205d2b0edc59c12ec58794::sellable::create_config<CRED>(arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

