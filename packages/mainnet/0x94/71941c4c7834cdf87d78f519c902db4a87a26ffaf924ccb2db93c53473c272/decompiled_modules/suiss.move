module 0xb3a31022f9b7a585a701392959072e4fc9b0390d93c1d72b3102f74eb7d70162::suiss {
    struct SUISS has drop {
        dummy_field: bool,
    }

    struct TokenInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISS>, arg1: 0x2::coin::Coin<SUISS>) {
        0x2::coin::burn<SUISS>(arg0, arg1);
    }

    public entry fun update_icon_url(arg0: &mut TokenInfo, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.icon_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg1));
    }

    public entry fun burn_amount(arg0: &mut 0x2::coin::TreasuryCap<SUISS>, arg1: &mut 0x2::coin::Coin<SUISS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUISS>(arg0, 0x2::coin::split<SUISS>(arg1, arg2, arg3));
    }

    public fun get_description(arg0: &TokenInfo) : &0x1::string::String {
        &arg0.description
    }

    public fun get_icon_url(arg0: &TokenInfo) : &0x1::option::Option<0x2::url::Url> {
        &arg0.icon_url
    }

    public fun get_name(arg0: &TokenInfo) : &0x1::string::String {
        &arg0.name
    }

    public fun get_symbol(arg0: &TokenInfo) : &0x1::string::String {
        &arg0.symbol
    }

    fun init(arg0: SUISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISS>(arg0, 9, b"SUISS", b"Suiss- A Meme Nation", b"The ultimate meme token for the Sui ecosystem. Join the meme revolution!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISS>>(v1);
        let v2 = TokenInfo{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Suiss- A Meme Nation"),
            symbol      : 0x1::string::utf8(b"SUISS"),
            description : 0x1::string::utf8(b"The ultimate meme token for the Sui ecosystem. Join the meme revolution!"),
            icon_url    : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/fw3Fpxy.png")),
        };
        0x2::transfer::public_share_object<TokenInfo>(v2);
    }

    public entry fun mint_initial_supply(arg0: &mut 0x2::coin::TreasuryCap<SUISS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISS>>(0x2::coin::mint<SUISS>(arg0, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun secure_mint(arg0: &mut 0x2::coin::TreasuryCap<SUISS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISS>>(0x2::coin::mint<SUISS>(arg0, arg1, arg3), arg2);
    }

    public entry fun update_coin_metadata_icon(arg0: &0x2::coin::TreasuryCap<SUISS>, arg1: &mut 0x2::coin::CoinMetadata<SUISS>, arg2: vector<u8>) {
        0x2::coin::update_icon_url<SUISS>(arg0, arg1, 0x1::ascii::string(arg2));
    }

    public entry fun update_icon_url_public(arg0: &mut TokenInfo, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.icon_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg1));
    }

    public entry fun update_icon_url_string(arg0: &mut TokenInfo, arg1: 0x1::string::String) {
        arg0.icon_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(arg1)));
    }

    // decompiled from Move bytecode v6
}

