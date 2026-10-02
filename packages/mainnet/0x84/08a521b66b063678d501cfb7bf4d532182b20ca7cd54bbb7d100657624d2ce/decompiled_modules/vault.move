module 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        traders: 0x2::vec_set::VecSet<address>,
        locked: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Ticket<phantom T0, phantom T1> {
        vault: 0x2::object::ID,
        pool: 0x2::object::ID,
        trader: address,
        amount_in: u64,
        min_out: u64,
        fill_rate_pct: u8,
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
        assert!(0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0), 8);
        let v1 = 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 8);
        0x2::balance::split<T0>(v1, arg1)
    }

    fun check(arg0: &Vault, arg1: &OwnerCap) {
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 9);
        assert!(arg0.version == 1, 10);
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
        };
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<Vault>(&v0),
        };
        0x2::transfer::share_object<Vault>(v0);
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_locked(arg0: &Vault) : bool {
        arg0.locked
    }

    public fun is_trader(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.traders, &arg1)
    }

    public fun limit(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 12);
        assert!((arg2 as u128) < 1000000, 16);
        let v0 = (arg0 as u256) * (arg0 as u256) / (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 11);
        let v1 = if (arg3) {
            v0 * (1000000 as u256) / ((1000000 - (arg2 as u128)) as u256)
        } else {
            v0 * ((1000000 - (arg2 as u128)) as u256) / (1000000 as u256)
        };
        assert!(v1 <= 340282366920938463463374607431768211455, 11);
        (v1 as u128)
    }

    public fun migrate(arg0: &mut Vault, arg1: &OwnerCap) {
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 9);
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

    public fun settle<T0, T1>(arg0: &mut Vault, arg1: Ticket<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        let Ticket {
            vault         : v0,
            pool          : v1,
            trader        : v2,
            amount_in     : v3,
            min_out       : v4,
            fill_rate_pct : v5,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault>(arg0), 9);
        assert!(arg0.version == 1, 10);
        let v6 = 0x2::balance::value<T0>(&arg2);
        assert!(v6 <= v3, 15);
        let v7 = v3 - v6;
        let v8 = 0x2::balance::value<T1>(&arg3);
        assert!((v7 as u128) * 100 >= (v5 as u128) * (v3 as u128), 6);
        assert!((v8 as u128) >= (v4 as u128) * (v7 as u128) / (v3 as u128), 7);
        join<T0>(arg0, arg2);
        join<T1>(arg0, arg3);
        let v9 = Swapped{
            vault     : v0,
            pool      : v1,
            trader    : v2,
            coin_in   : 0x1::type_name::with_defining_ids<T0>(),
            coin_out  : 0x1::type_name::with_defining_ids<T1>(),
            amount_in : v3,
            spent     : v7,
            out       : v8,
        };
        0x2::event::emit<Swapped>(v9);
    }

    public fun take<T0, T1>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T0, T1>) {
        assert!(arg0.version == 1, 10);
        assert!(!arg0.locked, 2);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg0.traders, &v0), 1);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 3);
        assert!(arg2 > 0, 13);
        assert!(arg3 > 0, 4);
        assert!(arg4 > 0 && arg4 <= 100, 5);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 14);
        let v1 = split<T0>(arg0, arg2);
        let v2 = Ticket<T0, T1>{
            vault         : 0x2::object::id<Vault>(arg0),
            pool          : arg1,
            trader        : 0x2::tx_context::sender(arg7),
            amount_in     : arg2,
            min_out       : arg3,
            fill_rate_pct : arg4,
        };
        (v1, v2)
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

