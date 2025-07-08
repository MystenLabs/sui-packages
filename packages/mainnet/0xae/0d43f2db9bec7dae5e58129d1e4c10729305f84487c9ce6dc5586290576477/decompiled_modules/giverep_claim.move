module 0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim {
    struct SuperAdmin has key {
        id: 0x2::object::UID,
        super_admin: vector<address>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        workspace_id: u64,
        balance: 0x2::balance::Balance<T0>,
        managers: vector<address>,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        workspace_id: u64,
        initial_amount: u64,
        managers: vector<address>,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        workspace_id: u64,
        amount: u64,
        depositor: address,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        workspace_id: u64,
        amount: u64,
        withdrawer: address,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        workspace_id: u64,
        amount: u64,
        manager: address,
        receiver: address,
    }

    struct PoolDeletedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        workspace_id: u64,
        sender: address,
    }

    struct ClaimStruct has drop {
        pool_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
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
        internal_claim_to_address<T0>(arg0, arg1, v1, arg2);
    }

    public fun claim_by_signature<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = create_claim_struct(0x2::object::id<Pool<T0>>(arg0), v0, arg1);
        let v2 = 0x2::bcs::to_bytes<ClaimStruct>(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg3, &v2), 0);
        let v3 = arg3;
        0x1::vector::insert<u8>(&mut v3, 0, 0);
        assert_is_manager<T0>(arg0, 0x2::address::from_bytes(0x2::hash::blake2b256(&v3)));
        internal_claim_to_address<T0>(arg0, arg1, v0, arg4);
    }

    public fun create_claim_struct(arg0: 0x2::object::ID, arg1: address, arg2: u64) : ClaimStruct {
        ClaimStruct{
            pool_id  : arg0,
            receiver : arg1,
            amount   : arg2,
        }
    }

    public fun create_pool<T0>(arg0: u64, arg1: &SuperAdmin, arg2: vector<address>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg1.super_admin, &v0), 1);
        let v1 = Pool<T0>{
            id           : 0x2::object::new(arg4),
            workspace_id : arg0,
            balance      : 0x2::coin::into_balance<T0>(arg3),
            managers     : arg2,
            claimed      : 0x2::table::new<address, bool>(arg4),
        };
        let v2 = PoolCreatedEvent{
            pool_id        : 0x2::object::id<Pool<T0>>(&v1),
            workspace_id   : arg0,
            initial_amount : 0x2::balance::value<T0>(&v1.balance),
            managers       : arg2,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        0x2::transfer::share_object<Pool<T0>>(v1);
    }

    public fun delete_multiple_table_fields<T0>(arg0: &mut Pool<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.claimed, *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun delete_pool<T0>(arg0: Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(&arg0, 0x2::tx_context::sender(arg1));
        let Pool {
            id           : v0,
            workspace_id : v1,
            balance      : v2,
            managers     : _,
            claimed      : v4,
        } = arg0;
        let v5 = PoolDeletedEvent{
            pool_id      : 0x2::object::id<Pool<T0>>(&arg0),
            workspace_id : v1,
            sender       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PoolDeletedEvent>(v5);
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::table::destroy_empty<address, bool>(v4);
    }

    public fun delete_table_fields<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::table::remove<address, bool>(&mut arg0.claimed, arg1);
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositEvent<T0>{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            workspace_id : arg0.workspace_id,
            amount       : 0x2::coin::value<T0>(&arg1),
            depositor    : 0x2::tx_context::sender(arg2),
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

    fun internal_claim_to_address<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimEvent<T0>{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            workspace_id : arg0.workspace_id,
            amount       : arg1,
            manager      : 0x2::tx_context::sender(arg3),
            receiver     : arg2,
        };
        0x2::event::emit<ClaimEvent<T0>>(v0);
        0x2::table::add<address, bool>(&mut arg0.claimed, arg2, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    fun is_manager<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.managers, &arg1)
    }

    public fun is_super_admin(arg0: &SuperAdmin, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.super_admin, &arg1)
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
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            workspace_id : arg0.workspace_id,
            amount       : arg1,
            withdrawer   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

