module 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events {
    struct BondingCurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        metadata_keys: vector<0x1::string::String>,
        metadata_values: vector<0x1::string::String>,
    }

    struct BondingCurveTrade has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        sui_amount: u64,
        token_amount: u64,
        pre_price: u64,
        post_price: u64,
        sender: address,
        is_buy: bool,
        virtual_sui_amount: u64,
        post_sui_balance: u64,
        post_token_balance: u64,
        available_token_reserves: u64,
        creator_fee: u64,
    }

    struct BondingCurveComplete has copy, drop {
        curve_id: 0x2::object::ID,
    }

    struct BondingCurveMigrate has copy, drop {
        curve_id: 0x2::object::ID,
        to_pool_id: 0x2::object::ID,
    }

    struct MemeConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
    }

    struct CoinUpdate has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        metadata_keys: vector<0x1::string::String>,
        metadata_values: vector<0x1::string::String>,
        update_message: 0x1::option::Option<0x1::string::String>,
    }

    struct CreatorFeeCollect has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        sui_amount: u64,
    }

    public(friend) fun emit_buy<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = BondingCurveTrade{
            curve_id                 : arg0,
            coin_type                : 0x1::type_name::with_defining_ids<T0>(),
            sui_amount               : arg1,
            token_amount             : arg2,
            pre_price                : arg3,
            post_price               : arg4,
            sender                   : arg5,
            is_buy                   : true,
            virtual_sui_amount       : arg6,
            post_sui_balance         : arg7,
            post_token_balance       : arg8,
            available_token_reserves : arg9,
            creator_fee              : arg10,
        };
        0x2::event::emit<BondingCurveTrade>(v0);
    }

    public(friend) fun emit_coin_update(arg0: 0x2::object::ID, arg1: address, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>) {
        let v0 = CoinUpdate{
            curve_id        : arg0,
            creator         : arg1,
            metadata_keys   : arg2,
            metadata_values : arg3,
            update_message  : arg4,
        };
        0x2::event::emit<CoinUpdate>(v0);
    }

    public(friend) fun emit_complete(arg0: 0x2::object::ID) {
        let v0 = BondingCurveComplete{curve_id: arg0};
        0x2::event::emit<BondingCurveComplete>(v0);
    }

    public(friend) fun emit_config_update(arg0: 0x2::object::ID) {
        let v0 = MemeConfigUpdated{config_id: arg0};
        0x2::event::emit<MemeConfigUpdated>(v0);
    }

    public(friend) fun emit_creator_fee_collect(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CreatorFeeCollect{
            curve_id   : arg0,
            creator    : arg1,
            sui_amount : arg2,
        };
        0x2::event::emit<CreatorFeeCollect>(v0);
    }

    public(friend) fun emit_curve_create(arg0: 0x2::object::ID, arg1: address, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        let v0 = BondingCurveCreated{
            curve_id        : arg0,
            creator         : arg1,
            metadata_keys   : arg2,
            metadata_values : arg3,
        };
        0x2::event::emit<BondingCurveCreated>(v0);
    }

    public(friend) fun emit_migrate(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = BondingCurveMigrate{
            curve_id   : arg0,
            to_pool_id : arg1,
        };
        0x2::event::emit<BondingCurveMigrate>(v0);
    }

    public(friend) fun emit_sell<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = BondingCurveTrade{
            curve_id                 : arg0,
            coin_type                : 0x1::type_name::with_defining_ids<T0>(),
            sui_amount               : arg1,
            token_amount             : arg2,
            pre_price                : arg3,
            post_price               : arg4,
            sender                   : arg5,
            is_buy                   : false,
            virtual_sui_amount       : arg6,
            post_sui_balance         : arg7,
            post_token_balance       : arg8,
            available_token_reserves : arg9,
            creator_fee              : arg10,
        };
        0x2::event::emit<BondingCurveTrade>(v0);
    }

    // decompiled from Move bytecode v6
}

