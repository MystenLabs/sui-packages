module 0xc40b14af0df5ad5dc80003a02e874f0978e39bb09328b93c912a460912ae7b77::wild_coin {
    struct WILD_COIN has drop {
        dummy_field: bool,
    }

    struct Wild_Supply has key {
        id: 0x2::object::UID,
        current_unfrozen_supply: u64,
        circulating_supply: u64,
    }

    struct WildVault has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        wild_coin_balance: 0x2::balance::Balance<WILD_COIN>,
        reward_sui_blance: 0x2::balance::Balance<0x2::sui::SUI>,
        donation_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct WILD_COIN_AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun burn_wild_coin(arg0: &mut 0x2::coin::TreasuryCap<WILD_COIN>, arg1: &mut Wild_Supply, arg2: 0x2::coin::Coin<WILD_COIN>) {
        let v0 = 0x2::coin::value<WILD_COIN>(&arg2);
        assert!(arg1.circulating_supply >= v0, 5);
        0x2::coin::burn<WILD_COIN>(arg0, arg2);
        arg1.circulating_supply = arg1.circulating_supply - v0;
    }

    public(friend) fun claim_reward_from_lending_platform(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x2::sui::SUI>, arg3: &mut WildVault, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x2::sui::SUI>(arg0, arg4, arg2, arg1, arg3.sui_index, 0, &arg3.account_cap), arg5);
        deposit_reward_sui_to_vault(arg3, v0);
    }

    public fun decrease_unfrozen_supply(arg0: &WILD_COIN_AdminCap, arg1: &mut Wild_Supply, arg2: u64) {
        assert!(arg1.current_unfrozen_supply >= arg2, 2);
        arg1.current_unfrozen_supply = arg1.current_unfrozen_supply - arg2;
    }

    public(friend) fun deposit_reward_sui_to_vault(arg0: &mut WildVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_sui_blance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun deposit_sui_to_lending_platform(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg3: &WildVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0x2::sui::SUI>(arg0, arg1, arg2, arg3.sui_index, arg4, arg5, arg6, &arg3.account_cap);
    }

    public(friend) fun deposit_sui_to_vault(arg0: &mut WildVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun deposit_wild_coin(arg0: &mut WildVault, arg1: 0x2::coin::Coin<WILD_COIN>) {
        0x2::balance::join<WILD_COIN>(&mut arg0.wild_coin_balance, 0x2::coin::into_balance<WILD_COIN>(arg1));
    }

    public(friend) fun distribute_airdrop(arg0: &0x2::linked_table::LinkedTable<0x2::object::ID, u64>, arg1: &mut WildVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::front<0x2::object::ID, u64>(arg0);
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v1 = 0x1::option::borrow<0x2::object::ID>(v0);
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_sui_blance) * *0x2::linked_table::borrow<0x2::object::ID, u64>(arg0, *v1) / 1000000000;
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw_sui_from_vault(arg1, v2, arg2), 0x2::object::id_to_address(v1));
            };
            v0 = 0x2::linked_table::next<0x2::object::ID, u64>(arg0, *v1);
        };
    }

    public fun increase_unfrozen_supply(arg0: &WILD_COIN_AdminCap, arg1: &mut Wild_Supply, arg2: u64) {
        assert!(arg1.current_unfrozen_supply + arg2 <= 1000000000, 1);
        arg1.current_unfrozen_supply = arg1.current_unfrozen_supply + arg2;
    }

    fun init(arg0: WILD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILD_COIN>(arg0, 9, b"WILD", b"wild coin", b"wild coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = WildVault{
            id                : 0x2::object::new(arg1),
            sui_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            wild_coin_balance : 0x2::balance::zero<WILD_COIN>(),
            reward_sui_blance : 0x2::balance::zero<0x2::sui::SUI>(),
            donation_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            account_cap       : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            sui_index         : 0,
            usdc_index        : 1,
        };
        let v3 = Wild_Supply{
            id                      : 0x2::object::new(arg1),
            current_unfrozen_supply : 0,
            circulating_supply      : 0,
        };
        let v4 = WILD_COIN_AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Wild_Supply>(v3);
        0x2::transfer::share_object<WildVault>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WILD_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WILD_COIN>>(v0);
        0x2::transfer::transfer<WILD_COIN_AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint_wild(arg0: &mut 0x2::coin::TreasuryCap<WILD_COIN>, arg1: &mut WildVault, arg2: &mut Wild_Supply, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.current_unfrozen_supply <= 1000000000, 3);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(arg2.circulating_supply + 0x2::balance::value<0x2::sui::SUI>(&v0) <= arg2.current_unfrozen_supply, 4);
        arg2.circulating_supply = arg2.circulating_supply + 0x2::balance::value<0x2::sui::SUI>(&v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<WILD_COIN>>(0x2::coin::mint<WILD_COIN>(arg0, 0x2::balance::value<0x2::sui::SUI>(&v0), arg5), arg4);
    }

    public fun swap_wild_coin_for_sui(arg0: &mut 0x2::coin::TreasuryCap<WILD_COIN>, arg1: &mut Wild_Supply, arg2: &mut WildVault, arg3: 0x2::coin::Coin<WILD_COIN>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<WILD_COIN>(&arg3);
        assert!(arg1.circulating_supply >= v0, 7);
        burn_wild_coin(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw_sui_from_vault(arg2, v0, arg5), arg4);
    }

    public(friend) fun withdraw_sui_from_lending_platform(arg0: &mut WildVault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0x2::sui::SUI>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8);
        deposit_sui_to_vault(arg0, v0);
    }

    public(friend) fun withdraw_sui_from_vault(arg0: &mut WildVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 6);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, arg1, arg2)
    }

    public(friend) fun withdraw_wild_coin_from_vault(arg0: &mut WildVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WILD_COIN> {
        assert!(0x2::balance::value<WILD_COIN>(&arg0.wild_coin_balance) >= arg1, 6);
        0x2::coin::take<WILD_COIN>(&mut arg0.wild_coin_balance, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

