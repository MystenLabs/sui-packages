module 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::events {
    struct ProtocolInitialized has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        version: u64,
    }

    struct ProtocolStatusChanged has copy, drop {
        config_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    struct ProtocolVersionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct ProtocolCapRevoked has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        kind: u8,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        quote_type: 0x1::type_name::TypeName,
        creator: address,
    }

    struct ShareCapMinted has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        flag: u64,
    }

    struct ShareCapRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        shares_minted: u64,
        via_cap: bool,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        shares_burned: u64,
        performance_fee: u64,
    }

    struct ShareTransferred has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        from: address,
        to: address,
        royalty: u64,
    }

    struct ManagementFeeAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        shares_minted: u64,
        new_total_shares: u64,
        elapsed_seconds: u64,
    }

    struct PerformanceFeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BuyFeeApplied has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        fee_amount: u64,
        period_used: u64,
        period_cap: u64,
    }

    struct VaultDepositCapSet has copy, drop {
        vault_id: 0x2::object::ID,
        cap_quote: u64,
        nav_at_set: u64,
    }

    struct EarlyWithdrawPolicySet has copy, drop {
        config_id: 0x2::object::ID,
        window_ms: u64,
        fee_bps: u64,
    }

    struct NavDonated has copy, drop {
        vault_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        quote_value: u64,
        donor: address,
        nav_after: u64,
    }

    struct EarlyWithdrawFeeCharged has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        shares: u64,
        fee_quote: u64,
        held_ms: u64,
        window_ms: u64,
    }

    struct RewardTypeAllowed has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct DripCreated has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        rate_per_second: u64,
    }

    struct DripFunded has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        funder: address,
        locked_after: u64,
        rate_per_second: u64,
    }

    struct DripPumped has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        released: u64,
        locked_after: u64,
        credited: bool,
    }

    struct RewardDonated has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        donor: address,
        total_shares: u64,
    }

    struct AdapterFlow has copy, drop {
        account: 0x2::object::ID,
        vault: 0x2::object::ID,
        amount: u64,
        d: u8,
    }

    struct AmmSwap has copy, drop {
        vault: 0x2::object::ID,
        dex: u8,
        pool: 0x2::object::ID,
        buy_base: bool,
        amount_in: u64,
        amount_out: u64,
        basis_quote: u64,
    }

    struct OracleDesignated has copy, drop {
        config_id: 0x2::object::ID,
        previous: 0x1::option::Option<0x2::object::ID>,
        current: 0x2::object::ID,
    }

    struct OraclePrice has copy, drop {
        oracle: 0x2::object::ID,
        price: u64,
        sources: u64,
        at_ms: u64,
    }

    struct EquityMark has copy, drop {
        vault: 0x2::object::ID,
        kind: u8,
        subject: 0x2::object::ID,
        old_value: u64,
        new_value: u64,
        at_ms: u64,
    }

    struct BmSwap has copy, drop {
        account: 0x2::object::ID,
        vault: 0x2::object::ID,
        dex: u8,
        pool: 0x2::object::ID,
        sell_base: bool,
        actual_in: u64,
        actual_out: u64,
    }

    struct CustodyRetired has copy, drop {
        vault: 0x2::object::ID,
        account: 0x2::object::ID,
        by_admin: bool,
        at_ms: u64,
    }

    public fun emit_adapter_flow(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8) {
        let v0 = AdapterFlow{
            account : arg0,
            vault   : arg1,
            amount  : arg2,
            d       : arg3,
        };
        0x2::event::emit<AdapterFlow>(v0);
    }

    public fun emit_amm_swap(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = AmmSwap{
            vault       : arg0,
            dex         : arg1,
            pool        : arg2,
            buy_base    : arg3,
            amount_in   : arg4,
            amount_out  : arg5,
            basis_quote : arg6,
        };
        0x2::event::emit<AmmSwap>(v0);
    }

    public fun emit_bm_swap(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64) {
        let v0 = BmSwap{
            account    : arg0,
            vault      : arg1,
            dex        : arg2,
            pool       : arg3,
            sell_base  : arg4,
            actual_in  : arg5,
            actual_out : arg6,
        };
        0x2::event::emit<BmSwap>(v0);
    }

    public fun emit_buy_fee(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BuyFeeApplied{
            vault_id    : arg0,
            coin_type   : arg1,
            fee_amount  : arg2,
            period_used : arg3,
            period_cap  : arg4,
        };
        0x2::event::emit<BuyFeeApplied>(v0);
    }

    public fun emit_custody_retired(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        let v0 = CustodyRetired{
            vault    : arg0,
            account  : arg1,
            by_admin : arg2,
            at_ms    : arg3,
        };
        0x2::event::emit<CustodyRetired>(v0);
    }

    public fun emit_deposit(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = DepositEvent{
            vault_id      : arg0,
            depositor     : arg1,
            coin_type     : arg2,
            amount        : arg3,
            shares_minted : arg4,
            via_cap       : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun emit_drip_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = DripCreated{
            vault_id        : arg0,
            reward_type     : arg1,
            rate_per_second : arg2,
        };
        0x2::event::emit<DripCreated>(v0);
    }

    public fun emit_drip_funded(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        let v0 = DripFunded{
            vault_id        : arg0,
            reward_type     : arg1,
            amount          : arg2,
            funder          : arg3,
            locked_after    : arg4,
            rate_per_second : arg5,
        };
        0x2::event::emit<DripFunded>(v0);
    }

    public fun emit_drip_pumped(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = DripPumped{
            vault_id     : arg0,
            reward_type  : arg1,
            released     : arg2,
            locked_after : arg3,
            credited     : arg4,
        };
        0x2::event::emit<DripPumped>(v0);
    }

    public fun emit_early_withdraw_fee(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = EarlyWithdrawFeeCharged{
            vault_id  : arg0,
            share_id  : arg1,
            shares    : arg2,
            fee_quote : arg3,
            held_ms   : arg4,
            window_ms : arg5,
        };
        0x2::event::emit<EarlyWithdrawFeeCharged>(v0);
    }

    public fun emit_early_withdraw_policy(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = EarlyWithdrawPolicySet{
            config_id : arg0,
            window_ms : arg1,
            fee_bps   : arg2,
        };
        0x2::event::emit<EarlyWithdrawPolicySet>(v0);
    }

    public fun emit_equity_mark(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = EquityMark{
            vault     : arg0,
            kind      : arg1,
            subject   : arg2,
            old_value : arg3,
            new_value : arg4,
            at_ms     : arg5,
        };
        0x2::event::emit<EquityMark>(v0);
    }

    public fun emit_initialized(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProtocolInitialized{
            config_id : arg0,
            admin     : arg1,
            version   : arg2,
        };
        0x2::event::emit<ProtocolInitialized>(v0);
    }

    public fun emit_management_fee(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ManagementFeeAccrued{
            vault_id         : arg0,
            shares_minted    : arg1,
            new_total_shares : arg2,
            elapsed_seconds  : arg3,
        };
        0x2::event::emit<ManagementFeeAccrued>(v0);
    }

    public fun emit_nav_donated(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: address, arg5: u64) {
        let v0 = NavDonated{
            vault_id    : arg0,
            asset       : arg1,
            amount      : arg2,
            quote_value : arg3,
            donor       : arg4,
            nav_after   : arg5,
        };
        0x2::event::emit<NavDonated>(v0);
    }

    public fun emit_oracle_designated(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x2::object::ID) {
        let v0 = OracleDesignated{
            config_id : arg0,
            previous  : arg1,
            current   : arg2,
        };
        0x2::event::emit<OracleDesignated>(v0);
    }

    public fun emit_oracle_price(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = OraclePrice{
            oracle  : arg0,
            price   : arg1,
            sources : arg2,
            at_ms   : arg3,
        };
        0x2::event::emit<OraclePrice>(v0);
    }

    public fun emit_performance_fee(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = PerformanceFeeCollected{
            vault_id  : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<PerformanceFeeCollected>(v0);
    }

    public fun emit_protocol_cap_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = ProtocolCapRevoked{
            config_id : arg0,
            cap_id    : arg1,
            kind      : arg2,
        };
        0x2::event::emit<ProtocolCapRevoked>(v0);
    }

    public fun emit_reward_donated(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: address, arg4: u64) {
        let v0 = RewardDonated{
            vault_id     : arg0,
            reward_type  : arg1,
            amount       : arg2,
            donor        : arg3,
            total_shares : arg4,
        };
        0x2::event::emit<RewardDonated>(v0);
    }

    public fun emit_reward_type_allowed(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: bool) {
        let v0 = RewardTypeAllowed{
            vault_id    : arg0,
            reward_type : arg1,
            allowed     : arg2,
        };
        0x2::event::emit<RewardTypeAllowed>(v0);
    }

    public fun emit_share_cap_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ShareCapMinted{
            vault_id : arg0,
            cap_id   : arg1,
            flag     : arg2,
        };
        0x2::event::emit<ShareCapMinted>(v0);
    }

    public fun emit_share_cap_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ShareCapRevoked{
            vault_id : arg0,
            cap_id   : arg1,
        };
        0x2::event::emit<ShareCapRevoked>(v0);
    }

    public fun emit_share_transferred(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64) {
        let v0 = ShareTransferred{
            vault_id : arg0,
            share_id : arg1,
            from     : arg2,
            to       : arg3,
            royalty  : arg4,
        };
        0x2::event::emit<ShareTransferred>(v0);
    }

    public fun emit_status_changed(arg0: 0x2::object::ID, arg1: u8, arg2: u8) {
        let v0 = ProtocolStatusChanged{
            config_id  : arg0,
            old_status : arg1,
            new_status : arg2,
        };
        0x2::event::emit<ProtocolStatusChanged>(v0);
    }

    public fun emit_vault_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = VaultCreated{
            vault_id   : arg0,
            quote_type : arg1,
            creator    : arg2,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public fun emit_vault_deposit_cap(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = VaultDepositCapSet{
            vault_id   : arg0,
            cap_quote  : arg1,
            nav_at_set : arg2,
        };
        0x2::event::emit<VaultDepositCapSet>(v0);
    }

    public fun emit_version_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProtocolVersionUpdated{
            config_id   : arg0,
            old_version : arg1,
            new_version : arg2,
        };
        0x2::event::emit<ProtocolVersionUpdated>(v0);
    }

    public fun emit_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WithdrawEvent{
            vault_id        : arg0,
            receiver        : arg1,
            coin_type       : arg2,
            amount          : arg3,
            shares_burned   : arg4,
            performance_fee : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

