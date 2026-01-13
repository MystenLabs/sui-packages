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

    struct UserWithdrawalRequest has key {
        id: 0x2::object::UID,
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
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v2, v1) >= arg0.creator_minimum_share_ratio, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::creator_shares_below_minimum());
    }

    public fun claim_closed_vault_funds<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &mut Vault<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(is_closed<T0>(arg4), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_not_closed());
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg4.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::bank_mismatch());
        let v1 = arg4.last_share_price;
        assert!(0x2::table::contains<address, Position>(&arg4.user_positions, v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_user_not_exist());
        let v2 = 0x2::table::remove<address, Position>(&mut arg4.user_positions, v0);
        let v3 = v2.shares;
        let v4 = if (v0 != arg4.creator) {
            profit_sharing_to_creator(arg4.creator_profit_share_ratio, v3, v2.average_price, v1)
        } else {
            0
        };
        v2.shares = v2.shares - v3;
        arg4.total_shares = arg4.total_shares - v3;
        let Position {
            shares               : _,
            average_price        : _,
            last_deposit_time_ms : _,
        } = v2;
        0x2::vec_set::remove<address>(&mut arg4.users, &v0);
        let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v3, v1);
        assert!(v8 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::can_not_be_zero());
        assert!(v8 >= v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unreachable());
        let v9 = v8 - v4;
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg2, bank_account<T0>(arg4)) >= v8, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_insufficient_balance());
        let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg3);
        if (v9 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, bank_account<T0>(arg4), v0, v9, 3, v10);
        };
        if (v4 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, bank_account<T0>(arg4), arg4.creator, v4, 3, v10);
        };
        if (arg4.requested_pending_shares == 0 && 0x2::vec_set::length<address>(&arg4.users) == 0) {
            let v11 = bank_account<T0>(arg4);
            let v12 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg2, v11);
            if (v12 > 0) {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, v11, arg4.creator, v12, 3, v10);
            };
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::remove_empty_account<T0>(arg2, v11);
        };
        let v13 = ClaimClosedVaultFundsEvent{
            vault_id           : 0x2::object::uid_to_inner(&arg4.id),
            tx_index           : v10,
            withdrawer         : v0,
            claimed_shares     : v3,
            received_amount    : v9,
            amount_to_creator  : v4,
            vault_total_shares : arg4.total_shares,
            vault_nav          : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg4.total_shares, v1),
        };
        0x2::event::emit<ClaimClosedVaultFundsEvent>(v13);
    }

    public fun close_vault<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut Vault<T0>, arg4: &0x2::clock::Clock, arg5: VaultNAV, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::method_deprecated()
    }

    public fun close_vault_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut Vault<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &0x2::clock::Clock, arg6: VaultNAV, arg7: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(arg6.total_position_vaule == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_has_position());
        update_share_price_v2<T0>(arg3, arg6, arg4, arg5);
        assert!(arg3.requested_pending_shares == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_has_pending_withdrawals());
        assert!(0x2::tx_context::sender(arg7) == arg3.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        let v0 = bank_account<T0>(arg3);
        assert!(!is_closed<T0>(arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_closed());
        let v1 = 0x2::clock::timestamp_ms(arg5);
        arg3.closed_at = v1;
        arg3.deposit_status = false;
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::get_all_sub_accounts(arg2, v0);
        0x1::vector::reverse<address>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v2)) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg2, v0, 0x1::vector::pop_back<address>(&mut v2), false);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(v2);
        let v4 = VaultClosedEvent{
            vault_id  : 0x2::object::uid_to_inner(&arg3.id),
            closed_by : 0x2::tx_context::sender(arg7),
            closed_at : v1,
        };
        0x2::event::emit<VaultClosedEvent>(v4);
    }

    public fun compute_perpetual_position_value(arg0: &mut VaultNAV, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2));
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.perpetuals, &v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::perpetual_not_found());
        assert!(!0x2::table::contains<0x2::object::ID, u128>(&arg0.position_values, v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::perpetual_position_value_already_computed());
        let v1 = 0x2::object::id_to_address(&arg0.vault_id);
        if (!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::has_position(arg2, v1)) {
            0x2::table::add<0x2::object::ID, u128>(&mut arg0.position_values, v0, 0);
            return
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price(arg2, arg3, arg1);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::borrow_position(arg2, v1);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::positive_value(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_pnl_per_unit(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg2)), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v2)), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_funding_fee_per_unit(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::funding_rate(arg2))), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v2))), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v2)));
        0x2::table::add<0x2::object::ID, u128>(&mut arg0.position_values, v0, v3);
        arg0.total_position_vaule = arg0.total_position_vaule + v3;
    }

    public fun create_vault<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut VaultConfig, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: 0x1::string::String, arg7: address, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg2.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(arg7 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg2.registry.name_to_id, arg6), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_name_already_exists());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg8);
        assert!(v0 <= arg2.max_cap, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exceeds_vault_max_cap());
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg9);
        assert!(v1 >= 10000000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_min_deposit_amount_too_low());
        assert!(v1 <= v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_deposit_amount());
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg10);
        assert!(v2 >= 50000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_ratio());
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg12);
        assert!(v3 >= v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_deposit_amount());
        assert!(v3 <= v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exceeds_vault_max_cap());
        let v4 = 0x2::tx_context::sender(arg13);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg4, v4) >= v3 + arg2.vault_creating_fee, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_insufficient_balance());
        let v5 = create_vault_internal<T0>(arg1, arg2, arg3, arg4, v4, arg6, arg7, v0, v1, v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg11), v3, arg13);
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg4, v4, 0x2::object::id_to_address(&v5), v3, 3, v6);
        let v7 = DepositEvent{
            vault_id           : v5,
            tx_index           : v6,
            depositor          : v4,
            deposited_amount   : v3,
            received_shares    : v3,
            user_total_shares  : v3,
            user_average_price : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            vault_total_shares : v3,
            vault_nav          : v3,
        };
        0x2::event::emit<DepositEvent>(v7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg4, arg2.fee_pool);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg4, v4, arg2.fee_pool, arg2.vault_creating_fee, 3, v6);
    }

    public fun create_vault_by_manager<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg3: &mut VaultConfig, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg6: address, arg7: 0x1::string::String, arg8: address, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg2);
        assert!(arg3.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(arg8 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg6 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg3.registry.name_to_id, arg7), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_name_already_exists());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg10);
        assert!(v0 >= 10000000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_min_deposit_amount_too_low());
        create_vault_internal<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg9), v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg11), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg12), 0, arg13);
    }

    public(friend) fun create_vault_config(arg0: address, arg1: u128, arg2: u128, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg3 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg1);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg2);
        let v2 = 10000000;
        assert!(v2 <= 500000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
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
        assert!(arg9 < v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_ratio());
        assert!(arg10 < v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_ratio());
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
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        update_share_price_v2<T0>(arg5, arg6, arg3, arg2);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg7);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg4);
        let (v3, v4) = deposit_internal<T0>(arg3, arg5, v2, v0, arg8);
        if (!0x2::table::contains<address, Position>(&arg5.user_positions, v1)) {
            assert!(0x2::vec_set::length<address>(&arg5.users) < 8000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_max_depositors_reached());
            let v5 = Position{
                shares               : v4,
                average_price        : arg5.last_share_price,
                last_deposit_time_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::table::add<address, Position>(&mut arg5.user_positions, v1, v5);
            0x2::vec_set::insert<address>(&mut arg5.users, v1);
        } else {
            let v6 = 0x2::table::borrow_mut<address, Position>(&mut arg5.user_positions, v1);
            increase_deposit(v6, v4, arg5.last_share_price, 0x2::clock::timestamp_ms(arg2));
        };
        if (v1 != arg5.creator) {
            check_creator_share_ratio<T0>(arg5);
        };
        let v7 = 0x2::table::borrow<address, Position>(&arg5.user_positions, v1);
        let v8 = DepositEvent{
            vault_id           : 0x2::object::uid_to_inner(&arg5.id),
            tx_index           : v2,
            depositor          : v1,
            deposited_amount   : v0,
            received_shares    : v4,
            user_total_shares  : v7.shares,
            user_average_price : v7.average_price,
            vault_total_shares : arg5.total_shares,
            vault_nav          : v3,
        };
        0x2::event::emit<DepositEvent>(v8);
    }

    fun deposit_internal<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: &mut Vault<T0>, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) : (u128, u128) {
        assert!(!is_closed<T0>(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_closed());
        let v0 = 0x2::tx_context::sender(arg4) == arg1.creator;
        let v1 = arg1.total_shares == 0;
        if (v1) {
            assert!(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_creator_must_deposit_first());
        };
        if (!v0) {
            assert!(arg1.deposit_status == true, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::deposit_paused());
        };
        assert!(arg3 > 0 && arg3 >= arg1.min_deposit_amount, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_deposit_amount());
        assert!(arg1.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::bank_mismatch());
        let v2 = arg1.last_share_price;
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(arg3, v2);
        assert!(v3 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::can_not_be_zero());
        if (v1) {
            assert!(v3 >= 1000000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_creator_locked_shares_insufficient());
        };
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg1.total_shares + v3, v2);
        assert!(v4 <= arg1.max_cap, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exceeds_vault_max_cap());
        arg1.total_shares = arg1.total_shares + v3;
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg0, 0x2::tx_context::sender(arg4), bank_account<T0>(arg1), arg3, 3, arg2);
        (v4, v3)
    }

    public fun fill_withdrawal_requests<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &mut Vault<T0>, arg6: VaultNAV, arg7: vector<UserWithdrawalRequest>, arg8: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        update_share_price_v2<T0>(arg5, arg6, arg3, arg2);
        let v0 = bank_account<T0>(arg5);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(v1 == arg1.operator || v1 == arg5.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        let v2 = arg5.last_share_price;
        let v3 = 0;
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg4);
        let v5 = 0;
        while (v3 < 0x1::vector::length<UserWithdrawalRequest>(&arg7)) {
            let v6 = 0x1::vector::pop_back<UserWithdrawalRequest>(&mut arg7);
            let (v7, v8) = profit_sharing_to_creator_shares(arg5.creator_profit_share_ratio, v6.shares, v6.entry_price, v2, v2);
            let v9 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v7, v2);
            if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg3, v0) >= v9) {
                let v10 = arg1.withdrawal_filling_gas_fee;
                let (v11, v12) = if (v10 > 0) {
                    if (v9 <= v10) {
                        (0, v9)
                    } else {
                        (v9 - v10, v10)
                    }
                } else {
                    (v9, 0)
                };
                if (v12 > 0) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v0, arg1.fee_pool, v12, 3, v4);
                };
                if (v11 > 0) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v0, v6.withdrawer, v11, 3, v4);
                };
                arg5.requested_pending_shares = arg5.requested_pending_shares - v6.shares;
                arg5.total_shares = arg5.total_shares - v6.shares;
                v5 = v5 + v8;
                let v13 = WithdrawRequestFillEvent{
                    vault_id         : 0x2::object::uid_to_inner(&arg5.id),
                    tx_index         : v4,
                    request_id       : 0x2::object::uid_to_inner(&v6.id),
                    withdrawer       : v6.withdrawer,
                    requested_shares : v6.shares,
                    share_to_creator : v8,
                    fill_price       : v2,
                    received_amount  : v11,
                };
                0x2::event::emit<WithdrawRequestFillEvent>(v13);
                let UserWithdrawalRequest {
                    id          : v14,
                    withdrawer  : _,
                    shares      : _,
                    entry_price : _,
                } = v6;
                0x2::object::delete(v14);
            } else {
                let v18 = WithdrawRequestUnfillEvent{
                    vault_id   : 0x2::object::uid_to_inner(&arg5.id),
                    request_id : 0x2::object::uid_to_inner(&v6.id),
                    withdrawer : v6.withdrawer,
                    shares     : v6.shares,
                };
                0x2::event::emit<WithdrawRequestUnfillEvent>(v18);
                0x2::transfer::share_object<UserWithdrawalRequest>(v6);
            };
            v3 = v3 + 1;
        };
        if (v5 > 0) {
            let v19 = creator_position_mut<T0>(arg5);
            add_shares(v19, v5, v2);
            arg5.total_shares = arg5.total_shares + v5;
        };
        0x1::vector::destroy_empty<UserWithdrawalRequest>(arg7);
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
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(arg2.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::bank_mismatch());
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
        assert!(0x2::tx_context::sender(arg4) == arg1.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        assert!(is_closed<T0>(&arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_not_closed());
        assert!(arg3.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::bank_mismatch());
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::exists_account<T0>(arg2, bank_account<T0>(&arg3)), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unreachable());
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
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(!is_closed<T0>(arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_closed());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg4);
        assert!(v0 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::can_not_be_zero());
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Position>(&arg3.user_positions, v1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_user_not_exist());
        let v2 = 0x2::table::remove<address, Position>(&mut arg3.user_positions, v1);
        assert!(0x2::clock::timestamp_ms(arg2) - v2.last_deposit_time_ms > arg1.lock_period_ms, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_withdrawal_locked());
        assert!(v2.shares >= v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insufficient_shares());
        if (v1 == arg3.creator) {
            assert!(v2.shares - v0 >= 1000000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_creator_locked_shares_cannot_withdraw());
        };
        if (v2.shares > v0) {
            assert!(v0 >= 1000000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_withdrawal_shares_too_low());
        };
        v2.shares = v2.shares - v0;
        arg3.requested_pending_shares = arg3.requested_pending_shares + v0;
        let v3 = v2.average_price;
        let v4 = UserWithdrawalRequest{
            id          : 0x2::object::new(arg5),
            withdrawer  : v1,
            shares      : v0,
            entry_price : v3,
        };
        0x2::transfer::share_object<UserWithdrawalRequest>(v4);
        if (v2.shares > 0) {
            0x2::table::add<address, Position>(&mut arg3.user_positions, v1, v2);
        } else {
            let Position {
                shares               : _,
                average_price        : _,
                last_deposit_time_ms : _,
            } = v2;
            0x2::vec_set::remove<address>(&mut arg3.users, &v1);
        };
        let v8 = WithdrawRequestEvent{
            vault_id    : 0x2::object::uid_to_inner(&arg3.id),
            request_id  : 0x2::object::uid_to_inner(&v4.id),
            withdrawer  : v1,
            shares      : v0,
            entry_price : v3,
        };
        0x2::event::emit<WithdrawRequestEvent>(v8);
        if (v1 == arg3.creator) {
            check_creator_share_ratio<T0>(arg3);
        };
    }

    public fun set_auto_close_on_withdraw<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(0x2::tx_context::sender(arg4) == arg2.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        assert!(arg3 != arg2.auto_close_on_withdraw, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
        arg2.auto_close_on_withdraw = arg3;
        let v0 = VaultAutoCloseOnWithdrawUpdateEvent{
            vault_id               : 0x2::object::uid_to_inner(&arg2.id),
            auto_close_on_withdraw : arg3,
        };
        0x2::event::emit<VaultAutoCloseOnWithdrawUpdateEvent>(v0);
    }

    public fun set_deposit_status<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(0x2::tx_context::sender(arg4) == arg2.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        assert!(arg3 != arg2.deposit_status, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
        arg2.deposit_status = arg3;
        let v0 = VaultDepositStatusUpdateEvent{
            vault_id : 0x2::object::uid_to_inner(&arg2.id),
            status   : arg3,
        };
        0x2::event::emit<VaultDepositStatusUpdateEvent>(v0);
    }

    public fun set_max_cap<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(0x2::tx_context::sender(arg4) == arg2.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg3);
        assert!(v0 != arg2.max_cap, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
        assert!(v0 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::can_not_be_zero());
        assert!(v0 <= arg1.max_cap, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exceeds_vault_max_cap());
        arg2.max_cap = v0;
        let v1 = VaultMaxCapUpdateEvent{
            vault_id : 0x2::object::uid_to_inner(&arg2.id),
            max_cap  : v0,
        };
        0x2::event::emit<VaultMaxCapUpdateEvent>(v1);
    }

    public fun set_min_deposit_amount<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(0x2::tx_context::sender(arg4) == arg2.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg3);
        assert!(v0 != arg2.min_deposit_amount, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
        assert!(v0 >= 10000000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_min_deposit_amount_too_low());
        arg2.min_deposit_amount = v0;
        let v1 = VaultMinDepositAmountUpdateEvent{
            vault_id           : 0x2::object::uid_to_inner(&arg2.id),
            min_deposit_amount : v0,
        };
        0x2::event::emit<VaultMinDepositAmountUpdateEvent>(v1);
    }

    public fun set_sub_trader<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: address, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(0x2::tx_context::sender(arg6) == arg2.trader, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        assert!(!is_closed<T0>(arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_closed());
        assert!(arg4 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg4 != arg2.trader, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_trader_address());
        assert!(arg4 != arg1.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_platform_operator());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg3, bank_account<T0>(arg2), arg4, arg5);
        let v0 = VaultSubAccountUpdateEvent{
            vault_id   : 0x2::object::uid_to_inner(&arg2.id),
            sub_trader : arg4,
            status     : arg5,
        };
        0x2::event::emit<VaultSubAccountUpdateEvent>(v0);
    }

    public fun set_trader<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &VaultConfig, arg2: &mut Vault<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg1.status == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_invalid_protocol_status());
        assert!(arg4 != @0x0 && arg4 != arg2.trader, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_trader_address());
        assert!(0x2::tx_context::sender(arg5) == arg2.creator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        assert!(arg2.trader != arg1.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_trader_address());
        assert!(arg4 != arg1.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_trader_address());
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg3, v0, arg4), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_trader_address());
        arg2.trader = arg4;
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::get_all_sub_accounts(arg3, v0);
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            if (v3 != arg1.operator) {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg3, v0, v3, false);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg3, v0, arg2.trader, true);
        let v4 = VaultTraderUpdateEvent{
            vault_id : 0x2::object::uid_to_inner(&arg2.id),
            trader   : arg4,
        };
        0x2::event::emit<VaultTraderUpdateEvent>(v4);
    }

    public fun set_vault_config_fee_pool(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut VaultConfig, arg3: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg3 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg3 != arg2.fee_pool, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
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
        assert!(arg3 <= 2592000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_lock_period_too_long());
        assert!(arg3 != arg2.lock_period_ms, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
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
        assert!(v0 != arg2.max_cap, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
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
        assert!(arg3 != @0x0 && arg3 != arg2.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_platform_operator());
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
        assert!((arg3 == 0 || arg3 == 1) && arg3 != arg2.status, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
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
        assert!(v0 != arg2.vault_creating_fee, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
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
        assert!(v0 <= 500000000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_withdrawal_filling_gas_fee_too_high());
        assert!(v0 != arg2.withdrawal_filling_gas_fee, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_status());
        arg2.withdrawal_filling_gas_fee = v0;
        let v1 = VaultConfigWithdrawalFillingGasFeeUpdateEvent{
            id                         : 0x2::object::uid_to_inner(&arg2.id),
            withdrawal_filling_gas_fee : v0,
        };
        0x2::event::emit<VaultConfigWithdrawalFillingGasFeeUpdateEvent>(v1);
    }

    public fun update_share_price<T0>(arg0: &mut Vault<T0>, arg1: VaultNAV, arg2: &0x2::clock::Clock) {
        abort 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::method_deprecated()
    }

    public fun update_share_price_v2<T0>(arg0: &mut Vault<T0>, arg1: VaultNAV, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.vault_id, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_mismatch());
        assert!(is_nav_filled(&arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_nav_not_filled());
        assert!(arg0.bank_id == 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_bank_id<T0>(arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::bank_mismatch());
        let VaultNAV {
            vault_id             : _,
            perpetuals           : _,
            position_values      : v2,
            total_position_vaule : v3,
            bank_balance         : v4,
        } = arg1;
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg2, bank_account<T0>(arg0)) == v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::vault_bank_balance_mismatch());
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
        assert!(0x2::tx_context::sender(arg5) == arg2.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unauthorized());
        assert!(arg4 != arg2.operator, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_platform_operator());
        let v0 = bank_account<T0>(arg3);
        assert!(arg4 != arg3.trader, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_platform_operator());
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg1, v0, arg4), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_platform_operator());
        assert!(arg2.operator != arg3.trader, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_platform_operator());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg1, v0, arg4, false);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::set_sub_account_internal(arg1, v0, arg2.operator, true);
    }

    // decompiled from Move bytecode v6
}

