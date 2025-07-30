module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis_treasury {
    struct WeisTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>,
        metadata: 0x2::coin::CoinMetadata<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>,
        ecosystem_growth_tokens: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>,
        dao_tokens: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>,
        airdrop_tokens: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>,
        reserve_tokens: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>,
    }

    public fun ecosystem_growth_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS> {
        0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&mut arg1.ecosystem_growth_tokens, arg2), arg3)
    }

    public fun get_airdrop_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&arg0.airdrop_tokens)
    }

    public fun get_dao_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&arg0.dao_tokens)
    }

    public fun get_ecosystem_growth_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&arg0.ecosystem_growth_tokens)
    }

    public fun get_reserve_balance(arg0: &WeisTreasury) : u64 {
        0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&arg0.reserve_tokens)
    }

    public fun init_treasury(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: 0x2::coin::TreasuryCap<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>, arg2: 0x2::coin::CoinMetadata<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>, arg3: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>, arg4: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>, arg5: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>, arg6: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = WeisTreasury{
            id                      : 0x2::object::new(arg7),
            treasury_cap            : arg1,
            metadata                : arg2,
            ecosystem_growth_tokens : 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(arg3),
            dao_tokens              : 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(arg4),
            airdrop_tokens          : 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(arg5),
            reserve_tokens          : 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(arg6),
        };
        0x2::transfer::share_object<WeisTreasury>(v0);
    }

    public fun withdraw_airdrop_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS> {
        0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&mut arg1.airdrop_tokens, arg2), arg3)
    }

    public fun withdraw_dao_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS> {
        0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&mut arg1.dao_tokens, arg2), arg3)
    }

    public fun withdraw_reserve_tokens(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut WeisTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS> {
        0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis::WEIS>(&mut arg1.reserve_tokens, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

