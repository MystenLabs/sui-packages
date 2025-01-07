module 0x157c281c6d65312477ed6f2fa63421295cfdd9d0fd26fe8b7c425774174e02c5::farm {
    struct FarmWitness has drop {
        dummy_field: bool,
    }

    struct Account<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        nft_ids: 0x2::table_vec::TableVec<0x2::object::ID>,
        reward_debt: u256,
    }

    struct Farm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        rewards_per_second: u64,
        start_timestamp: u64,
        last_reward_timestamp: u64,
        accrued_rewards_per_share: u256,
        total_staked_nft: u64,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        balance_reward_coin: 0x2::balance::Balance<T1>,
        owned_by: 0x2::object::ID,
        policy_id: 0x2::object::ID,
    }

    struct NewFarm<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct AddReward<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        value: u64,
    }

    struct Stake<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        reward_amount: u64,
    }

    struct Unstake<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        reward_amount: u64,
    }

    struct Withdraw<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        reward_amount: u64,
    }

    struct NewRewardRate<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        rate: u64,
    }

    public fun accrued_rewards_per_share<T0, T1>(arg0: &Farm<T0, T1>) : u256 {
        arg0.accrued_rewards_per_share
    }

    public fun add_rewards<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>) {
        update<T0, T1>(arg0, clock_timestamp_s(arg1));
        let v0 = AddReward<T0, T1>{
            farm  : 0x2::object::id<Farm<T0, T1>>(arg0),
            value : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<AddReward<T0, T1>>(v0);
        0x2::balance::join<T1>(&mut arg0.balance_reward_coin, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun amount<T0, T1>(arg0: &Account<T0, T1>) : u64 {
        0x2::table_vec::length<0x2::object::ID>(&arg0.nft_ids)
    }

    public fun balance_reward_coin<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_reward_coin)
    }

    public fun borrow_mut_uid<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<FarmWitness>) : &mut 0x2::object::UID {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::assert_ownership<FarmWitness>(arg1, 0x2::object::id<Farm<T0, T1>>(arg0));
        &mut arg0.id
    }

    fun calculate_accrued_rewards_per_share(arg0: u64, arg1: u256, arg2: u64, arg3: u64, arg4: u64) : u256 {
        arg1 + 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math256::min((arg3 as u256), (arg0 as u256) * (arg4 as u256)) / (arg2 as u256)
    }

    fun calculate_pending_rewards<T0, T1>(arg0: &Account<T0, T1>, arg1: u256) : u64 {
        (((0x2::table_vec::length<0x2::object::ID>(&arg0.nft_ids) as u256) * arg1 - arg0.reward_debt) as u64)
    }

    fun calculate_reward_debt(arg0: u64, arg1: u256) : u256 {
        (arg0 as u256) * arg1
    }

    fun clock_timestamp_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun destroy_zero_account<T0, T1>(arg0: Account<T0, T1>) {
        let Account {
            id          : v0,
            farm_id     : _,
            nft_ids     : v2,
            reward_debt : _,
        } = arg0;
        let v4 = v2;
        assert!(0x2::table_vec::length<0x2::object::ID>(&v4) == 0, 1);
        0x2::table_vec::destroy_empty<0x2::object::ID>(v4);
        0x2::object::delete(v0);
    }

    public fun destroy_zero_farm<T0, T1>(arg0: Farm<T0, T1>, arg1: &0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<FarmWitness>) {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::assert_ownership<FarmWitness>(arg1, 0x2::object::id<Farm<T0, T1>>(&arg0));
        let Farm {
            id                        : v0,
            rewards_per_second        : _,
            start_timestamp           : _,
            last_reward_timestamp     : _,
            accrued_rewards_per_share : _,
            total_staked_nft          : _,
            kiosk_cap                 : v6,
            balance_reward_coin       : v7,
            owned_by                  : _,
            policy_id                 : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T1>(v7);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, @0x0);
    }

    fun find_in_table_vec(arg0: &0x2::table_vec::TableVec<0x2::object::ID>, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<0x2::object::ID>(arg0)) {
            if (0x2::table_vec::borrow<0x2::object::ID>(arg0, v0) == &arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun last_reward_timestamp<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.last_reward_timestamp
    }

    public fun new_account<T0, T1>(arg0: &Farm<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : Account<T0, T1> {
        Account<T0, T1>{
            id          : 0x2::object::new(arg1),
            farm_id     : 0x2::object::id<Farm<T0, T1>>(arg0),
            nft_ids     : 0x2::table_vec::empty<0x2::object::ID>(arg1),
            reward_debt : 0,
        }
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<FarmWitness> {
        let v0 = FarmWitness{dummy_field: false};
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::new<FarmWitness>(v0, 0x1::vector::empty<0x2::object::ID>(), arg0)
    }

    public fun new_farm<T0, T1>(arg0: &mut 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<FarmWitness>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : Farm<T0, T1> {
        assert!(arg3 > clock_timestamp_s(arg1), 3);
        let (v0, v1) = 0x2::kiosk::new(arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = 0x2::object::id<0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<FarmWitness>>(arg0);
        let v3 = Farm<T0, T1>{
            id                        : 0x2::object::new(arg5),
            rewards_per_second        : arg2,
            start_timestamp           : arg3,
            last_reward_timestamp     : arg3,
            accrued_rewards_per_share : 0,
            total_staked_nft          : 0,
            kiosk_cap                 : v1,
            balance_reward_coin       : 0x2::balance::zero<T1>(),
            owned_by                  : v2,
            policy_id                 : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg4),
        };
        let v4 = 0x2::object::id<Farm<T0, T1>>(&v3);
        let v5 = FarmWitness{dummy_field: false};
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::add<FarmWitness>(arg0, v5, v4);
        let v6 = NewFarm<T0, T1>{
            farm : v4,
            cap  : v2,
        };
        0x2::event::emit<NewFarm<T0, T1>>(v6);
        v3
    }

    public fun owned_by<T0, T1>(arg0: &Farm<T0, T1>) : 0x2::object::ID {
        arg0.owned_by
    }

    public fun pending_rewards<T0, T1>(arg0: &Farm<T0, T1>, arg1: &Account<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::object::id<Farm<T0, T1>>(arg0) != arg1.farm_id) {
            return 0
        };
        let v0 = clock_timestamp_s(arg2);
        let v1 = if (arg0.total_staked_nft == 0 || arg0.last_reward_timestamp >= v0) {
            arg0.accrued_rewards_per_share
        } else {
            calculate_accrued_rewards_per_share(arg0.rewards_per_second, arg0.accrued_rewards_per_share, arg0.total_staked_nft, 0x2::balance::value<T1>(&arg0.balance_reward_coin), v0 - arg0.last_reward_timestamp)
        };
        calculate_pending_rewards<T0, T1>(arg1, v1)
    }

    public fun reward_debt<T0, T1>(arg0: &Account<T0, T1>) : u256 {
        arg0.reward_debt
    }

    public fun rewards_per_second<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.rewards_per_second
    }

    public fun share_farm<T0, T1>(arg0: Farm<T0, T1>) {
        0x2::transfer::public_share_object<Farm<T0, T1>>(arg0);
    }

    public fun stake<T0: store + key, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut Account<T0, T1>, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: T0, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<Farm<T0, T1>>(arg0) == arg1.farm_id, 2);
        assert!(0x2::kiosk::has_access(arg3, &arg0.kiosk_cap), 4);
        update<T0, T1>(arg0, clock_timestamp_s(arg5));
        let v0 = 0x2::coin::zero<T1>(arg6);
        if (0x2::table_vec::length<0x2::object::ID>(&arg1.nft_ids) != 0) {
            let v1 = 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::min(calculate_pending_rewards<T0, T1>(arg1, arg0.accrued_rewards_per_share), 0x2::balance::value<T1>(&arg0.balance_reward_coin));
            if (v1 != 0) {
                0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut v0), 0x2::balance::split<T1>(&mut arg0.balance_reward_coin, v1));
            };
        };
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.nft_ids, 0x2::object::id<T0>(&arg4));
        let v2 = Stake<T0, T1>{
            farm          : 0x2::object::id<Farm<T0, T1>>(arg0),
            nft_id        : 0x2::object::id<T0>(&arg4),
            reward_amount : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<Stake<T0, T1>>(v2);
        0x2::kiosk::lock<T0>(arg3, &arg0.kiosk_cap, arg2, arg4);
        arg0.total_staked_nft = arg0.total_staked_nft + 1;
        arg1.reward_debt = calculate_reward_debt(0x2::table_vec::length<0x2::object::ID>(&arg1.nft_ids), arg0.accrued_rewards_per_share);
        v0
    }

    public fun stake_kiosk<T0: store + key, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut Account<T0, T1>, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::transfer_policy::TransferRequest<T0>) {
        0x2::kiosk::list<T0>(arg5, arg6, arg4, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg5, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        (stake<T0, T1>(arg0, arg1, arg2, arg3, v0, arg7, arg8), v1)
    }

    public fun start_timestamp<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    public fun unstake<T0: store + key, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut Account<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = find_in_table_vec(&arg1.nft_ids, arg3);
        assert!(0x2::object::id<Farm<T0, T1>>(arg0) == arg1.farm_id, 2);
        assert!(0x1::option::is_some<u64>(&v0), 5);
        update<T0, T1>(arg0, clock_timestamp_s(arg4));
        let v1 = calculate_pending_rewards<T0, T1>(arg1, arg0.accrued_rewards_per_share);
        let v2 = 0x2::coin::zero<T1>(arg5);
        if (v1 != 0) {
            0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut v2), 0x2::balance::split<T1>(&mut arg0.balance_reward_coin, 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::min(v1, 0x2::balance::value<T1>(&arg0.balance_reward_coin))));
        };
        arg1.reward_debt = calculate_reward_debt(0x2::table_vec::length<0x2::object::ID>(&arg1.nft_ids), arg0.accrued_rewards_per_share);
        let v3 = Unstake<T0, T1>{
            farm          : 0x2::object::id<Farm<T0, T1>>(arg0),
            nft_id        : arg3,
            reward_amount : v1,
        };
        0x2::event::emit<Unstake<T0, T1>>(v3);
        0x2::kiosk::list<T0>(arg2, &arg0.kiosk_cap, arg3, 0);
        let (v4, v5) = 0x2::kiosk::purchase<T0>(arg2, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg1.nft_ids, *0x1::option::borrow<u64>(&v0));
        arg0.total_staked_nft = arg0.total_staked_nft - 1;
        (v2, v4, v5)
    }

    fun update<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64) {
        if (arg0.last_reward_timestamp >= arg1 || arg0.start_timestamp > arg1) {
            return
        };
        arg0.last_reward_timestamp = arg1;
        if (arg0.total_staked_nft == 0) {
            return
        };
        arg0.accrued_rewards_per_share = calculate_accrued_rewards_per_share(arg0.rewards_per_second, arg0.accrued_rewards_per_share, arg0.total_staked_nft, 0x2::balance::value<T1>(&arg0.balance_reward_coin), arg1 - arg0.last_reward_timestamp);
    }

    public fun update_rewards_per_second<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<FarmWitness>, arg2: u64, arg3: &0x2::clock::Clock) {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::assert_ownership<FarmWitness>(arg1, 0x2::object::id<Farm<T0, T1>>(arg0));
        update<T0, T1>(arg0, clock_timestamp_s(arg3));
        arg0.rewards_per_second = arg2;
        let v0 = NewRewardRate<T0, T1>{
            farm : 0x2::object::id<Farm<T0, T1>>(arg0),
            rate : arg2,
        };
        0x2::event::emit<NewRewardRate<T0, T1>>(v0);
    }

    public fun withdraw_rewards<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut Account<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<Farm<T0, T1>>(arg0) == arg1.farm_id, 2);
        update<T0, T1>(arg0, clock_timestamp_s(arg2));
        let v0 = calculate_pending_rewards<T0, T1>(arg1, arg0.accrued_rewards_per_share);
        let v1 = 0x2::coin::zero<T1>(arg3);
        if (v0 != 0) {
            0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut v1), 0x2::balance::split<T1>(&mut arg0.balance_reward_coin, 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::min(v0, 0x2::balance::value<T1>(&arg0.balance_reward_coin))));
        };
        arg1.reward_debt = calculate_reward_debt(0x2::table_vec::length<0x2::object::ID>(&arg1.nft_ids), arg0.accrued_rewards_per_share);
        let v2 = Withdraw<T0, T1>{
            farm          : 0x2::object::id<Farm<T0, T1>>(arg0),
            reward_amount : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<Withdraw<T0, T1>>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

