module 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::events {
    struct ConnectorCreated<phantom T0> has copy, drop {
        connector_id: 0x2::object::ID,
        creator: address,
    }

    struct BondingCurveCreated<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
    }

    struct BondingCurveBuy<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        buy_amount: u64,
        buyer: address,
        virtual_sui_amount: u64,
        post_sui_balance: u64,
        post_token_balance: u64,
    }

    struct BondingCurveSell<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        sell_amount: u64,
        seller: address,
        virtual_sui_amount: u64,
        post_sui_balance: u64,
        post_token_balance: u64,
    }

    struct BondingCurveComplete<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        sui_amount: u64,
    }

    struct BondingCurveMigrate<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
    }

    public(friend) fun emit_buy<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BondingCurveBuy<T0>{
            curve_id           : arg0,
            buy_amount         : arg1,
            buyer              : arg2,
            virtual_sui_amount : arg3,
            post_sui_balance   : arg4,
            post_token_balance : arg5,
        };
        0x2::event::emit<BondingCurveBuy<T0>>(v0);
    }

    public(friend) fun emit_complete<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BondingCurveComplete<T0>{
            curve_id   : arg0,
            sui_amount : arg1,
        };
        0x2::event::emit<BondingCurveComplete<T0>>(v0);
    }

    public(friend) fun emit_connector_create<T0>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ConnectorCreated<T0>{
            connector_id : arg0,
            creator      : arg1,
        };
        0x2::event::emit<ConnectorCreated<T0>>(v0);
    }

    public(friend) fun emit_curve_create<T0>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = BondingCurveCreated<T0>{
            curve_id : arg0,
            creator  : arg1,
        };
        0x2::event::emit<BondingCurveCreated<T0>>(v0);
    }

    public(friend) fun emit_migrate<T0>(arg0: 0x2::object::ID) {
        let v0 = BondingCurveMigrate<T0>{curve_id: arg0};
        0x2::event::emit<BondingCurveMigrate<T0>>(v0);
    }

    public(friend) fun emit_sell<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BondingCurveSell<T0>{
            curve_id           : arg0,
            sell_amount        : arg1,
            seller             : arg2,
            virtual_sui_amount : arg3,
            post_sui_balance   : arg4,
            post_token_balance : arg5,
        };
        0x2::event::emit<BondingCurveSell<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

