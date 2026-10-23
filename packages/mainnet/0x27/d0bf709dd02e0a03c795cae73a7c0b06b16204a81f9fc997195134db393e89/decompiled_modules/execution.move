module 0x27d0bf709dd02e0a03c795cae73a7c0b06b16204a81f9fc997195134db393e89::execution {
    struct RouteExecution<phantom T0> has copy, drop {
        candidate_index: u64,
        principal: u64,
        amount_out: u64,
        realized_profit: u64,
    }

    struct RouteSettlement<phantom T0> has copy, drop {
        candidate_index: u64,
        principal: u64,
        amount_out: u64,
        realized_profit: u64,
        realized_loss: u64,
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

    struct AuxiliaryFeeEstimate<phantom T0> has copy, drop {
        estimated_fee: u64,
    }

    public fun assert_auxiliary_fee_cap<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
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
        let v0 = arg1 - 0x2::coin::value<T0>(arg0);
        assert!(v0 <= arg2, 405);
        v0
    }

    fun assert_realized<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!((0x2::coin::value<T0>(arg0) as u128) >= (arg1 as u128) + (arg2 as u128), 403);
    }

    public fun capital_balance<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun executable_profit(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: u128) : u128 {
        if (is_executable(arg0, arg1)) {
            0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::gross_profit(arg0)
        } else {
            0
        }
    }

    fun execution_amount(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : u64 {
        (0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::amount_in(arg0) as u64)
    }

    public fun execution_rejection_code(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: u128) : u64 {
        if (is_executable(arg0, arg1)) {
            return 0
        };
        if (0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::found(arg0)) {
            return 411
        };
        if (0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::coarse_rejected(arg0)) {
            return 413
        };
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::search_rejection_code(0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::status(arg0))
    }

    public fun funding_capacity(arg0: u64) : u128 {
        (arg0 as u128)
    }

    public fun is_complete_executable(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: u128) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::complete(arg0) && is_executable(arg0, arg1)
    }

    public fun is_executable(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: u128) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::found(arg0) && 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::gross_profit(arg0) >= arg1
    }

    public fun optional_is_some<T0>(arg0: &0x1::option::Option<0x2::coin::Coin<T0>>) : bool {
        0x1::option::is_some<0x2::coin::Coin<T0>>(arg0)
    }

    public fun prepare_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, u64) {
        if (!is_executable(arg1, arg2)) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0)
        };
        let v0 = execution_amount(arg1);
        record_search_auxiliary_fee<T0>(arg1);
        (0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg3)), v0)
    }

    public fun prepare_required<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = require_amount(arg1, arg2);
        record_search_auxiliary_fee<T0>(arg1);
        (0x2::coin::split<T0>(arg0, v0, arg3), v0)
    }

    public fun prepare_selected_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg2: bool, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, u64) {
        if (!arg2) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0)
        };
        prepare_optional<T0>(arg0, arg1, arg3, arg4)
    }

    public fun private_funding_capacity<T0: key>(arg0: &T0) : u128 {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8) {
            v1 = v1 | (*0x1::vector::borrow<u8>(&v0, 32 + v2) as u128) << ((v2 * 8) as u8);
            v2 = v2 + 1;
        };
        v1
    }

    public fun record_auxiliary_fee_estimate<T0>(arg0: u64) {
        let v0 = AuxiliaryFeeEstimate<T0>{estimated_fee: arg0};
        0x2::event::emit<AuxiliaryFeeEstimate<T0>>(v0);
    }

    fun record_search_auxiliary_fee<T0>(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) {
        let v0 = 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::auxiliary_fee_estimate(arg0);
        if (v0 > 0) {
            record_auxiliary_fee_estimate<T0>((v0 as u64));
        };
    }

    public fun require_amount(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: u128) : u64 {
        let v0 = execution_rejection_code(arg0, arg1);
        assert!(v0 == 0, v0);
        execution_amount(arg0)
    }

    public fun select_non_overlapping(arg0: vector<u128>, arg1: vector<u64>) : vector<bool> {
        let v0 = 0x1::vector::length<u128>(&arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
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

    public fun selected_maximum_principal(arg0: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>, arg1: &vector<bool>, arg2: vector<u128>) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(&arg0)) {
            if (*0x1::vector::borrow<bool>(arg1, v2) && is_executable(0x1::vector::borrow<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(&arg0, v2), *0x1::vector::borrow<u128>(&arg2, v2))) {
                let v3 = execution_amount(0x1::vector::borrow<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(&arg0, v2));
                if (v3 > v0) {
                    v1 = v3;
                };
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 400);
        v1
    }

    public fun selected_total_principal(arg0: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>, arg1: &vector<bool>, arg2: vector<u128>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(&arg0)) {
            let v2 = 0x1::vector::borrow<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(&arg0, v1);
            if (*0x1::vector::borrow<bool>(arg1, v1) && is_executable(v2, *0x1::vector::borrow<u128>(&arg2, v1))) {
                v0 = v0 + (execution_amount(v2) as u128);
            };
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 400);
        (v0 as u64)
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
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return (false, 0)
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1);
        assert_realized<T0>(&v0, arg2, arg3);
        0x2::coin::join<T0>(arg0, v0);
        (true, 0x2::coin::value<T0>(&v0))
    }

    public fun settle_optional_netted_indexed<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return false
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = if (v1 >= arg2) {
            v1 - arg2
        } else {
            0
        };
        let v3 = if (v1 < arg2) {
            arg2 - v1
        } else {
            0
        };
        0x2::coin::join<T0>(arg0, v0);
        let v4 = RouteSettlement<T0>{
            candidate_index : arg4,
            principal       : arg2,
            amount_out      : v1,
            realized_profit : v2,
            realized_loss   : v3,
        };
        0x2::event::emit<RouteSettlement<T0>>(v4);
        true
    }

    public fun settle_required<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64) {
        assert_realized<T0>(&arg1, arg2, arg3);
        0x2::coin::join<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

