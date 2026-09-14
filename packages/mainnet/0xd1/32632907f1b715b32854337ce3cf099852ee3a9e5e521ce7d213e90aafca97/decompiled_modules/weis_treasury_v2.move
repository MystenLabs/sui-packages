module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis_treasury_v2 {
    struct WeisTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        metadata: 0x2::coin::CoinMetadata<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        ecosystem_growth_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        dao_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        airdrop_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        reserve_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
    }

    struct WeisTreasuryV2 has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        ecosystem_growth_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        dao_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        airdrop_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
        reserve_tokens: 0x2::balance::Balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>,
    }

    public fun ecosystem_growth_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        abort 0
    }

    public fun ecosystem_growth_tokens_v2(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasuryV2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        0x2::coin::from_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(0x2::balance::split<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&mut arg1.ecosystem_growth_tokens, arg2), arg3)
    }

    public fun get_airdrop_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.airdrop_tokens)
    }

    public fun get_airdrop_balance_v2(arg0: &WeisTreasuryV2) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.airdrop_tokens)
    }

    public fun get_dao_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.dao_tokens)
    }

    public fun get_dao_balance_v2(arg0: &WeisTreasuryV2) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.dao_tokens)
    }

    public fun get_ecosystem_growth_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.ecosystem_growth_tokens)
    }

    public fun get_ecosystem_growth_balance_v2(arg0: &WeisTreasuryV2) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.ecosystem_growth_tokens)
    }

    public fun get_reserve_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.reserve_tokens)
    }

    public fun get_reserve_balance_v2(arg0: &WeisTreasuryV2) : u64 {
        0x2::balance::value<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&arg0.reserve_tokens)
    }

    public entry fun init_treasury(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: 0x2::coin::TreasuryCap<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>, arg2: 0x2::coin::CoinMetadata<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>, arg3: 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>, arg4: 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>, arg5: 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>, arg6: 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = WeisTreasury{
            id                      : 0x2::object::new(arg7),
            treasury_cap            : arg1,
            metadata                : arg2,
            ecosystem_growth_tokens : 0x2::coin::into_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(arg3),
            dao_tokens              : 0x2::coin::into_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(arg4),
            airdrop_tokens          : 0x2::coin::into_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(arg5),
            reserve_tokens          : 0x2::coin::into_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(arg6),
        };
        0x2::transfer::share_object<WeisTreasury>(v0);
    }

    public entry fun migrate_and_freeze_metadata(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: WeisTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        let WeisTreasury {
            id                      : v0,
            treasury_cap            : v1,
            metadata                : v2,
            ecosystem_growth_tokens : v3,
            dao_tokens              : v4,
            airdrop_tokens          : v5,
            reserve_tokens          : v6,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>>(v2);
        let v7 = WeisTreasuryV2{
            id                      : 0x2::object::new(arg2),
            treasury_cap            : v1,
            ecosystem_growth_tokens : v3,
            dao_tokens              : v4,
            airdrop_tokens          : v5,
            reserve_tokens          : v6,
        };
        0x2::transfer::share_object<WeisTreasuryV2>(v7);
    }

    public fun withdraw_airdrop_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        abort 0
    }

    public fun withdraw_airdrop_tokens_v2(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasuryV2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        0x2::coin::from_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(0x2::balance::split<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&mut arg1.airdrop_tokens, arg2), arg3)
    }

    public fun withdraw_dao_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        abort 0
    }

    public fun withdraw_dao_tokens_v2(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasuryV2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        0x2::coin::from_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(0x2::balance::split<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&mut arg1.dao_tokens, arg2), arg3)
    }

    public fun withdraw_reserve_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        abort 0
    }

    public fun withdraw_reserve_tokens_v2(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasuryV2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS> {
        0x2::coin::from_balance<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(0x2::balance::split<0xeb14299cfb01db1b755da4cec699700e56de36d5ec5d7260ca616b69bc8659cf::weis::WEIS>(&mut arg1.reserve_tokens, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

