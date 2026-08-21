module 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault {
    struct ALPHA_VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AlphaVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct RedemptionTreasuryWalletKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PasCustodyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PasCustodyState has store {
        account_id: 0x2::object::ID,
        managed_xaua: u128,
        xaua_dust: u128,
    }

    public fun accept_admin<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::accept_admin<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1);
    }

    public fun add_assessor<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::add_assessor<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun add_controller<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::add_controller<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun add_operator<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::add_operator<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun add_settler<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::add_settler<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun add_to_whitelist<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::add_to_whitelist<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    fun assert_native_custody<T0, T1>(arg0: &AlphaVault<T0, T1>) {
        assert!(!has_pas_custody<T0, T1>(arg0), 24);
    }

    fun assert_pas_account<T0>(arg0: &AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account) {
        let v0 = load_pas_custody<T0>(arg0);
        assert!(0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg1) == 0x2::object::uid_to_address(&arg0.id), 20);
        assert!(v0.account_id == 0x2::object::id<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account>(arg1), 20);
    }

    fun assert_pas_reserve<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pas_account<T0>(arg0, arg1);
        let v0 = load_pas_custody<T0>(arg0);
        let v1 = v0.managed_xaua + v0.xaua_dust;
        assert!(v1 <= 18446744073709551615, 21);
        if (v1 == 0) {
            return
        };
        let v2 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::new_auth_as_object(&mut arg0.id);
        let v3 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::unsafe_send_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, &v2, 0x2::object::uid_to_address(&arg0.id), (v1 as u64), arg4);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_transfer(arg2, &mut v3);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::resolve_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v3, arg3);
    }

    public fun batch<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: u64) : 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::Batch {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::batch<T0, T1>(load_inner<T0, T1>(arg0), arg1)
    }

    public fun batch_settlement_reference(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::Batch) : vector<u8> {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::batch_settlement_reference_bytes(arg0)
    }

    public fun batch_status(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::Batch) : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::batch_status(arg0)
    }

    public fun cancel_admin_transfer<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::cancel_admin_transfer<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1);
    }

    public fun cancel_redemption<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = has_pas_custody<T0, T1>(arg0);
        let v1 = load_inner_mut<T0, T1>(arg0);
        collect_redemption_cancellation_fee<T0, T1>(arg0, 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::cancel_redemption<T0, T1>(v1, arg1, arg2, arg3), v0);
    }

    public fun cancel_stale_redemption_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = has_pas_custody<T0, T1>(arg0);
        let v1 = load_inner_mut<T0, T1>(arg0);
        collect_redemption_cancellation_fee<T0, T1>(arg0, 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::cancel_stale_redemption_batch<T0, T1>(v1, arg1, arg2, arg3), v0);
    }

    public fun cancel_stale_subscription_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::cancel_stale_subscription_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    public fun cancel_subscription<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::cancel_subscription<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    public fun claim_usdc<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::claim_usdc<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    fun collect_redemption_cancellation_fee<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u128, arg2: bool) {
        if (arg1 == 0) {
            return
        };
        if (arg2) {
            let v0 = PasCustodyKey{dummy_field: false};
            let v1 = 0x2::dynamic_field::borrow_mut<PasCustodyKey, PasCustodyState>(&mut arg0.id, v0);
            assert!(v1.managed_xaua >= arg1, 22);
            v1.managed_xaua = v1.managed_xaua - arg1;
            v1.xaua_dust = v1.xaua_dust + arg1;
        } else {
            0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::collect_native_redemption_cancellation_fee<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1);
        };
    }

    public fun create_redemption_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::create_redemption_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3)
    }

    public fun create_subscription_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::create_subscription_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3)
    }

    public fun create_vault<T0, T1>(arg0: &AdminCap, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u128, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphaVault<T0, T1>{
            id    : 0x2::object::new(arg14),
            inner : 0x2::versioned::create<0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::AlphaVaultInner<T0, T1>>(2, new_inner<T0, T1>(0x2::tx_context::sender(arg14), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg14),
        };
        let v1 = RedemptionTreasuryWalletKey{dummy_field: false};
        0x2::dynamic_field::add<RedemptionTreasuryWalletKey, address>(&mut v0.id, v1, arg2);
        0x2::transfer::share_object<AlphaVault<T0, T1>>(v0);
    }

    public fun fee_balance<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::fee_balance<T0, T1>(load_inner<T0, T1>(arg0))
    }

    fun has_pas_custody<T0, T1>(arg0: &AlphaVault<T0, T1>) : bool {
        let v0 = PasCustodyKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<PasCustodyKey, PasCustodyState>(&arg0.id, v0)
    }

    fun init(arg0: ALPHA_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_xaua_pas_custody<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_admin_public<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(load_inner<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0), 0x2::tx_context::sender(arg2));
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_pas_initializable<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(load_inner<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0));
        assert!(0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg1) == 0x2::object::uid_to_address(&arg0.id), 20);
        let v0 = PasCustodyKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<PasCustodyKey, PasCustodyState>(&arg0.id, v0), 18);
        let v1 = PasCustodyState{
            account_id   : 0x2::object::id<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account>(arg1),
            managed_xaua : 0,
            xaua_dust    : 0,
        };
        0x2::dynamic_field::add<PasCustodyKey, PasCustodyState>(&mut arg0.id, v0, v1);
    }

    fun load_inner<T0, T1>(arg0: &AlphaVault<T0, T1>) : &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::AlphaVaultInner<T0, T1> {
        assert!(0x2::versioned::version(&arg0.inner) == 2, 25);
        0x2::versioned::load_value<0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::AlphaVaultInner<T0, T1>>(&arg0.inner)
    }

    fun load_inner_mut<T0, T1>(arg0: &mut AlphaVault<T0, T1>) : &mut 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::AlphaVaultInner<T0, T1> {
        assert!(0x2::versioned::version(&arg0.inner) == 2, 25);
        0x2::versioned::load_value_mut<0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::AlphaVaultInner<T0, T1>>(&mut arg0.inner)
    }

    fun load_pas_custody<T0>(arg0: &AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>) : &PasCustodyState {
        let v0 = PasCustodyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PasCustodyKey, PasCustodyState>(&arg0.id, v0), 19);
        0x2::dynamic_field::borrow<PasCustodyKey, PasCustodyState>(&arg0.id, v0)
    }

    fun load_pas_custody_mut<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>) : &mut PasCustodyState {
        let v0 = PasCustodyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PasCustodyKey, PasCustodyState>(&arg0.id, v0), 19);
        0x2::dynamic_field::borrow_mut<PasCustodyKey, PasCustodyState>(&mut arg0.id, v0)
    }

    fun new_inner<T0, T1>(arg0: address, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u128) : 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::AlphaVaultInner<T0, T1> {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, arg0);
        0x2::vec_set::insert<address>(&mut v1, arg0);
        0x2::vec_set::insert<address>(&mut v2, arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::new<T0, T1>(arg0, v0, v1, v2, 0x2::vec_set::empty<address>(), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun next_batch_id<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::next_batch_id<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun next_request_id<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::next_request_id<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun pause_operator_submission() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::pause_operator_submission()
    }

    public fun pause_redemptions() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::pause_redemptions()
    }

    public fun pause_subscriptions() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::pause_subscriptions()
    }

    public fun pending_admin<T0, T1>(arg0: &AlphaVault<T0, T1>) : 0x1::option::Option<address> {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::pending_admin<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun pending_redemption_ids<T0, T1>(arg0: &AlphaVault<T0, T1>) : vector<u64> {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::pending_redemption_ids<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun pending_subscription_ids<T0, T1>(arg0: &AlphaVault<T0, T1>) : vector<u64> {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::pending_subscription_ids<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun position<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: address) : 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::UserPosition {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::position<T0, T1>(load_inner<T0, T1>(arg0), arg1)
    }

    public fun position_available_shares(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::UserPosition) : u128 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::position_available_shares(arg0)
    }

    public fun position_claimable_usdc(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::UserPosition) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::position_claimable_usdc(arg0)
    }

    public fun position_locked_shares(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::UserPosition) : u128 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::position_locked_shares(arg0)
    }

    public fun position_pending_subscription_shares(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::UserPosition) : u128 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::position_pending_subscription_shares(arg0)
    }

    public fun position_total_claimed_usdc(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::UserPosition) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::position_total_claimed_usdc(arg0)
    }

    public fun prepare_redemption_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::prepare_redemption_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), v0, arg1, arg2, arg3);
    }

    public fun prepare_subscription_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::prepare_subscription_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), v0, arg1, arg2, arg3);
    }

    public fun processing_batch() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::processing_batch()
    }

    public fun processing_real_time() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::processing_real_time()
    }

    public fun prune_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::prune_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun prune_position<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::prune_position<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    public fun prune_redemption_request<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::prune_redemption_request<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun prune_subscription_request<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::prune_subscription_request<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun receive_and_finalize_realtime_redemption<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_settler_or_operator<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::finalize_realtime_redemption<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_finalize_realtime_subscription<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_native_custody<T0, T1>(arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_settler_or_operator<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T1>(0x2::balance::withdraw_funds_from_object<T1>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::finalize_realtime_subscription<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_finalize_redemption_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_operator_public<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::finalize_redemption_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_finalize_subscription_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_native_custody<T0, T1>(arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_operator_public<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T1>(0x2::balance::withdraw_funds_from_object<T1>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::finalize_subscription_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_finalize_xaua_pas_realtime_subscription<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let (v1, v2) = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::finalize_managed_realtime_subscription<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v0, arg4, arg5, arg6, arg7);
        let v3 = load_pas_custody_mut<T0>(arg0);
        v3.managed_xaua = v3.managed_xaua + v1;
        v3.xaua_dust = v3.xaua_dust + v2;
        assert_pas_reserve<T0>(arg0, arg1, arg2, arg3, arg7);
    }

    public fun receive_and_finalize_xaua_pas_subscription_batch<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let (v1, v2) = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::finalize_managed_subscription_batch<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v0, arg4, arg5, arg6, arg7);
        let v3 = load_pas_custody_mut<T0>(arg0);
        v3.managed_xaua = v3.managed_xaua + v1;
        v3.xaua_dust = v3.xaua_dust + v2;
        assert_pas_reserve<T0>(arg0, arg1, arg2, arg3, arg7);
    }

    public fun receive_and_refund_realtime_redemption<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_native_custody<T0, T1>(arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_settler_or_operator<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T1>(0x2::balance::withdraw_funds_from_object<T1>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::refund_realtime_redemption<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_refund_realtime_subscription<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_settler_or_operator<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::refund_realtime_subscription<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_refund_redemption_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_native_custody<T0, T1>(arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_operator_public<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T1>(0x2::balance::withdraw_funds_from_object<T1>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::refund_redemption_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_refund_subscription_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_operator_public<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2), arg4);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::refund_subscription_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, v0, arg3, arg4);
    }

    public fun receive_and_refund_xaua_pas_realtime_redemption<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let v1 = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::refund_managed_realtime_redemption<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v0, arg4, arg5, arg6, arg7);
        let v2 = load_pas_custody_mut<T0>(arg0);
        v2.managed_xaua = v2.managed_xaua + v1;
        assert_pas_reserve<T0>(arg0, arg1, arg2, arg3, arg7);
    }

    public fun receive_and_refund_xaua_pas_redemption_batch<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let v1 = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::refund_managed_redemption_batch<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v0, arg4, arg5, arg6, arg7);
        let v2 = load_pas_custody_mut<T0>(arg0);
        v2.managed_xaua = v2.managed_xaua + v1;
        assert_pas_reserve<T0>(arg0, arg1, arg2, arg3, arg7);
    }

    public fun redemption_fee_bps(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::RedemptionRequest) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::redemption_fee_bps(arg0)
    }

    public fun redemption_min_usdc_out(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::RedemptionRequest) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::redemption_min_usdc_out(arg0)
    }

    public fun redemption_request<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: u64) : 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::RedemptionRequest {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::redemption_request<T0, T1>(load_inner<T0, T1>(arg0), arg1)
    }

    public fun redemption_status(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::RedemptionRequest) : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::redemption_status(arg0)
    }

    public fun redemption_treasury_wallet<T0, T1>(arg0: &AlphaVault<T0, T1>) : address {
        let v0 = RedemptionTreasuryWalletKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RedemptionTreasuryWalletKey, address>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RedemptionTreasuryWalletKey, address>(&arg0.id, v0)
        } else {
            0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::issuer_treasury_wallet<T0, T1>(load_inner<T0, T1>(arg0))
        }
    }

    public fun remove_assessor<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::remove_assessor<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun remove_controller<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::remove_controller<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun remove_from_whitelist<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::remove_from_whitelist<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun remove_operator<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::remove_operator<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun remove_settler<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::remove_settler<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun request_redemption<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::request_redemption<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3, arg4)
    }

    public fun resolve_failed_realtime_redemption<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::resolve_failed_realtime_redemption<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    public fun resolve_failed_realtime_subscription<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::resolve_failed_realtime_subscription<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    fun send_pas_xaua<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_pas_account<T0>(arg0, arg1);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::new_auth_as_object(&mut arg0.id);
        let v1 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::unsafe_send_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, &v0, arg4, arg5, arg6);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_transfer(arg2, &mut v1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::resolve_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v1, arg3);
    }

    public fun set_fee_collector<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::set_fee_collector<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun set_fees<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::set_fees<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_issuer_treasury_wallet<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::set_issuer_treasury_wallet<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun set_limits<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::set_limits<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_pause_flags<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::set_pause_flags<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun set_real_time_window<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u32, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::set_real_time_window<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3);
    }

    public fun set_redemption_treasury_wallet<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_controller_public<T0, T1>(load_inner<T0, T1>(arg0), 0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x0, 23);
        let v0 = RedemptionTreasuryWalletKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RedemptionTreasuryWalletKey, address>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<RedemptionTreasuryWalletKey, address>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<RedemptionTreasuryWalletKey, address>(&mut arg0.id, v0, arg1);
        };
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::emit_config_updated(9);
    }

    public fun status_claimed() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::status_claimed()
    }

    public fun status_prepared() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::status_prepared()
    }

    public fun status_refunded() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::status_refunded()
    }

    public fun status_requested() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::status_requested()
    }

    public fun status_settled() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::status_settled()
    }

    public fun status_submitted() : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::status_submitted()
    }

    public fun submit_realtime_redemption<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_native_custody<T0, T1>(arg0);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = redemption_treasury_wallet<T0, T1>(arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submit_realtime_redemption<T0, T1>(load_inner_mut<T0, T1>(arg0), v0, arg1, v1, arg2, arg3);
    }

    public fun submit_realtime_subscription<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submit_realtime_subscription<T0, T1>(load_inner_mut<T0, T1>(arg0), v0, arg1, arg2, arg3);
    }

    public fun submit_redemption_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_native_custody<T0, T1>(arg0);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = redemption_treasury_wallet<T0, T1>(arg0);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submit_redemption_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), v0, arg1, v1, arg2, arg3);
    }

    public fun submit_subscription_batch<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submit_subscription_batch<T0, T1>(load_inner_mut<T0, T1>(arg0), v0, arg1, arg2, arg3);
    }

    public fun submit_xaua_pas_realtime_redemption<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = redemption_treasury_wallet<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let v2 = load_inner_mut<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let v3 = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submit_managed_realtime_redemption<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v2, v0, arg4, v1, arg5, arg6);
        let v4 = load_pas_custody_mut<T0>(arg0);
        assert!(v4.managed_xaua >= (v3 as u128), 22);
        v4.managed_xaua = v4.managed_xaua - (v3 as u128);
        send_pas_xaua<T0>(arg0, arg1, arg2, arg3, v1, v3, arg6);
    }

    public fun submit_xaua_pas_redemption_batch<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = redemption_treasury_wallet<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let v2 = load_inner_mut<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0);
        let v3 = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submit_managed_redemption_batch<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v2, v0, arg4, v1, arg5, arg6);
        let v4 = load_pas_custody_mut<T0>(arg0);
        assert!(v4.managed_xaua >= (v3 as u128), 22);
        v4.managed_xaua = v4.managed_xaua - (v3 as u128);
        send_pas_xaua<T0>(arg0, arg1, arg2, arg3, v1, v3, arg6);
    }

    public fun submitted_batch_ids<T0, T1>(arg0: &AlphaVault<T0, T1>) : vector<u64> {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::submitted_batch_ids<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun subscribe<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscribe<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun subscription_max_shares_out(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::SubscriptionRequest) : u128 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscription_max_shares_out(arg0)
    }

    public fun subscription_min_shares_out(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::SubscriptionRequest) : u128 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscription_min_shares_out(arg0)
    }

    public fun subscription_net_usdc(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::SubscriptionRequest) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscription_net_usdc(arg0)
    }

    public fun subscription_processing_mode(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::SubscriptionRequest) : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscription_processing_mode(arg0)
    }

    public fun subscription_request<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: u64) : 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::SubscriptionRequest {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscription_request<T0, T1>(load_inner<T0, T1>(arg0), arg1)
    }

    public fun subscription_status(arg0: &0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::SubscriptionRequest) : u8 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::subscription_status(arg0)
    }

    public fun transfer_admin<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::transfer_admin<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun usdc_balance<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::usdc_balance<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun usdc_dust_balance<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::usdc_dust_balance<T0, T1>(load_inner<T0, T1>(arg0))
    }

    public fun withdraw_dust<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::withdraw_dust<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1);
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::withdraw_fees<T0, T1>(load_inner_mut<T0, T1>(arg0), arg1);
    }

    public fun withdraw_xaua_pas_dust<T0>(arg0: &mut AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::assert_admin_public<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(load_inner<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::fee_collector<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(load_inner<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0));
        let v1 = load_pas_custody_mut<T0>(arg0);
        assert!(v1.xaua_dust <= 18446744073709551615, 21);
        let v2 = (v1.xaua_dust as u64);
        v1.xaua_dust = 0;
        if (v2 > 0) {
            send_pas_xaua<T0>(arg0, arg1, arg2, arg3, v0, v2, arg4);
        };
    }

    public fun xaua_balance<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        let v0 = PasCustodyKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_with_type<PasCustodyKey, PasCustodyState>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<PasCustodyKey, PasCustodyState>(&arg0.id, v0).managed_xaua
        } else {
            0
        };
        let v2 = (0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::xaua_balance<T0, T1>(load_inner<T0, T1>(arg0)) as u128) + v1;
        assert!(v2 <= 18446744073709551615, 21);
        (v2 as u64)
    }

    public fun xaua_dust_balance<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        let v0 = PasCustodyKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_with_type<PasCustodyKey, PasCustodyState>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<PasCustodyKey, PasCustodyState>(&arg0.id, v0).xaua_dust
        } else {
            0
        };
        let v2 = (0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner::xaua_dust_balance<T0, T1>(load_inner<T0, T1>(arg0)) as u128) + v1;
        assert!(v2 <= 18446744073709551615, 21);
        (v2 as u64)
    }

    public fun xaua_pas_account_id<T0>(arg0: &AlphaVault<T0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>) : 0x2::object::ID {
        load_pas_custody<T0>(arg0).account_id
    }

    // decompiled from Move bytecode v7
}

