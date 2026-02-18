module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::social_trading {
    struct TradingVault has key {
        id: 0x2::object::UID,
        trader: address,
        performance_fee_bps: u64,
        total_assets: 0x2::balance::Balance<0x2::sui::SUI>,
        total_shares: u64,
    }

    struct VAULT_SHARE has drop {
        dummy_field: bool,
    }

    struct VaultTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<VAULT_SHARE>,
    }

    struct VaultCreated has copy, drop {
        id: 0x2::object::ID,
        trader: address,
        fee_bps: u64,
    }

    public fun create_vault_with_cap(arg0: 0x2::coin::TreasuryCap<VAULT_SHARE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TradingVault{
            id                  : 0x2::object::new(arg2),
            trader              : 0x2::tx_context::sender(arg2),
            performance_fee_bps : arg1,
            total_assets        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_shares        : 0,
        };
        let v1 = VaultCreated{
            id      : 0x2::object::uid_to_inner(&v0.id),
            trader  : v0.trader,
            fee_bps : v0.performance_fee_bps,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<TradingVault>(v0);
        let v2 = VaultTreasury{
            id  : 0x2::object::new(arg2),
            cap : arg0,
        };
        0x2::transfer::share_object<VaultTreasury>(v2);
    }

    public fun deposit(arg0: &mut TradingVault, arg1: &mut VaultTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_SHARE> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_assets, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.total_shares = arg0.total_shares + v0;
        0x2::coin::mint<VAULT_SHARE>(&mut arg1.cap, v0, arg3)
    }

    public fun report_profit(arg0: &mut TradingVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.trader, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * arg0.performance_fee_bps / 10000, arg2), arg0.trader);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_assets, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun withdraw(arg0: &mut TradingVault, arg1: &mut VaultTreasury, arg2: 0x2::coin::Coin<VAULT_SHARE>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<VAULT_SHARE>(&arg2);
        0x2::coin::burn<VAULT_SHARE>(&mut arg1.cap, arg2);
        arg0.total_shares = arg0.total_shares - v0;
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_assets, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

