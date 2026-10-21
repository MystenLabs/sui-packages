module 0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        traders: 0x2::vec_set::VecSet<address>,
        routers: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rebalancers: 0x2::vec_set::VecSet<address>,
        recipients: 0x2::vec_set::VecSet<address>,
        locked: bool,
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

    struct MaxTakeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MaxWithdrawKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
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
        router: 0x1::type_name::TypeName,
        trader: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        spent: u64,
        out: u64,
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

    struct MaxTakeSet has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        max: u64,
    }

    struct LockSet has copy, drop {
        vault: 0x2::object::ID,
        locked: bool,
    }

    struct RebalancerSet has copy, drop {
        vault: 0x2::object::ID,
        rebalancer: address,
        allowed: bool,
    }

    struct RecipientSet has copy, drop {
        vault: 0x2::object::ID,
        recipient: address,
        allowed: bool,
    }

    struct MaxWithdrawSet has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        max: u64,
    }

    struct WithdrawnTo has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun balance<T0>(arg0: &Vault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
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
        assert!(balance<T0>(arg0) >= arg1, 15);
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1)
    }

    public fun assert_gain_at_least<T0>(arg0: &Vault, arg1: u64, arg2: u64) {
        assert!((balance<T0>(arg0) as u128) >= (arg1 as u128) + (arg2 as u128), 19);
    }

    public fun assert_loss_at_most<T0>(arg0: &Vault, arg1: u64, arg2: u64) {
        assert!((balance<T0>(arg0) as u128) + (arg2 as u128) >= (arg1 as u128), 19);
    }

    fun assert_owner(arg0: &Vault, arg1: &OwnerCap) {
        assert_version(arg0);
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 6);
    }

    fun assert_version(arg0: &Vault) {
        assert!(arg0.version == 2, 8);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = Vault{
            id          : 0x2::object::new(arg0),
            version     : 2,
            traders     : 0x2::vec_set::empty<address>(),
            routers     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rebalancers : 0x2::vec_set::empty<address>(),
            recipients  : 0x2::vec_set::empty<address>(),
            locked      : true,
        };
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<Vault>(&v0),
        };
        0x2::transfer::share_object<Vault>(v0);
        v1
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        abort 23
    }

    public fun is_listed(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        let v0 = PoolKey{pool: arg1};
        0x2::dynamic_field::exists<PoolKey>(&arg0.id, v0)
    }

    public fun is_locked(arg0: &Vault) : bool {
        arg0.locked
    }

    public fun is_rebalancer(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.rebalancers, &arg1)
    }

    public fun is_recipient(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.recipients, &arg1)
    }

    public fun is_router<T0>(arg0: &Vault) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.routers, &v0)
    }

    public fun is_trader(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.traders, &arg1)
    }

    public fun max_take<T0>(arg0: &Vault) : u64 {
        abort 23
    }

    public fun max_withdraw<T0>(arg0: &Vault) : u64 {
        abort 23
    }

    public fun migrate(arg0: &mut Vault, arg1: &OwnerCap) {
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 6);
        assert!(arg0.version < 2, 18);
        arg0.version = 2;
    }

    public fun rebalancer_deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.rebalancers, &v0), 20);
        let v1 = 0x2::balance::value<T0>(&arg1);
        assert!(v1 > 0, 9);
        join<T0>(arg0, arg1);
        let v2 = Deposited{
            vault  : 0x2::object::id<Vault>(arg0),
            coin   : 0x1::type_name::with_defining_ids<T0>(),
            amount : v1,
        };
        0x2::event::emit<Deposited>(v2);
    }

    public fun set_locked(arg0: &mut Vault, arg1: &OwnerCap, arg2: bool) {
        assert_owner(arg0, arg1);
        arg0.locked = arg2;
        let v0 = LockSet{
            vault  : 0x2::object::id<Vault>(arg0),
            locked : arg2,
        };
        0x2::event::emit<LockSet>(v0);
    }

    public fun set_max_take<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64) {
        abort 23
    }

    public fun set_max_withdraw<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64) {
        abort 23
    }

    fun set_member<T0: copy + drop>(arg0: &mut 0x2::vec_set::VecSet<T0>, arg1: T0, arg2: bool) {
        let v0 = 0x2::vec_set::contains<T0>(arg0, &arg1);
        if (arg2 && !v0) {
            0x2::vec_set::insert<T0>(arg0, arg1);
        } else if (!arg2 && v0) {
            0x2::vec_set::remove<T0>(arg0, &arg1);
        };
    }

    public fun set_pools(arg0: &mut Vault, arg1: &OwnerCap, arg2: vector<0x2::object::ID>, arg3: bool) {
        assert_owner(arg0, arg1);
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            let v2 = PoolKey{pool: v1};
            let v3 = 0x2::dynamic_field::exists<PoolKey>(&arg0.id, v2);
            if (arg3 && !v3) {
                0x2::dynamic_field::add<PoolKey, bool>(&mut arg0.id, v2, true);
            } else if (!arg3 && v3) {
                0x2::dynamic_field::remove<PoolKey, bool>(&mut arg0.id, v2);
            };
            let v4 = PoolSet{
                vault   : 0x2::object::id<Vault>(arg0),
                pool    : v1,
                allowed : arg3,
            };
            0x2::event::emit<PoolSet>(v4);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    public fun set_rebalancer(arg0: &mut Vault, arg1: &OwnerCap, arg2: address, arg3: bool) {
        assert_owner(arg0, arg1);
        let v0 = &mut arg0.rebalancers;
        set_member<address>(v0, arg2, arg3);
        let v1 = RebalancerSet{
            vault      : 0x2::object::id<Vault>(arg0),
            rebalancer : arg2,
            allowed    : arg3,
        };
        0x2::event::emit<RebalancerSet>(v1);
    }

    public fun set_recipient(arg0: &mut Vault, arg1: &OwnerCap, arg2: address, arg3: bool) {
        assert_owner(arg0, arg1);
        let v0 = &mut arg0.recipients;
        set_member<address>(v0, arg2, arg3);
        let v1 = RecipientSet{
            vault     : 0x2::object::id<Vault>(arg0),
            recipient : arg2,
            allowed   : arg3,
        };
        0x2::event::emit<RecipientSet>(v1);
    }

    public fun set_router<T0: drop>(arg0: &mut Vault, arg1: &OwnerCap, arg2: bool) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg0.routers;
        set_member<0x1::type_name::TypeName>(v1, v0, arg2);
        let v2 = RouterSet{
            vault   : 0x2::object::id<Vault>(arg0),
            router  : v0,
            allowed : arg2,
        };
        0x2::event::emit<RouterSet>(v2);
    }

    public fun set_trader(arg0: &mut Vault, arg1: &OwnerCap, arg2: address, arg3: bool) {
        assert_owner(arg0, arg1);
        let v0 = &mut arg0.traders;
        set_member<address>(v0, arg2, arg3);
        let v1 = TraderSet{
            vault   : 0x2::object::id<Vault>(arg0),
            trader  : arg2,
            allowed : arg3,
        };
        0x2::event::emit<TraderSet>(v1);
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
        let v6 = 0x2::balance::value<T1>(&arg3);
        assert!(v6 <= v4, 11);
        let v7 = v4 - v6;
        assert!(v7 > 0, 17);
        let v8 = 0x2::balance::value<T2>(&arg4);
        assert!((v8 as u128) * (v4 as u128) >= (v5 as u128) * (v7 as u128), 5);
        join<T1>(arg0, arg3);
        join<T2>(arg0, arg4);
        let v9 = Swapped{
            vault     : v0,
            pool      : v2,
            router    : v1,
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
        assert_version(arg0);
        assert!(!arg0.locked, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.routers, &v0), 12);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg0.traders, &v1), 1);
        assert!(is_listed(arg0, arg2), 13);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 3);
        assert!(arg3 > 0, 9);
        assert!(arg4 > 0, 4);
        assert!(0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<T2>(), 10);
        let v2 = split<T1>(arg0, arg3);
        let v3 = Ticket<T1, T2>{
            vault     : 0x2::object::id<Vault>(arg0),
            router    : v0,
            pool      : arg2,
            trader    : 0x2::tx_context::sender(arg7),
            amount_in : arg3,
            min_out   : arg4,
        };
        (v2, v3)
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_owner(arg0, arg1);
        let v0 = split<T0>(arg0, arg2);
        let v1 = Withdrawn{
            vault  : 0x2::object::id<Vault>(arg0),
            coin   : 0x1::type_name::with_defining_ids<T0>(),
            amount : arg2,
        };
        0x2::event::emit<Withdrawn>(v1);
        v0
    }

    public fun withdraw_to<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.locked, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.rebalancers, &v0), 20);
        assert!(0x2::vec_set::contains<address>(&arg0.recipients, &arg2), 21);
        assert!(arg1 > 0, 9);
        let v1 = split<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
        let v2 = WithdrawnTo{
            vault     : 0x2::object::id<Vault>(arg0),
            coin      : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<WithdrawnTo>(v2);
    }

    // decompiled from Move bytecode v7
}

