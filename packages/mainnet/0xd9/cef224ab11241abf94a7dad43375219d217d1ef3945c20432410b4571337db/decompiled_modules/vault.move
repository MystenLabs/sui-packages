module 0xd9cef224ab11241abf94a7dad43375219d217d1ef3945c20432410b4571337db::vault {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct Account has key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<USDC>,
        obligation_cap: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>,
    }

    public fun claim_rewards_and_compound<T0>(arg0: &Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap), 7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards_and_deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap)), arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Account{
            id     : 0x2::object::new(arg0),
            amount : 0,
        };
        0x2::transfer::transfer<Account>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_vault(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id             : 0x2::object::new(arg1),
            balance        : 0x2::balance::zero<USDC>(),
            obligation_cap : 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1)),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun deposit(arg0: &mut Account, arg1: 0x2::coin::Coin<USDC>, arg2: &mut Vault) {
        0x2::balance::join<USDC>(&mut arg2.balance, 0x2::coin::into_balance<USDC>(arg1));
        arg0.amount = arg0.amount + 0x2::coin::value<USDC>(&arg1);
    }

    public fun deposit_all_to_suilend(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap), 4);
        let v0 = 0x2::balance::value<USDC>(&arg0.balance);
        assert!(v0 > 0, 1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, USDC>(arg1, arg2, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap), arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, USDC>(arg1, arg2, arg3, 0x2::coin::from_balance<USDC>(0x2::balance::split<USDC>(&mut arg0.balance, v0), arg4), arg4), arg4);
    }

    public fun withdraw(arg0: &mut Account, arg1: u64, arg2: &mut Vault, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(arg0.amount >= arg1, 0);
        arg0.amount = arg0.amount - arg1;
        0x2::coin::from_balance<USDC>(0x2::balance::split<USDC>(&mut arg2.balance, arg1), arg3)
    }

    public fun withdraw_all_from_suilend(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap), 5);
        0x2::balance::join<USDC>(&mut arg0.balance, 0x2::coin::into_balance<USDC>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, USDC>(arg1, arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, USDC>(arg1, arg2, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap), arg3, arg4, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, USDC>>(), arg5)));
    }

    // decompiled from Move bytecode v6
}

