module 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::honey_trade {
    struct HoneyManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        honey_kraft_cap: 0x2::coin::TreasuryCap<T0>,
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
        total_burnt: u64,
        module_version: u64,
    }

    struct HoneyBurnt has copy, drop {
        honey_burnt_tax: u64,
        honey_burnt_sui_fee: u64,
        total_honey_burnt: u64,
    }

    public fun transfer_honey(arg0: &mut 0x2::token::Token<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg1: &HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(arg0, &arg1.policy_cap, arg2, arg3, arg4, arg5);
    }

    public fun transfer_honey_balance(arg0: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg1: &HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(arg0, &arg1.policy_cap, arg2, arg3, arg4);
    }

    public fun unwrap_honey_tokens_to_coins(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonFoodCapability, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: &mut 0x2::token::Token<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY> {
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::unwrap_honey_tokens_to_coins<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(arg3, &arg1.policy_cap, arg2, arg4, arg5)
    }

    public fun delete_dragon_trainer(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DegenHiveMapStore, arg1: &0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::HiveGraph, arg3: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg5: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg6: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::delete_dragon_trainer(arg0, arg2, arg5, &arg3.policy_cap, arg1, arg4, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun entry_deposit_honey_in_dragon_school(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonSchool, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: 0x2::token::Token<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::entry_deposit_honey_in_dragon_school(arg0, arg2, &arg1.policy_cap, arg3, arg4, arg5);
    }

    public fun entry_deposit_honey_in_trainer(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: 0x2::token::Token<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::entry_deposit_honey_in_trainer(arg0, arg2, &arg1.policy_cap, arg3, arg4, arg5);
    }

    public fun harvest_yield_from_bees(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg3: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE> {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::harvest_yield_from_bees(arg0, arg1, arg2, arg4, &arg3.policy_cap, arg5)
    }

    public fun harvest_yield_from_bees_and_return(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg3: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg5: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::harvest_yield_from_bees_and_return(arg0, arg1, arg2, arg4, &arg3.policy_cap, arg5);
    }

    public fun infuse_bee_with_energy(arg0: &0x2::clock::Clock, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg2: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg5: u64, arg6: 0x2::coin::Coin<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::infuse_bee_with_energy(arg0, arg1, arg3, &arg2.policy_cap, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun infuse_bee_with_health(arg0: &0x2::clock::Clock, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg2: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg5: u64, arg6: 0x2::token::Token<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::infuse_bee_with_health(arg0, arg1, arg3, &arg2.policy_cap, arg4, arg5, arg6, arg7, arg8);
    }

    public fun replenish_master_key_with_honey(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::GameMasterKey, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: 0x2::token::Token<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::replenish_master_key_with_honey(arg0, arg2, &arg1.policy_cap, arg3, arg4, arg5);
    }

    public fun send_to_hidden_world(arg0: &0x2::clock::Clock, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::HiddenWorld, arg3: &HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg5: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg6: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::send_to_hidden_world(arg0, arg1, arg4, arg2, arg5, &arg3.policy_cap, arg6, arg7, arg8);
    }

    public fun withdraw_funds_from_trainer(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg3: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::withdraw_funds_from_trainer(arg0, arg3, &arg1.policy_cap, arg2, arg4, arg5, arg6)
    }

    public fun withdraw_funds_from_trainer_and_return(arg0: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::YieldFarm, arg3: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::withdraw_funds_from_trainer_and_return(arg0, arg3, &arg1.policy_cap, arg2, arg4, arg5, arg6);
    }

    public fun add_liquidity_to_x_honey_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::token::Token<T1>, arg4: u64, arg5: u64, arg6: &HoneyManager<T1>, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6.module_version == 0, 5036);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey<T1>(&mut arg3, &arg6.policy_cap, arg7, 0x2::token::value<T1>(&arg3), 0x2::tx_context::sender(arg8), arg8);
        0x2::token::destroy_zero<T1>(arg3);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>(0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::unwrap_honey_tokens_to_coins<T1>(&mut arg3, &arg6.policy_cap, arg7, arg4, arg8)), arg5), 0x2::tx_context::sender(arg8), arg8);
    }

    public fun add_liquidity_to_x_honey_pool_and_return_lp<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::token::Token<T1>, arg4: u64, arg5: u64, arg6: &HoneyManager<T1>, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>> {
        assert!(arg6.module_version == 0, 5036);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey<T1>(&mut arg3, &arg6.policy_cap, arg7, 0x2::token::value<T1>(&arg3), 0x2::tx_context::sender(arg8), arg8);
        0x2::token::destroy_zero<T1>(arg3);
        0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::unwrap_honey_tokens_to_coins<T1>(&mut arg3, &arg6.policy_cap, arg7, arg4, arg8)), arg5)
    }

    public fun burn_honey_from_supply(arg0: &mut 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::YieldFlow, arg1: &mut 0x2::token::TokenPolicy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = 0x2::token::spent_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(arg1);
        0x2::token::flush<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(arg1, &mut arg2.honey_kraft_cap, arg3);
        let v1 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::withdraw_honey_to_burn(arg0, &arg2.honey_kraft_cap);
        let v2 = 0x2::balance::value<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&v1);
        0x2::coin::burn<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut arg2.honey_kraft_cap, 0x2::coin::from_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(v1, arg3));
        arg2.total_burnt = arg2.total_burnt + v0 + v2;
        let v3 = HoneyBurnt{
            honey_burnt_tax     : v0,
            honey_burnt_sui_fee : v2,
            total_honey_burnt   : arg2.total_burnt,
        };
        0x2::event::emit<HoneyBurnt>(v3);
        (v0, v2)
    }

    public entry fun increment_honey_manager<T0>(arg0: &mut HoneyManager<T0>) {
        assert!(arg0.module_version < 0, 5035);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun kraft_genesis_honey(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonFoodCapability, arg1: 0x2::coin::TreasuryCap<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>) {
        let v0 = 0x2::coin::into_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(0x2::coin::mint<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut arg1, 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::total_honey_supply(), arg7));
        let (v1, v2) = 0x2::token::new_policy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&arg1, arg7);
        let v3 = v2;
        let v4 = v1;
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::set_rules<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v4, &v3, arg7);
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::deposit_honey_with_treasury(arg2, 0x2::balance::split<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v0, (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::total_honey_supply() as u128), (arg4 as u128), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u128)) as u64)));
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::deposit_honey_with_dragon_eggs_basket(arg2, 0x2::balance::split<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v0, (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::total_honey_supply() as u128), (arg5 as u128), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u128)) as u64)));
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v4, &v3, v0, 0x2::tx_context::sender(arg7), arg7);
        let v5 = HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>{
            id              : 0x2::object::new(arg7),
            honey_kraft_cap : arg1,
            policy_cap      : v3,
            total_burnt     : 0,
            module_version  : 0,
        };
        0x2::transfer::share_object<HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>>(v5);
        0x2::token::share_policy<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(v4);
        (0x2::balance::split<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v0, (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::total_honey_supply() as u128), (arg3 as u128), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u128)) as u64)), 0x2::balance::split<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v0, (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::total_honey_supply() as u128), (arg6 as u128), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u128)) as u64)))
    }

    public fun kraft_more_honey_for_dragon_bees(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonDaoCapability, arg1: &mut HoneyManager<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY> {
        let v0 = 0x2::coin::into_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(0x2::coin::mint<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut arg1.honey_kraft_cap, arg3, arg5));
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::deposit_honey_with_treasury(arg2, v0);
        0x2::balance::split<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::HONEY>(&mut v0, (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((arg3 as u128), (arg4 as u128), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u128)) as u64))
    }

    public fun remove_liquidity_from_x_honey_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::token::TokenPolicy<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::token::Token<T1>, 0x2::balance::Balance<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>) {
        let (v0, v1, v2) = 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::remove_liquidity_from_x_honey_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v3, v4) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg7), arg7);
        let v5 = v4;
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::verify<T1>(arg6, &mut v5, arg7);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, v5, arg7);
        (v0, v3, v2)
    }

    public fun remove_liquidity_from_x_honey_pool_and_return<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &HoneyManager<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8.module_version == 0, 5036);
        let v0 = 0x2::coin::into_balance<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>(arg2);
        let (v1, v2, v3) = 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::remove_liquidity_from_x_honey_pool<T0, T1, T2>(arg0, arg1, 0x2::balance::split<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>(&mut v0, arg3), arg4, arg5, arg6);
        0x2::balance::join<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>(&mut v0, v3);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg9), arg9);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg9), arg9);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey_balance<T1>(arg7, &arg8.policy_cap, v2, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun swap_honey_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: 0x2::token::Token<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &HoneyManager<T1>, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9.module_version == 0, 5036);
        let (v0, v1) = 0xd78b14c416ea2400662152cbaffa0c7b8ba017e64102fe11aebdb07e4e82c670::two_pool::swap_honey_coins<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, arg3), arg4, 0x2::coin::into_balance<T1>(0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::unwrap_honey_tokens_to_coins<T1>(&mut arg5, &arg9.policy_cap, arg10, arg6, arg11)), arg7, arg8);
        0x2::balance::join<T0>(&mut arg2, v0);
        let (v2, v3) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg11);
        let v4 = v3;
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::verify<T1>(arg10, &mut v4, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v4, arg11);
        0x2::token::join<T1>(&mut arg5, v2);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::honey::transfer_honey<T1>(&mut arg5, &arg9.policy_cap, arg10, 0x2::token::value<T1>(&arg5), 0x2::tx_context::sender(arg11), arg11);
        0x2::token::destroy_zero<T1>(arg5);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<T0>(arg2, 0x2::tx_context::sender(arg11), arg11);
    }

    // decompiled from Move bytecode v6
}

