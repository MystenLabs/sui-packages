module 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events {
    struct DepositEvent has copy, drop {
        batch_id: u64,
        deposit_nonce: u64,
        sender: address,
        recipient: vector<u8>,
        amount: u64,
        token_type: vector<u8>,
    }

    struct AdminRoleTransferred has copy, drop {
        previous_admin: address,
        new_admin: address,
    }

    struct BridgeTransferred has copy, drop {
        previous_bridge: address,
        new_bridge: address,
    }

    struct RelayerAdded has copy, drop {
        account: address,
        sender: address,
    }

    struct RelayerRemoved has copy, drop {
        account: address,
        sender: address,
    }

    struct Pause has copy, drop {
        is_pause: bool,
    }

    struct TokenWhitelisted has copy, drop {
        token_type: vector<u8>,
        min_limit: u64,
        max_limit: u64,
        is_native: bool,
        is_mint_burn: bool,
        is_locked: bool,
    }

    struct TokenRemovedFromWhitelist has copy, drop {
        token_type: vector<u8>,
    }

    struct TokenLimitsUpdated has copy, drop {
        token_type: vector<u8>,
        new_min_limit: u64,
        new_max_limit: u64,
    }

    struct TokenIsNativeUpdated has copy, drop {
        token_type: vector<u8>,
        is_native: bool,
    }

    struct TokenIsLockedUpdated has copy, drop {
        token_type: vector<u8>,
        is_locked: bool,
    }

    struct TokenIsMintBurnUpdated has copy, drop {
        token_type: vector<u8>,
        is_mint_burn: bool,
    }

    struct BatchCreated has copy, drop {
        batch_nonce: u64,
        block_number: u64,
    }

    struct TransferExecuted has copy, drop {
        recipient: address,
        amount: u64,
        token_type: vector<u8>,
        success: bool,
    }

    struct BatchSettingsUpdated has copy, drop {
        batch_size: u16,
        batch_block_limit: u8,
        batch_settle_limit: u8,
    }

    public(friend) fun emit_admin_role_transferred(arg0: address, arg1: address) {
        let v0 = AdminRoleTransferred{
            previous_admin : arg0,
            new_admin      : arg1,
        };
        0x2::event::emit<AdminRoleTransferred>(v0);
    }

    public(friend) fun emit_batch_created(arg0: u64, arg1: u64) {
        let v0 = BatchCreated{
            batch_nonce  : arg0,
            block_number : arg1,
        };
        0x2::event::emit<BatchCreated>(v0);
    }

    public(friend) fun emit_batch_settings_updated(arg0: u16, arg1: u8, arg2: u8) {
        let v0 = BatchSettingsUpdated{
            batch_size         : arg0,
            batch_block_limit  : arg1,
            batch_settle_limit : arg2,
        };
        0x2::event::emit<BatchSettingsUpdated>(v0);
    }

    public(friend) fun emit_bridge_transferred(arg0: address, arg1: address) {
        let v0 = BridgeTransferred{
            previous_bridge : arg0,
            new_bridge      : arg1,
        };
        0x2::event::emit<BridgeTransferred>(v0);
    }

    public fun emit_deposit(arg0: u64, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        abort 0
    }

    public(friend) fun emit_deposit_v1(arg0: u64, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        let v0 = DepositEvent{
            batch_id      : arg0,
            deposit_nonce : arg1,
            sender        : arg2,
            recipient     : arg3,
            amount        : arg4,
            token_type    : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_pause(arg0: bool) {
        let v0 = Pause{is_pause: arg0};
        0x2::event::emit<Pause>(v0);
    }

    public(friend) fun emit_relayer_added(arg0: address, arg1: address) {
        let v0 = RelayerAdded{
            account : arg0,
            sender  : arg1,
        };
        0x2::event::emit<RelayerAdded>(v0);
    }

    public(friend) fun emit_relayer_removed(arg0: address, arg1: address) {
        let v0 = RelayerRemoved{
            account : arg0,
            sender  : arg1,
        };
        0x2::event::emit<RelayerRemoved>(v0);
    }

    public(friend) fun emit_token_is_locked_updated(arg0: vector<u8>, arg1: bool) {
        let v0 = TokenIsLockedUpdated{
            token_type : arg0,
            is_locked  : arg1,
        };
        0x2::event::emit<TokenIsLockedUpdated>(v0);
    }

    public(friend) fun emit_token_is_mint_burn_updated(arg0: vector<u8>, arg1: bool) {
        let v0 = TokenIsMintBurnUpdated{
            token_type   : arg0,
            is_mint_burn : arg1,
        };
        0x2::event::emit<TokenIsMintBurnUpdated>(v0);
    }

    public(friend) fun emit_token_is_native_updated(arg0: vector<u8>, arg1: bool) {
        let v0 = TokenIsNativeUpdated{
            token_type : arg0,
            is_native  : arg1,
        };
        0x2::event::emit<TokenIsNativeUpdated>(v0);
    }

    public(friend) fun emit_token_limits_updated(arg0: vector<u8>, arg1: u64, arg2: u64) {
        let v0 = TokenLimitsUpdated{
            token_type    : arg0,
            new_min_limit : arg1,
            new_max_limit : arg2,
        };
        0x2::event::emit<TokenLimitsUpdated>(v0);
    }

    public(friend) fun emit_token_removed_from_whitelist(arg0: vector<u8>) {
        let v0 = TokenRemovedFromWhitelist{token_type: arg0};
        0x2::event::emit<TokenRemovedFromWhitelist>(v0);
    }

    public(friend) fun emit_token_whitelisted(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: bool) {
        let v0 = TokenWhitelisted{
            token_type   : arg0,
            min_limit    : arg1,
            max_limit    : arg2,
            is_native    : arg3,
            is_mint_burn : arg4,
            is_locked    : arg5,
        };
        0x2::event::emit<TokenWhitelisted>(v0);
    }

    public(friend) fun emit_transfer_executed(arg0: address, arg1: u64, arg2: vector<u8>, arg3: bool) {
        let v0 = TransferExecuted{
            recipient  : arg0,
            amount     : arg1,
            token_type : arg2,
            success    : arg3,
        };
        0x2::event::emit<TransferExecuted>(v0);
    }

    // decompiled from Move bytecode v6
}

