module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::staking_manager {
    struct StakingManager has key {
        id: 0x2::object::UID,
        admin: address,
        xaum_pool: 0x2::balance::Balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>,
        xaum_fee_pool: 0x2::balance::Balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>,
        stake_fee_rate: 0x1::fixed_point32::FixedPoint32,
        unstake_fee_rate: 0x1::fixed_point32::FixedPoint32,
        stake_cap: u64,
        gr_supply: 0x2::balance::Supply<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>,
        gy_supply: 0x2::balance::Supply<0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::COIN_GY>,
    }

    struct StakeEvent has copy, drop {
        user: address,
        xaum_gross: u64,
        xaum_fee: u64,
        xaum_net: u64,
        gr_minted: u64,
        gy_minted: u64,
    }

    struct UnstakeEvent has copy, drop {
        user: address,
        xaum_returned: u64,
        gr_burned: u64,
        gy_burned: u64,
    }

    struct ManagerCreated has copy, drop {
        manager_id: address,
        admin: address,
    }

    public fun get_admin(arg0: &StakingManager) : address {
        arg0.admin
    }

    public fun get_fee_pool_balance(arg0: &StakingManager) : u64 {
        0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum_fee_pool)
    }

    public fun get_gr_total_supply(arg0: &StakingManager) : u64 {
        0x2::balance::supply_value<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>(&arg0.gr_supply)
    }

    public fun get_gy_total_supply(arg0: &StakingManager) : u64 {
        0x2::balance::supply_value<0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::COIN_GY>(&arg0.gy_supply)
    }

    public fun get_pool_balance(arg0: &StakingManager) : u64 {
        0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum_pool)
    }

    public fun get_stake_cap(arg0: &StakingManager) : u64 {
        arg0.stake_cap
    }

    public fun init_staking_manager(arg0: 0x2::coin::TreasuryCap<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>, arg1: 0x2::coin::TreasuryCap<0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::COIN_GY>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = StakingManager{
            id               : 0x2::object::new(arg2),
            admin            : v0,
            xaum_pool        : 0x2::balance::zero<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(),
            xaum_fee_pool    : 0x2::balance::zero<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(),
            stake_fee_rate   : 0x1::fixed_point32::create_from_rational(0, 1),
            unstake_fee_rate : 0x1::fixed_point32::create_from_rational(0, 1),
            stake_cap        : 0,
            gr_supply        : 0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::treasury_into_supply(arg0),
            gy_supply        : 0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::treasury_into_supply(arg1),
        };
        let v2 = ManagerCreated{
            manager_id : 0x2::object::id_address<StakingManager>(&v1),
            admin      : v0,
        };
        0x2::event::emit<ManagerCreated>(v2);
        0x2::transfer::share_object<StakingManager>(v1);
    }

    public(friend) fun owner_deposit_xaum(arg0: &mut StakingManager, arg1: 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>) {
        0x2::balance::join<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg0.xaum_pool, 0x2::coin::into_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(arg1));
    }

    public(friend) fun owner_withdraw_xaum(arg0: &mut StakingManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM> {
        assert!(0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum_pool) >= arg1, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_pool_xaum_not_enough_error());
        0x2::coin::from_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(0x2::balance::split<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg0.xaum_pool, arg1), arg2)
    }

    public fun read_fee_pool_balance(arg0: &StakingManager) : u64 {
        0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum_fee_pool)
    }

    public fun stake_xaum(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut StakingManager, arg2: 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg2);
        assert!(v1 >= 1000000, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_min_xaum_error());
        let v2 = 0x1::fixed_point32::multiply_u64(v1, arg1.stake_fee_rate);
        assert!(v1 > v2, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_fee_exceeds_amount_error());
        let v3 = 0x2::coin::into_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(arg2);
        0x2::balance::join<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg1.xaum_fee_pool, 0x2::balance::split<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut v3, v2));
        let v4 = v1 - v2;
        if (arg1.stake_cap > 0) {
            assert!(0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg1.xaum_pool) + v4 <= arg1.stake_cap, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_stake_cap_exceeded_error());
        };
        0x2::balance::join<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg1.xaum_pool, v3);
        let v5 = v4 * 100;
        let v6 = v4 * 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>>(0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::mint_from_supply(&mut arg1.gr_supply, v5, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::COIN_GY>>(0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::mint_from_supply(&mut arg1.gy_supply, v6, arg3), v0);
        let v7 = StakeEvent{
            user       : v0,
            xaum_gross : v1,
            xaum_fee   : v2,
            xaum_net   : v4,
            gr_minted  : v5,
            gy_minted  : v6,
        };
        0x2::event::emit<StakeEvent>(v7);
    }

    public(friend) fun take_stake_fee_coin(arg0: &mut StakingManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM> {
        0x2::coin::from_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(0x2::balance::split<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg0.xaum_fee_pool, arg1), arg2)
    }

    public fun unstake(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut StakingManager, arg2: 0x2::coin::Coin<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>, arg3: 0x2::coin::Coin<0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::COIN_GY>, arg4: &mut 0x2::tx_context::TxContext) {
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>(&arg2);
        let v2 = 0x2::coin::value<0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::COIN_GY>(&arg3);
        assert!(v1 == v2, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_gr_gy_mismatch_error());
        assert!(v1 >= 1000000 * 100, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_insufficient_gr_gy_error());
        assert!(v1 % 100 == 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_gr_amount_not_divisible_error());
        let v3 = v1 / 100;
        assert!(0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg1.xaum_pool) >= v3, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_pool_xaum_not_enough_error());
        0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::burn_to_supply(&mut arg1.gr_supply, arg2);
        0xf5c26e43a9347ed2b8fc2dd67a65fd760c3ee05a510009f86a2d0671f71e453f::coin_gy::burn_to_supply(&mut arg1.gy_supply, arg3);
        let v4 = 0x2::balance::split<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg1.xaum_pool, v3);
        let v5 = 0x1::fixed_point32::multiply_u64(v3, arg1.unstake_fee_rate);
        assert!(v3 > v5, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_fee_exceeds_amount_error());
        if (v5 > 0) {
            0x2::balance::join<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg1.xaum_fee_pool, 0x2::balance::split<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut v4, v5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>>(0x2::coin::from_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(v4, arg4), v0);
        let v6 = UnstakeEvent{
            user          : v0,
            xaum_returned : v3 - v5,
            gr_burned     : v1,
            gy_burned     : v2,
        };
        0x2::event::emit<UnstakeEvent>(v6);
    }

    public(friend) fun update_stake_cap(arg0: &mut StakingManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_not_admin_error());
        arg0.stake_cap = arg1;
    }

    public(friend) fun update_stake_fee(arg0: &mut StakingManager, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_not_admin_error());
        assert!(arg2 > 0 && arg1 <= arg2, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_invalid_params_error());
        arg0.stake_fee_rate = 0x1::fixed_point32::create_from_rational(arg1, arg2);
    }

    public(friend) fun update_unstake_fee(arg0: &mut StakingManager, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_not_admin_error());
        assert!(arg2 > 0 && arg1 <= arg2, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::staking_invalid_params_error());
        arg0.unstake_fee_rate = 0x1::fixed_point32::create_from_rational(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

