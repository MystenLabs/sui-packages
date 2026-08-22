module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::events {
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

