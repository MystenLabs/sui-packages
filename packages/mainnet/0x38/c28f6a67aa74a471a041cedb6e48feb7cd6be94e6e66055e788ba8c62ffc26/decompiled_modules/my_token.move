module 0x38c28f6a67aa74a471a041cedb6e48feb7cd6be94e6e66055e788ba8c62ffc26::my_token {
    struct TokenMetadata has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        description: 0x1::string::String,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
        metadata: TokenMetadata,
        total_supply: u64,
        minted_supply: u64,
    }

    struct TokenInfo has key {
        id: 0x2::object::UID,
        metadata: TokenMetadata,
        total_supply: u64,
        minted_supply: u64,
    }

    struct TokenCreated has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        total_supply: u64,
    }

    struct TokensMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        from: address,
    }

    public fun decrease_minted_supply(arg0: &mut TokenTreasury, arg1: u64) {
        arg0.minted_supply = arg0.minted_supply - arg1;
    }

    public fun get_metadata(arg0: &TokenTreasury) : &TokenMetadata {
        &arg0.metadata
    }

    public fun get_minted_supply(arg0: &TokenTreasury) : u64 {
        arg0.minted_supply
    }

    public fun get_token_info(arg0: &TokenInfo) : &TokenMetadata {
        &arg0.metadata
    }

    public fun get_total_supply(arg0: &TokenTreasury) : u64 {
        arg0.total_supply
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenMetadata{
            name        : 0x1::string::utf8(b"USD"),
            symbol      : 0x1::string::utf8(b"USD"),
            decimals    : 9,
            description : 0x1::string::utf8(b"A USD token on Sui blockchain"),
        };
        let v1 = 50000000;
        let v2 = 0;
        let v3 = TokenTreasury{
            id            : 0x2::object::new(arg0),
            metadata      : v0,
            total_supply  : v1,
            minted_supply : v2,
        };
        let v4 = TokenInfo{
            id            : 0x2::object::new(arg0),
            metadata      : v0,
            total_supply  : v1,
            minted_supply : v2,
        };
        let v5 = TokenCreated{
            name         : 0x1::string::utf8(b"USD"),
            symbol       : 0x1::string::utf8(b"USD"),
            total_supply : v1,
        };
        0x2::event::emit<TokenCreated>(v5);
        0x2::transfer::transfer<TokenTreasury>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<TokenInfo>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun merge_coins(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(arg0, arg1);
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    public fun transfer_tokens(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public fun update_metadata(arg0: &mut TokenTreasury, arg1: TokenMetadata) {
        arg0.metadata = arg1;
    }

    public fun update_minted_supply(arg0: &mut TokenTreasury, arg1: u64) {
        arg0.minted_supply = arg0.minted_supply + arg1;
    }

    // decompiled from Move bytecode v6
}

