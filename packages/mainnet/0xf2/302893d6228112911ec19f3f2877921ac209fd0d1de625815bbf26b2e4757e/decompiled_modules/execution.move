module 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::execution {
    struct RouteExecution<phantom T0> has copy, drop {
        candidate_index: u64,
        principal: u64,
        amount_out: u64,
        realized_profit: u64,
    }

    struct BatchExecution<phantom T0> has copy, drop {
        starting_balance: u64,
        ending_balance: u64,
        realized_profit: u64,
    }

    struct AuxiliaryFee<phantom T0> has copy, drop {
        starting_balance: u64,
        ending_balance: u64,
        spent: u64,
    }

    public fun assert_auxiliary_fee_cap<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 <= arg1, 405);
        let v1 = arg1 - v0;
        assert!(v1 <= arg2, 405);
        let v2 = AuxiliaryFee<T0>{
            starting_balance : arg1,
            ending_balance   : v0,
            spent            : v1,
        };
        0x2::event::emit<AuxiliaryFee<T0>>(v2);
        v0
    }

    public fun assert_batch_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!((v0 as u128) >= (arg1 as u128) + (arg2 as u128), 403);
        let v1 = v0 - arg1;
        let v2 = BatchExecution<T0>{
            starting_balance : arg1,
            ending_balance   : v0,
            realized_profit  : v1,
        };
        0x2::event::emit<BatchExecution<T0>>(v2);
        v1
    }

    public fun assert_maximum_asset_loss<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 <= arg1, 405);
        let v1 = arg1 - v0;
        assert!(v1 <= arg2, 405);
        v1
    }

    fun assert_realized<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!((0x2::coin::value<T0>(arg0) as u128) >= (arg1 as u128) + (arg2 as u128), 403);
    }

    public fun capital_balance<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    fun checked_amount(arg0: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult) : u64 {
        let v0 = 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::amount_in(arg0);
        assert!(v0 > 0 && v0 <= 18446744073709551615, 401);
        (v0 as u64)
    }

    public fun executable_profit(arg0: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg1: u128) : u128 {
        if (is_executable(arg0, arg1)) {
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::gross_profit(arg0)
        } else {
            0
        }
    }

    public fun is_complete_executable(arg0: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg1: u128) : bool {
        0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::complete(arg0) && is_executable(arg0, arg1)
    }

    public fun is_executable(arg0: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg1: u128) : bool {
        if (0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::found(arg0)) {
            if (0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::amount_in(arg0) > 0) {
                if (0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::amount_in(arg0) <= 18446744073709551615) {
                    0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::gross_profit(arg0) >= arg1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun optional_is_some<T0>(arg0: &0x1::option::Option<0x2::coin::Coin<T0>>) : bool {
        0x1::option::is_some<0x2::coin::Coin<T0>>(arg0)
    }

    public fun prepare_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, u64) {
        if (!is_executable(arg1, arg2)) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0)
        };
        let v0 = checked_amount(arg1);
        (0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg3)), v0)
    }

    public fun prepare_required<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = require_amount(arg1, arg2);
        (0x2::coin::split<T0>(arg0, v0, arg3), v0)
    }

    public fun prepare_selected_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg2: bool, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, u64) {
        if (!arg2) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0)
        };
        prepare_optional<T0>(arg0, arg1, arg3, arg4)
    }

    public fun require_amount(arg0: &0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult, arg1: u128) : u64 {
        assert!(is_executable(arg0, arg1), 400);
        checked_amount(arg0)
    }

    public fun select_non_overlapping(arg0: vector<u128>, arg1: vector<u64>) : vector<bool> {
        let v0 = 0x1::vector::length<u128>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1) && v0 <= 64, 404);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            assert!(*0x1::vector::borrow<u64>(&arg1, v2) & 1 << (v2 as u8) == 0, 404);
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            v2 = 0;
            while (v2 < v0) {
                if (v3 & 1 << (v2 as u8) == 0) {
                };
                v2 = v2 + 1;
            };
            if (v0 == v0) {
                break
            };
            *0x1::vector::borrow_mut<bool>(&mut v1, v0) = true;
            let v5 = v3 | 1 << (v0 as u8);
            v3 = v5 | *0x1::vector::borrow<u64>(&arg1, v0);
            v4 = v4 + 1;
        };
        v1
    }

    public fun selected_at(arg0: &vector<bool>, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(arg0, arg1)
    }

    public fun settle_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64) : bool {
        let (v0, _) = settle_optional_inner<T0>(arg0, arg1, arg2, arg3);
        v0
    }

    public fun settle_optional_indexed<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u64) : bool {
        let (v0, v1) = settle_optional_inner<T0>(arg0, arg1, arg2, arg3);
        if (v0) {
            let v2 = RouteExecution<T0>{
                candidate_index : arg4,
                principal       : arg2,
                amount_out      : v1,
                realized_profit : v1 - arg2,
            };
            0x2::event::emit<RouteExecution<T0>>(v2);
        };
        v0
    }

    fun settle_optional_inner<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64) : (bool, u64) {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            assert!(arg2 == 0, 402);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return (false, 0)
        };
        assert!(arg2 > 0, 402);
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1);
        assert_realized<T0>(&v0, arg2, arg3);
        0x2::coin::join<T0>(arg0, v0);
        (true, 0x2::coin::value<T0>(&v0))
    }

    public fun settle_required<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 402);
        assert_realized<T0>(&arg1, arg2, arg3);
        0x2::coin::join<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

