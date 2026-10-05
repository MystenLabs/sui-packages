module 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        traders: 0x2::vec_set::VecSet<address>,
        locked: bool,
        routers: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolKey has copy, drop, store {
        pool: 0x2::object::ID,
    }

    struct Ticket<phantom T0, phantom T1> {
        vault: 0x2::object::ID,
        router: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
        trader: address,
        amount_in: u64,
        min_out: u64,
    }

    struct Swapped has copy, drop {
        vault: 0x2::object::ID,
        pool: 0x2::object::ID,
        trader: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        spent: u64,
        out: u64,
    }

    struct TraderSet has copy, drop {
        vault: 0x2::object::ID,
        trader: address,
        allowed: bool,
    }

    struct RouterSet has copy, drop {
        vault: 0x2::object::ID,
        router: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct PoolSet has copy, drop {
        vault: 0x2::object::ID,
        pool: 0x2::object::ID,
        allowed: bool,
    }

    struct LockSet has copy, drop {
        vault: 0x2::object::ID,
        locked: bool,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    fun join<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun split<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0), 6);
        let v1 = 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 6);
        0x2::balance::split<T0>(v1, arg1)
    }

    fun check(arg0: &Vault, arg1: &OwnerCap) {
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 7);
        assert!(arg0.version == 1, 8);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: 0x2::coin::Coin<T0>) {
        check(arg0, arg1);
        join<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        let v0 = Deposited{
            vault  : 0x2::object::id<Vault>(arg0),
            coin   : 0x1::type_name::with_defining_ids<T0>(),
            amount : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun held<T0>(arg0: &Vault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            version : 1,
            traders : 0x2::vec_set::empty<address>(),
            locked  : true,
            routers : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<Vault>(&v0),
        };
        0x2::transfer::share_object<Vault>(v0);
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_listed(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        let v0 = PoolKey{pool: arg1};
        0x2::dynamic_field::exists<PoolKey>(&arg0.id, v0)
    }

    public fun is_locked(arg0: &Vault) : bool {
        arg0.locked
    }

    public fun is_router<T0>(arg0: &Vault) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.routers, &v0)
    }

    public fun is_trader(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.traders, &arg1)
    }

    public fun migrate(arg0: &mut Vault, arg1: &OwnerCap) {
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 7);
        assert!(arg0.version < 1, 8);
        arg0.version = 1;
    }

    public fun set_locked(arg0: &mut Vault, arg1: &OwnerCap, arg2: bool) {
        check(arg0, arg1);
        arg0.locked = arg2;
        let v0 = LockSet{
            vault  : 0x2::object::id<Vault>(arg0),
            locked : arg2,
        };
        0x2::event::emit<LockSet>(v0);
    }

    public fun set_pools(arg0: &mut Vault, arg1: &OwnerCap, arg2: vector<0x2::object::ID>, arg3: bool) {
        check(arg0, arg1);
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            let v2 = PoolKey{pool: v1};
            if (arg3) {
                if (!0x2::dynamic_field::exists<PoolKey>(&arg0.id, v2)) {
                    0x2::dynamic_field::add<PoolKey, bool>(&mut arg0.id, v2, true);
                };
            } else if (0x2::dynamic_field::exists<PoolKey>(&arg0.id, v2)) {
                0x2::dynamic_field::remove<PoolKey, bool>(&mut arg0.id, v2);
            };
            let v3 = PoolSet{
                vault   : 0x2::object::id<Vault>(arg0),
                pool    : v1,
                allowed : arg3,
            };
            0x2::event::emit<PoolSet>(v3);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    public fun set_router<T0: drop>(arg0: &mut Vault, arg1: &OwnerCap, arg2: bool) {
        check(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.routers, &v0)) {
                0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.routers, v0);
            };
        } else if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.routers, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.routers, &v0);
        };
        let v1 = RouterSet{
            vault   : 0x2::object::id<Vault>(arg0),
            router  : v0,
            allowed : arg2,
        };
        0x2::event::emit<RouterSet>(v1);
    }

    public fun set_trader(arg0: &mut Vault, arg1: &OwnerCap, arg2: address, arg3: bool) {
        check(arg0, arg1);
        if (arg3) {
            if (!0x2::vec_set::contains<address>(&arg0.traders, &arg2)) {
                0x2::vec_set::insert<address>(&mut arg0.traders, arg2);
            };
        } else if (0x2::vec_set::contains<address>(&arg0.traders, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.traders, &arg2);
        };
        let v0 = TraderSet{
            vault   : 0x2::object::id<Vault>(arg0),
            trader  : arg2,
            allowed : arg3,
        };
        0x2::event::emit<TraderSet>(v0);
    }

    public fun settle<T0: drop, T1, T2>(arg0: &mut Vault, arg1: T0, arg2: Ticket<T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        let Ticket {
            vault     : v0,
            router    : v1,
            pool      : v2,
            trader    : v3,
            amount_in : v4,
            min_out   : v5,
        } = arg2;
        assert!(v0 == 0x2::object::id<Vault>(arg0), 7);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 14);
        assert!(arg0.version == 1, 8);
        let v6 = 0x2::balance::value<T1>(&arg3);
        assert!(v6 <= v4, 11);
        let v7 = v4 - v6;
        let v8 = 0x2::balance::value<T2>(&arg4);
        assert!((v8 as u128) >= (v5 as u128) * (v7 as u128) / (v4 as u128), 5);
        join<T1>(arg0, arg3);
        join<T2>(arg0, arg4);
        let v9 = Swapped{
            vault     : v0,
            pool      : v2,
            trader    : v3,
            coin_in   : 0x1::type_name::with_defining_ids<T1>(),
            coin_out  : 0x1::type_name::with_defining_ids<T2>(),
            amount_in : v4,
            spent     : v7,
            out       : v8,
        };
        0x2::event::emit<Swapped>(v9);
    }

    public fun take<T0: drop, T1, T2>(arg0: &mut Vault, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T1, T2>) {
        assert!(arg0.version == 1, 8);
        assert!(!arg0.locked, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.routers, &v0), 12);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg0.traders, &v1), 1);
        let v2 = PoolKey{pool: arg2};
        assert!(0x2::dynamic_field::exists<PoolKey>(&arg0.id, v2), 13);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 3);
        assert!(arg3 > 0, 9);
        assert!(arg4 > 0, 4);
        assert!(0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<T2>(), 10);
        let v3 = split<T1>(arg0, arg3);
        let v4 = Ticket<T1, T2>{
            vault     : 0x2::object::id<Vault>(arg0),
            router    : v0,
            pool      : arg2,
            trader    : 0x2::tx_context::sender(arg7),
            amount_in : arg3,
            min_out   : arg4,
        };
        (v3, v4)
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check(arg0, arg1);
        let v0 = split<T0>(arg0, arg2);
        let v1 = Withdrawn{
            vault  : 0x2::object::id<Vault>(arg0),
            coin   : 0x1::type_name::with_defining_ids<T0>(),
            amount : arg2,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

