module 0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::treasury {
    struct TREASURY has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        configured: bool,
        treasury_balance: 0x2::balance::Balance<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>,
        builder_grant_balance: u64,
        cex_reserve_balance: u64,
        token_sales_balance: u64,
        marketing_reserve_balance: u64,
        lp_reserve_balance: u64,
        future_airdrop_balance: u64,
        vesting_wallet: 0x1::option::Option<0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::Wallet<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TreasuryAdminCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryConfigured has copy, drop {
        treasury_size: u64,
        builder_grant_balance: u64,
        cex_reserve_balance: u64,
        token_sales_balance: u64,
        marketing_reserve_balance: u64,
        lp_reserve_balance: u64,
        team_vesting_balance: u64,
        future_airdrop_balance: u64,
        vesting_start_timestamp_ms: u64,
        vesting_duration_ms: u64,
    }

    struct NewTreasuryAdmin has copy, drop {
        admin: address,
    }

    struct BuilderGrantReserveSpent has copy, drop {
        amount: u64,
        remaining_builder_grant_balance: u64,
    }

    struct CexReserveSpent has copy, drop {
        amount: u64,
        remaining_cex_reserve_balance: u64,
    }

    struct SalesReserveSpent has copy, drop {
        amount: u64,
        remaining_token_sales_balance: u64,
    }

    struct MarketingReserveSpent has copy, drop {
        amount: u64,
        remaining_marketing_reserve_balance: u64,
    }

    struct LpReserveSpent has copy, drop {
        amount: u64,
        remaining_lp_reserve_balance: u64,
    }

    struct TeamTokensClaimed has copy, drop {
        remaining_team_vesting_balance: u64,
    }

    struct AirdropReserveSpent has copy, drop {
        amount: u64,
        remaining_airdrop_reserve_balance: u64,
    }

    public entry fun allocate_cex_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(take_from_cex_reserve(arg0, arg1, arg3, arg4), arg2);
    }

    fun begin_team_vesting(arg0: &mut Treasury, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::Wallet<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(&arg0.vesting_wallet), 4);
        0x1::option::fill<0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::Wallet<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(&mut arg0.vesting_wallet, 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::new<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg0.treasury_balance, arg1, arg5), arg4, arg2, arg3, arg5));
    }

    public fun claim_from_team_vesting(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        let v0 = TeamTokensClaimed{remaining_team_vesting_balance: 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::balance<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(0x1::option::borrow<0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::Wallet<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(&arg1.vesting_wallet))};
        0x2::event::emit<TeamTokensClaimed>(v0);
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::claim<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(0x1::option::borrow_mut<0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::Wallet<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(&mut arg1.vesting_wallet), arg2, arg3)
    }

    public entry fun claim_vested_team_tokens(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(claim_from_team_vesting(arg0, arg1, arg3, arg4), arg2);
    }

    public entry fun configure(arg0: &0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::TreasuryConfigurationCap, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.configured == false, 5);
        assert!(arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9 == 0x2::coin::value<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&arg2), 3);
        0x2::balance::join<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, 0x2::coin::into_balance<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(arg2));
        arg1.builder_grant_balance = arg3;
        arg1.cex_reserve_balance = arg4;
        arg1.token_sales_balance = arg5;
        arg1.marketing_reserve_balance = arg6;
        arg1.lp_reserve_balance = arg7;
        arg1.future_airdrop_balance = arg9;
        arg1.configured = true;
        let v0 = TreasuryAdminCap{id: 0x2::object::new(arg14)};
        transfer_admin(v0, arg12);
        begin_team_vesting(arg1, arg8, arg10, arg11, arg13, arg14);
        let v1 = TreasuryConfigured{
            treasury_size              : 0x2::balance::value<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&arg1.treasury_balance),
            builder_grant_balance      : arg3,
            cex_reserve_balance        : arg4,
            token_sales_balance        : arg5,
            marketing_reserve_balance  : arg6,
            lp_reserve_balance         : arg7,
            team_vesting_balance       : arg8,
            future_airdrop_balance     : arg9,
            vesting_start_timestamp_ms : arg10,
            vesting_duration_ms        : arg11,
        };
        0x2::event::emit<TreasuryConfigured>(v1);
    }

    public entry fun deploy_lp_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(take_from_lp_reserve(arg0, arg1, arg3, arg4), arg2);
    }

    public entry fun disburse_builder_grant(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(take_from_builder_grant_reserve(arg0, arg1, arg3, arg4), arg2);
    }

    fun init(arg0: TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                        : 0x2::object::new(arg1),
            configured                : false,
            treasury_balance          : 0x2::balance::zero<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(),
            builder_grant_balance     : 0,
            cex_reserve_balance       : 0,
            token_sales_balance       : 0,
            marketing_reserve_balance : 0,
            lp_reserve_balance        : 0,
            future_airdrop_balance    : 0,
            vesting_wallet            : 0x1::option::none<0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::linear_vesting_wallet::Wallet<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(),
            sui_balance               : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun receive_sui_balance(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun take_from_airdrop_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        assert!(arg1.future_airdrop_balance >= arg2, 1);
        arg1.future_airdrop_balance = arg1.future_airdrop_balance - arg2;
        let v0 = AirdropReserveSpent{
            amount                            : arg2,
            remaining_airdrop_reserve_balance : arg1.future_airdrop_balance,
        };
        0x2::event::emit<AirdropReserveSpent>(v0);
        0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, arg2, arg3)
    }

    public fun take_from_builder_grant_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        assert!(arg1.builder_grant_balance >= arg2, 1);
        arg1.builder_grant_balance = arg1.builder_grant_balance - arg2;
        let v0 = BuilderGrantReserveSpent{
            amount                          : arg2,
            remaining_builder_grant_balance : arg1.builder_grant_balance,
        };
        0x2::event::emit<BuilderGrantReserveSpent>(v0);
        0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, arg2, arg3)
    }

    public fun take_from_cex_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        assert!(arg1.cex_reserve_balance >= arg2, 1);
        arg1.cex_reserve_balance = arg1.cex_reserve_balance - arg2;
        let v0 = CexReserveSpent{
            amount                        : arg2,
            remaining_cex_reserve_balance : arg1.cex_reserve_balance,
        };
        0x2::event::emit<CexReserveSpent>(v0);
        0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, arg2, arg3)
    }

    public fun take_from_lp_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        assert!(arg1.lp_reserve_balance >= arg2, 1);
        arg1.lp_reserve_balance = arg1.lp_reserve_balance - arg2;
        let v0 = LpReserveSpent{
            amount                       : arg2,
            remaining_lp_reserve_balance : arg1.lp_reserve_balance,
        };
        0x2::event::emit<LpReserveSpent>(v0);
        0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, arg2, arg3)
    }

    public fun take_from_marketing_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        assert!(arg1.marketing_reserve_balance >= arg2, 1);
        arg1.marketing_reserve_balance = arg1.marketing_reserve_balance - arg2;
        let v0 = MarketingReserveSpent{
            amount                              : arg2,
            remaining_marketing_reserve_balance : arg1.marketing_reserve_balance,
        };
        0x2::event::emit<MarketingReserveSpent>(v0);
        0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, arg2, arg3)
    }

    public fun take_from_sales_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI> {
        assert!(arg1.token_sales_balance >= arg2, 1);
        arg1.token_sales_balance = arg1.token_sales_balance - arg2;
        let v0 = SalesReserveSpent{
            amount                        : arg2,
            remaining_token_sales_balance : arg1.token_sales_balance,
        };
        0x2::event::emit<SalesReserveSpent>(v0);
        0x2::coin::take<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>(&mut arg1.treasury_balance, arg2, arg3)
    }

    public fun take_from_sui_balance(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) >= arg2, 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, arg2, arg3)
    }

    public entry fun transfer_admin(arg0: TreasuryAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<TreasuryAdminCap>(arg0, arg1);
        let v0 = NewTreasuryAdmin{admin: arg1};
        0x2::event::emit<NewTreasuryAdmin>(v0);
    }

    public entry fun utilize_marketing_reserve(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1000ed22ea4a07a894172607eb602355df32399a1c948969c61f9ec6a24db96f::kimchi::KIMCHI>>(take_from_marketing_reserve(arg0, arg1, arg3, arg4), arg2);
    }

    public entry fun withdraw_from_sui_balance(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(take_from_sui_balance(arg0, arg1, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

