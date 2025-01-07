module 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor {
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
        pool_allocator: 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::Allocator,
        fee_wallet: address,
        airdrop_wallet: address,
        airdrop_wallet_balance: 0x2::balance::Balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>,
        team_wallet_address: address,
        team_wallet_balance: 0x2::balance::Balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>,
        dust_wallet_address: address,
        onhold_receipts_wallet_address: address,
        reward_unlock: 0x2::vec_map::VecMap<0x1::type_name::TypeName, UnlockData>,
    }

    struct DistributorEvent has copy, drop {
        value: u64,
        location: u64,
    }

    entry fun add_new_pool(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Distributor, arg3: 0x2::object::ID) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::add_new_pool(&mut arg2.pool_allocator, arg3);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = if (v0 == 0x1::type_name::get<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>()) {
            if (0x2::clock::timestamp_ms(arg2) > arg0.next_halving_timestamp) {
                mint_and_distribute_alpha(arg0, arg2, arg3);
            };
            ((upms_for_alpha(arg0) as u64), 0x2::clock::timestamp_ms(arg2))
        } else if (0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0) == true) {
            let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0);
            (v3.unlock_per_ms, (0x2::math::min(v3.last_unlock_time, 0x2::clock::timestamp_ms(arg2)) as u64))
        } else {
            (0, 0x2::clock::timestamp_ms(arg2))
        };
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::get_rewards<T0>(&mut arg0.pool_allocator, arg1, v1, v2)
    }

    entry fun add_admin(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        let v0 = AdminCap{
            id       : 0x2::object::new(arg3),
            owner_id : arg2,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
    }

    entry fun add_reward<T0>(arg0: &mut Distributor, arg1: &AdminCap, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 != 0x1::type_name::get<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::external_reward_alpha());
        let v1 = false;
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0) == true) {
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, &v0);
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v3.unlock_per_ms, 0x2::math::min(0x2::clock::timestamp_ms(arg5), v3.last_unlock_time), v3.last_unlock_time);
            v3.last_unlock_time
        } else {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::balance::zero<T0>());
            v1 = true;
            0
        };
        if (0x2::clock::timestamp_ms(arg5) > v2) {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, 0, 0x2::clock::timestamp_ms(arg5), 0x2::clock::timestamp_ms(arg5));
        };
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg3));
        if (v1) {
            let v4 = UnlockData{
                unlock_per_ms    : arg4,
                last_unlock_time : 0x2::clock::timestamp_ms(arg5) + 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::get_reward_value<T0>(&arg0.pool_allocator) / arg4,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, v0, v4);
        } else {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, &v0);
            v5.unlock_per_ms = arg4;
            v5.last_unlock_time = 0x2::clock::timestamp_ms(arg5) + 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::get_reward_value<T0>(&arg0.pool_allocator) / arg4;
        };
    }

    entry fun change_airdrop_wallet_address(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Distributor, arg3: address) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.airdrop_wallet = arg3;
    }

    entry fun change_dust_wallet_address(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Distributor, arg3: address) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.dust_wallet_address = arg3;
    }

    entry fun change_fee_wallet_address(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Distributor, arg3: address) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.fee_wallet = arg3;
    }

    entry fun change_onhold_receipts_wallet_address(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Distributor, arg3: address) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.onhold_receipts_wallet_address = arg3;
    }

    entry fun change_team_wallet_address(arg0: &AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Distributor, arg3: address) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.team_wallet_address = arg3;
    }

    public fun create(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: 0x2::coin::TreasuryCap<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        let v0 = 0x2::object::new(arg7);
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::TreasuryCap<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(&mut v0, b"treasury_cap", arg1);
        let v1 = Distributor{
            id                             : v0,
            start_timestamp                : 0,
            next_halving_timestamp         : 0,
            target                         : 0,
            pool_allocator                 : 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::create_allocator(arg7),
            fee_wallet                     : arg2,
            airdrop_wallet                 : arg3,
            airdrop_wallet_balance         : 0x2::balance::zero<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(),
            team_wallet_address            : arg4,
            team_wallet_balance            : 0x2::balance::zero<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(),
            dust_wallet_address            : arg5,
            onhold_receipts_wallet_address : arg6,
            reward_unlock                  : 0x2::vec_map::empty<0x1::type_name::TypeName, UnlockData>(),
        };
        0x2::transfer::public_share_object<Distributor>(v1);
        let v2 = AdminCap{
            id       : 0x2::object::new(arg7),
            owner_id : 0x2::tx_context::sender(arg7),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg7));
        let v3 = EmergencyCap{
            id       : 0x2::object::new(arg7),
            owner_id : 0x2::tx_context::sender(arg7),
        };
        0x2::transfer::public_transfer<EmergencyCap>(v3, 0x2::tx_context::sender(arg7));
        let v4 = DevCap{
            id       : 0x2::object::new(arg7),
            owner_id : 0x2::tx_context::sender(arg7),
        };
        0x2::transfer::public_transfer<DevCap>(v4, 0x2::tx_context::sender(arg7));
        let v5 = BurnStartCap{id: 0x2::object::new(arg7)};
        0x2::transfer::public_transfer<BurnStartCap>(v5, 0x2::tx_context::sender(arg7));
        let v6 = RebalanceCap{id: 0x2::object::new(arg7)};
        0x2::transfer::public_transfer<RebalanceCap>(v6, 0x2::tx_context::sender(arg7));
    }

    entry fun delete_pool_from_allocator(arg0: &AdminCap, arg1: &mut Distributor, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: 0x2::object::ID) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::delete_pool(&mut arg1.pool_allocator, arg3);
    }

    fun destroy_start_cap(arg0: BurnStartCap) {
        let BurnStartCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get_airdrop_wallet_address(arg0: &Distributor) : address {
        arg0.airdrop_wallet
    }

    public(friend) fun get_dust_wallet_address(arg0: &Distributor) : address {
        arg0.dust_wallet_address
    }

    public(friend) fun get_fee_wallet_address(arg0: &Distributor) : address {
        arg0.fee_wallet
    }

    public(friend) fun get_onhold_receipts_wallet_address(arg0: &Distributor) : address {
        arg0.onhold_receipts_wallet_address
    }

    fun mint_and_distribute_alpha(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.target == 0 || 0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"treasury_cap") == false) {
            return
        };
        let v0 = 0;
        while (arg0.next_halving_timestamp <= 0x2::clock::timestamp_ms(arg1)) {
            let v1 = upms_for_alpha(arg0);
            let v2 = DistributorEvent{
                value    : v1,
                location : 10,
            };
            0x2::event::emit<DistributorEvent>(v2);
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::top_up_pools<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut arg0.pool_allocator, v1, arg0.next_halving_timestamp, arg0.next_halving_timestamp);
            let v3 = (arg0.next_halving_timestamp - arg0.start_timestamp) / 86400000;
            arg0.next_halving_timestamp = arg0.next_halving_timestamp + 100 * 86400000;
            if (v3 < 900) {
                arg0.target = arg0.target / 2;
            };
            if (v3 >= 1000) {
                arg0.target = 0;
                break
            };
            let v4 = arg0.target;
            let v5 = ((2750000 * (v4 as u128) / 4250000) as u64);
            let v6 = DistributorEvent{
                value    : v5,
                location : 11,
            };
            0x2::event::emit<DistributorEvent>(v6);
            let v7 = 0x2::coin::mint<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(&mut arg0.id, b"treasury_cap"), v5, arg2);
            send_rewards_to_pool_allocator<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg0, v7);
            v0 = v0 + v4;
        };
        let v8 = ((250000 * (v0 as u128) / 4250000) as u64);
        let v9 = DistributorEvent{
            value    : v8,
            location : 12,
        };
        0x2::event::emit<DistributorEvent>(v9);
        let v10 = 1250000 * (v0 as u128) / 4250000;
        let v11 = DistributorEvent{
            value    : (v10 as u64),
            location : 13,
        };
        0x2::event::emit<DistributorEvent>(v11);
        let v12 = 0x2::dynamic_field::remove<vector<u8>, 0x2::coin::TreasuryCap<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(&mut arg0.id, b"treasury_cap");
        0x2::balance::join<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut arg0.airdrop_wallet_balance, 0x2::coin::into_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(0x2::coin::mint<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut v12, v8, arg2)));
        0x2::balance::join<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut arg0.team_wallet_balance, 0x2::coin::into_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(0x2::coin::mint<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut v12, (v10 as u64), arg2)));
        if (arg0.target == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(v12, @0x0);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::coin::TreasuryCap<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(&mut arg0.id, b"treasury_cap", v12);
        };
    }

    entry fun remove_unlock_per_second<T0>(arg0: &mut Distributor, arg1: &AdminCap, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: &0x2::clock::Clock) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0) == true, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::reward_not_set_error());
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, UnlockData>(&arg0.reward_unlock, &v0);
        let v2 = v1.unlock_per_ms;
        if (v2 > 0) {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v2, 0x2::math::min(0x2::clock::timestamp_ms(arg3), v1.last_unlock_time), v1.last_unlock_time);
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, UnlockData>(&mut arg0.reward_unlock, &v0);
    }

    fun send_rewards_to_pool_allocator<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun set_start_timestamp_and_destroy_cap(arg0: &AdminCap, arg1: BurnStartCap, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: &mut Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        destroy_start_cap(arg1);
        arg3.target = 8500000 * 1000000000;
        arg3.start_timestamp = 0x2::clock::timestamp_ms(arg4);
        arg3.next_halving_timestamp = arg3.start_timestamp;
        send_rewards_to_pool_allocator<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg3, 0x2::coin::zero<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg5));
        mint_and_distribute_alpha(arg3, arg4, arg5);
    }

    entry fun set_weights<T0>(arg0: &AdminCap, arg1: &mut Distributor, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg4), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::input_error());
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, UnlockData>(&arg1.reward_unlock, &v0) == true) {
            let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, UnlockData>(&arg1.reward_unlock, &v0);
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::top_up_pools<T0>(&mut arg1.pool_allocator, v1.unlock_per_ms, 0x2::math::min(0x2::clock::timestamp_ms(arg5), v1.last_unlock_time), v1.last_unlock_time);
        };
        if (v0 == 0x1::type_name::get<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>()) {
            if (0x2::clock::timestamp_ms(arg5) > arg1.next_halving_timestamp) {
                mint_and_distribute_alpha(arg1, arg5, arg6);
            };
            if (arg1.next_halving_timestamp > 0) {
                0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::top_up_pools<T0>(&mut arg1.pool_allocator, upms_for_alpha(arg1), 0x2::clock::timestamp_ms(arg5), arg1.next_halving_timestamp);
            };
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::allocator::set_weight<T0>(&mut arg1.pool_allocator, 0x1::vector::pop_back<0x2::object::ID>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), arg5);
            v2 = v2 + 1;
        };
    }

    fun upms_for_alpha(arg0: &Distributor) : u64 {
        (((arg0.target as u128) * 2750000 / ((100 * 86400000) as u128) * 4250000) as u64)
    }

    entry fun withdraw_airdrop_balance(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: &mut Distributor, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        assert!(0x2::balance::value<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&arg1.airdrop_wallet_balance) >= arg2, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(0x2::coin::from_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(0x2::balance::split<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut arg1.airdrop_wallet_balance, arg2), arg3), arg1.airdrop_wallet);
    }

    entry fun withdraw_team_balance(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: &mut Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.start_timestamp + 300 * 86400000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::withdraw_before_cliff_error());
        assert!(0x2::balance::value<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&arg1.team_wallet_balance) > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>>(0x2::coin::from_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(0x2::balance::withdraw_all<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&mut arg1.team_wallet_balance), arg3), arg1.team_wallet_address);
    }

    // decompiled from Move bytecode v6
}

