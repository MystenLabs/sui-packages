module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner_id: address,
    }

    struct EmergencyCap has store, key {
        id: 0x2::object::UID,
        owner_id: address,
    }

    struct DevCap has store, key {
        id: 0x2::object::UID,
        owner_id: address,
    }

    struct BurnStartCap has store, key {
        id: 0x2::object::UID,
    }

    struct RebalanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct UnlockData has drop, store {
        unlock_per_ms: u64,
        last_unlock_time: u64,
    }

    struct Distributor has store, key {
        id: 0x2::object::UID,
        start_timestamp: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::Allocator,
        fee_wallet_address: address,
        airdrop_wallet_address: address,
        airdrop_wallet_balance: u64,
        team_wallet_address: address,
        team_wallet_balance: u64,
        dust_wallet_address: address,
        onhold_receipts_wallet_address: address,
        reward_unlock: 0x2::vec_map::VecMap<0x1::type_name::TypeName, UnlockData>,
        balances: 0x2::bag::Bag,
    }

    struct MintDistributeEvent has copy, drop {
        unlock_per_ms: u64,
    }

    struct MintToAllocatorEvent has copy, drop {
        amount: u64,
    }

    struct MintAirdropEvent has copy, drop {
        amount: u64,
    }

    struct MintTeamEvent has copy, drop {
        amount: u64,
    }

    struct TeamWithdrawEvent has copy, drop {
        amount: u64,
    }

    struct AirdropWithdrawEvent has copy, drop {
        amount: u64,
    }

    entry fun add_new_pool(arg0: &AdminCap, arg1: &mut Distributor, arg2: 0x2::object::ID) {
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::add_new_pool(&mut arg1.pool_allocator, arg2);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let (v2, v3) = if (has_platform_token(arg0) && v0 == platform_token_type(arg0)) {
            if (v1 > arg0.next_halving_timestamp) {
                mint_and_distribute<T0>(arg0, arg2, arg3);
            };
            ((unlock_per_ms_for_platform_token(arg0) as u64), v1)
        } else if (0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0)) {
            let v4 = 0x2::vec_map::get<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0);
            (v4.unlock_per_ms, 0x1::u64::min(v4.last_unlock_time, v1))
        } else {
            (0, v1)
        };
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::get_rewards<T0>(&mut arg0.pool_allocator, arg1, v2, v3)
    }

    public entry fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id       : 0x2::object::new(arg2),
            owner_id : arg1,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public entry fun add_reward<T0>(arg0: &mut Distributor, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        if (has_platform_token(arg0)) {
            assert!(v0 != platform_token_type(arg0), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::external_reward_platform_token());
        };
        let v1 = false;
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0)) {
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, &v0);
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v3.unlock_per_ms, 0x1::u64::min(0x2::clock::timestamp_ms(arg4), v3.last_unlock_time), v3.last_unlock_time);
            v3.last_unlock_time
        } else {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::balance::zero<T0>());
            v1 = true;
            0
        };
        if (0x2::clock::timestamp_ms(arg4) > v2) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, 0, 0x2::clock::timestamp_ms(arg4), 0x2::clock::timestamp_ms(arg4));
        };
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg2));
        if (v1) {
            let v4 = UnlockData{
                unlock_per_ms    : arg3,
                last_unlock_time : 0x2::clock::timestamp_ms(arg4) + 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::get_reward_value<T0>(&arg0.pool_allocator) / arg3,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, v0, v4);
        } else {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, &v0);
            v5.unlock_per_ms = arg3;
            v5.last_unlock_time = 0x2::clock::timestamp_ms(arg4) + 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::get_reward_value<T0>(&arg0.pool_allocator) / arg3;
        };
    }

    entry fun change_airdrop_wallet_address(arg0: &AdminCap, arg1: &mut Distributor, arg2: address) {
        arg1.airdrop_wallet_address = arg2;
    }

    entry fun change_dust_wallet_address(arg0: &AdminCap, arg1: &mut Distributor, arg2: address) {
        arg1.dust_wallet_address = arg2;
    }

    entry fun change_fee_wallet_address(arg0: &AdminCap, arg1: &mut Distributor, arg2: address) {
        arg1.fee_wallet_address = arg2;
    }

    entry fun change_onhold_receipts_wallet_address(arg0: &AdminCap, arg1: &mut Distributor, arg2: address) {
        arg1.onhold_receipts_wallet_address = arg2;
    }

    entry fun change_team_wallet_address(arg0: &AdminCap, arg1: &mut Distributor, arg2: address) {
        arg1.team_wallet_address = arg2;
    }

    public fun create(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id                             : 0x2::object::new(arg5),
            start_timestamp                : 0,
            next_halving_timestamp         : 0,
            target                         : 0,
            pool_allocator                 : 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::create_allocator(arg5),
            fee_wallet_address             : arg0,
            airdrop_wallet_address         : arg1,
            airdrop_wallet_balance         : 0,
            team_wallet_address            : arg2,
            team_wallet_balance            : 0,
            dust_wallet_address            : arg3,
            onhold_receipts_wallet_address : arg4,
            reward_unlock                  : 0x2::vec_map::empty<0x1::type_name::TypeName, UnlockData>(),
            balances                       : 0x2::bag::new(arg5),
        };
        0x2::transfer::public_share_object<Distributor>(v0);
        let v1 = AdminCap{
            id       : 0x2::object::new(arg5),
            owner_id : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg5));
        let v2 = EmergencyCap{
            id       : 0x2::object::new(arg5),
            owner_id : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_transfer<EmergencyCap>(v2, 0x2::tx_context::sender(arg5));
        let v3 = DevCap{
            id       : 0x2::object::new(arg5),
            owner_id : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_transfer<DevCap>(v3, 0x2::tx_context::sender(arg5));
        let v4 = BurnStartCap{id: 0x2::object::new(arg5)};
        0x2::transfer::public_transfer<BurnStartCap>(v4, 0x2::tx_context::sender(arg5));
        let v5 = RebalanceCap{id: 0x2::object::new(arg5)};
        0x2::transfer::public_transfer<RebalanceCap>(v5, 0x2::tx_context::sender(arg5));
    }

    entry fun delete_pool_from_allocator(arg0: &AdminCap, arg1: &mut Distributor, arg2: 0x2::object::ID) {
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::delete_pool(&mut arg1.pool_allocator, arg2);
    }

    fun destroy_start_cap(arg0: BurnStartCap) {
        let BurnStartCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get_airdrop_wallet_address(arg0: &Distributor) : address {
        arg0.airdrop_wallet_address
    }

    public(friend) fun get_dust_wallet_address(arg0: &Distributor) : address {
        arg0.dust_wallet_address
    }

    public(friend) fun get_fee_wallet_address(arg0: &Distributor) : address {
        arg0.fee_wallet_address
    }

    public(friend) fun get_onhold_receipts_wallet_address(arg0: &Distributor) : address {
        arg0.onhold_receipts_wallet_address
    }

    fun has_platform_token(arg0: &Distributor) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"platform_token")
    }

    fun mint_and_distribute<T0>(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.target == 0 || !0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"dynamic_field")) {
            return
        };
        let v0 = 0;
        while (arg0.next_halving_timestamp <= 0x2::clock::timestamp_ms(arg1)) {
            let v1 = unlock_per_ms_for_platform_token(arg0);
            let v2 = MintDistributeEvent{unlock_per_ms: v1};
            0x2::event::emit<MintDistributeEvent>(v2);
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v1, arg0.next_halving_timestamp, arg0.next_halving_timestamp);
            let v3 = (arg0.next_halving_timestamp - arg0.start_timestamp) / 86400000;
            arg0.next_halving_timestamp = arg0.next_halving_timestamp + 8640000000;
            if (v3 < 900) {
                arg0.target = arg0.target / 2;
            };
            if (v3 >= 1000) {
                arg0.target = 0;
                break
            };
            let v4 = ((2750000 * (arg0.target as u128) / 4250000) as u64);
            let v5 = MintToAllocatorEvent{amount: v4};
            0x2::event::emit<MintToAllocatorEvent>(v5);
            let v6 = 0x2::coin::mint<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"dynamic_field"), v4, arg2);
            send_rewards_to_pool_allocator<T0>(arg0, v6);
            v0 = v0 + arg0.target;
        };
        let v7 = ((250000 * (v0 as u128) / 4250000) as u64);
        let v8 = MintAirdropEvent{amount: v7};
        0x2::event::emit<MintAirdropEvent>(v8);
        let v9 = ((1250000 * (v0 as u128) / 4250000) as u64);
        let v10 = MintTeamEvent{amount: v9};
        0x2::event::emit<MintTeamEvent>(v10);
        let v11 = 0x2::dynamic_field::remove<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"dynamic_field");
        let v12 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>());
        0x2::balance::join<T0>(v12, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut v11, v7, arg2)));
        0x2::balance::join<T0>(v12, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut v11, v9, arg2)));
        arg0.airdrop_wallet_balance = arg0.airdrop_wallet_balance + v7;
        arg0.team_wallet_balance = arg0.team_wallet_balance + v9;
        if (arg0.target == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v11, @0x0);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"dynamic_field", v11);
        };
    }

    fun platform_token_type(arg0: &Distributor) : 0x1::type_name::TypeName {
        *0x2::dynamic_field::borrow<vector<u8>, 0x1::type_name::TypeName>(&arg0.id, b"platform_token")
    }

    entry fun remove_unlock_per_second<T0>(arg0: &mut Distributor, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::reward_not_set_error());
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0);
        if (v1.unlock_per_ms > 0) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v1.unlock_per_ms, 0x1::u64::min(0x2::clock::timestamp_ms(arg2), v1.last_unlock_time), v1.last_unlock_time);
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, &v0);
    }

    fun send_rewards_to_pool_allocator<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>) {
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun set_platform_token<T0>(arg0: &AdminCap, arg1: &mut Distributor, arg2: 0x2::coin::TreasuryCap<T0>) {
        0x2::dynamic_field::add<vector<u8>, 0x1::type_name::TypeName>(&mut arg1.id, b"platform_token", 0x1::type_name::get<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, b"dynamic_field", arg2);
    }

    public fun set_start_timestamp_and_destroy_cap<T0>(arg0: &AdminCap, arg1: BurnStartCap, arg2: &mut Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(has_platform_token(arg2) && platform_token_type(arg2) == 0x1::type_name::get<T0>(), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::wrong_platform_token_type());
        destroy_start_cap(arg1);
        arg2.target = 8500000000000000;
        arg2.start_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg2.next_halving_timestamp = arg2.start_timestamp;
        send_rewards_to_pool_allocator<T0>(arg2, 0x2::coin::zero<T0>(arg4));
        mint_and_distribute<T0>(arg2, arg3, arg4);
    }

    entry fun set_weights<T0>(arg0: &AdminCap, arg1: &mut Distributor, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u64>(&arg3), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::input_error());
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg1.reward_unlock, &v0)) {
            let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, UnlockData>(&arg1.reward_unlock, &v0);
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::top_up_pools<T0>(&mut arg1.pool_allocator, v1.unlock_per_ms, 0x1::u64::min(0x2::clock::timestamp_ms(arg4), v1.last_unlock_time), v1.last_unlock_time);
        };
        if (v0 == platform_token_type(arg1)) {
            if (0x2::clock::timestamp_ms(arg4) > arg1.next_halving_timestamp) {
                mint_and_distribute<T0>(arg1, arg4, arg5);
            };
            if (arg1.next_halving_timestamp > 0) {
                0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::top_up_pools<T0>(&mut arg1.pool_allocator, unlock_per_ms_for_platform_token(arg1), 0x2::clock::timestamp_ms(arg4), arg1.next_halving_timestamp);
            };
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::allocator::set_weight<T0>(&mut arg1.pool_allocator, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), arg4);
            v2 = v2 + 1;
        };
    }

    fun unlock_per_ms_for_platform_token(arg0: &Distributor) : u64 {
        (((arg0.target as u128) * 2750000 / 8640000000 * 4250000) as u64)
    }

    entry fun withdraw_airdrop_balance<T0>(arg0: &mut Distributor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.airdrop_wallet_balance >= arg1, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == platform_token_type(arg0), 9223374429151559679);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2), arg0.airdrop_wallet_address);
        let v2 = AirdropWithdrawEvent{amount: arg1};
        0x2::event::emit<AirdropWithdrawEvent>(v2);
        arg0.airdrop_wallet_balance = arg0.airdrop_wallet_balance - arg1;
    }

    entry fun withdraw_team_balance<T0>(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.start_timestamp + 25920000000, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::withdraw_before_cliff_error());
        assert!(arg0.team_wallet_balance > 0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == platform_token_type(arg0), 9223374562295545855);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg0.team_wallet_balance), arg2), arg0.team_wallet_address);
        let v1 = TeamWithdrawEvent{amount: arg0.team_wallet_balance};
        0x2::event::emit<TeamWithdrawEvent>(v1);
        arg0.team_wallet_balance = 0;
    }

    // decompiled from Move bytecode v6
}

