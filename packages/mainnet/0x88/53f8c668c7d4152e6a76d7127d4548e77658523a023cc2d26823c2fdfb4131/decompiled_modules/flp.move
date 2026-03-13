module 0x8853f8c668c7d4152e6a76d7127d4548e77658523a023cc2d26823c2fdfb4131::flp {
    struct FLP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FLPAmount has store {
        usdc_flp_amount: u64,
        sui_flp_amount: u64,
    }

    struct ObligationFLP has store {
        amount: FLPAmount,
        scanned: bool,
    }

    struct FLPApp has store, key {
        id: 0x2::object::UID,
        has_ended: bool,
        version: u64,
        total_amount: FLPAmount,
        obligation_flps: 0x2::table::Table<0x2::object::ID, ObligationFLP>,
    }

    struct FLPAmountUpdated has copy, drop {
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    fun borrow_or_create_obligation_flp(arg0: &mut 0x2::table::Table<0x2::object::ID, ObligationFLP>, arg1: 0x2::object::ID) : &mut ObligationFLP {
        if (!0x2::table::contains<0x2::object::ID, ObligationFLP>(arg0, arg1)) {
            let v0 = ObligationFLP{
                amount  : new_flp_amount(),
                scanned : false,
            };
            0x2::table::add<0x2::object::ID, ObligationFLP>(arg0, arg1, v0);
        };
        0x2::table::borrow_mut<0x2::object::ID, ObligationFLP>(arg0, arg1)
    }

    fun calculate_new_quota(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(arg1), arg2));
        if (arg0 >= v0) {
            return arg1
        };
        let v1 = ceiling_div(v0 - arg0, arg2);
        if (arg1 <= v1) {
            0
        } else {
            arg1 - v1
        }
    }

    fun calculate_obligation_asset_flp_quota<T0>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::Obligation<T0>, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) : u64 {
        calculate_new_quota(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::exchange_rate<T0>(arg0, arg2), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ctoken_amount_by_coin<T0>(arg1, arg2))), arg3, arg4)
    }

    fun ceiling_div(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun deposit<T0>(arg0: &mut FLPApp, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market_type::MainMarket>, arg3: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        ensure_not_stop(arg0);
        let v0 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::id(arg3);
        let v1 = &mut arg0.obligation_flps;
        let v2 = borrow_or_create_obligation_flp(v1, v0);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        if (v3 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v4 = 0x2::coin::value<T0>(&arg4) / 5000000000;
            v2.amount.sui_flp_amount = v2.amount.sui_flp_amount + v4;
            arg0.total_amount.sui_flp_amount = arg0.total_amount.sui_flp_amount + v4;
        } else {
            assert!(v3 == 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 5);
            let v5 = 0x2::coin::value<T0>(&arg4) / 5000000;
            v2.amount.usdc_flp_amount = v2.amount.usdc_flp_amount + v5;
            arg0.total_amount.usdc_flp_amount = arg0.total_amount.usdc_flp_amount + v5;
        };
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::deposit::deposit<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market_type::MainMarket, T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v6 = &mut arg0.total_amount;
        refresh_obligation_flp_quota<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market_type::MainMarket>(v6, arg2, v0, v2);
        assert!(arg0.total_amount.sui_flp_amount <= 800, 1);
        assert!(arg0.total_amount.usdc_flp_amount <= 1200, 1);
    }

    fun ensure_not_stop(arg0: &FLPApp) {
        assert!(!arg0.has_ended, 0);
    }

    fun init(arg0: FLP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<FLP>(arg0, arg1);
        let (v0, v1) = init_app(arg1);
        0x2::transfer::public_share_object<FLPApp>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init_app(arg0: &mut 0x2::tx_context::TxContext) : (FLPApp, AdminCap) {
        let v0 = FLPApp{
            id              : 0x2::object::new(arg0),
            has_ended       : false,
            version         : 0,
            total_amount    : new_flp_amount(),
            obligation_flps : 0x2::table::new<0x2::object::ID, ObligationFLP>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun lock_flp(arg0: &AdminCap, arg1: &mut FLPApp, arg2: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market_type::MainMarket>, arg3: vector<0x2::object::ID>) {
        assert!(arg1.has_ended, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v0);
            assert!(0x2::table::contains<0x2::object::ID, ObligationFLP>(&arg1.obligation_flps, v1), 2);
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, ObligationFLP>(&mut arg1.obligation_flps, v1);
            assert!(!v2.scanned, 3);
            v2.scanned = true;
            let v3 = &mut arg1.total_amount;
            refresh_obligation_flp_quota<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market_type::MainMarket>(v3, arg2, v1, v2);
            v0 = v0 + 1;
        };
    }

    fun new_flp_amount() : FLPAmount {
        FLPAmount{
            usdc_flp_amount : 0,
            sui_flp_amount  : 0,
        }
    }

    public fun quotas_by_cap(arg0: &FLPApp, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap) : (u64, u64) {
        quotas_by_id(arg0, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::id(arg1))
    }

    public fun quotas_by_id(arg0: &FLPApp, arg1: 0x2::object::ID) : (u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, ObligationFLP>(&arg0.obligation_flps, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, ObligationFLP>(&arg0.obligation_flps, arg1);
        (v0.amount.sui_flp_amount, v0.amount.usdc_flp_amount)
    }

    fun refresh_obligation_flp_quota<T0>(arg0: &mut FLPAmount, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg2: 0x2::object::ID, arg3: &mut ObligationFLP) {
        let v0 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::borrow_obligation<T0>(arg1, arg2);
        let v1 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::deposit_types<T0>(v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
            if (v3 == &v4) {
                arg3.amount.sui_flp_amount = calculate_obligation_asset_flp_quota<T0>(arg1, v0, *v3, arg3.amount.sui_flp_amount, 5000000000);
                arg0.sui_flp_amount = arg0.sui_flp_amount + arg3.amount.sui_flp_amount - arg3.amount.sui_flp_amount;
                let v5 = FLPAmountUpdated{
                    obligation_id : arg2,
                    coin_type     : *v3,
                    amount        : arg3.amount.sui_flp_amount,
                };
                0x2::event::emit<FLPAmountUpdated>(v5);
            } else {
                let v6 = 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>();
                if (v3 == &v6) {
                    arg3.amount.usdc_flp_amount = calculate_obligation_asset_flp_quota<T0>(arg1, v0, *v3, arg3.amount.usdc_flp_amount, 5000000);
                    arg0.usdc_flp_amount = arg0.usdc_flp_amount + arg3.amount.usdc_flp_amount - arg3.amount.usdc_flp_amount;
                    let v7 = FLPAmountUpdated{
                        obligation_id : arg2,
                        coin_type     : *v3,
                        amount        : arg3.amount.usdc_flp_amount,
                    };
                    0x2::event::emit<FLPAmountUpdated>(v7);
                };
            };
            v2 = v2 + 1;
        };
    }

    public fun stop(arg0: &AdminCap, arg1: &mut FLPApp) {
        arg1.has_ended = true;
    }

    public fun sui_flp_cut_off_coin_amount() : u64 {
        5000000000
    }

    public fun sui_flp_total_quota() : u64 {
        800
    }

    public fun usdc_flp_cut_off_coin_amount() : u64 {
        5000000
    }

    public fun usdc_flp_total_quota() : u64 {
        1200
    }

    // decompiled from Move bytecode v6
}

