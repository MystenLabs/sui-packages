module 0x2e891cd6329ec058ad164166eeb09373054ed7fc51b6cc180a8068be3b2c6549::e4c_vesting {
    struct VestingReceipt has store, key {
        id: 0x2::object::UID,
        address: address,
        staking_end_at: u64,
        reward: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
    }

    struct ReleaseCap has store, key {
        id: 0x2::object::UID,
        address: address,
    }

    struct VestingPool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
    }

    struct PoolPlaced has copy, drop {
        sender: address,
        amount: u64,
    }

    struct ReceiptCreate has copy, drop {
        receipt_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct UnwrapCap has store, key {
        id: 0x2::object::UID,
        admin: address,
        pool_id: address,
    }

    struct Released has copy, drop {
        receipt_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct E4C_VESTING has drop {
        dummy_field: bool,
    }

    fun calculate_locking_time(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 24 * 60 * 60 * 1000
    }

    public fun create_poool(arg0: &ReleaseCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : UnwrapCap {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = VestingPool{
            id      : v0,
            balance : 0x2::balance::zero<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(),
        };
        let v3 = UnwrapCap{
            id      : 0x2::object::new(arg2),
            admin   : arg1,
            pool_id : 0x2::object::id_to_address(&v1),
        };
        0x2::transfer::public_share_object<VestingPool>(v2);
        let v4 = PoolPlaced{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0,
        };
        0x2::event::emit<PoolPlaced>(v4);
        v3
    }

    public fun get_pool_balance(arg0: &VestingPool) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.balance)
    }

    public fun get_recipient(arg0: &VestingReceipt) : address {
        arg0.address
    }

    public fun get_reward(arg0: &VestingReceipt) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.reward)
    }

    fun init(arg0: E4C_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReleaseCap{
            id      : 0x2::object::new(arg1),
            address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<ReleaseCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_vesting_receipt(arg0: &ReleaseCap, arg1: u64, arg2: &mut VestingPool, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VestingReceipt {
        assert!(0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg2.balance) >= arg1, 0);
        let v0 = 0x2::object::new(arg6);
        let v1 = VestingReceipt{
            id             : v0,
            address        : arg4,
            staking_end_at : calculate_locking_time(0x2::clock::timestamp_ms(arg5), arg3),
            reward         : 0x2::balance::split<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg2.balance, arg1),
        };
        let v2 = ReceiptCreate{
            receipt_id : 0x2::object::uid_to_inner(&v0),
            owner      : arg4,
            amount     : arg1,
        };
        0x2::event::emit<ReceiptCreate>(v2);
        v1
    }

    public fun place_in_vesting_pool(arg0: 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>, arg1: &mut VestingPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg1.balance, 0x2::coin::into_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(arg0));
        let v0 = PoolPlaced{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0),
        };
        0x2::event::emit<PoolPlaced>(v0);
    }

    public fun release_receipt(arg0: VestingReceipt, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.staking_end_at, 1);
        let VestingReceipt {
            id             : v0,
            address        : v1,
            staking_end_at : _,
            reward         : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>>(0x2::coin::from_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(v4, arg2), v1);
        let v6 = Released{
            receipt_id : 0x2::object::uid_to_inner(&v5),
            owner      : v1,
            amount     : 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&v4),
        };
        0x2::event::emit<Released>(v6);
        0x2::object::delete(v5);
    }

    public fun unwrap(arg0: &UnwrapCap, arg1: VestingReceipt, arg2: &mut VestingPool) {
        let VestingReceipt {
            id             : v0,
            address        : _,
            staking_end_at : _,
            reward         : v3,
        } = arg1;
        assert!(arg0.pool_id == 0x2::object::uid_to_address(&arg2.id), 0);
        0x2::balance::join<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg2.balance, v3);
        0x2::object::delete(v0);
    }

    public fun withdraw(arg0: UnwrapCap, arg1: VestingPool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_id == 0x2::object::uid_to_address(&arg1.id), 0);
        let VestingPool {
            id      : v0,
            balance : v1,
        } = arg1;
        let UnwrapCap {
            id      : v2,
            admin   : v3,
            pool_id : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>>(0x2::coin::from_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(v1, arg2), v3);
        0x2::object::delete(v0);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

