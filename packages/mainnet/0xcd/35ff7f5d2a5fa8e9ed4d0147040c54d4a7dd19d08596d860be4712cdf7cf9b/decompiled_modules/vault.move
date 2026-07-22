module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::vault {
    struct VaultRegistry has store {
        name_to_id: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        id_to_name: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
        ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct VaultConfig has key {
        id: 0x2::object::UID,
        operator: address,
        registry: VaultRegistry,
        status: u8,
        max_cap: u128,
        vault_creating_fee: u128,
        lock_period_ms: u64,
        fee_pool: address,
        withdrawal_filling_gas_fee: u128,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        bank_id: 0x2::object::ID,
        creator: address,
        creator_minimum_share_ratio: u128,
        creator_profit_share_ratio: u128,
        creator_loss_share_ratio: u64,
        trader: address,
        closed_at: u64,
        deposit_status: bool,
        total_shares: u128,
        max_cap: u128,
        min_deposit_amount: u128,
        requested_pending_shares: u128,
        last_share_price: u128,
        last_price_update: u64,
        user_positions: 0x2::table::Table<address, Position>,
        users: 0x2::vec_set::VecSet<address>,
        auto_close_on_withdraw: bool,
    }

    struct VaultExtension has store {
        follower_max_cap: u128,
    }

    struct UserWithdrawalRequest has key {
        id: 0x2::object::UID,
        withdrawer: address,
        shares: u128,
        entry_price: u128,
    }

    struct UserWithdrawalRequestV2 has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        withdrawer: address,
        shares: u128,
        entry_price: u128,
    }

    struct Position has drop, store {
        shares: u128,
        average_price: u128,
        last_deposit_time_ms: u64,
    }

    struct VaultNAV {
        vault_id: 0x2::object::ID,
        perpetuals: 0x2::vec_set::VecSet<0x2::object::ID>,
        position_values: 0x2::table::Table<0x2::object::ID, u128>,
        total_position_vaule: u128,
        bank_balance: u128,
    }

    struct CreatedVaultConfigEvent has copy, drop {
        id: 0x2::object::ID,
        operator: address,
        max_cap: u128,
        vault_creating_fee: u128,
        fee_pool: address,
    }

    struct VaultConfigMaxCapUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        max_cap: u128,
    }

    struct VaultConfigStatusUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        status: u8,
    }

    struct VaultConfigVaultCreatingFeeUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        vault_creating_fee: u128,
    }

    struct VaultConfigFeePoolUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        fee_pool: address,
    }

    struct VaultConfigLockPeriodUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        lock_period_ms: u64,
    }

    struct VaultConfigWithdrawalFillingGasFeeUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        withdrawal_filling_gas_fee: u128,
    }

    struct CreatedVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        trader: address,
        initial_shares: u128,
        max_cap: u128,
        min_deposit_amount: u128,
        creator_minimum_share_ratio: u128,
        creator_profit_share_ratio: u128,
        creator_loss_share_ratio: u128,
    }

    struct VaultTraderUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        trader: address,
    }

    struct VaultSubAccountUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sub_trader: address,
        status: bool,
    }

    struct VaultDepositStatusUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        status: bool,
    }

    struct VaultMaxCapUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        max_cap: u128,
    }

    struct VaultFollowerMaxCapUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        follower_max_cap: u128,
    }

    struct VaultMinDepositAmountUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        min_deposit_amount: u128,
    }

    struct VaultAutoCloseOnWithdrawUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        auto_close_on_withdraw: bool,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        tx_index: u128,
        depositor: address,
        deposited_amount: u128,
        received_shares: u128,
        user_total_shares: u128,
        user_average_price: u128,
        vault_total_shares: u128,
        vault_nav: u128,
    }

    struct ClaimClosedVaultFundsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        tx_index: u128,
        withdrawer: address,
        claimed_shares: u128,
        received_amount: u128,
        amount_to_creator: u128,
        vault_total_shares: u128,
        vault_nav: u128,
    }

    struct WithdrawRequestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        withdrawer: address,
        shares: u128,
        entry_price: u128,
    }

    struct VaultClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        closed_by: address,
        closed_at: u64,
    }

    struct VaultRemovedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct SharePriceUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        share_price: u128,
        timestamp_ms: u64,
    }

    struct VaultConfigOperatorUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        new_operator: address,
    }

    struct WithdrawRequestFillEvent has copy, drop {
        vault_id: 0x2::object::ID,
        tx_index: u128,
        request_id: 0x2::object::ID,
        withdrawer: address,
        requested_shares: u128,
        share_to_creator: u128,
        fill_price: u128,
        received_amount: u128,
    }

    struct WithdrawRequestUnfillEvent has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        withdrawer: address,
        shares: u128,
    }

    fun verify_user_signature(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg1: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::verify_user_signature(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::get_all_sub_accounts(arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(arg1)), arg2, arg3, arg4, arg5);
    }

    fun add_shares(arg0: &mut Position, arg1: u128, arg2: u128) {
        if (arg1 == 0) {
            return
        };
        arg0.average_price = (arg0.average_price * arg0.shares + arg2 * arg1) / (arg0.shares + arg1);
        arg0.shares = arg0.shares + arg1;
    }

    fun bank_account<T0>(arg0: &Vault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun check_creator_share_ratio<T0>(arg0: &Vault<T0>) {
        let v0 = arg0.total_shares;
        if (is_closed<T0>(arg0) || v0 == 0) {
            return
        };
        let v1 = v0 - arg0.requested_pending_shares;
        if (v1 == 0) {
            return
        };
        let v2 = if (0x2::table::contains<address, Position>(&arg0.user_positions, arg0.creator)) {
            0x2::table::borrow<address, Position>(&arg0.user_positions, arg0.creator).shares
        } else {
            0
        };
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v2, v1) >= arg0.creator_minimum_share_ratio, 2008);
    }

    public fun claim_closed_vault_funds<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &mut Vault<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    fun claim_closed_vault_funds_impl<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: &mut Vault<T0>, arg2: u128, arg3: address) {
        assert!(is_closed<T0>(arg1), 2010);
        assert!(arg1.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg0), 2022);
        let v0 = arg1.last_share_price;
        assert!(0x2::table::contains<address, Position>(&arg1.user_positions, arg3), 2033);
        let v1 = 0x2::table::remove<address, Position>(&mut arg1.user_positions, arg3);
        let v2 = v1.shares;
        let v3 = if (arg3 != arg1.creator) {
            profit_sharing_to_creator(arg1.creator_profit_share_ratio, v2, v1.average_price, v0)
        } else {
            0
        };
        v1.shares = v1.shares - v2;
        arg1.total_shares = arg1.total_shares - v2;
        let Position {
            shares               : _,
            average_price        : _,
            last_deposit_time_ms : _,
        } = v1;
        0x2::vec_set::remove<address>(&mut arg1.users, &arg3);
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v2, v0);
        assert!(v7 > 0, 2015);
        assert!(v7 >= v3, 99999);
        let v8 = v7 - v3;
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, bank_account<T0>(arg1)) >= v7, 2027);
        if (v8 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg0, bank_account<T0>(arg1), arg3, v8, 3, arg2);
        };
        if (v3 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg0, bank_account<T0>(arg1), arg1.creator, v3, 3, arg2);
        };
        if (arg1.requested_pending_shares == 0 && 0x2::vec_set::length<address>(&arg1.users) == 0) {
            let v9 = bank_account<T0>(arg1);
            let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, v9);
            if (v10 > 0) {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg0, v9, arg1.creator, v10, 3, arg2);
            };
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::remove_empty_account_internal<T0>(arg0, v9);
        };
        let v11 = ClaimClosedVaultFundsEvent{
            vault_id           : 0x2::object::uid_to_inner(&arg1.id),
            tx_index           : arg2,
            withdrawer         : arg3,
            claimed_shares     : v2,
            received_amount    : v8,
            amount_to_creator  : v3,
            vault_total_shares : arg1.total_shares,
            vault_nav          : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg1.total_shares, v0),
        };
        0x2::event::emit<ClaimClosedVaultFundsEvent>(v11);
    }

    public fun claim_closed_vault_funds_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut Vault<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: u128, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg9, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg12);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_claim_closed_vault_funds(bank_account<T0>(arg5), v0, arg8, arg9);
        verify_user_signature(arg3, &v0, v1, arg10, arg11, 52);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        claim_closed_vault_funds_impl<T0>(arg2, arg5, v2, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg2, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultClaimClosedFunds"), v2, arg12);
    }

    public fun close_vault<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut Vault<T0>, arg4: &0x2::clock::Clock, arg5: VaultNAV, arg6: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun close_vault_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut Vault<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &0x2::clock::Clock, arg6: VaultNAV, arg7: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun close_vault_v3<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &mut Vault<T0>, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: VaultNAV, arg8: vector<u8>, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg8);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg4.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg2, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_close(bank_account<T0>(arg4), v0, arg9, arg10);
        verify_user_signature(arg2, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultClose"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        assert!(arg7.total_position_vaule == 0, 2014);
        update_share_price_v2<T0>(arg4, arg7, arg5, arg6);
        assert!(arg4.requested_pending_shares == 0, 2003);
        let v2 = bank_account<T0>(arg4);
        assert!(!is_closed<T0>(arg4), 2009);
        let v3 = 0x2::clock::timestamp_ms(arg6);
        arg4.closed_at = v3;
        arg4.deposit_status = false;
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::get_all_sub_accounts(arg2, v2);
        0x1::vector::reverse<address>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&v4)) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg2, v2, 0x1::vector::pop_back<address>(&mut v4), false);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<address>(v4);
        let v6 = VaultClosedEvent{
            vault_id  : 0x2::object::uid_to_inner(&arg4.id),
            closed_by : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0),
            closed_at : v3,
        };
        0x2::event::emit<VaultClosedEvent>(v6);
    }

    public fun compute_perpetual_position_value(arg0: &mut VaultNAV, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        abort 999
    }

    public fun compute_perpetual_position_value_v2(arg0: &mut VaultNAV, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed) {
        let v0 = 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2));
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.perpetuals, &v0), 2030);
        assert!(!0x2::table::contains<0x2::object::ID, u128>(&arg0.position_values, v0), 2029);
        let v1 = 0x2::object::id_to_address(&arg0.vault_id);
        if (!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::has_position(arg2, v1)) {
            0x2::table::add<0x2::object::ID, u128>(&mut arg0.position_values, v0, 0);
            return
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg3, arg1);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::borrow_position(arg2, v1);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::positive_value(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_pnl_per_unit(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg2)), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v2)), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_funding_fee_per_unit(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::funding_rate(arg2))), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v2))), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v2)));
        0x2::table::add<0x2::object::ID, u128>(&mut arg0.position_values, v0, v3);
        arg0.total_position_vaule = arg0.total_position_vaule + v3;
    }

    public fun create_vault<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut VaultConfig, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: 0x1::string::String, arg7: address, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun create_vault_by_manager<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg3: &mut VaultConfig, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: address, arg7: 0x1::string::String, arg8: address, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg2);
        assert!(arg3.status == 1, 2013);
        assert!(arg8 != @0x0, 105);
        assert!(arg6 != @0x0, 105);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg3.registry.name_to_id, arg7), 2023);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg10);
        assert!(v0 >= 10000000000, 2036);
        create_vault_internal<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg9), v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg11), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg12), 0, arg13);
    }

    public(friend) fun create_vault_config(arg0: address, arg1: u128, arg2: u128, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 105);
        assert!(arg3 != @0x0, 105);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg1);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg2);
        let v2 = 10000000;
        assert!(v2 <= 500000000, 2026);
        let v3 = VaultRegistry{
            name_to_id : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg4),
            id_to_name : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg4),
            ids        : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v4 = VaultConfig{
            id                         : 0x2::object::new(arg4),
            operator                   : arg0,
            registry                   : v3,
            status                     : 1,
            max_cap                    : v0,
            vault_creating_fee         : v1,
            lock_period_ms             : 86400000,
            fee_pool                   : arg3,
            withdrawal_filling_gas_fee : v2,
        };
        let v5 = CreatedVaultConfigEvent{
            id                 : 0x2::object::uid_to_inner(&v4.id),
            operator           : arg0,
            max_cap            : v0,
            vault_creating_fee : v1,
            fee_pool           : arg3,
        };
        0x2::event::emit<CreatedVaultConfigEvent>(v5);
        0x2::transfer::share_object<VaultConfig>(v4);
    }

    fun create_vault_internal<T0>(arg0: &0x2::clock::Clock, arg1: &mut VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: address, arg5: 0x1::string::String, arg6: address, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        assert!(arg9 < v0, 2028);
        assert!(arg10 <= 500000000, 2028);
        let v1 = 0x2::object::new(arg12);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::uid_to_address(&v1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg3, v3);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg2, v3, arg6, true);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg2, v3, arg1.operator, true);
        let v4 = 0x2::table::new<address, Position>(arg12);
        let v5 = 0x2::vec_set::empty<address>();
        if (arg11 > 0) {
            let v6 = Position{
                shares               : arg11,
                average_price        : v0,
                last_deposit_time_ms : 0x2::clock::timestamp_ms(arg0),
            };
            0x2::table::add<address, Position>(&mut v4, arg4, v6);
            0x2::vec_set::insert<address>(&mut v5, arg4);
        };
        let v7 = Vault<T0>{
            id                          : v1,
            name                        : arg5,
            bank_id                     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg3),
            creator                     : arg4,
            creator_minimum_share_ratio : arg9,
            creator_profit_share_ratio  : arg10,
            creator_loss_share_ratio    : 0,
            trader                      : arg6,
            closed_at                   : 0,
            deposit_status              : true,
            total_shares                : arg11,
            max_cap                     : arg7,
            min_deposit_amount          : arg8,
            requested_pending_shares    : 0,
            last_share_price            : v0,
            last_price_update           : 0x2::clock::timestamp_ms(arg0),
            user_positions              : v4,
            users                       : v5,
            auto_close_on_withdraw      : false,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.registry.ids, v2);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.registry.name_to_id, arg5, v2);
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg1.registry.id_to_name, v2, arg5);
        let v8 = CreatedVaultEvent{
            vault_id                    : v2,
            name                        : arg5,
            creator                     : arg4,
            trader                      : arg6,
            initial_shares              : arg11,
            max_cap                     : arg7,
            min_deposit_amount          : arg8,
            creator_minimum_share_ratio : arg9,
            creator_profit_share_ratio  : arg10,
            creator_loss_share_ratio    : 0,
        };
        0x2::event::emit<CreatedVaultEvent>(v8);
        0x2::transfer::share_object<Vault<T0>>(v7);
        v2
    }

    public fun create_vault_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut VaultConfig, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: vector<u8>, arg7: 0x1::string::String, arg8: vector<u8>, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: u128, arg14: u128, arg15: u64, arg16: vector<u8>, arg17: vector<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg1, arg15, 34);
        assert!(arg2.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg6);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg18);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg8);
        let v2 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_create(v0, arg7, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        verify_user_signature(arg3, &v0, v2, arg16, arg17, 52);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v2));
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v1) != @0x0, 105);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg2.registry.name_to_id, arg7), 2023);
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg9);
        assert!(v4 <= arg2.max_cap, 2011);
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg10);
        assert!(v5 >= 10000000000, 2036);
        assert!(v5 <= v4, 2037);
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg11);
        assert!(v6 >= 50000000, 2028);
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg13);
        assert!(v7 >= v5, 2037);
        assert!(v7 <= v4, 2011);
        let v8 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg4, arg0, v8, 0x1::string::utf8(b"VaultCreate"), v3, arg18);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg4, v8) >= v7 + arg2.vault_creating_fee, 2027);
        let v9 = create_vault_internal<T0>(arg1, arg2, arg3, arg4, v8, arg7, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v1), v4, v5, v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg12), v7, arg18);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg4, v8, 0x2::object::id_to_address(&v9), v7, 3, v3);
        let v10 = DepositEvent{
            vault_id           : v9,
            tx_index           : v3,
            depositor          : v8,
            deposited_amount   : v7,
            received_shares    : v7,
            user_total_shares  : v7,
            user_average_price : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            vault_total_shares : v7,
            vault_nav          : v7,
        };
        0x2::event::emit<DepositEvent>(v10);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg4, arg2.fee_pool);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg4, v8, arg2.fee_pool, arg2.vault_creating_fee, 3, v3);
    }

    fun creator_position_mut<T0>(arg0: &mut Vault<T0>) : &mut Position {
        if (!0x2::table::contains<address, Position>(&arg0.user_positions, arg0.creator)) {
            let v0 = Position{
                shares               : 0,
                average_price        : 0,
                last_deposit_time_ms : 0,
            };
            0x2::table::add<address, Position>(&mut arg0.user_positions, arg0.creator, v0);
        };
        0x2::table::borrow_mut<address, Position>(&mut arg0.user_positions, arg0.creator)
    }

    public fun deposit<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut Vault<T0>, arg6: VaultNAV, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    fun deposit_internal<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: &mut Vault<T0>, arg2: u128, arg3: address, arg4: u128) : (u128, u128) {
        assert!(!is_closed<T0>(arg1), 2009);
        let v0 = arg3 == arg1.creator;
        let v1 = arg1.total_shares == 0;
        if (v1) {
            assert!(v0, 2042);
        };
        if (!v0) {
            assert!(arg1.deposit_status == true, 2001);
        };
        assert!(arg4 > 0 && arg4 >= arg1.min_deposit_amount, 2037);
        assert!(arg1.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg0), 2022);
        let v2 = arg1.last_share_price;
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(arg4, v2);
        assert!(v3 > 0, 2015);
        if (v1) {
            assert!(v3 >= 1000000000, 2043);
        };
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg1.total_shares + v3, v2);
        assert!(v4 <= arg1.max_cap, 2011);
        if (!v0) {
            let v5 = if (0x2::table::contains<address, Position>(&arg1.user_positions, arg3)) {
                0x2::table::borrow<address, Position>(&arg1.user_positions, arg3).shares
            } else {
                0
            };
            assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v5 + v3, v2) <= effective_follower_max_cap<T0>(arg1), 2046);
        };
        arg1.total_shares = arg1.total_shares + v3;
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg0, arg3, bank_account<T0>(arg1), arg4, 3, arg2);
        (v4, v3)
    }

    public fun deposit_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &mut Vault<T0>, arg7: VaultNAV, arg8: vector<u8>, arg9: u128, arg10: u128, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg2, arg11, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg8);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg4, &v0, arg14);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_deposit(bank_account<T0>(arg6), v0, arg9, arg10, arg11);
        verify_user_signature(arg4, &v0, v1, arg12, arg13, 52);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        update_share_price_v2<T0>(arg6, arg7, arg3, arg2);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg9);
        let v4 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg3, arg0, v4, 0x1::string::utf8(b"VaultDeposit"), v2, arg14);
        let (v5, v6) = deposit_internal<T0>(arg3, arg6, v2, v4, v3);
        if (!0x2::table::contains<address, Position>(&arg6.user_positions, v4)) {
            assert!(0x2::vec_set::length<address>(&arg6.users) < 8000, 2017);
            let v7 = Position{
                shares               : v6,
                average_price        : arg6.last_share_price,
                last_deposit_time_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::table::add<address, Position>(&mut arg6.user_positions, v4, v7);
            0x2::vec_set::insert<address>(&mut arg6.users, v4);
        } else {
            let v8 = 0x2::table::borrow_mut<address, Position>(&mut arg6.user_positions, v4);
            increase_deposit(v8, v6, arg6.last_share_price, 0x2::clock::timestamp_ms(arg2));
        };
        if (v4 != arg6.creator) {
            check_creator_share_ratio<T0>(arg6);
        };
        let v9 = 0x2::table::borrow<address, Position>(&arg6.user_positions, v4);
        let v10 = DepositEvent{
            vault_id           : 0x2::object::uid_to_inner(&arg6.id),
            tx_index           : v2,
            depositor          : v4,
            deposited_amount   : v3,
            received_shares    : v6,
            user_total_shares  : v9.shares,
            user_average_price : v9.average_price,
            vault_total_shares : arg6.total_shares,
            vault_nav          : v5,
        };
        0x2::event::emit<DepositEvent>(v10);
    }

    fun effective_follower_max_cap<T0>(arg0: &Vault<T0>) : u128 {
        let v0 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"vault_extension")) {
            0x2::dynamic_field::borrow<vector<u8>, VaultExtension>(&arg0.id, b"vault_extension").follower_max_cap
        } else {
            arg0.max_cap
        };
        if (v0 > arg0.max_cap) {
            arg0.max_cap
        } else {
            v0
        }
    }

    public fun fill_withdrawal_requests<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut Vault<T0>, arg6: VaultNAV, arg7: vector<UserWithdrawalRequest>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun fill_withdrawal_requests_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut Vault<T0>, arg6: VaultNAV, arg7: vector<UserWithdrawalRequestV2>, arg8: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 2013);
        update_share_price_v2<T0>(arg5, arg6, arg3, arg2);
        let v0 = bank_account<T0>(arg5);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(v1 == arg1.operator || v1 == arg5.creator, 920);
        let v2 = arg5.last_share_price;
        let v3 = 0;
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg4);
        let v5 = 0;
        while (v3 < 0x1::vector::length<UserWithdrawalRequestV2>(&arg7)) {
            let v6 = 0x1::vector::pop_back<UserWithdrawalRequestV2>(&mut arg7);
            assert!(v6.vault_id == 0x2::object::uid_to_inner(&arg5.id), 2012);
            let (v7, v8) = if (v6.withdrawer == arg5.creator) {
                (v6.shares, 0)
            } else {
                profit_sharing_to_creator_shares(arg5.creator_profit_share_ratio, v6.shares, v6.entry_price, v2, v2)
            };
            let v9 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v7, v2);
            if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg3, v0) >= v9) {
                let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::configured_action_gas_fee(arg0, 0x1::string::utf8(b"VaultFillWithdrawalRequests"));
                let (v11, v12) = if (v10 > 0) {
                    let (v13, v14) = if (v9 <= v10) {
                        (0, v9)
                    } else {
                        (v9 - v10, v10)
                    };
                    (v14, v13)
                } else {
                    (0, v9)
                };
                if (v11 > 0) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer_gas_fee<T0>(arg3, v0, arg1.fee_pool, v11, 3, v4);
                };
                if (v12 > 0) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v0, v6.withdrawer, v12, 3, v4);
                };
                arg5.requested_pending_shares = arg5.requested_pending_shares - v6.shares;
                arg5.total_shares = arg5.total_shares - v6.shares;
                v5 = v5 + v8;
                let v15 = WithdrawRequestFillEvent{
                    vault_id         : 0x2::object::uid_to_inner(&arg5.id),
                    tx_index         : v4,
                    request_id       : 0x2::object::uid_to_inner(&v6.id),
                    withdrawer       : v6.withdrawer,
                    requested_shares : v6.shares,
                    share_to_creator : v8,
                    fill_price       : v2,
                    received_amount  : v12,
                };
                0x2::event::emit<WithdrawRequestFillEvent>(v15);
                let UserWithdrawalRequestV2 {
                    id          : v16,
                    vault_id    : _,
                    withdrawer  : _,
                    shares      : _,
                    entry_price : _,
                } = v6;
                0x2::object::delete(v16);
            } else {
                let v21 = WithdrawRequestUnfillEvent{
                    vault_id   : 0x2::object::uid_to_inner(&arg5.id),
                    request_id : 0x2::object::uid_to_inner(&v6.id),
                    withdrawer : v6.withdrawer,
                    shares     : v6.shares,
                };
                0x2::event::emit<WithdrawRequestUnfillEvent>(v21);
                0x2::transfer::share_object<UserWithdrawalRequestV2>(v6);
            };
            v3 = v3 + 1;
        };
        if (v5 > 0) {
            let v22 = creator_position_mut<T0>(arg5);
            add_shares(v22, v5, v2);
            arg5.total_shares = arg5.total_shares + v5;
        };
        0x1::vector::destroy_empty<UserWithdrawalRequestV2>(arg7);
    }

    public fun get_effective_follower_max_cap<T0>(arg0: &Vault<T0>) : u128 {
        effective_follower_max_cap<T0>(arg0)
    }

    fun increase_deposit(arg0: &mut Position, arg1: u128, arg2: u128, arg3: u64) {
        add_shares(arg0, arg1, arg2);
        arg0.last_deposit_time_ms = arg3;
    }

    fun is_closed<T0>(arg0: &Vault<T0>) : bool {
        arg0.closed_at > 0
    }

    public fun is_nav_filled(arg0: &VaultNAV) : bool {
        0x2::vec_set::length<0x2::object::ID>(&arg0.perpetuals) == 0x2::table::length<0x2::object::ID, u128>(&arg0.position_values)
    }

    public fun new_vault_nav<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &Vault<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x2::tx_context::TxContext) : VaultNAV {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 2013);
        assert!(arg2.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg3), 2022);
        VaultNAV{
            vault_id             : 0x2::object::uid_to_inner(&arg2.id),
            perpetuals           : *0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::borrow_perpetual_ids(arg0),
            position_values      : 0x2::table::new<0x2::object::ID, u128>(arg4),
            total_position_vaule : 0,
            bank_balance         : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg3, bank_account<T0>(arg2)),
        }
    }

    public fun pnl_per_share(arg0: u128, arg1: u128) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from_subtraction(arg1, arg0)
    }

    fun profit_sharing_to_creator(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(pnl_per_share(arg2, arg3), arg1);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gt_u128(v0, 0)) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v0), arg0)
        } else {
            0
        }
    }

    fun profit_sharing_to_creator_shares(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (u128, u128) {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(profit_sharing_to_creator(arg0, arg1, arg2, arg3), arg4);
        (arg1 - v0, v0)
    }

    public fun remove_vault<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut VaultConfig, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: Vault<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1.operator, 920);
        assert!(is_closed<T0>(&arg3), 2010);
        assert!(arg3.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg2), 2022);
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::exists_account<T0>(arg2, bank_account<T0>(&arg3)), 99999);
        let v0 = 0x2::object::uid_to_inner(&arg3.id);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg1.registry.name_to_id, 0x2::table::remove<0x2::object::ID, 0x1::string::String>(&mut arg1.registry.id_to_name, v0));
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.registry.ids, &v0);
        let Vault {
            id                          : v1,
            name                        : _,
            bank_id                     : _,
            creator                     : _,
            creator_minimum_share_ratio : _,
            creator_profit_share_ratio  : _,
            creator_loss_share_ratio    : _,
            trader                      : _,
            closed_at                   : _,
            deposit_status              : _,
            total_shares                : _,
            max_cap                     : _,
            min_deposit_amount          : _,
            requested_pending_shares    : _,
            last_share_price            : _,
            last_price_update           : _,
            user_positions              : v17,
            users                       : _,
            auto_close_on_withdraw      : _,
        } = arg3;
        0x2::object::delete(v1);
        0x2::table::drop<address, Position>(v17);
        let v20 = VaultRemovedEvent{vault_id: v0};
        0x2::event::emit<VaultRemovedEvent>(v20);
    }

    public fun request_withdraw<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut Vault<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    fun request_withdraw_impl<T0>(arg0: &VaultConfig, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: address, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_closed<T0>(arg2), 2009);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg4);
        assert!(v0 > 0, 2015);
        assert!(0x2::table::contains<address, Position>(&arg2.user_positions, arg3), 2033);
        let v1 = 0x2::table::remove<address, Position>(&mut arg2.user_positions, arg3);
        assert!(0x2::clock::timestamp_ms(arg1) - v1.last_deposit_time_ms > arg0.lock_period_ms, 2038);
        assert!(v1.shares >= v0, 2004);
        if (arg3 == arg2.creator) {
            assert!(v1.shares - v0 >= 1000000000, 2044);
        };
        if (v1.shares > v0) {
            assert!(v0 >= 1000000000, 2041);
        };
        v1.shares = v1.shares - v0;
        arg2.requested_pending_shares = arg2.requested_pending_shares + v0;
        let v2 = v1.average_price;
        let v3 = UserWithdrawalRequestV2{
            id          : 0x2::object::new(arg5),
            vault_id    : 0x2::object::uid_to_inner(&arg2.id),
            withdrawer  : arg3,
            shares      : v0,
            entry_price : v2,
        };
        0x2::transfer::share_object<UserWithdrawalRequestV2>(v3);
        if (v1.shares > 0) {
            0x2::table::add<address, Position>(&mut arg2.user_positions, arg3, v1);
        } else {
            let Position {
                shares               : _,
                average_price        : _,
                last_deposit_time_ms : _,
            } = v1;
            0x2::vec_set::remove<address>(&mut arg2.users, &arg3);
        };
        let v7 = WithdrawRequestEvent{
            vault_id    : 0x2::object::uid_to_inner(&arg2.id),
            request_id  : 0x2::object::uid_to_inner(&v3.id),
            withdrawer  : arg3,
            shares      : v0,
            entry_price : v2,
        };
        0x2::event::emit<WithdrawRequestEvent>(v7);
        if (arg3 == arg2.creator) {
            check_creator_share_ratio<T0>(arg2);
        };
    }

    public fun request_withdraw_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &mut Vault<T0>, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg2, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg4, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_request_withdraw(bank_account<T0>(arg6), v0, arg8, arg9, arg10);
        verify_user_signature(arg4, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg3, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultRequestWithdraw"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        request_withdraw_impl<T0>(arg1, arg2, arg6, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), arg8, arg13);
    }

    public fun set_auto_close_on_withdraw<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun set_auto_close_on_withdraw_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: bool, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_auto_close_on_withdraw(bank_account<T0>(arg2), v0, arg8, arg9, arg10);
        verify_user_signature(arg3, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultSetAutoCloseOnWithdraw"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        assert!(arg8 != arg2.auto_close_on_withdraw, 2026);
        arg2.auto_close_on_withdraw = arg8;
        let v2 = VaultAutoCloseOnWithdrawUpdateEvent{
            vault_id               : 0x2::object::uid_to_inner(&arg2.id),
            auto_close_on_withdraw : arg8,
        };
        0x2::event::emit<VaultAutoCloseOnWithdrawUpdateEvent>(v2);
    }

    public fun set_deposit_status<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun set_deposit_status_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: bool, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_deposit_status(bank_account<T0>(arg2), v0, arg8, arg9, arg10);
        verify_user_signature(arg3, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultSetDepositStatus"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        assert!(arg8 != arg2.deposit_status, 2026);
        arg2.deposit_status = arg8;
        let v2 = VaultDepositStatusUpdateEvent{
            vault_id : 0x2::object::uid_to_inner(&arg2.id),
            status   : arg8,
        };
        0x2::event::emit<VaultDepositStatusUpdateEvent>(v2);
    }

    public fun set_follower_max_cap<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun set_follower_max_cap_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_follower_max_cap(bank_account<T0>(arg2), v0, arg8, arg9, arg10);
        verify_user_signature(arg3, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultSetFollowerMaxCap"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg8);
        assert!(v2 > 0, 2015);
        assert!(v2 > arg2.min_deposit_amount, 2047);
        assert!(v2 <= arg2.max_cap, 2011);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, b"vault_extension")) {
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, VaultExtension>(&mut arg2.id, b"vault_extension");
            assert!(v2 != v3.follower_max_cap, 2026);
            v3.follower_max_cap = v2;
        } else {
            let v4 = VaultExtension{follower_max_cap: v2};
            0x2::dynamic_field::add<vector<u8>, VaultExtension>(&mut arg2.id, b"vault_extension", v4);
        };
        let v5 = VaultFollowerMaxCapUpdateEvent{
            vault_id         : 0x2::object::uid_to_inner(&arg2.id),
            follower_max_cap : v2,
        };
        0x2::event::emit<VaultFollowerMaxCapUpdateEvent>(v5);
    }

    public fun set_max_cap<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun set_max_cap_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_max_cap(bank_account<T0>(arg2), v0, arg8, arg9, arg10);
        verify_user_signature(arg3, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultSetMaxCap"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg8);
        assert!(v2 != arg2.max_cap, 2026);
        assert!(v2 > 0, 2015);
        assert!(v2 <= arg1.max_cap, 2011);
        arg2.max_cap = v2;
        let v3 = VaultMaxCapUpdateEvent{
            vault_id : 0x2::object::uid_to_inner(&arg2.id),
            max_cap  : v2,
        };
        0x2::event::emit<VaultMaxCapUpdateEvent>(v3);
    }

    public fun set_min_deposit_amount<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun set_min_deposit_amount_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_min_deposit_amount(bank_account<T0>(arg2), v0, arg8, arg9, arg10);
        verify_user_signature(arg3, &v0, v1, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultSetMinDepositAmount"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1)), arg13);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg8);
        assert!(v2 != arg2.min_deposit_amount, 2026);
        assert!(v2 >= 10000000000, 2036);
        arg2.min_deposit_amount = v2;
        let v3 = VaultMinDepositAmountUpdateEvent{
            vault_id           : 0x2::object::uid_to_inner(&arg2.id),
            min_deposit_amount : v2,
        };
        0x2::event::emit<VaultMinDepositAmountUpdateEvent>(v3);
    }

    public fun set_sub_trader<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: address, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 2013);
        assert!(0x2::tx_context::sender(arg6) == arg2.trader, 920);
        set_sub_trader_internal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    fun set_sub_trader_internal<T0>(arg0: &VaultConfig, arg1: &Vault<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: address, arg4: bool) {
        assert!(!is_closed<T0>(arg1), 2009);
        assert!(arg3 != @0x0, 105);
        assert!(arg3 != arg1.trader, 2025);
        assert!(arg3 != arg0.operator, 2024);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg2, bank_account<T0>(arg1), arg3, arg4);
        let v0 = VaultSubAccountUpdateEvent{
            vault_id   : 0x2::object::uid_to_inner(&arg1.id),
            sub_trader : arg3,
            status     : arg4,
        };
        0x2::event::emit<VaultSubAccountUpdateEvent>(v0);
    }

    public fun set_sub_trader_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: vector<u8>, arg9: bool, arg10: u128, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg11, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.trader, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg14);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg8);
        let v2 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_sub_trader(bank_account<T0>(arg2), v0, v1, arg9, arg10, arg11);
        verify_user_signature(arg3, &v0, v2, arg12, arg13, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, arg2.creator, 0x1::string::utf8(b"VaultSetSubTrader"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v2)), arg14);
        set_sub_trader_internal<T0>(arg1, arg2, arg3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v1), arg9);
    }

    public fun set_trader<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: address, arg5: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun set_trader_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: vector<u8>, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg6, arg10, 34);
        assert!(arg1.status == 1, 2013);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0) == arg2.creator, 920);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg8);
        let v2 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::vault_set_trader(bank_account<T0>(arg2), v0, v1, arg9, arg10);
        verify_user_signature(arg3, &v0, v2, arg11, arg12, 52);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg5, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"VaultSetTrader"), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v2)), arg13);
        let v3 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v1);
        assert!(v3 != @0x0 && v3 != arg2.trader, 2025);
        let v4 = 0x2::object::uid_to_address(&arg2.id);
        assert!(arg2.trader != arg1.operator, 2025);
        assert!(v3 != arg1.operator, 2025);
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg3, v4, v3), 2025);
        arg2.trader = v3;
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::get_all_sub_accounts(arg3, v4);
        0x1::vector::reverse<address>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&v5)) {
            let v7 = 0x1::vector::pop_back<address>(&mut v5);
            if (v7 != arg1.operator) {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg3, v4, v7, false);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg3, v4, arg2.trader, true);
        let v8 = VaultTraderUpdateEvent{
            vault_id : 0x2::object::uid_to_inner(&arg2.id),
            trader   : v3,
        };
        0x2::event::emit<VaultTraderUpdateEvent>(v8);
    }

    public fun set_vault_config_fee_pool(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg3 != @0x0, 105);
        assert!(arg3 != arg2.fee_pool, 2026);
        arg2.fee_pool = arg3;
        let v0 = VaultConfigFeePoolUpdateEvent{
            id       : 0x2::object::uid_to_inner(&arg2.id),
            fee_pool : arg3,
        };
        0x2::event::emit<VaultConfigFeePoolUpdateEvent>(v0);
    }

    public fun set_vault_config_lock_period(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: u64) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg3 <= 2592000000, 2005);
        assert!(arg3 != arg2.lock_period_ms, 2026);
        arg2.lock_period_ms = arg3;
        let v0 = VaultConfigLockPeriodUpdateEvent{
            id             : 0x2::object::uid_to_inner(&arg2.id),
            lock_period_ms : arg3,
        };
        0x2::event::emit<VaultConfigLockPeriodUpdateEvent>(v0);
    }

    public fun set_vault_config_max_cap(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg3);
        assert!(v0 != arg2.max_cap, 2026);
        arg2.max_cap = v0;
        let v1 = VaultConfigMaxCapUpdateEvent{
            id      : 0x2::object::uid_to_inner(&arg2.id),
            max_cap : v0,
        };
        0x2::event::emit<VaultConfigMaxCapUpdateEvent>(v1);
    }

    public fun set_vault_config_operator(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg3 != @0x0 && arg3 != arg2.operator, 2024);
        arg2.operator = arg3;
        let v0 = VaultConfigOperatorUpdateEvent{
            id           : 0x2::object::uid_to_inner(&arg2.id),
            new_operator : arg3,
        };
        0x2::event::emit<VaultConfigOperatorUpdateEvent>(v0);
    }

    public fun set_vault_config_status(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: u8) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!((arg3 == 0 || arg3 == 1) && arg3 != arg2.status, 2026);
        arg2.status = arg3;
        let v0 = VaultConfigStatusUpdateEvent{
            id     : 0x2::object::uid_to_inner(&arg2.id),
            status : arg3,
        };
        0x2::event::emit<VaultConfigStatusUpdateEvent>(v0);
    }

    public fun set_vault_config_vault_creating_fee(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg3);
        assert!(v0 != arg2.vault_creating_fee, 2026);
        arg2.vault_creating_fee = v0;
        let v1 = VaultConfigVaultCreatingFeeUpdateEvent{
            id                 : 0x2::object::uid_to_inner(&arg2.id),
            vault_creating_fee : v0,
        };
        0x2::event::emit<VaultConfigVaultCreatingFeeUpdateEvent>(v1);
    }

    public fun set_vault_config_withdrawal_filling_gas_fee(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg3);
        assert!(v0 <= 500000000, 2006);
        assert!(v0 != arg2.withdrawal_filling_gas_fee, 2026);
        arg2.withdrawal_filling_gas_fee = v0;
        let v1 = VaultConfigWithdrawalFillingGasFeeUpdateEvent{
            id                         : 0x2::object::uid_to_inner(&arg2.id),
            withdrawal_filling_gas_fee : v0,
        };
        0x2::event::emit<VaultConfigWithdrawalFillingGasFeeUpdateEvent>(v1);
    }

    public fun update_share_price<T0>(arg0: &mut Vault<T0>, arg1: VaultNAV, arg2: &0x2::clock::Clock) {
        abort 999
    }

    public fun update_share_price_v2<T0>(arg0: &mut Vault<T0>, arg1: VaultNAV, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.vault_id, 2012);
        assert!(is_nav_filled(&arg1), 2035);
        assert!(arg0.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg2), 2022);
        let VaultNAV {
            vault_id             : _,
            perpetuals           : _,
            position_values      : v2,
            total_position_vaule : v3,
            bank_balance         : v4,
        } = arg1;
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg2, bank_account<T0>(arg0)) == v4, 2045);
        if (arg0.total_shares == 0) {
            0x2::table::drop<0x2::object::ID, u128>(v2);
            return
        };
        arg0.last_share_price = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v3 + v4, arg0.total_shares);
        arg0.last_price_update = 0x2::clock::timestamp_ms(arg3);
        0x2::table::drop<0x2::object::ID, u128>(v2);
        let v5 = SharePriceUpdatedEvent{
            vault_id     : 0x2::object::uid_to_inner(&arg0.id),
            share_price  : arg0.last_share_price,
            timestamp_ms : arg0.last_price_update,
        };
        0x2::event::emit<SharePriceUpdatedEvent>(v5);
    }

    public fun update_vault_operator<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg2: &mut VaultConfig, arg3: &Vault<T0>, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg2.operator, 920);
        assert!(arg4 != arg2.operator, 2024);
        let v0 = bank_account<T0>(arg3);
        assert!(arg4 != arg3.trader, 2024);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg1, v0, arg4), 2024);
        assert!(arg2.operator != arg3.trader, 2024);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg1, v0, arg4, false);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg1, v0, arg2.operator, true);
    }

    public(friend) fun withdrawal_filling_gas_fee(arg0: &VaultConfig) : u128 {
        arg0.withdrawal_filling_gas_fee
    }

    // decompiled from Move bytecode v7
}

