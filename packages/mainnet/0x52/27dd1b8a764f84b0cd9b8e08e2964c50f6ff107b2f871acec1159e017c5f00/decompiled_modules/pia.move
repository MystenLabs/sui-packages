module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia {
    struct PiaRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Pia has store, key {
        id: 0x2::object::UID,
        amount: u64,
        listing_id: 0x2::object::ID,
        user: address,
        dbpk: 0x1::string::String,
    }

    struct PiaCreated has copy, drop {
        dbpk: 0x1::string::String,
        amount: u64,
        listing_id: 0x2::object::ID,
        user: address,
    }

    struct PiaUsed has copy, drop {
        dbpk: 0x1::string::String,
        amount: u64,
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

    public(friend) fun add_balance<T0>(arg0: &mut PiaRegistry, arg1: 0x2::coin::Coin<T0>) {
        assert!(validate_pool_exists(arg0), 403);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Pool<T0>>(&mut arg0.id, b"pia_pool");
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v0.balance, v1);
        let v2 = PoolBalanceAdded{
            pool_id : 0x2::object::uid_to_inner(&v0.id),
            amount  : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<PoolBalanceAdded>(v2);
    }

    public(friend) fun add_pool<T0>(arg0: &mut PiaRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_field::add<vector<u8>, Pool<T0>>(&mut arg0.id, b"pia_pool", v0);
        let v1 = PoolCreated{pool_id: 0x2::object::id<Pool<T0>>(&v0)};
        0x2::event::emit<PoolCreated>(v1);
    }

    public(friend) fun create_pia(arg0: &PiaRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : Pia {
        new_pia_internal(arg0, arg1, arg2, arg3)
    }

    public(friend) fun delete_pia(arg0: Pia) {
        let Pia {
            id         : v0,
            amount     : _,
            listing_id : _,
            user       : _,
            dbpk       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_pia(arg0: &Pia) : (0x2::object::ID, u64, 0x2::object::ID, address, 0x1::string::String) {
        (0x2::object::id<Pia>(arg0), arg0.amount, arg0.listing_id, arg0.user, arg0.dbpk)
    }

    public fun get_pia_amount(arg0: &Pia) : u64 {
        arg0.amount
    }

    public fun get_pia_user(arg0: &Pia) : address {
        arg0.user
    }

    public(friend) fun initialize_pia_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PiaRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<PiaRegistry>(v0);
    }

    fun new_pia_internal(arg0: &PiaRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : Pia {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0));
        let v2 = 0x2::bcs::peel_address(&mut v0);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        let v4 = 0x2::bcs::peel_u64(&mut v0);
        assert!(0x2::bcs::peel_u64(&mut v0) > 0x2::clock::timestamp_ms(arg3), 401);
        assert!(v4 > 0, 402);
        assert!(validate_pool_exists(arg0), 403);
        let v5 = PiaCreated{
            dbpk       : v3,
            amount     : v4,
            listing_id : v1,
            user       : v2,
        };
        0x2::event::emit<PiaCreated>(v5);
        Pia{
            id         : 0x2::object::new(arg2),
            amount     : v4,
            listing_id : v1,
            user       : v2,
            dbpk       : v3,
        }
    }

    public fun provide_liquidity<T0>(arg0: &mut PiaRegistry, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 402);
        add_balance<T0>(arg0, arg1);
    }

    public fun try_get_pool_id<T0>(arg0: &PiaRegistry) : 0x1::option::Option<0x2::object::ID> {
        if (!validate_pool_exists(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(0x2::object::id<Pool<T0>>(0x2::dynamic_field::borrow<vector<u8>, Pool<T0>>(&arg0.id, b"pia_pool")))
    }

    public(friend) fun use_pia<T0>(arg0: &mut PiaRegistry, arg1: Pia, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(validate_pool_exists(arg0), 403);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Pool<T0>>(&mut arg0.id, b"pia_pool");
        assert!(0x2::balance::value<T0>(&v0.balance) >= arg1.amount, 404);
        let v1 = PiaUsed{
            dbpk       : arg1.dbpk,
            amount     : arg1.amount,
            listing_id : arg1.listing_id,
            user       : arg1.user,
        };
        0x2::event::emit<PiaUsed>(v1);
        let Pia {
            id         : v2,
            amount     : _,
            listing_id : _,
            user       : _,
            dbpk       : _,
        } = arg1;
        0x2::object::delete(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, arg1.amount), arg2)
    }

    public fun validate_pool_exists(arg0: &PiaRegistry) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"pia_pool")
    }

    // decompiled from Move bytecode v6
}

