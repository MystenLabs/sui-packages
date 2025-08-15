module 0x20ce6a7d29ea34bc162017767847ae4b23f236096111b6651294178f360d05d4::reward_pool {
    struct RewardClaimed has copy, drop {
        task_id: u64,
        user: address,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct RewardPoolCap has store, key {
        id: 0x2::object::UID,
    }

    struct Task has store, key {
        id: 0x2::object::UID,
        task_id: u64,
        funders: vector<address>,
    }

    struct Reward<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_deposited: u64,
        claimed_rewards: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct RewardPool has store, key {
        id: 0x2::object::UID,
        tasks: 0x2::table::Table<u64, Task>,
        signer: vector<u8>,
    }

    struct TempSign has store, key {
        id: 0x2::object::UID,
        user: address,
        task_id: u64,
        amount: u64,
        signature: vector<u8>,
        signer: vector<u8>,
        verified: bool,
    }

    struct TempSign1 has store, key {
        id: 0x2::object::UID,
        user: address,
        task_id: u64,
        amount: u64,
        signature: vector<u8>,
        signer: vector<u8>,
        verified: bool,
        msg: vector<u8>,
    }

    public entry fun add_funder(arg0: &RewardPoolCap, arg1: &mut RewardPool, arg2: u64, arg3: address) {
        let v0 = &mut 0x2::table::borrow_mut<u64, Task>(&mut arg1.tasks, arg2).funders;
        assert!(!0x1::vector::contains<address>(v0, &arg3), 1);
        0x1::vector::push_back<address>(v0, arg3);
    }

    public entry fun claim<T0>(arg0: &mut RewardPool, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0x2::tx_context::sender(arg5), 3);
        let v0 = 0x2::table::borrow_mut<u64, Task>(&mut arg0.tasks, arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::bcs::to_bytes<u64>(&v0.task_id);
        let v3 = 0x2::tx_context::sender(arg5);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::ascii::String>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.signer, &v2), 4);
        if (!0x2::dynamic_field::exists_with_type<0x1::ascii::String, Reward<T0>>(&v0.id, v1)) {
            let v4 = Reward<T0>{
                id              : 0x2::object::new(arg5),
                total_deposited : 0,
                claimed_rewards : 0x2::table::new<address, u64>(arg5),
                balance         : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_field::add<0x1::ascii::String, Reward<T0>>(&mut v0.id, v1, v4);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, Reward<T0>>(&mut v0.id, v1);
        if (!0x2::table::contains<address, u64>(&v5.claimed_rewards, 0x2::tx_context::sender(arg5))) {
            0x2::table::add<address, u64>(&mut v5.claimed_rewards, 0x2::tx_context::sender(arg5), 0);
        };
        let v6 = 0x2::table::borrow_mut<address, u64>(&mut v5.claimed_rewards, 0x2::tx_context::sender(arg5));
        *v6 = arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5.balance, arg3 - *v6), arg5), 0x2::tx_context::sender(arg5));
        let v7 = RewardClaimed{
            task_id   : arg1,
            user      : 0x2::tx_context::sender(arg5),
            amount    : arg3,
            coin_type : v1,
        };
        0x2::event::emit<RewardClaimed>(v7);
    }

    public entry fun copy_reward_pool_cap(arg0: &RewardPoolCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPoolCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RewardPoolCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_task(arg0: &RewardPoolCap, arg1: &mut RewardPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, Task>(&arg1.tasks, arg2), 0);
        let v0 = Task{
            id      : 0x2::object::new(arg3),
            task_id : arg2,
            funders : 0x1::vector::empty<address>(),
        };
        0x2::table::add<u64, Task>(&mut arg1.tasks, arg2, v0);
    }

    public entry fun deposit<T0>(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Task>(&mut arg0.tasks, arg2);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::dynamic_field::exists_with_type<0x1::ascii::String, Reward<T0>>(&v0.id, v1)) {
            let v2 = Reward<T0>{
                id              : 0x2::object::new(arg3),
                total_deposited : 0,
                claimed_rewards : 0x2::table::new<address, u64>(arg3),
                balance         : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_field::add<0x1::ascii::String, Reward<T0>>(&mut v0.id, v1, v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, Reward<T0>>(&mut v0.id, v1);
        v3.total_deposited = v3.total_deposited + 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut v3.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_claimed_reward(arg0: &RewardPool, arg1: u64, arg2: address, arg3: 0x1::ascii::String) : u64 {
        let v0 = 0x2::dynamic_field::borrow<0x1::ascii::String, Reward<u64>>(&0x2::table::borrow<u64, Task>(&arg0.tasks, arg1).id, arg3);
        if (!0x2::table::contains<address, u64>(&v0.claimed_rewards, arg2)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&v0.claimed_rewards, arg2)
    }

    public fun get_claimed_reward_with_type<T0>(arg0: &RewardPool, arg1: u64, arg2: address) : u64 {
        let v0 = 0x2::dynamic_field::borrow<0x1::ascii::String, Reward<u64>>(&0x2::table::borrow<u64, Task>(&arg0.tasks, arg1).id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::table::contains<address, u64>(&v0.claimed_rewards, arg2)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&v0.claimed_rewards, arg2)
    }

    public entry fun get_sign<T0>(arg0: u64, arg1: address, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::bcs::to_bytes<u64>(&arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::ascii::String>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        let v2 = TempSign1{
            id        : 0x2::object::new(arg5),
            user      : arg1,
            task_id   : arg0,
            amount    : arg2,
            signature : arg4,
            signer    : arg3,
            verified  : 0x2::ed25519::ed25519_verify(&arg4, &arg3, &v1),
            msg       : v1,
        };
        0x2::transfer::public_transfer<TempSign1>(v2, 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPoolCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RewardPoolCap>(v0, 0x2::tx_context::sender(arg0));
        0x1::type_name::into_string(0x1::type_name::get<0x2::coin::Coin<u64>>());
    }

    public entry fun new_reward_pool(arg0: &RewardPoolCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id     : 0x2::object::new(arg2),
            tasks  : 0x2::table::new<u64, Task>(arg2),
            signer : arg1,
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public entry fun remove_funder(arg0: &RewardPoolCap, arg1: &mut RewardPool, arg2: u64, arg3: u64) {
        0x1::vector::remove<address>(&mut 0x2::table::borrow_mut<u64, Task>(&mut arg1.tasks, arg2).funders, arg3);
    }

    public entry fun withdraw<T0>(arg0: &RewardPoolCap, arg1: &mut RewardPool, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<0x1::ascii::String, Reward<T0>>(&mut 0x2::table::borrow_mut<u64, Task>(&mut arg1.tasks, arg2).id, 0x1::type_name::into_string(0x1::type_name::get<T0>())).balance, arg4), arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

