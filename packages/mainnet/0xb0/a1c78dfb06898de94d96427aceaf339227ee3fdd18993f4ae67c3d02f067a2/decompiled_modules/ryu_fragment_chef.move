module 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::ryu_fragment_chef {
    struct DepositEvent has copy, drop {
        sender_address: address,
        coin_name: 0x1::ascii::String,
        reward: u64,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender_address: address,
        coin_name: 0x1::ascii::String,
        reward: u64,
        amount: u64,
    }

    struct SetEvent has copy, drop {
        coin_name: 0x1::ascii::String,
        alloc_point: u64,
    }

    struct AddEvent has copy, drop {
        coin_name: 0x1::ascii::String,
        alloc_point: u64,
    }

    struct UserInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        reward_debt: u128,
    }

    struct PoolInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_reserve: 0x2::coin::Coin<T0>,
        coin_reward: 0x2::coin::Coin<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>,
        acc_BOXFRAGMENT_per_share: u128,
        last_reward_timestamp: u64,
        alloc_point: u64,
    }

    struct MasterChefData has key {
        id: 0x2::object::UID,
        ryu_mint_cap: 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::MintCap,
        total_alloc_point: u64,
        admin_address: address,
        start_timestamp: u64,
        per_second_BOXFRAGMENT: u128,
        pool_list: vector<address>,
    }

    public entry fun add_pool<T0>(arg0: &0x2::clock::Clock, arg1: &mut MasterChefData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 1001);
        assert!(!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, PoolInfo<T0>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 1003);
        arg1.total_alloc_point = arg1.total_alloc_point + arg2;
        let v0 = if (get_current_timestamp(arg0) > arg1.start_timestamp) {
            get_current_timestamp(arg0)
        } else {
            arg1.start_timestamp
        };
        let v1 = 0x2::object::new(arg3);
        let v2 = PoolInfo<T0>{
            id                        : v1,
            coin_reserve              : 0x2::coin::zero<T0>(arg3),
            coin_reward               : 0x2::coin::zero<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>(arg3),
            acc_BOXFRAGMENT_per_share : 0,
            last_reward_timestamp     : v0,
            alloc_point               : arg2,
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, PoolInfo<T0>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v2);
        0x1::vector::push_back<address>(&mut arg1.pool_list, 0x2::object::uid_to_address(&v1));
        let v3 = AddEvent{
            coin_name   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            alloc_point : arg2,
        };
        0x2::event::emit<AddEvent>(v3);
    }

    public entry fun deposit<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FragmentInfo, arg4: &mut MasterChefData, arg5: &mut UserInfo<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        update_pool<T0>(arg2, arg3, arg4, arg6);
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, PoolInfo<T0>>(&mut arg4.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 1002);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, PoolInfo<T0>>(&mut arg4.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (arg1 == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        } else {
            let v1 = handle_coin_obj<T0>(arg0, arg1, arg6);
            0x2::coin::join<T0>(&mut v0.coin_reserve, v1);
        };
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0;
        if (arg5.amount > 0) {
            let v4 = (arg5.amount as u128) * v0.acc_BOXFRAGMENT_per_share / 1000000000000 - arg5.reward_debt;
            v3 = v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>>(0x2::coin::split<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>(&mut v0.coin_reward, (v4 as u64), arg6), v2);
        };
        arg5.amount = arg5.amount + arg1;
        arg5.reward_debt = (arg5.amount as u128) * v0.acc_BOXFRAGMENT_per_share / 1000000000000;
        let v5 = DepositEvent{
            sender_address : v2,
            coin_name      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward         : (v3 as u64),
            amount         : arg1,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public entry fun first_deposit<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FragmentInfo, arg4: &mut MasterChefData, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, PoolInfo<T0>>(&mut arg4.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 1002);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, PoolInfo<T0>>(&mut arg4.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(!0x2::dynamic_field::exists_with_type<address, address>(&mut v1.id, v0), 1006);
        let v2 = 0x2::object::new(arg5);
        0x2::dynamic_field::add<address, address>(&mut v1.id, v0, 0x2::object::uid_to_address(&v2));
        let v3 = UserInfo<T0>{
            id          : v2,
            amount      : 0,
            reward_debt : 0,
        };
        let v4 = &mut v3;
        deposit<T0>(arg0, arg1, arg2, arg3, arg4, v4, arg5);
        0x2::transfer::transfer<UserInfo<T0>>(v3, v0);
    }

    fun get_current_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun get_mc_data(arg0: &MasterChefData) : (u64, u64, u128) {
        (arg0.total_alloc_point, arg0.start_timestamp, arg0.per_second_BOXFRAGMENT)
    }

    fun get_multiplier(arg0: u64, arg1: u64) : u128 {
        ((arg1 - arg0) as u128)
    }

    public fun get_pool_info<T0>(arg0: &PoolInfo<T0>) : (u128, u64, u64) {
        (arg0.acc_BOXFRAGMENT_per_share, arg0.last_reward_timestamp, arg0.alloc_point)
    }

    public fun get_user_info<T0>(arg0: &UserInfo<T0>) : (u64, u128) {
        (arg0.amount, arg0.reward_debt)
    }

    public fun get_user_info_amount<T0>(arg0: &UserInfo<T0>) : u64 {
        arg0.amount
    }

    fun handle_coin_obj<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 1008);
        assert!(arg1 > 0, 1009);
        let v0 = 0x2::coin::zero<T0>(arg2);
        let v1 = 0;
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            if (v1 < arg1) {
                let v3 = 0x2::coin::value<T0>(&v2);
                if (v3 + v1 <= arg1) {
                    0x2::coin::join<T0>(&mut v0, v2);
                    v1 = v3 + v1;
                    continue
                };
                let v4 = arg1 - v1;
                0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut v2, v4, arg2));
                v1 = v1 + v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        assert!(0x2::coin::value<T0>(&v0) == arg1, 1007);
        v0
    }

    public entry fun harvest<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FragmentInfo, arg2: &mut MasterChefData, arg3: &mut UserInfo<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun initialize(arg0: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        let v0 = 0x2::object::new(arg2);
        let v1 = MasterChefData{
            id                     : v0,
            ryu_mint_cap           : 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::set_new_role(arg0, &mut v0, 100000000000000),
            total_alloc_point      : 0,
            admin_address          : 0x2::tx_context::sender(arg2),
            start_timestamp        : get_current_timestamp(arg1),
            per_second_BOXFRAGMENT : 1653400,
            pool_list              : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<MasterChefData>(v1);
    }

    public fun pending_BOXFRAGMENT<T0>(arg0: &UserInfo<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FragmentInfo, arg3: &mut MasterChefData, arg4: &mut PoolInfo<T0>, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        update_pool<T0>(arg1, arg2, arg3, arg5);
        (((arg0.amount as u128) * arg4.acc_BOXFRAGMENT_per_share / 1000000000000 - arg0.reward_debt) as u64)
    }

    public entry fun set_admin_address(arg0: &mut MasterChefData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 1001);
        arg0.admin_address = arg1;
    }

    public entry fun set_per_second_BOXFRAGMENT(arg0: &mut MasterChefData, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 1001);
        assert!(arg1 >= 1000000 && arg1 <= 10000000000, 1001);
        arg0.per_second_BOXFRAGMENT = arg1;
    }

    public entry fun set_pool<T0>(arg0: &mut MasterChefData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 1001);
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, PoolInfo<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 1002);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, PoolInfo<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        arg0.total_alloc_point = arg0.total_alloc_point - v0.alloc_point + arg1;
        v0.alloc_point = arg1;
        let v1 = SetEvent{
            coin_name   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            alloc_point : arg1,
        };
        0x2::event::emit<SetEvent>(v1);
    }

    public entry fun update_pool<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FragmentInfo, arg2: &mut MasterChefData, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, PoolInfo<T0>>(&mut arg2.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 1002);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, PoolInfo<T0>>(&mut arg2.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = get_current_timestamp(arg0);
        if (v1 <= v0.last_reward_timestamp) {
            return
        };
        let v2 = 0x2::coin::value<T0>(&v0.coin_reserve);
        if (v2 <= 0) {
            v0.last_reward_timestamp = v1;
            return
        };
        let v3 = get_multiplier(v0.last_reward_timestamp, v1) * arg2.per_second_BOXFRAGMENT * (v0.alloc_point as u128) / (arg2.total_alloc_point as u128);
        0x2::coin::join<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>(&mut v0.coin_reward, 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::mint_coin(&mut arg2.ryu_mint_cap, arg1, (v3 as u64), arg3));
        v0.acc_BOXFRAGMENT_per_share = v0.acc_BOXFRAGMENT_per_share + v3 * 1000000000000 / (v2 as u128);
        v0.last_reward_timestamp = v1;
    }

    public entry fun withdraw<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FragmentInfo, arg3: &mut MasterChefData, arg4: &mut UserInfo<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        update_pool<T0>(arg1, arg2, arg3, arg5);
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, PoolInfo<T0>>(&mut arg3.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 1002);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, PoolInfo<T0>>(&mut arg3.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg4.amount >= arg0, 1004);
        assert!(arg0 > 0, 1010);
        let v2 = 0;
        if (arg4.amount > 0) {
            let v3 = (arg4.amount as u128) * v0.acc_BOXFRAGMENT_per_share / 1000000000000 - arg4.reward_debt;
            v2 = v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>>(0x2::coin::split<0xb0a1c78dfb06898de94d96427aceaf339227ee3fdd18993f4ae67c3d02f067a2::fragment::FRAGMENT>(&mut v0.coin_reward, (v3 as u64), arg5), v1);
        };
        arg4.amount = arg4.amount - arg0;
        arg4.reward_debt = (arg4.amount as u128) * v0.acc_BOXFRAGMENT_per_share / 1000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_reserve, arg0, arg5), v1);
        let v4 = WithdrawEvent{
            sender_address : v1,
            coin_name      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward         : (v2 as u64),
            amount         : arg0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

