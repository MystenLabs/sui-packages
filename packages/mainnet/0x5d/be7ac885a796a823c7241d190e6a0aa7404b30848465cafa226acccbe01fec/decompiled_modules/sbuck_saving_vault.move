module 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::sbuck_saving_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>,
        underlying_nominal_value_buck: u64,
        collected_profit_buck: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
        collected_profit_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        stake_proof: 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>,
    }

    public entry fun new(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategy{
            id                            : 0x2::object::new(arg1),
            version                       : 1,
            admin_cap_id                  : 0x2::object::id<AdminCap>(arg0),
            vault_access                  : 0x1::option::none<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(),
            underlying_nominal_value_buck : 0,
            collected_profit_buck         : 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(),
            collected_profit_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            stake_proof                   : 0x1::option::none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Strategy>(v0);
    }

    public fun deposit(arg0: &mut 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg1: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK> {
        0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg0, arg1, arg2)
    }

    public fun withdraw(arg0: &mut Strategy, arg1: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::WithdrawTicket<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_sbuck_fountain(arg1);
        assert_sbuck_flask(arg2);
        let v0 = 0x1::option::borrow<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::withdraw_ticket_to_withdraw<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg3, v0);
        if (v1 == 0) {
            return
        };
        let (v2, v3) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg1, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.stake_proof));
        let v4 = v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_profit_sui, v3);
        let v5 = 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg2, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(0x2::balance::split<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v4, 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::utils::mul_div(staked_amount(arg0), v1, arg0.underlying_nominal_value_buck)), arg5));
        if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v5) > v1) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.collected_profit_buck, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v5, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v5) - v1));
        };
        0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::strategy_withdraw_to_ticket<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg3, v0, v5);
        let (_, v7) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg1);
        if (0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v4) == 0) {
            0x2::balance::destroy_zero<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(v4);
        } else {
            0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.stake_proof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg1, v4, v7, arg5));
        };
        arg0.underlying_nominal_value_buck = arg0.underlying_nominal_value_buck - v1;
    }

    fun assert_admin(arg0: &AdminCap, arg1: &Strategy) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 101);
    }

    fun assert_sbuck_flask(arg0: &0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        assert!(0x2::object::id_address<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(arg0) == @0xc6ecc9731e15d182bc0a46ebe1754a779a4bfb165c201102ad51a36838a1a7b8, 105);
    }

    fun assert_sbuck_fountain(arg0: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>) {
        assert!(0x2::object::id_address<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0) == @0xbdf91f558c2b61662e5839db600198eda66d502e4c10c4fc5c683f9caca13359, 104);
    }

    fun assert_version(arg0: &Strategy) {
        assert!(arg0.version == 1, 1);
    }

    public fun collected_profit_buck(arg0: &Strategy) : &0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        &arg0.collected_profit_buck
    }

    public fun collected_profit_sui(arg0: &Strategy) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.collected_profit_sui
    }

    public fun deposit_sold_profits(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg3: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg3, 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg1.collected_profit_buck));
        0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::strategy_hand_over_profit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg2, 0x1::option::borrow<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(&arg1.vault_access), arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun join_vault(arg0: &0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::AdminCap<0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg1: &AdminCap, arg2: &mut 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg3: &mut Strategy, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg3);
        assert_admin(arg1, arg3);
        0x1::option::fill<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(&mut arg3.vault_access, 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::add_strategy<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg0, arg2, arg4));
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Strategy) {
        assert_admin(arg0, arg1);
        assert!(arg1.version < 1, 103);
        arg1.version = 1;
    }

    public fun rebalance(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg3: &0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::RebalanceAmounts, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_version(arg1);
        assert_sbuck_fountain(arg4);
        assert_sbuck_flask(arg5);
        let v0 = 0x1::option::borrow<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(&arg1.vault_access);
        let (v1, v2) = 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::rebalance_amounts_get(arg3, v0);
        let (_, v4) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4);
        if (v2 > 0) {
            assert!(0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg1.stake_proof), 106);
            let (v5, v6) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg6, arg4, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof));
            let v7 = v5;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_profit_sui, v6);
            let v8 = 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg5, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(0x2::balance::split<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v7, 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::utils::mul_div(0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v7), v2, arg1.underlying_nominal_value_buck)), arg7));
            if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8) > v2) {
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg1.collected_profit_buck, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v8, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8) - v2));
            };
            0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::strategy_repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg2, v0, v8);
            arg1.underlying_nominal_value_buck = arg1.underlying_nominal_value_buck - 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8);
            0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg6, arg4, v7, v4, arg7));
        } else if (v1 > 0) {
            let v9 = 0x2::math::min(v1, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::free_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg2)));
            let v10 = 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg5, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::strategy_borrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(arg2, v0, v9), arg7));
            if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg1.stake_proof)) {
                let (v11, v12) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg6, arg4, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof));
                let v13 = v11;
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_profit_sui, v12);
                0x2::balance::join<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v13, v10);
                0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg6, arg4, v13, v4, arg7));
            } else {
                0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg6, arg4, v10, v4, arg7));
            };
            arg1.underlying_nominal_value_buck = arg1.underlying_nominal_value_buck + v9;
        };
    }

    public fun remove_from_vault(arg0: &0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::AdminCap<0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>, arg1: &AdminCap, arg2: &mut Strategy, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock) : 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::StrategyRemovalTicket<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK> {
        assert_version(arg2);
        assert_admin(arg1, arg2);
        assert_sbuck_fountain(arg3);
        let (v0, v1) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg3, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg2.stake_proof));
        let v2 = v1;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2) == 0, 102);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.collected_profit_sui) == 0, 102);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        arg2.underlying_nominal_value_buck = 0;
        0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::new_strategy_removal_ticket<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0xbe225286e3b4aa2aea6ed2087da3a6db42eace16412dad723d2a3867846cf9f4::st_sbuck::ST_SBUCK>(0x1::option::extract<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(&mut arg2.vault_access), v0)
    }

    public fun skim_base_profits(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_admin(arg0, arg1);
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg1.stake_proof)) {
            return
        };
        let (v0, v1) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_profit_sui, v1);
        let v2 = 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(v0, arg5));
        if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v2) > arg1.underlying_nominal_value_buck) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg1.collected_profit_buck, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v2, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v2) - arg1.underlying_nominal_value_buck));
        };
        let (_, v4) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2);
        0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v2, arg5)), v4, arg5));
    }

    public fun stake_proof(arg0: &Strategy) : &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI> {
        0x1::option::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)
    }

    public fun staked_amount(arg0: &Strategy) : u64 {
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            return 0
        };
        0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(stake_proof(arg0))
    }

    public fun take_profits_for_selling(arg0: &AdminCap, arg1: &mut Strategy, arg2: 0x1::option::Option<u64>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_version(arg1);
        assert_admin(arg0, arg1);
        assert_sbuck_fountain(arg3);
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg1.stake_proof)) {
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_profit_sui, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg3, 0x1::option::borrow_mut<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg1.stake_proof)));
        if (0x1::option::is_some<u64>(&arg2)) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg1.collected_profit_sui, *0x1::option::borrow<u64>(&arg2))
        } else {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.collected_profit_sui)
        }
    }

    public fun underlying_nominal_value_buck(arg0: &Strategy) : u64 {
        arg0.underlying_nominal_value_buck
    }

    public fun underlying_profits(arg0: &Strategy, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg2: &0x2::clock::Clock) : u64 {
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            return 0
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_profit_sui) + 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_reward_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg1, 0x1::option::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof), 0x2::clock::timestamp_ms(arg2))
    }

    public fun vault_access_id(arg0: &Strategy) : 0x2::object::ID {
        0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::vault_access_id(0x1::option::borrow<0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::vault::VaultAccess>(&arg0.vault_access))
    }

    // decompiled from Move bytecode v6
}

