module 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position {
    struct YieldPosition<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        maturity_ms: u64,
        initial_rate: u64,
        backing_vault: 0x2::balance::Balance<T0>,
        total_face_outstanding: u64,
        split_count: u64,
        finalized: bool,
        final_rate: u64,
        principal_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        yield_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        pt_face_remaining: u64,
        yt_face_remaining: u64,
    }

    struct FinalizeReceipt<phantom T0> {
        market_id: 0x2::object::ID,
        backing_amount: u64,
        total_face_outstanding: u64,
    }

    public fun backing_value<T0>(arg0: &YieldPosition<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.backing_vault)
    }

    public(friend) fun begin_finalize<T0>(arg0: &mut YieldPosition<T0>) : (FinalizeReceipt<T0>, 0x2::balance::Balance<T0>) {
        assert!(!arg0.finalized, 0);
        assert!(arg0.total_face_outstanding > 0, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.backing_vault);
        assert!(v0 > 0, 6);
        let v1 = FinalizeReceipt<T0>{
            market_id              : 0x2::object::id<YieldPosition<T0>>(arg0),
            backing_amount         : v0,
            total_face_outstanding : arg0.total_face_outstanding,
        };
        (v1, 0x2::balance::withdraw_all<T0>(&mut arg0.backing_vault))
    }

    public(friend) fun complete_finalize<T0>(arg0: &mut YieldPosition<T0>, arg1: FinalizeReceipt<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>) : (u64, u64, u64) {
        let FinalizeReceipt {
            market_id              : v0,
            backing_amount         : v1,
            total_face_outstanding : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<YieldPosition<T0>>(arg0), 5);
        assert!(!arg0.finalized, 0);
        assert!(0x2::balance::value<T0>(&arg0.backing_vault) == 0, 4);
        assert!(v2 == arg0.total_face_outstanding, 2);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= v2, 3);
        let v4 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::math::rate_from_value(v3, v1);
        arg0.finalized = true;
        arg0.final_rate = v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.principal_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.yield_pool, arg2);
        arg0.pt_face_remaining = v2;
        arg0.yt_face_remaining = v2;
        (v2, v3 - v2, v4)
    }

    public(friend) fun deposit_backing<T0>(arg0: &mut YieldPosition<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        assert!(!arg0.finalized, 0);
        assert!(arg2 > 0, 6);
        0x2::balance::join<T0>(&mut arg0.backing_vault, arg1);
        arg0.total_face_outstanding = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::math::safe_add(arg0.total_face_outstanding, arg2);
        arg0.split_count = arg0.split_count + 1;
    }

    public fun final_rate<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.final_rate
    }

    public fun finalized<T0>(arg0: &YieldPosition<T0>) : bool {
        arg0.finalized
    }

    public fun initial_rate<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.initial_rate
    }

    public fun maturity_ms<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.maturity_ms
    }

    public(friend) fun new_market<T0>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : YieldPosition<T0> {
        YieldPosition<T0>{
            id                     : 0x2::object::new(arg3),
            owner                  : arg0,
            maturity_ms            : arg1,
            initial_rate           : arg2,
            backing_vault          : 0x2::balance::zero<T0>(),
            total_face_outstanding : 0,
            split_count            : 0,
            finalized              : false,
            final_rate             : 0,
            principal_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
            yield_pool             : 0x2::balance::zero<0x2::sui::SUI>(),
            pt_face_remaining      : 0,
            yt_face_remaining      : 0,
        }
    }

    public fun owner<T0>(arg0: &YieldPosition<T0>) : address {
        arg0.owner
    }

    public fun principal_pool_value<T0>(arg0: &YieldPosition<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.principal_pool)
    }

    public fun pt_face_remaining<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.pt_face_remaining
    }

    public(friend) fun share<T0>(arg0: YieldPosition<T0>) {
        0x2::transfer::share_object<YieldPosition<T0>>(arg0);
    }

    public fun split_count<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.split_count
    }

    public fun total_face_outstanding<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.total_face_outstanding
    }

    public(friend) fun withdraw_backing_for_early_exit<T0>(arg0: &mut YieldPosition<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(!arg0.finalized, 0);
        assert!(arg1 > 0, 6);
        assert!(arg1 <= arg0.total_face_outstanding, 2);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.backing_vault), 2);
        arg0.total_face_outstanding = arg0.total_face_outstanding - arg1;
        0x2::balance::split<T0>(&mut arg0.backing_vault, arg2)
    }

    public(friend) fun withdraw_principal<T0>(arg0: &mut YieldPosition<T0>, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.finalized, 1);
        let v0 = &mut arg0.principal_pool;
        let v1 = &mut arg0.pt_face_remaining;
        withdraw_sui_pool(v0, v1, arg1)
    }

    fun withdraw_sui_pool(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut u64, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg2 > 0, 6);
        assert!(arg2 <= *arg1, 2);
        let v0 = if (arg2 == *arg1) {
            0x2::balance::value<0x2::sui::SUI>(arg0)
        } else {
            0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::math::mul_div_down(0x2::balance::value<0x2::sui::SUI>(arg0), arg2, *arg1)
        };
        *arg1 = *arg1 - arg2;
        if (v0 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            0x2::balance::split<0x2::sui::SUI>(arg0, v0)
        }
    }

    public(friend) fun withdraw_yield<T0>(arg0: &mut YieldPosition<T0>, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.finalized, 1);
        let v0 = &mut arg0.yield_pool;
        let v1 = &mut arg0.yt_face_remaining;
        withdraw_sui_pool(v0, v1, arg1)
    }

    public fun yield_pool_value<T0>(arg0: &YieldPosition<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.yield_pool)
    }

    public fun yt_face_remaining<T0>(arg0: &YieldPosition<T0>) : u64 {
        arg0.yt_face_remaining
    }

    // decompiled from Move bytecode v7
}

