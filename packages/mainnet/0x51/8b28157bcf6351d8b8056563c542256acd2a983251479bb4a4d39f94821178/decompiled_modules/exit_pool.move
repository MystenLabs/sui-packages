module 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::exit_pool {
    struct ExitPool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        allowed: 0x2::vec_set::VecSet<0x2::object::ID>,
        min_face: u64,
        free: 0x2::balance::Balance<T0>,
        tickets: vector<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>,
        face_total: u64,
        units_total: u64,
        base_bps: u64,
        slope_bps: u64,
        max_bps: u64,
        max_util_bps: u64,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct LpPosition has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        units: u64,
    }

    struct TicketBought has copy, drop {
        pool: 0x2::object::ID,
        vault: 0x2::object::ID,
        face: u64,
        paid: u64,
        discount_bps: u64,
    }

    struct TicketsCranked has copy, drop {
        pool: 0x2::object::ID,
        vault: 0x2::object::ID,
        count: u64,
        amount: u64,
    }

    public fun allow_vault<T0>(arg0: &mut ExitPool<T0>, arg1: &PoolCap, arg2: 0x2::object::ID) {
        assert_cap<T0>(arg0, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed, arg2);
        };
    }

    fun assert_cap<T0>(arg0: &ExitPool<T0>, arg1: &PoolCap) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<ExitPool<T0>>(arg0), 1);
    }

    fun assert_version<T0>(arg0: &ExitPool<T0>) {
        assert!(arg0.version == 1, 8);
    }

    fun check(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg2 <= 2000 && arg0 <= arg2, 5);
        assert!(arg1 <= 2000, 5);
        assert!(arg3 <= 10000, 5);
    }

    public fun crank<T0, T1>(arg0: &mut ExitPool<T0>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(&arg0.tickets)) {
            let v4 = 0x1::vector::borrow<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(&arg0.tickets, v1);
            if (0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::ticket_vault(v4) == v0 && 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_ticket_funded<T0, T1>(arg1, v4)) {
                let v5 = 0x1::vector::swap_remove<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(&mut arg0.tickets, v1);
                let v6 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::ticket_amount(&v5);
                0x2::balance::join<T0>(&mut arg0.free, 0x2::coin::into_balance<T0>(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::claim<T0, T1>(arg1, v5, arg2)));
                arg0.face_total = arg0.face_total - v6;
                v2 = v2 + 1;
                v3 = v3 + v6;
                continue
            };
            v1 = v1 + 1;
        };
        if (v2 > 0) {
            let v7 = TicketsCranked{
                pool   : 0x2::object::id<ExitPool<T0>>(arg0),
                vault  : v0,
                count  : v2,
                amount : v3,
            };
            0x2::event::emit<TicketsCranked>(v7);
        };
    }

    public fun create<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : PoolCap {
        check(arg0, arg1, arg2, arg3);
        let v0 = ExitPool<T0>{
            id           : 0x2::object::new(arg4),
            version      : 1,
            allowed      : 0x2::vec_set::empty<0x2::object::ID>(),
            min_face     : 0,
            free         : 0x2::balance::zero<T0>(),
            tickets      : 0x1::vector::empty<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(),
            face_total   : 0,
            units_total  : 0,
            base_bps     : arg0,
            slope_bps    : arg1,
            max_bps      : arg2,
            max_util_bps : arg3,
        };
        let v1 = PoolCap{
            id   : 0x2::object::new(arg4),
            pool : 0x2::object::id<ExitPool<T0>>(&v0),
        };
        0x2::transfer::share_object<ExitPool<T0>>(v0);
        v1
    }

    public fun deposit<T0>(arg0: &mut ExitPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : LpPosition {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = pool_value<T0>(arg0);
        let v2 = if (arg0.units_total == 0 || v1 == 0) {
            v0
        } else {
            mul_div(v0, arg0.units_total, v1)
        };
        assert!(v2 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.free, 0x2::coin::into_balance<T0>(arg1));
        arg0.units_total = arg0.units_total + v2;
        LpPosition{
            id    : 0x2::object::new(arg2),
            pool  : 0x2::object::id<ExitPool<T0>>(arg0),
            units : v2,
        }
    }

    public fun destroy_empty_position(arg0: LpPosition) {
        let LpPosition {
            id    : v0,
            pool  : _,
            units : v2,
        } = arg0;
        assert!(v2 == 0, 2);
        0x2::object::delete(v0);
    }

    public fun disallow_vault<T0>(arg0: &mut ExitPool<T0>, arg1: &PoolCap, arg2: 0x2::object::ID) {
        assert_cap<T0>(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed, &arg2);
        };
    }

    public fun face_total<T0>(arg0: &ExitPool<T0>) : u64 {
        arg0.face_total
    }

    public fun free_value<T0>(arg0: &ExitPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.free)
    }

    public fun is_allowed<T0>(arg0: &ExitPool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &arg1)
    }

    public fun migrate<T0>(arg0: &mut ExitPool<T0>, arg1: &PoolCap) {
        assert!(arg1.pool == 0x2::object::id<ExitPool<T0>>(arg0), 1);
        assert!(arg0.version < 1, 8);
        arg0.version = 1;
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun pool_value<T0>(arg0: &ExitPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.free) + arg0.face_total
    }

    public fun quote_discount<T0>(arg0: &ExitPool<T0>, arg1: u64) : u64 {
        let v0 = pool_value<T0>(arg0);
        if (v0 == 0) {
            return arg0.max_bps
        };
        min(arg0.base_bps + mul_div(arg0.slope_bps, min(mul_div(arg0.face_total + arg1, 10000, v0), 10000), 10000), arg0.max_bps)
    }

    public fun sell_ticket<T0, T1>(arg0: &mut ExitPool<T0>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::ticket_vault(&arg2) == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1), 1);
        let v0 = 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &v0), 7);
        assert!(0x1::vector::length<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(&arg0.tickets) < 1024, 6);
        let v1 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::ticket_amount(&arg2);
        assert!(v1 >= arg0.min_face && v1 >= pool_value<T0>(arg0) / 1024, 2);
        let v2 = quote_discount<T0>(arg0, v1);
        let v3 = mul_div(v1, 10000 - v2, 10000);
        assert!(v3 > 0, 2);
        assert!(v3 >= arg3, 4);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.free), 3);
        assert!(mul_div(arg0.face_total + v1, 10000, pool_value<T0>(arg0)) <= arg0.max_util_bps, 6);
        arg0.face_total = arg0.face_total + v1;
        0x1::vector::push_back<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(&mut arg0.tickets, arg2);
        let v4 = TicketBought{
            pool         : 0x2::object::id<ExitPool<T0>>(arg0),
            vault        : 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1),
            face         : v1,
            paid         : v3,
            discount_bps : v2,
        };
        0x2::event::emit<TicketBought>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free, v3), arg4)
    }

    public fun set_min_face<T0>(arg0: &mut ExitPool<T0>, arg1: &PoolCap, arg2: u64) {
        assert_cap<T0>(arg0, arg1);
        arg0.min_face = arg2;
    }

    public fun set_pricing<T0>(arg0: &mut ExitPool<T0>, arg1: &PoolCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_cap<T0>(arg0, arg1);
        check(arg2, arg3, arg4, arg5);
        arg0.base_bps = arg2;
        arg0.slope_bps = arg3;
        arg0.max_bps = arg4;
        arg0.max_util_bps = arg5;
    }

    public fun ticket_count<T0>(arg0: &ExitPool<T0>) : u64 {
        0x1::vector::length<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::WithdrawTicket>(&arg0.tickets)
    }

    public fun units(arg0: &LpPosition) : u64 {
        arg0.units
    }

    public fun withdraw<T0>(arg0: &mut ExitPool<T0>, arg1: &mut LpPosition, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<ExitPool<T0>>(arg0), 1);
        assert!(arg2 > 0 && arg2 <= arg1.units, 2);
        let v0 = mul_div(arg2, pool_value<T0>(arg0), arg0.units_total);
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.free), 3);
        if (arg0.face_total > 0) {
            assert!((arg0.face_total as u128) * (10000 as u128) <= ((pool_value<T0>(arg0) - v0) as u128) * (arg0.max_util_bps as u128), 6);
        };
        arg1.units = arg1.units - arg2;
        arg0.units_total = arg0.units_total - arg2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free, v0), arg3)
    }

    // decompiled from Move bytecode v7
}

