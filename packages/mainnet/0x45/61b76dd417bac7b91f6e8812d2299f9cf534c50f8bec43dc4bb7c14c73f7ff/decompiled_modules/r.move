module 0x4561b76dd417bac7b91f6e8812d2299f9cf534c50f8bec43dc4bb7c14c73f7ff::r {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    struct R has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        access_list: vector<address>,
        total_swaps: u64,
        total_settlements: u64,
    }

    struct SwapEvent has copy, drop {
        dex: u8,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        profit: u64,
        recipient: address,
    }

    fun access_check(arg0: &R, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.access_list, &v0), 1);
    }

    public fun admin(arg0: &R) : address {
        arg0.admin
    }

    fun admin_check(arg0: &R, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
    }

    public fun assert_min_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 6);
    }

    public fun bluefin_a2b<T0, T1>(arg0: &mut R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, true, true, v0, 4295048017);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg3);
        emit_swap_and_count(arg0, 19, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun bluefin_b2a<T0, T1>(arg0: &mut R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, false, true, v0, 79226673515401279992447579054);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg3);
        emit_swap_and_count(arg0, 19, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun bluefin_flash_a2b<T0, T1>(arg0: &R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, 0x2::balance::Balance<T1>) {
        access_check(arg0, arg5);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, true, false, arg3, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>{
            r : v3,
            a : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (v4, v1)
    }

    public fun bluefin_flash_b2a<T0, T1>(arg0: &R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, 0x2::balance::Balance<T0>) {
        access_check(arg0, arg5);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, false, false, arg3, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>{
            r : v3,
            a : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (v4, v0)
    }

    public fun bluefin_repay_a2b<T0, T1>(arg0: &mut R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let LL {
            r : v0,
            a : v1,
        } = arg4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, v1), 0x2::balance::zero<T1>(), v0);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg3
    }

    public fun bluefin_repay_b2a<T0, T1>(arg0: &mut R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let LL {
            r : v0,
            a : v1,
        } = arg4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v1), v0);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg3
    }

    public fun cetus_dependency_marker<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
    }

    fun emit_swap_and_count(arg0: &mut R, arg1: u8, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = SwapEvent{
            dex        : arg1,
            a2b        : arg2,
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<SwapEvent>(v0);
        arg0.total_swaps = arg0.total_swaps + 1;
    }

    public fun grant_access(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        let v0 = &mut arg0.access_list;
        grant_access_if_absent(v0, arg1);
    }

    fun grant_access_if_absent(arg0: &mut vector<address>, arg1: address) {
        if (!0x1::vector::contains<address>(arg0, &arg1)) {
            0x1::vector::push_back<address>(arg0, arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        r_new(arg0);
    }

    public fun migrate(arg0: &mut R, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun r_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = R{
            id                : 0x2::object::new(arg0),
            version           : 1,
            admin             : 0x2::tx_context::sender(arg0),
            access_list       : v0,
            total_swaps       : 0,
            total_settlements : 0,
        };
        0x2::transfer::share_object<R>(v1);
    }

    public fun revoke_access(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        let v0 = &mut arg0.access_list;
        revoke_all_access_entries(v0, arg1);
    }

    fun revoke_all_access_entries(arg0: &mut vector<address>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        let v2 = v0;
        let v3 = v1;
        while (v2) {
            0x1::vector::remove<address>(arg0, v3);
            let (v4, v5) = 0x1::vector::index_of<address>(arg0, &arg1);
            v2 = v4;
            v3 = v5;
        };
    }

    public fun total_settlements(arg0: &R) : u64 {
        arg0.total_settlements
    }

    public fun total_swaps(arg0: &R) : u64 {
        arg0.total_swaps
    }

    public fun transfer_admin(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun version(arg0: &R) : u64 {
        arg0.version
    }

    public fun xz<T0>(arg0: &mut R, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        access_check(arg0, arg3);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = ProfitEvent<T0>{
            profit    : v0,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProfitEvent<T0>>(v1);
        arg0.total_settlements = arg0.total_settlements + 1;
        0x2::coin::from_balance<T0>(arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

