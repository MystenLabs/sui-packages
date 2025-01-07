module 0x8227925a95d62bffa724e2ce9d00a5ead3516a3cb2618a93ba9a4ee5ebd554c1::bucket_v1 {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        token_supply: 0x2::balance::Supply<T0>,
        total_holding: u64,
        holding: vector<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>,
        profit_target: u64,
        profit: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_pacakge_version<T0>(arg0);
        let v0 = 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg2, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg4, arg5));
        let v1 = if (arg0.total_holding > 0) {
            0x8227925a95d62bffa724e2ce9d00a5ead3516a3cb2618a93ba9a4ee5ebd554c1::math::mul_factor(0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v0), 0x2::balance::supply_value<T0>(&arg0.token_supply), arg0.total_holding)
        } else {
            0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v0)
        };
        arg0.total_holding = arg0.total_holding + 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v0);
        stake_protocol<T0>(arg0, arg1, arg3, v0, arg5);
        0x2::balance::increase_supply<T0>(&mut arg0.token_supply, v1)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        assert_pacakge_version<T0>(arg0);
        assert!(0x2::balance::value<T0>(&arg4) <= 0x2::balance::supply_value<T0>(&arg0.token_supply), 1003);
        let (v0, v1) = unstake_protocol<T0>(arg0, arg1, arg3);
        let v2 = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profit, v1);
        let v3 = 0x8227925a95d62bffa724e2ce9d00a5ead3516a3cb2618a93ba9a4ee5ebd554c1::math::mul_factor(0x2::balance::value<T0>(&arg4), 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v2), 0x2::balance::supply_value<T0>(&arg0.token_supply));
        let v4 = v3;
        if (v3 > 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v2)) {
            v4 = 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v2);
        };
        arg0.total_holding = 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v2);
        stake_protocol<T0>(arg0, arg1, arg3, v2, arg5);
        0x2::balance::decrease_supply<T0>(&mut arg0.token_supply, arg4);
        0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg2, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(0x2::balance::split<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v2, v4), arg5))
    }

    fun assert_admin_cap<T0>(arg0: &Vault<T0>, arg1: &AdminCap) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 1002);
    }

    fun assert_pacakge_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 1001);
    }

    public fun collect_profit<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_pacakge_version<T0>(arg0);
        assert_admin_cap<T0>(arg0, arg1);
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.profit)
    }

    entry fun collect_profit_entry<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(collect_profit<T0>(arg0, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (Vault<T0>, AdminCap) {
        let v0 = Vault<T0>{
            id            : 0x2::object::new(arg1),
            version       : 1,
            token_supply  : 0x2::coin::treasury_into_supply<T0>(arg0),
            total_holding : 0,
            holding       : 0x1::vector::empty<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(),
            profit_target : 1000000000,
            profit        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<Vault<T0>>(&v0),
        };
        (v0, v1)
    }

    entry fun create_entry<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create<T0>(arg0, arg1);
        0x2::transfer::share_object<Vault<T0>>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun restake_protocol<T0, T1>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T1>, arg6: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg7: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_pacakge_version<T0>(arg0);
        assert_admin_cap<T0>(arg0, arg1);
        let (v0, v1) = unstake_protocol<T0>(arg0, arg2, arg7);
        let v2 = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profit, v1);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.profit) > arg0.profit_target) {
            let (v3, v4) = 0x8227925a95d62bffa724e2ce9d00a5ead3516a3cb2618a93ba9a4ee5ebd554c1::swap::swap<T1, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.profit, 0x2::balance::value<0x2::sui::SUI>(&arg0.profit) - arg0.profit_target), false, arg2);
            let v5 = v4;
            let (v6, v7) = 0x8227925a95d62bffa724e2ce9d00a5ead3516a3cb2618a93ba9a4ee5ebd554c1::swap::swap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T1>(arg3, arg5, 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(), v3, false, arg2);
            let v8 = v7;
            let v9 = v6;
            assert!(0x2::balance::value<T1>(&v8) == 0, 1005);
            0x2::balance::destroy_zero<T1>(v8);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) == 0, 1006);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
            if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v9) > 0) {
                0x2::balance::join<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v2, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg6, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v9, arg8)));
            } else {
                0x2::balance::destroy_zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v9);
            };
        };
        arg0.total_holding = 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v2);
        stake_protocol<T0>(arg0, arg2, arg7, v2, arg8);
    }

    fun stake_protocol<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: 0x2::balance::Balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&arg3) > 0) {
            0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.holding, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg1, arg2, arg3, 4838400000, arg4));
        } else {
            0x2::balance::destroy_zero<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(arg3);
        };
    }

    fun unstake_protocol<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>) : (0x2::balance::Balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::zero<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>();
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::is_empty<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.holding) == false) {
            let (v2, v3) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg1, arg2, 0x1::vector::pop_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.holding));
            0x2::balance::join<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v0, v2);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v3);
        };
        assert!(arg0.total_holding == 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v0), 1004);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

