module 0xd21fd6eff96a49a6bb26cb5022e27266afa1c18fb23b1754cb1a708428352d70::wild_coin {
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
        scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>,
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

    public(friend) fun calc_coin_to_scoin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        let v4 = if (v3 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v3, v0 + v1 - v2)
        } else {
            arg4
        };
        assert!(v4 > 0, 1);
        v4
    }

    fun calc_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public(friend) fun claim_reward_from_lending_platform(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut WildVault, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&arg4.scoin_balance);
        let v1 = calc_coin_to_scoin(arg0, arg1, 0x1::type_name::get<0x2::sui::SUI>(), arg3, arg2);
        assert!(v0 >= v1, 10);
        if (v0 > v1) {
            let v2 = withdraw_scoin_from_vault(arg4, v0 - v1, arg5);
            deposit_reward_sui_to_vault(arg4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x2::sui::SUI>(arg0, arg1, v2, arg3, arg5));
        };
    }

    public fun decrease_unfrozen_supply(arg0: &WILD_COIN_AdminCap, arg1: &mut Wild_Supply, arg2: u64) {
        assert!(arg1.current_unfrozen_supply >= arg2, 2);
        arg1.current_unfrozen_supply = arg1.current_unfrozen_supply - arg2;
    }

    public(friend) fun deposit_reward_sui_to_vault(arg0: &mut WildVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_sui_blance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun deposit_scoin_to_vault(arg0: &mut WildVault, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>) {
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg0.scoin_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(arg1));
    }

    public fun deposit_sui_coin_to_reward(arg0: &WILD_COIN_AdminCap, arg1: &mut WildVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.reward_sui_blance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public(friend) fun deposit_sui_to_lending_platform(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut WildVault, arg5: &mut 0x2::tx_context::TxContext) {
        deposit_scoin_to_vault(arg4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg5));
    }

    public(friend) fun deposit_sui_to_vault(arg0: &mut WildVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun deposit_wild_coin(arg0: &mut WildVault, arg1: 0x2::coin::Coin<WILD_COIN>) {
        0x2::balance::join<WILD_COIN>(&mut arg0.wild_coin_balance, 0x2::coin::into_balance<WILD_COIN>(arg1));
    }

    public(friend) fun distribute_airdrop(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock, arg3: &0x2::linked_table::LinkedTable<0x2::object::ID, u64>, arg4: u64, arg5: u64, arg6: &mut WildVault, arg7: &mut 0x2::tx_context::TxContext) {
        claim_reward_from_lending_platform(arg0, arg1, arg4 * arg5, arg2, arg6, arg7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg6.reward_sui_blance);
        let v1 = v0 * 20 / 100;
        let v2 = v0 - v1;
        let v3 = withdraw_sui_from_vault_reward(arg6, v1, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg6.donation_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v4 = withdraw_sui_from_vault_reward(arg6, v2, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg6.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
        let v5 = 0x2::linked_table::front<0x2::object::ID, u64>(arg3);
        while (0x1::option::is_some<0x2::object::ID>(v5)) {
            let v6 = 0x1::option::borrow<0x2::object::ID>(v5);
            let v7 = v2 * *0x2::linked_table::borrow<0x2::object::ID, u64>(arg3, *v6) / 1000000000;
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw_sui_from_vault(arg6, v7, arg7), 0x2::object::id_to_address(v6));
            };
            v5 = 0x2::linked_table::next<0x2::object::ID, u64>(arg3, *v6);
        };
    }

    fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    public fun increase_unfrozen_supply(arg0: &WILD_COIN_AdminCap, arg1: &mut Wild_Supply, arg2: u64) {
        assert!(arg1.current_unfrozen_supply + arg2 <= 10000000000000000000, 1);
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
            scoin_balance     : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(),
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
        assert!(arg2.current_unfrozen_supply <= 10000000000000000000, 3);
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

    public fun withdraw_donation_balance(arg0: &WILD_COIN_AdminCap, arg1: &mut WildVault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.donation_balance) >= arg2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.donation_balance, arg2, arg4), arg3);
    }

    public(friend) fun withdraw_scoin_from_vault(arg0: &mut WildVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>> {
        assert!(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&arg0.scoin_balance) >= arg1, 6);
        0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg0.scoin_balance, arg1), arg2)
    }

    public(friend) fun withdraw_sui_from_lending_platform(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>, arg3: &0x2::clock::Clock, arg4: &mut WildVault, arg5: &mut 0x2::tx_context::TxContext) {
        deposit_sui_to_vault(arg4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg5));
    }

    public fun withdraw_sui_from_reward(arg0: &WILD_COIN_AdminCap, arg1: &mut WildVault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.reward_sui_blance) >= arg2, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_sui_blance, arg2, arg4), arg3);
    }

    public(friend) fun withdraw_sui_from_vault(arg0: &mut WildVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 6);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, arg1, arg2)
    }

    public(friend) fun withdraw_sui_from_vault_reward(arg0: &mut WildVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reward_sui_blance) >= arg1, 6);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.reward_sui_blance, arg1, arg2)
    }

    public(friend) fun withdraw_wild_coin_from_vault(arg0: &mut WildVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WILD_COIN> {
        assert!(0x2::balance::value<WILD_COIN>(&arg0.wild_coin_balance) >= arg1, 6);
        0x2::coin::take<WILD_COIN>(&mut arg0.wild_coin_balance, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

