module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset {
    struct Asset<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        is_lend_coin: bool,
        is_collateral_coin: bool,
        price_feed_id: 0x1::string::String,
        max_price_age_seconds: u64,
        token_address: vector<u8>,
        chain_id: u16,
    }

    struct AssetEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        is_lend_coin: bool,
        is_collateral_coin: bool,
        price_feed_id: 0x1::string::String,
        max_price_age_seconds: u64,
        token_address: vector<u8>,
        chain_id: u16,
    }

    public(friend) fun delete<T0>(arg0: Asset<T0>) {
        let Asset {
            id                    : v0,
            name                  : _,
            symbol                : _,
            decimals              : _,
            is_lend_coin          : _,
            is_collateral_coin    : _,
            price_feed_id         : _,
            max_price_age_seconds : _,
            token_address         : _,
            chain_id              : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: bool, arg4: bool, arg5: 0x1::string::String, arg6: u64, arg7: vector<u8>, arg8: u16, arg9: &mut 0x2::tx_context::TxContext) : Asset<T0> {
        let v0 = Asset<T0>{
            id                    : 0x2::object::new(arg9),
            name                  : arg0,
            symbol                : arg1,
            decimals              : arg2,
            is_lend_coin          : arg3,
            is_collateral_coin    : arg4,
            price_feed_id         : arg5,
            max_price_age_seconds : arg6,
            token_address         : arg7,
            chain_id              : arg8,
        };
        let v1 = AssetEvent{
            id                    : 0x2::object::id<Asset<T0>>(&v0),
            name                  : arg0,
            symbol                : arg1,
            decimals              : arg2,
            is_lend_coin          : arg3,
            is_collateral_coin    : arg4,
            price_feed_id         : arg5,
            max_price_age_seconds : arg6,
            token_address         : arg7,
            chain_id              : arg8,
        };
        0x2::event::emit<AssetEvent>(v1);
        v0
    }

    public fun chain_id<T0>(arg0: &Asset<T0>) : u16 {
        arg0.chain_id
    }

    public fun decimals<T0>(arg0: &Asset<T0>) : u8 {
        arg0.decimals
    }

    public fun is_collateral_coin<T0>(arg0: &Asset<T0>) : bool {
        arg0.is_collateral_coin
    }

    public fun is_lend_coin<T0>(arg0: &Asset<T0>) : bool {
        arg0.is_lend_coin
    }

    public fun max_price_age_seconds<T0>(arg0: &Asset<T0>) : u64 {
        arg0.max_price_age_seconds
    }

    public fun price_feed_id<T0>(arg0: &Asset<T0>) : 0x1::string::String {
        arg0.price_feed_id
    }

    public fun symbol<T0>(arg0: &Asset<T0>) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_address<T0>(arg0: &Asset<T0>) : vector<u8> {
        arg0.token_address
    }

    public(friend) fun update<T0>(arg0: &mut Asset<T0>, arg1: 0x1::string::String, arg2: u64) {
        arg0.price_feed_id = arg1;
        arg0.max_price_age_seconds = arg2;
        let v0 = AssetEvent{
            id                    : 0x2::object::id<Asset<T0>>(arg0),
            name                  : arg0.name,
            symbol                : arg0.symbol,
            decimals              : arg0.decimals,
            is_lend_coin          : arg0.is_lend_coin,
            is_collateral_coin    : arg0.is_collateral_coin,
            price_feed_id         : arg0.price_feed_id,
            max_price_age_seconds : arg0.max_price_age_seconds,
            token_address         : arg0.token_address,
            chain_id              : arg0.chain_id,
        };
        0x2::event::emit<AssetEvent>(v0);
    }

    public(friend) fun update_asset_data<T0>(arg0: &mut Asset<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: bool, arg5: bool, arg6: 0x1::string::String, arg7: u64, arg8: vector<u8>, arg9: u16) {
        arg0.name = arg1;
        arg0.symbol = arg2;
        arg0.decimals = arg3;
        arg0.is_lend_coin = arg4;
        arg0.is_collateral_coin = arg5;
        arg0.price_feed_id = arg6;
        arg0.max_price_age_seconds = arg7;
        arg0.token_address = arg8;
        arg0.chain_id = arg9;
        let v0 = AssetEvent{
            id                    : 0x2::object::id<Asset<T0>>(arg0),
            name                  : arg0.name,
            symbol                : arg0.symbol,
            decimals              : arg0.decimals,
            is_lend_coin          : arg0.is_lend_coin,
            is_collateral_coin    : arg0.is_collateral_coin,
            price_feed_id         : arg0.price_feed_id,
            max_price_age_seconds : arg0.max_price_age_seconds,
            token_address         : arg0.token_address,
            chain_id              : arg0.chain_id,
        };
        0x2::event::emit<AssetEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

