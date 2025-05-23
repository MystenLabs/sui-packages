module 0x72cd8f0396da94b76ae25e9bbd744356d944f46a934bcffd2b619103004cfb76::giverep_claim {
    struct SuperAdmin has key {
        id: 0x2::object::UID,
        super_admin: vector<address>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        managers: vector<address>,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        managers: vector<address>,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        withdrawer: address,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        manager: address,
        receiver: address,
    }

    struct ClaimRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
    }

    struct PoolDeletedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
    }

    public fun add_manager<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x1::vector::push_back<address>(&mut arg0.managers, arg1);
    }

    public fun add_super_admin(arg0: &mut SuperAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.super_admin, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.super_admin, arg1);
    }

    fun assert_is_manager<T0>(arg0: &Pool<T0>, arg1: address) {
        assert!(is_manager<T0>(arg0, arg1), 1);
    }

    public fun claim<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::sponsor(arg2);
        let v1 = 0x1::option::extract<address>(&mut v0);
        assert!(v1 != 0x2::tx_context::sender(arg2) && !0x2::table::contains<address, bool>(&arg0.claimed, v1), 0);
        let v2 = ClaimEvent<T0>{
            pool_id  : 0x2::object::id<Pool<T0>>(arg0),
            amount   : arg1,
            manager  : 0x2::tx_context::sender(arg2),
            receiver : v1,
        };
        0x2::event::emit<ClaimEvent<T0>>(v2);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), v1);
    }

    public fun delete_pool<T0>(arg0: Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(&arg0, 0x2::tx_context::sender(arg1));
        let Pool {
            id       : v0,
            balance  : v1,
            managers : _,
            claimed  : v3,
        } = arg0;
        let v4 = PoolDeletedEvent{
            pool_id : 0x2::object::id<Pool<T0>>(&arg0),
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PoolDeletedEvent>(v4);
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::table::destroy_empty<address, bool>(v3);
    }

    public fun delete_table_fields<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::table::remove<address, bool>(&mut arg0.claimed, arg1);
        let v0 = ClaimRemovedEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            user    : arg1,
        };
        0x2::event::emit<ClaimRemovedEvent>(v0);
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositEvent<T0>{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            amount    : 0x2::coin::value<T0>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, 0x2::tx_context::sender(arg0));
        0x1::vector::push_back<address>(v1, @0xa40ec206390843153d219411366a48c7e68ef962cbfc30d4598d82b86636b978);
        let v2 = SuperAdmin{
            id          : 0x2::object::new(arg0),
            super_admin : v0,
        };
        0x2::transfer::share_object<SuperAdmin>(v2);
    }

    public fun init_pool<T0>(arg0: &SuperAdmin, arg1: vector<address>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.super_admin, &v0), 1);
        let v1 = Pool<T0>{
            id       : 0x2::object::new(arg3),
            balance  : 0x2::coin::into_balance<T0>(arg2),
            managers : arg1,
            claimed  : 0x2::table::new<address, bool>(arg3),
        };
        let v2 = PoolCreatedEvent{
            pool_id  : 0x2::object::id<Pool<T0>>(&v1),
            managers : arg1,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        0x2::transfer::share_object<Pool<T0>>(v1);
    }

    fun is_manager<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.managers, &arg1)
    }

    public fun remove_manager<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x1::vector::length<address>(&arg0.managers) > 1, 1);
        let (_, v1) = 0x1::vector::index_of<address>(&arg0.managers, &arg1);
        0x1::vector::remove<address>(&mut arg0.managers, v1);
    }

    public fun remove_super_admin(arg0: &mut SuperAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.super_admin, &v0) && 0x1::vector::length<address>(&arg0.super_admin) > 1, 1);
        let (_, v2) = 0x1::vector::index_of<address>(&arg0.super_admin, &arg1);
        0x1::vector::remove<address>(&mut arg0.super_admin, v2);
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = WithdrawEvent<T0>{
            pool_id    : 0x2::object::id<Pool<T0>>(arg0),
            amount     : arg1,
            withdrawer : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

