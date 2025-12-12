module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt {
    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Debt has store, key {
        id: 0x2::object::UID,
        amount: u64,
        pool_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        user: address,
        dbpk: u64,
    }

    struct DebtCreated has copy, drop {
        dbpk: u64,
        amount: u64,
        pool_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        user: address,
    }

    struct DebtUsed has copy, drop {
        dbpk: u64,
        amount: u64,
        pool_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        user: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct PoolBalanceAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun add_balance<T0>(arg0: &mut PoolRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 302);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Pool<T0>>(&mut arg0.id, arg1).balance, v0);
        let v1 = PoolBalanceAdded{
            pool_id : arg1,
            amount  : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<PoolBalanceAdded>(v1);
    }

    public(friend) fun add_pool<T0>(arg0: &mut PoolRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = 0x2::object::id<Pool<T0>>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Pool<T0>>(&mut arg0.id, v1, v0);
        let v2 = PoolCreated{pool_id: v1};
        0x2::event::emit<PoolCreated>(v2);
    }

    public(friend) fun create_debt<T0>(arg0: &PoolRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : Debt {
        let v0 = new_debt_internal(arg0, arg1, arg2, arg3);
        assert!(validate_pool_balance<T0>(arg0, v0.pool_id, v0.amount), 301);
        v0
    }

    public(friend) fun delete_debt(arg0: Debt) {
        let Debt {
            id         : v0,
            amount     : _,
            pool_id    : _,
            listing_id : _,
            user       : _,
            dbpk       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_debt(arg0: &Debt) : (0x2::object::ID, u64, 0x2::object::ID, 0x2::object::ID, address, u64) {
        (0x2::object::id<Debt>(arg0), arg0.amount, arg0.pool_id, arg0.listing_id, arg0.user, arg0.dbpk)
    }

    public fun get_debt_amount(arg0: &Debt) : u64 {
        arg0.amount
    }

    public fun get_debt_user(arg0: &Debt) : address {
        arg0.user
    }

    public fun get_pool_balance<T0>(arg0: &PoolRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(validate_pool_exists(arg0, arg1), 302);
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Pool<T0>>(&arg0.id, arg1).balance)
    }

    public(friend) fun initialize_pool_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<PoolRegistry>(v0);
    }

    public(friend) fun new_debt(arg0: &PoolRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : Debt {
        abort 305
    }

    fun new_debt_internal(arg0: &PoolRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : Debt {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0));
        let v2 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0));
        let v3 = 0x2::bcs::peel_address(&mut v0);
        let v4 = 0x2::bcs::peel_u64(&mut v0);
        let v5 = 0x2::bcs::peel_u64(&mut v0);
        assert!(0x2::bcs::peel_u64(&mut v0) > 0x2::clock::timestamp_ms(arg3), 303);
        assert!(v5 > 0, 304);
        assert!(validate_pool_exists(arg0, v1), 302);
        let v6 = DebtCreated{
            dbpk       : v4,
            amount     : v5,
            pool_id    : v1,
            listing_id : v2,
            user       : v3,
        };
        0x2::event::emit<DebtCreated>(v6);
        Debt{
            id         : 0x2::object::new(arg2),
            amount     : v5,
            pool_id    : v1,
            listing_id : v2,
            user       : v3,
            dbpk       : v4,
        }
    }

    public fun provide_liquidity<T0>(arg0: &mut PoolRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 304);
        add_balance<T0>(arg0, arg1, arg2);
    }

    public(friend) fun use_debt<T0>(arg0: &mut PoolRegistry, arg1: Debt, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(validate_pool_exists(arg0, arg1.pool_id), 302);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Pool<T0>>(&mut arg0.id, arg1.pool_id);
        assert!(0x2::balance::value<T0>(&v0.balance) >= arg1.amount, 301);
        let v1 = DebtUsed{
            dbpk       : arg1.dbpk,
            amount     : arg1.amount,
            pool_id    : arg1.pool_id,
            listing_id : arg1.listing_id,
            user       : arg1.user,
        };
        0x2::event::emit<DebtUsed>(v1);
        let Debt {
            id         : v2,
            amount     : _,
            pool_id    : _,
            listing_id : _,
            user       : _,
            dbpk       : _,
        } = arg1;
        0x2::object::delete(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, arg1.amount), arg2)
    }

    public fun validate_pool_balance<T0>(arg0: &PoolRegistry, arg1: 0x2::object::ID, arg2: u64) : bool {
        if (!validate_pool_exists(arg0, arg1)) {
            return false
        };
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Pool<T0>>(&arg0.id, arg1).balance) >= arg2
    }

    public fun validate_pool_exists(arg0: &PoolRegistry, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

