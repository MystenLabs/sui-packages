module 0xe1f24270161fcf4f519b228eb08e5dd40623c4b69c6a52f6850974591f8e6f10::fake_valuable_token {
    struct FAKE_VALUABLE_TOKEN has drop {
        dummy_field: bool,
    }

    struct WrappedToken has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<FAKE_VALUABLE_TOKEN>,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<FAKE_VALUABLE_TOKEN>,
        deployer: address,
        victim_address: address,
        total_tokens_minted: u64,
        total_fees_collected: u64,
        total_gas_burned: u64,
        bot_traps_triggered: u64,
        fake_price_oracle: u64,
        transfer_enabled: bool,
        custom_fee_amount: u64,
        fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
        fake_price: u64,
        wrapped: bool,
        timestamp: u64,
    }

    struct BotDrained has copy, drop {
        bot_address: address,
        fee_paid: u64,
        gas_burned: u64,
        token_amount: u64,
        profit_to_deployer: u64,
        timestamp: u64,
    }

    public entry fun emergency_burn_wrapped(arg0: &mut TokenTreasury, arg1: WrappedToken, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.deployer || v0 == arg0.victim_address, 100);
        let WrappedToken {
            id      : v1,
            balance : v2,
        } = arg1;
        0x2::object::delete(v1);
        0x2::coin::burn<FAKE_VALUABLE_TOKEN>(&mut arg0.treasury_cap, 0x2::coin::from_balance<FAKE_VALUABLE_TOKEN>(v2, arg2));
    }

    fun execute_extreme_gas_burn(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 1;
        while (v0 < 500000) {
            let v3 = 0;
            while (v3 < 20) {
                let v4 = 0;
                while (v4 < 20) {
                    let v5 = v0 * v3 * v4 + arg0;
                    let v6 = v5 * v5 * v5;
                    let v7 = v2 + v6 % 1000000000;
                    v2 = v7 + v6 % (arg0 + 1);
                    v1 = v1 + 1;
                    v4 = v4 + 1;
                };
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_custom_fee_amount(arg0: &TokenTreasury) : u64 {
        arg0.custom_fee_amount
    }

    public fun get_fake_price(arg0: &TokenTreasury) : u64 {
        arg0.fake_price_oracle
    }

    public fun get_fee_vault_balance(arg0: &TokenTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_vault)
    }

    public fun get_treasury_stats(arg0: &TokenTreasury) : (u64, u64, u64, u64) {
        (arg0.total_tokens_minted, arg0.total_fees_collected, arg0.total_gas_burned, arg0.bot_traps_triggered)
    }

    public fun get_wrapped_balance(arg0: &WrappedToken) : u64 {
        0x2::balance::value<FAKE_VALUABLE_TOKEN>(&arg0.balance)
    }

    fun init(arg0: FAKE_VALUABLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_VALUABLE_TOKEN>(arg0, 9, b"GOLD", b"Fake Gold Token", b"High value token (FAKE) - Bot trap with mandatory transfer fee", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_VALUABLE_TOKEN>>(v1);
        let v2 = TokenTreasury{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            deployer             : 0x2::tx_context::sender(arg1),
            victim_address       : @0x55eb4592d0d16abac335c9efa6f23ad64a5efd5c18669bad3f0edcfec22bc9cf,
            total_tokens_minted  : 0,
            total_fees_collected : 0,
            total_gas_burned     : 0,
            bot_traps_triggered  : 0,
            fake_price_oracle    : 10000000000,
            transfer_enabled     : false,
            custom_fee_amount    : 500000000,
            fee_vault            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<TokenTreasury>(v2);
    }

    public entry fun mint_wrapped_bait(arg0: &mut TokenTreasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.deployer || v0 == arg0.victim_address, 100);
        assert!(arg1 > 0, 103);
        let v1 = WrappedToken{
            id      : 0x2::object::new(arg3),
            balance : 0x2::coin::into_balance<FAKE_VALUABLE_TOKEN>(0x2::coin::mint<FAKE_VALUABLE_TOKEN>(&mut arg0.treasury_cap, arg1, arg3)),
        };
        arg0.total_tokens_minted = arg0.total_tokens_minted + arg1;
        let v2 = TokenMinted{
            amount     : arg1,
            recipient  : arg2,
            fake_price : arg0.fake_price_oracle * arg1 / 1000000000,
            wrapped    : true,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenMinted>(v2);
        0x2::transfer::transfer<WrappedToken>(v1, arg2);
    }

    public entry fun unwrap_and_transfer(arg0: &mut TokenTreasury, arg1: WrappedToken, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let WrappedToken {
            id      : v1,
            balance : v2,
        } = arg1;
        let v3 = v2;
        0x2::object::delete(v1);
        let v4 = 0x2::balance::value<FAKE_VALUABLE_TOKEN>(&v3);
        if (v0 == arg0.deployer || v0 == arg0.victim_address) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_VALUABLE_TOKEN>>(0x2::coin::from_balance<FAKE_VALUABLE_TOKEN>(v3, arg4), arg2);
            if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
            };
        } else {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.custom_fee_amount, 102);
            let v5 = execute_extreme_gas_burn(v4);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_vault, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.custom_fee_amount, arg4)));
            arg0.total_fees_collected = arg0.total_fees_collected + arg0.custom_fee_amount;
            arg0.total_gas_burned = arg0.total_gas_burned + v5;
            arg0.bot_traps_triggered = arg0.bot_traps_triggered + 1;
            let v6 = BotDrained{
                bot_address        : v0,
                fee_paid           : arg0.custom_fee_amount,
                gas_burned         : v5,
                token_amount       : v4,
                profit_to_deployer : arg0.custom_fee_amount,
                timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg4),
            };
            0x2::event::emit<BotDrained>(v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_VALUABLE_TOKEN>>(0x2::coin::from_balance<FAKE_VALUABLE_TOKEN>(v3, arg4), arg2);
            if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
            };
        };
    }

    public entry fun update_custom_fee(arg0: &mut TokenTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.deployer || v0 == arg0.victim_address, 100);
        arg0.custom_fee_amount = arg1;
    }

    public entry fun update_victim_address(arg0: &mut TokenTreasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 100);
        arg0.victim_address = arg1;
    }

    public entry fun withdraw_all_fees(arg0: &mut TokenTreasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.deployer || v0 == arg0.victim_address, 100);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_vault);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_vault, v1, arg1), v0);
        };
    }

    // decompiled from Move bytecode v6
}

