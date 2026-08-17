module 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault {
    struct VaultAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultOperatorCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultDepositCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultTradeCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct ShareTransferCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        owner: address,
        allowed_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        quote: 0x2::balance::Balance<T0>,
        nav_quote_value: u64,
        deployed_quote_value: u64,
        aux_balances: 0x2::bag::Bag,
        pending_performance_fee: 0x2::balance::Balance<T0>,
        total_shares: u64,
        fee_recipient_pending_shares: u64,
        rewards: 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::RewardAccumulator,
        hwm_per_share_q6: u64,
        last_mgmt_fee_ts_sec: u64,
        buy_fee_window: 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::BuyFeeWindow,
        allowed_dex: 0x2::vec_set::VecSet<u8>,
        allowed_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        resell_royalty_bps: u64,
        allowed_strategy_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        setup_finalized: bool,
        paused: bool,
    }

    struct VaultShare<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        user_reward_state: 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::UserRewardState,
        cost_basis_per_share_q6: u64,
    }

    public fun id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_dex_allowed<T0>(arg0: &Vault<T0>, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg1)
    }

    public fun accrue_mgmt_fee<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg1, arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_fee());
        assert_active_vault<T0>(arg0, arg1, arg2);
        accrue_mgmt_fee_internal<T0>(arg0, arg1, arg3);
    }

    fun accrue_mgmt_fee_internal<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::compute_mgmt_fee_shares(arg0.total_shares, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_management_bps(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_config(arg1)), arg0.last_mgmt_fee_ts_sec, v0);
        if (v1 > 0) {
            arg0.total_shares = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.total_shares, v1);
            arg0.fee_recipient_pending_shares = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.fee_recipient_pending_shares, v1);
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_management_fee(0x2::object::uid_to_inner(&arg0.id), v1, arg0.total_shares, v0 - arg0.last_mgmt_fee_ts_sec);
        };
        arg0.last_mgmt_fee_ts_sec = v0;
    }

    public fun add_allowed_pool<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: 0x2::object::ID) {
        assert_admin<T0>(arg0, arg1);
        assert!(!arg0.setup_finalized, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::setup_already_finalized());
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_pools, arg2);
        };
    }

    public fun allow_strategy_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: 0x2::object::ID) {
        assert_admin<T0>(arg0, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_strategy_caps, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_strategy_caps, arg2);
        };
    }

    public fun apply_buy_fee_to_window<T0>(arg0: &mut Vault<T0>, arg1: &VaultOperatorCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg2, arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_fee());
        assert_active_vault<T0>(arg0, arg2, arg3);
        assert_operator<T0>(arg0, arg1);
        let v0 = arg0.nav_quote_value;
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::apply_buy_fee(&mut arg0.buy_fee_window, arg4, arg5, v0, arg6);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_buy_fee(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::with_defining_ids<T0>(), arg4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::window_period_used(&arg0.buy_fee_window), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::bps(v0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_buy_per_period_cap(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_config(arg2))));
    }

    public fun assert_active_vault<T0>(arg0: &Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_active(arg1, arg2);
        assert!(arg0.config_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        assert!(!arg0.paused, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused());
    }

    public fun assert_admin<T0>(arg0: &Vault<T0>, arg1: &VaultAdminCap<T0>) {
        assert_cap_in_list<T0>(arg0, 0x2::object::id<VaultAdminCap<T0>>(arg1), arg1.vault_id);
    }

    fun assert_cap_in_list<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(arg2 == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_deposit_cap<T0>(arg0: &Vault<T0>, arg1: &VaultDepositCap<T0>) {
        assert_cap_in_list<T0>(arg0, 0x2::object::id<VaultDepositCap<T0>>(arg1), arg1.vault_id);
    }

    public fun assert_operator<T0>(arg0: &Vault<T0>, arg1: &VaultOperatorCap<T0>) {
        assert_cap_in_list<T0>(arg0, 0x2::object::id<VaultOperatorCap<T0>>(arg1), arg1.vault_id);
    }

    public fun assert_trade_cap<T0>(arg0: &Vault<T0>, arg1: &VaultTradeCap<T0>) {
        assert_cap_in_list<T0>(arg0, 0x2::object::id<VaultTradeCap<T0>>(arg1), arg1.vault_id);
    }

    public fun assert_transfer_cap<T0>(arg0: &Vault<T0>, arg1: &ShareTransferCap<T0>) {
        assert_cap_in_list<T0>(arg0, 0x2::object::id<ShareTransferCap<T0>>(arg1), arg1.vault_id);
    }

    public fun aux_balance<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.aux_balances, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.aux_balances, v0))
        } else {
            0
        }
    }

    public fun buy_fee_window<T0>(arg0: &Vault<T0>) : &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::BuyFeeWindow {
        &arg0.buy_fee_window
    }

    public fun cap_in_allowlist<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1)
    }

    public fun claim_mgmt_fee_shares<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::ProtocolFeeCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : VaultShare<T0> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_not_paused(arg1, arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_fee());
        assert!(!arg0.paused, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_fee_cap(arg1, arg2);
        assert!(arg0.config_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        let v0 = arg0.fee_recipient_pending_shares;
        assert!(v0 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::zero_value());
        arg0.fee_recipient_pending_shares = 0;
        let v1 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::new_user_state();
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::deposit_shares(&mut arg0.rewards, &mut v1, v0);
        VaultShare<T0>{
            id                      : 0x2::object::new(arg4),
            vault_id                : 0x2::object::uid_to_inner(&arg0.id),
            owner                   : 0x2::tx_context::sender(arg4),
            shares                  : v0,
            user_reward_state       : v1,
            cost_basis_per_share_q6 : share_price_q6<T0>(arg0),
        }
    }

    public fun claim_reward<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64, arg3: &mut VaultShare<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg1, arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_reward());
        assert!(!arg0.paused, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused());
        assert!(arg3.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        assert!(arg3.owner == 0x2::tx_context::sender(arg4), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::share_owner_mismatch());
        0x2::coin::from_balance<T1>(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::claim<T1>(&mut arg0.rewards, &mut arg3.user_reward_state), arg4)
    }

    public fun collect_performance_fee<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::ProtocolFeeCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_not_paused(arg1, arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_fee());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_fee_cap(arg1, arg2);
        assert!(arg0.config_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pending_performance_fee, 0x2::balance::value<T0>(&arg0.pending_performance_fee)), arg4)
    }

    public fun config_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun create<T0>(arg0: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (VaultAdminCap<T0>, VaultOperatorCap<T0>) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_governance_active(arg0, arg1);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = VaultAdminCap<T0>{
            id       : 0x2::object::new(arg4),
            vault_id : v1,
        };
        let v3 = VaultOperatorCap<T0>{
            id       : 0x2::object::new(arg4),
            vault_id : v1,
        };
        let v4 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v4, 0x2::object::id<VaultAdminCap<T0>>(&v2));
        0x2::vec_set::insert<0x2::object::ID>(&mut v4, 0x2::object::id<VaultOperatorCap<T0>>(&v3));
        let v5 = 0x2::vec_set::empty<u8>();
        0x2::vec_set::insert<u8>(&mut v5, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::dex_deepbook());
        let v6 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_config(arg0);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        let v8 = Vault<T0>{
            id                           : v0,
            config_id                    : 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg0),
            owner                        : 0x2::tx_context::sender(arg4),
            allowed_caps                 : v4,
            quote                        : 0x2::balance::zero<T0>(),
            nav_quote_value              : 0,
            deployed_quote_value         : 0,
            aux_balances                 : 0x2::bag::new(arg4),
            pending_performance_fee      : 0x2::balance::zero<T0>(),
            total_shares                 : 0,
            fee_recipient_pending_shares : 0,
            rewards                      : 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::new(arg4),
            hwm_per_share_q6             : 0,
            last_mgmt_fee_ts_sec         : v7 / 1000,
            buy_fee_window               : 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::new_buy_fee_window(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_buy_period_ms(v6), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_buy_per_period_cap(v6), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_buy_per_trade_cap(v6), v7),
            allowed_dex                  : v5,
            allowed_pools                : 0x2::vec_set::empty<0x2::object::ID>(),
            resell_royalty_bps           : 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_resell_royalty_bps(v6),
            allowed_strategy_caps        : 0x2::vec_set::empty<0x2::object::ID>(),
            setup_finalized              : false,
            paused                       : false,
        };
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_vault_created(v1, 0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg4));
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_minted(v1, 0x2::object::id<VaultAdminCap<T0>>(&v2), 0);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_minted(v1, 0x2::object::id<VaultOperatorCap<T0>>(&v3), 0);
        0x2::transfer::share_object<Vault<T0>>(v8);
        (v2, v3)
    }

    public fun deployed_quote_value<T0>(arg0: &Vault<T0>) : u64 {
        arg0.deployed_quote_value
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VaultShare<T0> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg1, arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_deposit());
        assert_active_vault<T0>(arg0, arg1, arg2);
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::direct_deposit_enabled(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::direct_deposit_disabled());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::risk::assert_deposit_size(0x2::coin::value<T0>(&arg3), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_max_deposit_per_tx(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_config(arg1)));
        do_deposit<T0>(arg0, arg1, arg3, false, arg4, arg5)
    }

    public fun deposit_into_share<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64, arg3: &mut VaultShare<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_active_vault<T0>(arg0, arg1, arg2);
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::direct_deposit_enabled(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::direct_deposit_disabled());
        assert!(arg3.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        assert!(arg3.owner == 0x2::tx_context::sender(arg6), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::share_owner_mismatch());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::risk::assert_deposit_size(0x2::coin::value<T0>(&arg4), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_max_deposit_per_tx(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_config(arg1)));
        do_deposit_into_share<T0>(arg0, arg1, arg3, arg4, false, arg5, arg6);
    }

    public fun deposit_into_share_with_cap<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: &VaultDepositCap<T0>, arg3: u64, arg4: &mut VaultShare<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_active_vault<T0>(arg0, arg1, arg3);
        assert_deposit_cap<T0>(arg0, arg2);
        assert!(arg4.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::risk::assert_deposit_size(0x2::coin::value<T0>(&arg5), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_max_deposit_per_tx(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_config(arg1)));
        do_deposit_into_share<T0>(arg0, arg1, arg4, arg5, true, arg6, arg7);
    }

    public fun deposit_with_cap<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: &VaultDepositCap<T0>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VaultShare<T0> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg1, arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_deposit());
        assert_active_vault<T0>(arg0, arg1, arg3);
        assert_deposit_cap<T0>(arg0, arg2);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::risk::assert_deposit_size(0x2::coin::value<T0>(&arg4), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_max_deposit_per_tx(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_config(arg1)));
        do_deposit<T0>(arg0, arg1, arg4, true, arg5, arg6)
    }

    public fun disable_vault_dex<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: u8) {
        assert_admin<T0>(arg0, arg1);
        if (0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg2)) {
            0x2::vec_set::remove<u8>(&mut arg0.allowed_dex, &arg2);
        };
    }

    public fun disallow_strategy_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: 0x2::object::ID) {
        assert_admin<T0>(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_strategy_caps, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_strategy_caps, &arg2);
        };
    }

    fun do_deposit<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VaultShare<T0> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::zero_value());
        accrue_mgmt_fee_internal<T0>(arg0, arg1, arg4);
        let v1 = arg0.nav_quote_value;
        let v2 = if (arg0.total_shares == 0) {
            assert!(v0 >= 1000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bootstrap_too_small());
            v0
        } else {
            assert!(v1 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_share_amount());
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::mul_div(v0, arg0.total_shares, v1)
        };
        assert!(v2 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_share_amount());
        let v3 = if (arg0.total_shares == 0) {
            1000000
        } else {
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::mul_div_ceil(v0, 1000000, v2)
        };
        0x2::balance::join<T0>(&mut arg0.quote, 0x2::coin::into_balance<T0>(arg2));
        arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.nav_quote_value, v0);
        let v4 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::new_user_state();
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::deposit_shares(&mut arg0.rewards, &mut v4, v2);
        let v5 = VaultShare<T0>{
            id                      : 0x2::object::new(arg5),
            vault_id                : 0x2::object::uid_to_inner(&arg0.id),
            owner                   : 0x2::tx_context::sender(arg5),
            shares                  : v2,
            user_reward_state       : v4,
            cost_basis_per_share_q6 : v3,
        };
        arg0.total_shares = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.total_shares, v2);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_deposit(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg5), 0x1::type_name::with_defining_ids<T0>(), v0, v2, arg3);
        v5
    }

    fun do_deposit_into_share<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: &mut VaultShare<T0>, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::zero_value());
        accrue_mgmt_fee_internal<T0>(arg0, arg1, arg5);
        let v1 = arg0.nav_quote_value;
        assert!(arg0.total_shares > 0 && v1 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_share_amount());
        let v2 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::mul_div(v0, arg0.total_shares, v1);
        assert!(v2 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_share_amount());
        0x2::balance::join<T0>(&mut arg0.quote, 0x2::coin::into_balance<T0>(arg3));
        arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.nav_quote_value, v0);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::deposit_shares(&mut arg0.rewards, &mut arg2.user_reward_state, v2);
        arg2.shares = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg2.shares, v2);
        arg2.cost_basis_per_share_q6 = weighted_cost_basis(arg2.shares, arg2.cost_basis_per_share_q6, v2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::mul_div_ceil(v0, 1000000, v2));
        arg0.total_shares = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.total_shares, v2);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_deposit(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg6), 0x1::type_name::with_defining_ids<T0>(), v0, v2, arg4);
    }

    public fun enable_vault_dex<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u8) {
        assert_admin<T0>(arg0, arg1);
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::is_dex_allowed(arg2, arg3), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::dex_not_allowed());
        if (!0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg3)) {
            0x2::vec_set::insert<u8>(&mut arg0.allowed_dex, arg3);
        };
    }

    public fun fee_recipient_pending_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fee_recipient_pending_shares
    }

    public fun finalize_vault_setup<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) {
        assert_admin<T0>(arg0, arg1);
        assert!(!arg0.setup_finalized, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::setup_already_finalized());
        arg0.setup_finalized = true;
    }

    public fun hwm_per_share<T0>(arg0: &Vault<T0>) : u64 {
        arg0.hwm_per_share_q6
    }

    public fun is_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.paused
    }

    public fun is_pool_allowed<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg1)
    }

    public fun is_strategy_cap_allowed<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_strategy_caps, &arg1)
    }

    public fun min_bootstrap_quote() : u64 {
        1000
    }

    public fun mint_deposit_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : VaultDepositCap<T0> {
        assert_admin<T0>(arg0, arg1);
        let v0 = VaultDepositCap<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<VaultDepositCap<T0>>(&v0));
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_minted(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<VaultDepositCap<T0>>(&v0), (12 as u64));
        v0
    }

    public fun mint_operator_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : VaultOperatorCap<T0> {
        assert_admin<T0>(arg0, arg1);
        let v0 = VaultOperatorCap<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<VaultOperatorCap<T0>>(&v0));
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_minted(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<VaultOperatorCap<T0>>(&v0), (11 as u64));
        v0
    }

    public fun mint_trade_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : VaultTradeCap<T0> {
        assert_admin<T0>(arg0, arg1);
        let v0 = VaultTradeCap<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<VaultTradeCap<T0>>(&v0));
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_minted(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<VaultTradeCap<T0>>(&v0), (13 as u64));
        v0
    }

    public fun mint_transfer_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : ShareTransferCap<T0> {
        assert_admin<T0>(arg0, arg1);
        let v0 = ShareTransferCap<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<ShareTransferCap<T0>>(&v0));
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_minted(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<ShareTransferCap<T0>>(&v0), (14 as u64));
        v0
    }

    public fun nav_quote_value<T0>(arg0: &Vault<T0>) : u64 {
        arg0.nav_quote_value
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun pending_performance_fee_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pending_performance_fee)
    }

    public(friend) fun put_aux<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.aux_balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.aux_balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.aux_balances, v0, arg1);
        };
    }

    public(friend) fun put_deployed_quote<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::min(v0, arg0.deployed_quote_value);
        let v2 = v0 - v1;
        arg0.deployed_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.deployed_quote_value, v1);
        if (v2 > 0) {
            arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.nav_quote_value, v2);
        };
        0x2::balance::join<T0>(&mut arg0.quote, arg1);
    }

    public(friend) fun put_quote<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.quote, arg1);
        arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.nav_quote_value, 0x2::balance::value<T0>(&arg1));
    }

    public fun quote_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.quote)
    }

    public fun remove_allowed_pool<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: 0x2::object::ID) {
        assert_admin<T0>(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_pools, &arg2);
        };
    }

    public fun resell_royalty_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.resell_royalty_bps
    }

    public fun resell_share<T0>(arg0: &mut Vault<T0>, arg1: &ShareTransferCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: VaultShare<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg2, arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_share_transfer());
        assert_active_vault<T0>(arg0, arg2, arg3);
        assert_transfer_cap<T0>(arg0, arg1);
        assert!(arg4.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        assert!(0x2::coin::value<T0>(&arg5) >= arg6, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        let v0 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::bps(arg6, arg0.resell_royalty_bps);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg0.pending_performance_fee, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v0, arg8)));
        };
        arg4.owner = arg7;
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_transferred(0x2::object::uid_to_inner(&arg0.id), 0x2::object::uid_to_inner(&arg4.id), arg4.owner, arg7, v0);
        0x2::transfer::public_transfer<VaultShare<T0>>(arg4, arg7);
        arg5
    }

    public fun revoke_cap<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: 0x2::object::ID) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x2::object::id<VaultAdminCap<T0>>(arg1) != arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_already_in_list());
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_not_in_allowlist());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_caps, &arg2);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_cap_revoked(0x2::object::uid_to_inner(&arg0.id), arg2);
    }

    public fun set_paused<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun set_resell_royalty_bps<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: u64) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg2 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_fee_bps());
        arg0.resell_royalty_bps = arg2;
    }

    public fun setup_finalized<T0>(arg0: &Vault<T0>) : bool {
        arg0.setup_finalized
    }

    public fun share_amount<T0>(arg0: &VaultShare<T0>) : u64 {
        arg0.shares
    }

    public fun share_cost_basis<T0>(arg0: &VaultShare<T0>) : u64 {
        arg0.cost_basis_per_share_q6
    }

    public fun share_id<T0>(arg0: &VaultShare<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun share_owner<T0>(arg0: &VaultShare<T0>) : address {
        arg0.owner
    }

    public fun share_pending_reward<T0, T1>(arg0: &VaultShare<T0>, arg1: &Vault<T0>) : u64 {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::pending_reward<T1>(&arg1.rewards, &arg0.user_reward_state)
    }

    public fun share_price_q6<T0>(arg0: &Vault<T0>) : u64 {
        if (arg0.total_shares == 0) {
            return 1000000
        };
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::mul_div(arg0.nav_quote_value, 1000000, arg0.total_shares)
    }

    public fun share_price_scale() : u64 {
        1000000
    }

    public fun share_vault_id<T0>(arg0: &VaultShare<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun strategy_put_aux<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        put_aux<T0, T1>(arg0, arg1);
    }

    public(friend) fun strategy_put_quote<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.quote, arg1);
    }

    public(friend) fun strategy_settle_principal<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64) {
        arg0.deployed_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.deployed_quote_value, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::min(arg1, arg0.deployed_quote_value));
        if (arg2 > arg1) {
            arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.nav_quote_value, arg2 - arg1);
        } else if (arg2 < arg1) {
            let v0 = arg1 - arg2;
            assert!(arg0.nav_quote_value >= v0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::boost_nav_shortfall());
            arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.nav_quote_value, v0);
        };
    }

    public(friend) fun strategy_take_aux<T0, T1>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T1> {
        assert!(arg1 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::zero_value());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.aux_balances, v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.aux_balances, v0);
        assert!(0x2::balance::value<T1>(v1) >= arg1, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        arg0.deployed_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.deployed_quote_value, arg2);
        0x2::balance::split<T1>(v1, arg1)
    }

    public(friend) fun strategy_take_quote<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::zero_value());
        assert!(0x2::balance::value<T0>(&arg0.quote) >= arg1, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        arg0.deployed_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.deployed_quote_value, arg1);
        0x2::balance::split<T0>(&mut arg0.quote, arg1)
    }

    public fun take_aux<T0, T1>(arg0: &mut Vault<T0>, arg1: &VaultOperatorCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64) : 0x2::balance::Balance<T1> {
        assert_active_vault<T0>(arg0, arg2, arg3);
        assert_operator<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.aux_balances, v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.aux_balances, v0);
        assert!(0x2::balance::value<T1>(v1) >= arg4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        0x2::balance::split<T1>(v1, arg4)
    }

    public fun take_quote<T0>(arg0: &mut Vault<T0>, arg1: &VaultOperatorCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64) : 0x2::balance::Balance<T0> {
        assert_active_vault<T0>(arg0, arg2, arg3);
        assert_operator<T0>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.quote) >= arg4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        arg0.deployed_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.deployed_quote_value, arg4);
        0x2::balance::split<T0>(&mut arg0.quote, arg4)
    }

    public fun top_up_reward<T0, T1>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: 0x2::coin::Coin<T1>) {
        assert_admin<T0>(arg0, arg1);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::top_up<T1>(&mut arg0.rewards, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun transfer_share<T0>(arg0: &mut Vault<T0>, arg1: &ShareTransferCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: VaultShare<T0>, arg5: address) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg2, arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_share_transfer());
        assert_transfer_cap<T0>(arg0, arg1);
        assert!(arg4.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        arg4.owner = arg5;
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_share_transferred(0x2::object::uid_to_inner(&arg0.id), 0x2::object::uid_to_inner(&arg4.id), arg4.owner, arg5, 0);
        0x2::transfer::public_transfer<VaultShare<T0>>(arg4, arg5);
    }

    fun weighted_cost_basis(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0, arg2);
        let v1 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) * (arg3 as u128) + (v0 as u128) - 1) / (v0 as u128);
        assert!(v1 <= 18446744073709551615, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::overflow());
        (v1 as u64)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64, arg3: &mut VaultShare<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_not_paused(arg1, arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_withdraw());
        assert!(!arg0.paused, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused());
        assert!(arg3.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        assert!(arg3.owner == 0x2::tx_context::sender(arg6), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::share_owner_mismatch());
        assert!(arg4 > 0 && arg4 <= arg3.shares, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_shares());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::risk::assert_withdraw_size(arg4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_max_withdraw_per_tx(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::risk_config(arg1)));
        accrue_mgmt_fee_internal<T0>(arg0, arg1, arg5);
        let v0 = share_price_q6<T0>(arg0);
        let v1 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::compute_performance_fee(arg4, v0, arg3.cost_basis_per_share_q6, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_performance_bps(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::fee_config(arg1)));
        let v2 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::mul_div(arg4, v0, 1000000);
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            v2
        };
        assert!(0x2::balance::value<T0>(&arg0.quote) >= v2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::reward_accumulator::withdraw_shares(&mut arg0.rewards, &mut arg3.user_reward_state, arg4);
        arg3.shares = arg3.shares - arg4;
        arg0.total_shares = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.total_shares, arg4);
        arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.nav_quote_value, v2);
        0x2::balance::join<T0>(&mut arg0.pending_performance_fee, 0x2::balance::split<T0>(&mut arg0.quote, v1));
        if (v1 > 0) {
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::fees::bump_hwm(&mut arg0.hwm_per_share_q6, v0);
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_performance_fee(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::with_defining_ids<T0>(), v1);
        };
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_withdraw(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg6), 0x1::type_name::with_defining_ids<T0>(), v3, arg4, v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.quote, v3), arg6)
    }

    public fun write_down_deployed_quote<T0>(arg0: &mut Vault<T0>, arg1: &VaultOperatorCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64) {
        assert_active_vault<T0>(arg0, arg2, arg3);
        assert_operator<T0>(arg0, arg1);
        assert!(arg0.deployed_quote_value >= arg4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        assert!(arg0.nav_quote_value >= arg4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::insufficient_balance());
        arg0.deployed_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.deployed_quote_value, arg4);
        arg0.nav_quote_value = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::sub(arg0.nav_quote_value, arg4);
    }

    // decompiled from Move bytecode v7
}

