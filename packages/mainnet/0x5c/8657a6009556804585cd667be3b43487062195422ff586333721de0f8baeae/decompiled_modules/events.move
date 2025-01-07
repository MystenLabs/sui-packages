module 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::events {
    struct ConnectorCreated<phantom T0> has copy, drop {
        connector_id: 0x2::object::ID,
    }

    struct BondingCurveCreated<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        coin_name: 0x1::string::String,
        ticker: 0x1::ascii::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    struct BondingCurveBuy<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
        pre_price: u64,
        post_price: u64,
        sender: address,
        is_dev_buy: bool,
        virtual_sui_amount: u64,
        post_sui_balance: u64,
        post_token_balance: u64,
        available_token_reserves: u64,
    }

    struct BondingCurveSell<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
        pre_price: u64,
        post_price: u64,
        virtual_sui_amount: u64,
        post_sui_balance: u64,
        post_token_balance: u64,
        available_token_reserves: u64,
    }

    struct BondingCurveComplete<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
    }

    struct BondingCurveMigrate<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        to_pool_id: 0x2::object::ID,
    }

    public(friend) fun emit_buy<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = BondingCurveBuy<T0>{
            curve_id                 : arg0,
            sui_amount               : arg1,
            token_amount             : arg2,
            pre_price                : arg3,
            post_price               : arg4,
            sender                   : arg5,
            is_dev_buy               : arg6,
            virtual_sui_amount       : arg7,
            post_sui_balance         : arg8,
            post_token_balance       : arg9,
            available_token_reserves : arg10,
        };
        0x2::event::emit<BondingCurveBuy<T0>>(v0);
    }

    public(friend) fun emit_complete<T0>(arg0: 0x2::object::ID) {
        let v0 = BondingCurveComplete<T0>{curve_id: arg0};
        0x2::event::emit<BondingCurveComplete<T0>>(v0);
    }

    public(friend) fun emit_connector_create<T0>(arg0: 0x2::object::ID) {
        let v0 = ConnectorCreated<T0>{connector_id: arg0};
        0x2::event::emit<ConnectorCreated<T0>>(v0);
    }

    public(friend) fun emit_curve_create<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x2::url::Url>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String) {
        let v0 = BondingCurveCreated<T0>{
            curve_id    : arg0,
            creator     : arg1,
            coin_name   : arg2,
            ticker      : arg3,
            description : arg4,
            image_url   : arg5,
            twitter     : arg6,
            website     : arg7,
            telegram    : arg8,
        };
        0x2::event::emit<BondingCurveCreated<T0>>(v0);
    }

    public(friend) fun emit_migrate<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = BondingCurveMigrate<T0>{
            curve_id   : arg0,
            to_pool_id : arg1,
        };
        0x2::event::emit<BondingCurveMigrate<T0>>(v0);
    }

    public(friend) fun emit_sell<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = BondingCurveSell<T0>{
            curve_id                 : arg0,
            sui_amount               : arg1,
            token_amount             : arg2,
            pre_price                : arg3,
            post_price               : arg4,
            virtual_sui_amount       : arg5,
            post_sui_balance         : arg6,
            post_token_balance       : arg7,
            available_token_reserves : arg8,
        };
        0x2::event::emit<BondingCurveSell<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

