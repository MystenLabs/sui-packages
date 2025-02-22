module 0x4bb212d688aad48067c90e320f7146951aa458bf9c176151eca21e123582b234::custom_token {
    struct TokenConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<CUSTOM_TOKEN>,
        blacklist: 0x2::table::Table<address, bool>,
        total_supply: u64,
        tax_rate: u64,
        reward_amount: u64,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CUSTOM_TOKEN has drop {
        dummy_field: bool,
    }

    struct Blacklisted has copy, drop {
        user: address,
    }

    struct Unblacklisted has copy, drop {
        user: address,
    }

    struct TaxCollected has copy, drop {
        amount: u64,
    }

    struct RewardDistributed has copy, drop {
        user: address,
        amount: u64,
    }

    public entry fun buy_tokens(arg0: &mut TokenConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::object::uid_to_address(&arg0.id));
        if (!0x2::table::contains<address, bool>(&arg0.blacklist, v0)) {
            0x2::table::add<address, bool>(&mut arg0.blacklist, v0, true);
            let v1 = Blacklisted{user: v0};
            0x2::event::emit<Blacklisted>(v1);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) >= arg0.reward_amount) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.reward_balance, arg0.reward_amount, arg3), v0);
            let v2 = RewardDistributed{
                user   : v0,
                amount : arg0.reward_amount,
            };
            0x2::event::emit<RewardDistributed>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_TOKEN>>(0x2::coin::mint<CUSTOM_TOKEN>(&mut arg0.treasury_cap, arg2, arg3), v0);
    }

    public entry fun deposit_reward_sui(arg0: &mut TokenConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x2::object::uid_to_address(&arg0.id), 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.reward_balance, arg1);
    }

    fun init(arg0: CUSTOM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 1000000000;
        let (v2, v3) = 0x2::coin::create_currency<CUSTOM_TOKEN>(arg0, 9, b"CTOK", b"Custom Token", b"A custom token with blacklist and rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_TOKEN>>(0x2::coin::mint<CUSTOM_TOKEN>(&mut v4, v1, arg1), v0);
        let v5 = TokenConfig{
            id             : 0x2::object::new(arg1),
            treasury_cap   : v4,
            blacklist      : 0x2::table::new<address, bool>(arg1),
            total_supply   : v1,
            tax_rate       : 100,
            reward_amount  : 1000000000,
            reward_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<TokenConfig>(v5, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTOM_TOKEN>>(v3);
    }

    public fun is_blacklisted(arg0: &TokenConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.blacklist, arg1)
    }

    public entry fun remove_from_blacklist(arg0: &mut TokenConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x2::object::uid_to_address(&arg0.id), 3);
        assert!(0x2::table::contains<address, bool>(&arg0.blacklist, arg1), 4);
        0x2::table::remove<address, bool>(&mut arg0.blacklist, arg1);
        let v0 = Unblacklisted{user: arg1};
        0x2::event::emit<Unblacklisted>(v0);
    }

    public entry fun transfer_tokens(arg0: &mut TokenConfig, arg1: 0x2::coin::Coin<CUSTOM_TOKEN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<CUSTOM_TOKEN>(&arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.blacklist, v0), 2);
        let v2 = v1 * arg0.tax_rate / 10000;
        let v3 = v1 - v2;
        if (v2 > 0) {
            0x2::coin::burn<CUSTOM_TOKEN>(&mut arg0.treasury_cap, 0x2::coin::split<CUSTOM_TOKEN>(&mut arg1, v2, arg3));
            let v4 = TaxCollected{amount: v2};
            0x2::event::emit<TaxCollected>(v4);
        };
        let v5 = if (v3 > 0) {
            0x2::coin::split<CUSTOM_TOKEN>(&mut arg1, v3, arg3)
        } else {
            0x2::coin::zero<CUSTOM_TOKEN>(arg3)
        };
        let v6 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_TOKEN>>(v6, arg2);
        if (!0x2::table::contains<address, bool>(&arg0.blacklist, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.blacklist, arg2, true);
            let v7 = Blacklisted{user: arg2};
            0x2::event::emit<Blacklisted>(v7);
        };
        if (0x2::coin::value<CUSTOM_TOKEN>(&v6) * 2 > arg0.total_supply) {
            0x2::table::remove<address, bool>(&mut arg0.blacklist, arg2);
            let v8 = Unblacklisted{user: arg2};
            0x2::event::emit<Unblacklisted>(v8);
        };
        if (0x2::coin::value<CUSTOM_TOKEN>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_TOKEN>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<CUSTOM_TOKEN>(arg1);
        };
    }

    public entry fun update_reward_amount(arg0: &mut TokenConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x2::object::uid_to_address(&arg0.id), 3);
        arg0.reward_amount = arg1;
    }

    public entry fun update_tax_rate(arg0: &mut TokenConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x2::object::uid_to_address(&arg0.id), 3);
        assert!(arg1 <= 10000, 5);
        arg0.tax_rate = arg1;
    }

    // decompiled from Move bytecode v6
}

