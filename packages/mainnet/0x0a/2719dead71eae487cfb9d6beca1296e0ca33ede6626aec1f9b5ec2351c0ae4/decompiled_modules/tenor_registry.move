module 0x3799d826b982e62e033ebfe4bca1aba4b5ab8d3cc31d5ea908fb5072b2ffddc4::tenor_registry {
    struct MarketInfo has copy, drop, store {
        market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        maturity_token_type: 0x1::type_name::TypeName,
        maturity: u64,
        name: 0x1::string::String,
    }

    struct PoolInfo has copy, drop, store {
        dex: 0x1::string::String,
        pool_id: address,
    }

    struct MarketRegistry has key {
        id: 0x2::object::UID,
        markets: 0x2::table::Table<0x2::object::ID, MarketInfo>,
    }

    public fun find_market_info(arg0: &MarketRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<MarketInfo> {
        if (0x2::table::contains<0x2::object::ID, MarketInfo>(&arg0.markets, arg1)) {
            0x1::option::some<MarketInfo>(*0x2::table::borrow<0x2::object::ID, MarketInfo>(&arg0.markets, arg1))
        } else {
            0x1::option::none<MarketInfo>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry{
            id      : 0x2::object::new(arg0),
            markets : 0x2::table::new<0x2::object::ID, MarketInfo>(arg0),
        };
        0x2::transfer::share_object<MarketRegistry>(v0);
    }

    public fun market_count(arg0: &MarketRegistry) : u64 {
        0x2::table::length<0x2::object::ID, MarketInfo>(&arg0.markets)
    }

    public fun market_info_coin_type(arg0: &MarketInfo) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun market_info_market_id(arg0: &MarketInfo) : 0x2::object::ID {
        arg0.market_id
    }

    public fun market_info_maturity(arg0: &MarketInfo) : u64 {
        arg0.maturity
    }

    public fun market_info_maturity_token_type(arg0: &MarketInfo) : 0x1::type_name::TypeName {
        arg0.maturity_token_type
    }

    public fun market_info_name(arg0: &MarketInfo) : 0x1::string::String {
        arg0.name
    }

    public fun pool_info(arg0: &MarketRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<PoolInfo> {
        if (0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg1)) {
            0x1::option::some<PoolInfo>(*0x2::dynamic_field::borrow<0x2::object::ID, PoolInfo>(&arg0.id, arg1))
        } else {
            0x1::option::none<PoolInfo>()
        }
    }

    public fun pool_info_dex(arg0: &PoolInfo) : 0x1::string::String {
        arg0.dex
    }

    public fun pool_info_pool_id(arg0: &PoolInfo) : address {
        arg0.pool_id
    }

    public(friend) fun register_market(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: 0x1::string::String) {
        let v0 = MarketInfo{
            market_id           : arg1,
            coin_type           : arg2,
            maturity_token_type : arg3,
            maturity            : arg4,
            name                : arg5,
        };
        0x2::table::add<0x2::object::ID, MarketInfo>(&mut arg0.markets, arg1, v0);
    }

    public(friend) fun set_pool_info(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: address) {
        if (0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg1)) {
            let v0 = PoolInfo{
                dex     : arg2,
                pool_id : arg3,
            };
            *0x2::dynamic_field::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg0.id, arg1) = v0;
        } else {
            let v1 = PoolInfo{
                dex     : arg2,
                pool_id : arg3,
            };
            0x2::dynamic_field::add<0x2::object::ID, PoolInfo>(&mut arg0.id, arg1, v1);
        };
        0x3799d826b982e62e033ebfe4bca1aba4b5ab8d3cc31d5ea908fb5072b2ffddc4::events::emit_pool_info_set(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

