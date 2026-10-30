module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault {
    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MgmtFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        roles: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::Roles,
        decimals: u8,
        idle: 0x2::balance::Balance<T0>,
        deployed_aum: u64,
        total_collectable_fees: u64,
        min_deposit: u64,
        deposit_cap: u64,
        max_deposit_amount: u64,
        max_withdrawal_amount: u64,
        aum_limits: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::AumLimits,
        paused: bool,
        subaccounts: 0x2::table::Table<address, bool>,
        subaccount_count: u64,
        queue_attached: bool,
        cooldown_ms: u64,
        fulfillment_window_ms: u64,
        pending_requests: u64,
        pending_shares: u64,
        fee_state: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::FeeState,
        timelock_delay_ms: u64,
    }

    public fun total_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(borrow_treasury_cap<T0, T1>(arg0))
    }

    public fun decimals<T0, T1>(arg0: &Vault<T0, T1>) : u8 {
        arg0.decimals
    }

    public fun derive_address<T0>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry) : address {
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<VaultKey<T0>>(0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry>(arg0), v0)
    }

    public(friend) fun new<T0, T1: key>(arg0: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x2::coin_registry::MetadataCap<T1>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::VaultCreatorRole>, arg6: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::VaultParams, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg0);
        let v0 = 0x2::coin_registry::decimals<T1>(arg4);
        assert!(0x2::coin_registry::decimals<T0>(arg3) == v0, 13835058944340721670);
        assert!(v0 <= 18, 13844629097848307786);
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 13835340427907497992);
        assert!(!0x2::coin_registry::is_regulated<T1>(arg4), 13844066160779526214);
        let v1 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::owner(&arg6);
        assert!(v1 != derive_address<T1>(arg0) && v1 != 0x2::object::id_address<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry>(arg0), 13844347657231204424);
        assert_cooldown(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::cooldown_ms(&arg6));
        assert_fulfillment_window(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::fulfillment_window_ms(&arg6));
        assert_timelock_delay(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::timelock_delay_ms(&arg6));
        assert_transaction_limits(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::max_deposit_amount(&arg6), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::max_withdrawal_amount(&arg6));
        let v2 = VaultKey<T1>{dummy_field: false};
        let v3 = 0x2::derived_object::claim<VaultKey<T1>>(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::uid_mut(arg0), v2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T1>>(&mut v3, v5, arg1);
        let v6 = MetadataCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<MetadataCapKey, 0x2::coin_registry::MetadataCap<T1>>(&mut v3, v6, arg2);
        let v7 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::new(0x1::option::some<address>(v1), arg8);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_vault_created<T0, T1>(v4, v1);
        let v8 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::operators(&arg6);
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(v8)) {
            let v10 = 0x1::vector::borrow<address>(v8, v9);
            if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::grant<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>(&mut v7, *v10)) {
                0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_granted(v4, 0x1::type_name::with_original_ids<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>(), *v10);
            };
            v9 = v9 + 1;
        };
        let v11 = Vault<T0, T1>{
            id                     : v3,
            roles                  : v7,
            decimals               : v0,
            idle                   : 0x2::balance::zero<T0>(),
            deployed_aum           : 0,
            total_collectable_fees : 0,
            min_deposit            : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::min_deposit(&arg6),
            deposit_cap            : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::deposit_cap(&arg6),
            max_deposit_amount     : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::max_deposit_amount(&arg6),
            max_withdrawal_amount  : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::max_withdrawal_amount(&arg6),
            aum_limits             : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::new(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::aum_increase_limit_bps(&arg6), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::aum_decrease_limit_bps(&arg6)),
            paused                 : false,
            subaccounts            : 0x2::table::new<address, bool>(arg8),
            subaccount_count       : 0,
            queue_attached         : false,
            cooldown_ms            : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::cooldown_ms(&arg6),
            fulfillment_window_ms  : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::fulfillment_window_ms(&arg6),
            pending_requests       : 0,
            pending_shares         : 0,
            fee_state              : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::new_state(*0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::fees(&arg6), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::share_price(0, 0, v0), 0x2::clock::timestamp_ms(arg7)),
            timelock_delay_ms      : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params::timelock_delay_ms(&arg6),
        };
        assert_fee_recipients<T0, T1>(&v11, arg0, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::fee_collectors(&v11.fee_state));
        assert_fee_recipients<T0, T1>(&v11, arg0, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::performance_fee_recipients(&v11.fee_state));
        v11
    }

    public fun aum_limits<T0, T1>(arg0: &Vault<T0, T1>) : &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::AumLimits {
        &arg0.aum_limits
    }

    public fun auth<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x2::tx_context::TxContext) : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, T2> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::new<T1, T2>(&arg0.roles, 0x2::tx_context::sender(arg2))
    }

    fun accrue_management_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::accrue_management_fee(&mut arg0.fee_state, net_assets<T0, T1>(arg0), v0);
        if (v1 == 0) {
            return
        };
        arg0.total_collectable_fees = arg0.total_collectable_fees + v1;
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_management_fee_charged<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v1, v0, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    public(friend) fun is_listed<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        let v0 = allocation<T0, T1>(arg0, arg1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::is_listed(&v0)
    }

    public fun roles<T0, T1>(arg0: &Vault<T0, T1>) : &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::Roles {
        &arg0.roles
    }

    public fun accept_owner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::accept_owner(&mut arg0.roles, v0, 0x2::clock::timestamp_ms(arg2));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_owner_accepted<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::option::destroy_some<address>(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::owner(&arg0.roles)), v0);
    }

    public fun cancel_owner_nomination<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::cancel_owner_nomination(&mut arg0.roles);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_owner_nomination_cancelled<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::nominee(&v0));
    }

    public fun nominate_owner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address, arg4: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::nominate_owner(&mut arg0.roles, arg3, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x1::option::destroy_some<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerNomination>(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::pending_owner(&arg0.roles));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_owner_nominated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::expires_at_ms(&v0));
    }

    public fun share_price<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry) : u128 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::share_price(net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0), arg0.decimals)
    }

    public fun total_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry) : u128 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        net_assets<T0, T1>(arg0)
    }

    public(friend) fun allocation<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::Allocation {
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::allocation_key(arg1);
        if (0x2::dynamic_field::exists<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::AllocationKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::AllocationKey, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::Allocation>(&arg0.id, v0)
        } else {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::new_allocation(0, 0)
        }
    }

    fun assert_coin_vault<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(!is_pas<T0, T1>(arg0), 13845479454128668752);
    }

    fun assert_cooldown(arg0: u64) {
        assert!(arg0 <= 2592000000, 13835627692500254730);
    }

    fun assert_fee_recipients<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &vector<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>) {
        assert!(!0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::contains_address(arg2, 0x2::object::uid_to_address(&arg0.id)) && !0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::contains_address(arg2, 0x2::object::id_address<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry>(arg1)), 13842664682885414972);
    }

    fun assert_fulfillment_window(arg0: u64) {
        assert!(arg0 <= 7776000000, 13835909188951932940);
    }

    public(friend) fun assert_listed<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(is_listed<T0, T1>(arg0, arg1), 13845197815943069774);
    }

    fun assert_own_request<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>) {
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::vault_id<T1>(arg1) == 0x2::object::uid_to_inner(&arg0.id), 13843790642922324036);
    }

    fun assert_timelock_delay(arg0: u64) {
        assert!(arg0 <= 2592000000, 13842946080552845374);
    }

    fun assert_transaction_limits(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg1 > 0, 13843509051981365314);
    }

    fun assets_for<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::assets_for_redemption(arg1, total_supply<T0, T1>(arg0), net_assets<T0, T1>(arg0))
    }

    public(friend) fun attach_policy_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<T1>>) {
        0x2::dynamic_object_field::add<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::PolicyCapKey, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<T1>>>(&mut arg0.id, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::policy_cap_key(), arg1);
    }

    public fun attach_withdrawal_queue<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (!arg0.queue_attached) {
            arg0.queue_attached = true;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_queue_attached<T0, T1>(0x2::object::uid_to_inner(&arg0.id));
        };
    }

    fun borrow_metadata_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::coin_registry::MetadataCap<T1> {
        let v0 = MetadataCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<MetadataCapKey, 0x2::coin_registry::MetadataCap<T1>>(&arg0.id, v0)
    }

    fun borrow_treasury_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::coin::TreasuryCap<T1> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T1>>(&arg0.id, v0)
    }

    fun borrow_treasury_cap_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::coin::TreasuryCap<T1> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T1>>(&mut arg0.id, v0)
    }

    public fun cancel_management_fee_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = MgmtFeeKey{dummy_field: false};
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_change_cancelled<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"management_fee"), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::cancel<MgmtFeeKey, u64>(&mut arg0.id, v0));
    }

    public(friend) fun cancel_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: address) : 0x2::balance::Balance<T1> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_own_request<T0, T1>(arg0, &arg2);
        assert!(arg3 == 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(&arg2), 13839848301029425192);
        close_request_with_event<T0, T1>(arg0, arg2)
    }

    public(friend) fun cancel_withdrawal_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_coin_vault<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(cancel_withdrawal<T0, T1>(arg0, arg1, arg2, 0x2::tx_context::sender(arg3)), arg3)
    }

    public fun charge_management_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        accrue_management_fee<T0, T1>(arg0, arg2);
    }

    public fun charge_performance_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = *0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::performance_fee_recipients(&arg0.fee_state);
        let v2 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::split_performance_fee(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::crystallize_performance_fee(&mut arg0.fee_state, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0), arg0.decimals, v0), &v1);
        let v3 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::total(&v2);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.idle), 13838720524221349920);
        pay_from_idle<T0, T1>(arg0, v1, v2);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_performance_fee_charged<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v3, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::high_watermark(&arg0.fee_state), v0, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    fun close_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.pending_requests = arg0.pending_requests - 1;
        arg0.pending_shares = arg0.pending_shares - arg1;
    }

    fun close_request_with_event<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>) : 0x2::balance::Balance<T1> {
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::destroy<T1>(arg1);
        close_request<T0, T1>(arg0, 0x2::balance::value<T1>(&v0));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_withdrawal_cancelled<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>>(&arg1), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(&arg1), 0x2::balance::value<T1>(&v0), net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
        v0
    }

    public(friend) fun close_seized_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>) : 0x2::balance::Balance<T1> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_own_request<T0, T1>(arg0, &arg2);
        close_request_with_event<T0, T1>(arg0, arg2)
    }

    public fun collect_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = *0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::fee_collectors(&arg0.fee_state);
        assert!(!0x1::vector::is_empty<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>(&v0), 13842379780524671034);
        let v1 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::split_fee(arg0.total_collectable_fees, &v0);
        let v2 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::total(&v1);
        if (v2 == 0) {
            return
        };
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.idle), 13838720623005597728);
        arg0.total_collectable_fees = arg0.total_collectable_fees - v2;
        pay_from_idle<T0, T1>(arg0, v0, v1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_fees_collected<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v2, arg0.total_collectable_fees, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    public fun cooldown_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.cooldown_ms
    }

    fun covers_collectable_fees<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        (arg0.total_collectable_fees as u128) <= (0x2::balance::value<T0>(&arg0.idle) as u128) + (arg0.deployed_aum as u128)
    }

    public fun deployed_aum<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.deployed_aum
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: address, arg5: u64) : 0x2::balance::Balance<T1> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(!arg0.paused, 13836188460610551822);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 >= arg0.min_deposit, 13836469944177328144);
        assert!(v0 <= arg0.max_deposit_amount, 13836751423449137170);
        assert!(net_assets<T0, T1>(arg0) + (v0 as u128) <= (arg0.deposit_cap as u128), 13837032911310880788);
        let v1 = shares_for<T0, T1>(arg0, v0);
        if (total_supply<T0, T1>(arg0) == 0) {
            assert!(covers_collectable_fees<T0, T1>(arg0), 13843225386571202624);
            let v2 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::share_price(0, 0, arg0.decimals);
            let v3 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::high_watermark(&arg0.fee_state);
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::reset_high_watermark(&mut arg0.fee_state, v2);
            if (v3 != v2) {
                0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_high_watermark_reset<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v3, v2);
            };
        };
        assert!(v1 >= arg5, 13837314467892101142);
        assert!(v1 > 0, 13837595947163910168);
        if (is_pas<T0, T1>(arg0)) {
            let v4 = allocation<T0, T1>(arg0, arg4);
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::record_deposit(&mut v4, v0, arg0.deposit_cap);
            set_allocation<T0, T1>(arg0, arg4, v4);
        };
        0x2::balance::join<T0>(&mut arg0.idle, arg2);
        let v5 = borrow_treasury_cap_mut<T0, T1>(arg0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_deposited<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3, arg4, v0, v1, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
        0x2::coin::mint_balance<T1>(v5, v1)
    }

    public fun deposit_cap<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.deposit_cap
    }

    public(friend) fun deposit_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_coin_vault<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(deposit<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::tx_context::sender(arg4), 0x2::tx_context::sender(arg4), arg3), arg4)
    }

    public fun deregister_subaccount<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x2::table::contains<address, bool>(&arg0.subaccounts, arg3)) {
            0x2::table::remove<address, bool>(&mut arg0.subaccounts, arg3);
            arg0.subaccount_count = arg0.subaccount_count - 1;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_subaccount_deregistered<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3);
        };
    }

    public fun detach_withdrawal_queue<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (arg0.queue_attached) {
            arg0.queue_attached = false;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_queue_detached<T0, T1>(0x2::object::uid_to_inner(&arg0.id));
        };
    }

    public fun execute_management_fee_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = MgmtFeeKey{dummy_field: false};
        let v1 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::execute<MgmtFeeKey, u64>(&mut arg0.id, v0, arg3);
        accrue_management_fee<T0, T1>(arg0, arg3);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::set_management_fee_bps(&mut arg0.fee_state, v1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_change_executed<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"management_fee"), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::management_fee_bps(&arg0.fee_state), v1);
    }

    fun expedite<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_own_request<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::expedite<T1>(arg2, v0);
        if (0x1::option::is_some<u64>(&v1)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_withdrawal_expedited<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>>(arg2), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(arg2), 0x1::option::destroy_some<u64>(v1), v0);
        } else {
            0x1::option::destroy_none<u64>(v1);
        };
    }

    public fun expedite_withdrawal<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg4: &0x2::clock::Clock) {
        expedite<T0, T1>(arg0, arg1, arg3, arg4);
    }

    public fun fee_state<T0, T1>(arg0: &Vault<T0, T1>) : &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::FeeState {
        &arg0.fee_state
    }

    public fun finalize_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        finalize_withdrawal_checked<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4);
    }

    public fun finalize_withdrawal_checked<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(!arg0.paused, 13836188215797415950);
        assert_own_request<T0, T1>(arg0, &arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 >= 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::eligible_at_ms<T1>(&arg2) && v0 - 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::eligible_at_ms<T1>(&arg2) >= 86400000;
        assert!(may_finalize<T1>(&arg2, 0x2::tx_context::sender(arg5)) || v1, 13840128899832938538);
        assert!(v0 >= 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::eligible_at_ms<T1>(&arg2), 13840410379104747564);
        let v2 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::expires_at_ms<T1>(&arg2);
        if (0x1::option::is_some<u64>(&v2)) {
            assert!(v0 < 0x1::option::destroy_some<u64>(v2), 13840691858376556590);
        } else {
            0x1::option::destroy_none<u64>(v2);
        };
        let v3 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T1>(&arg2);
        let v4 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::payout<T1>(&arg2);
        if (is_pas<T0, T1>(arg0)) {
            assert_listed<T0, T1>(arg0, v3);
            assert_listed<T0, T1>(arg0, v4);
        };
        let v5 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::shares<T1>(&arg2);
        let v6 = assets_for<T0, T1>(arg0, v5);
        assert!(v6 <= arg0.max_withdrawal_amount, 13838440101511495710);
        assert!(v6 >= arg3, 13837314210194063382);
        assert!(v6 > 0, 13837877164442714138);
        assert!(v6 <= 0x2::balance::value<T0>(&arg0.idle), 13838721593668206624);
        let v7 = borrow_treasury_cap_mut<T0, T1>(arg0);
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(v7), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::destroy<T1>(arg2));
        close_request<T0, T1>(arg0, v5);
        release_allocation<T0, T1>(arg0, v3, v6);
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.idle, v6), v4);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_withdrawal_finalized<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>>(&arg2), v3, v4, v5, v6, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    public fun fulfillment_window_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fulfillment_window_ms
    }

    public fun grant_operator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::grant<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>(&mut arg0.roles, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_granted(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::with_original_ids<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>(), arg3);
        };
    }

    public fun grant_pauser<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::grant<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::PauserRole>(&mut arg0.roles, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_granted(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::with_original_ids<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::PauserRole>(), arg3);
        };
    }

    public(friend) fun has_allocation<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        0x2::dynamic_field::exists<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::AllocationKey>(&arg0.id, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::allocation_key(arg1))
    }

    public fun idle_assets<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.idle)
    }

    fun instant_fee<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::instant_redemption_fee(arg1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::instant_redemption_fee_bps(&arg0.fee_state))
    }

    public(friend) fun is_pas<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x2::dynamic_object_field::exists<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::PolicyCapKey>(&arg0.id, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::policy_cap_key())
    }

    public fun is_subaccount<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.subaccounts, arg1)
    }

    public fun management_fee_expires_at_ms<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = MgmtFeeKey{dummy_field: false};
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::expires_at_ms<MgmtFeeKey, u64>(&arg0.id, v0)
    }

    public fun management_fee_ready_at_ms<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = MgmtFeeKey{dummy_field: false};
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::ready_at_ms<MgmtFeeKey, u64>(&arg0.id, v0)
    }

    public fun max_deposit_amount<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.max_deposit_amount
    }

    public fun max_withdrawal_amount<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.max_withdrawal_amount
    }

    fun may_finalize<T0>(arg0: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T0>, arg1: address) : bool {
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::finalizer<T0>(arg0);
        if (arg1 == 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::owner<T0>(arg0)) {
            true
        } else if (0x1::option::is_none<address>(&v0)) {
            true
        } else {
            0x1::option::contains<address>(&v0, &arg1)
        }
    }

    public fun metadata_cap_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x2::coin_registry::MetadataCap<T1>>(borrow_metadata_cap<T0, T1>(arg0))
    }

    public fun min_deposit<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.min_deposit
    }

    fun net_assets<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::total_assets(0x2::balance::value<T0>(&arg0.idle), arg0.deployed_aum, arg0.total_collectable_fees)
    }

    fun open_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.pending_requests = arg0.pending_requests + 1;
        arg0.pending_shares = arg0.pending_shares + arg1;
    }

    public fun operator_deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13841534960457154612);
        assert!(v0 <= arg0.deployed_aum, 13841816439728963638);
        arg0.deployed_aum = arg0.deployed_aum - v0;
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::record_return(&mut arg0.aum_limits, v0);
        0x2::balance::join<T0>(&mut arg0.idle, 0x2::coin::into_balance<T0>(arg2));
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_operator_deposited<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, arg0.deployed_aum, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    public fun operator_expedite_withdrawal<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>, arg3: &mut 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>, arg4: &0x2::clock::Clock) {
        expedite<T0, T1>(arg0, arg1, arg3, arg4);
    }

    public fun operator_update_aum<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = arg0.deployed_aum;
        assert!(!arg0.paused || arg3 <= v0, 13842098030669922360);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::record_report(&mut arg0.aum_limits, v0, arg3, 0x2::clock::timestamp_ms(arg4));
        arg0.deployed_aum = arg3;
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_aum_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, arg3, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    public fun operator_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>, arg3: address, arg4: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.subaccounts, arg3), 13841253356631294002);
        assert!(arg4 > 0, 13841534835903103028);
        assert!(arg4 <= 0x2::balance::value<T0>(&arg0.idle), 13838720090429653024);
        arg0.deployed_aum = arg0.deployed_aum + arg4;
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::record_deployment(&mut arg0.aum_limits, arg4);
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.idle, arg4), arg3);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_operator_withdrew<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3, arg4, arg0.deployed_aum, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
    }

    public fun pause<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, T2>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::can_pause<T2>(), 13844911509128020044);
        if (!arg0.paused) {
            arg0.paused = true;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_paused<T0, T1>(0x2::object::uid_to_inner(&arg0.id));
        };
    }

    public fun paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    fun pay_from_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: vector<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>, arg2: vector<u64>) {
        0x1::vector::reverse<u64>(&mut arg2);
        assert!(0x1::vector::length<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>(&arg1) == 0x1::vector::length<u64>(&arg2), 13906841441428045823);
        0x1::vector::reverse<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>(&mut arg1);
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (v2 > 0) {
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.idle, v2), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::addr(&v1));
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>(arg1);
        0x1::vector::destroy_empty<u64>(arg2);
    }

    public fun pending_management_fee<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = MgmtFeeKey{dummy_field: false};
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::pending_value<MgmtFeeKey, u64>(&arg0.id, v0)
    }

    public fun pending_requests<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.pending_requests
    }

    public fun pending_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.pending_shares
    }

    public fun preview_deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: u64) : u64 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        shares_for<T0, T1>(arg0, arg2)
    }

    public fun preview_redemption<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: u64, arg3: bool) : (u64, u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = assets_for<T0, T1>(arg0, arg2);
        let v1 = if (arg3) {
            instant_fee<T0, T1>(arg0, v0)
        } else {
            0
        };
        (v0, v0 - v1)
    }

    public fun queue_attached<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.queue_attached
    }

    public(friend) fun redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::balance::Balance<T1>, arg3: address, arg4: address, arg5: u64) : 0x2::balance::Balance<T0> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(!arg0.paused, 13836188714013622286);
        assert!(!arg0.queue_attached, 13838159043146481692);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = assets_for<T0, T1>(arg0, v0);
        assert!(v1 <= arg0.max_withdrawal_amount, 13838440535303192606);
        let v2 = instant_fee<T0, T1>(arg0, v1);
        let v3 = v1 - v2;
        assert!(v3 >= arg5, 13837314652575694870);
        assert!(v3 > 0, 13837877606824345626);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.idle), 13838722036049838112);
        let v4 = borrow_treasury_cap_mut<T0, T1>(arg0);
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(v4), arg2);
        release_allocation<T0, T1>(arg0, arg3, v1);
        arg0.total_collectable_fees = arg0.total_collectable_fees + v2;
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_redeemed<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3, arg4, v0, v1, v3, v2, net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
        0x2::balance::split<T0>(&mut arg0.idle, v3)
    }

    public(friend) fun redeem_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_coin_vault<T0, T1>(arg0);
        0x2::coin::from_balance<T0>(redeem<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), 0x2::tx_context::sender(arg4), 0x2::tx_context::sender(arg4), arg3), arg4)
    }

    public fun register_subaccount<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = if (arg3 != @0x0) {
            if (arg3 != 0x2::object::uid_to_address(&arg0.id)) {
                arg3 != 0x2::object::id_address<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry>(arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13840971722740662320);
        if (!0x2::table::contains<address, bool>(&arg0.subaccounts, arg3)) {
            0x2::table::add<address, bool>(&mut arg0.subaccounts, arg3, true);
            arg0.subaccount_count = arg0.subaccount_count + 1;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_subaccount_registered<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3);
        };
    }

    fun release_allocation<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64) {
        if (is_pas<T0, T1>(arg0) && has_allocation<T0, T1>(arg0, arg1)) {
            let v0 = allocation<T0, T1>(arg0, arg1);
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::record_withdrawal(&mut v0, arg2);
            set_allocation<T0, T1>(arg0, arg1, v0);
        };
    }

    public(friend) fun request_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::balance::Balance<T1>, arg3: address, arg4: u64, arg5: address, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock) : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1> {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert!(!arg0.paused, 13836188907287150606);
        assert!(arg0.queue_attached, 13839003661350535202);
        let v0 = 0x2::balance::value<T1>(&arg2);
        assert!(v0 > 0, 13839285144917311524);
        let v1 = if (arg5 != @0x0) {
            if (arg5 != 0x2::object::uid_to_address(&arg0.id)) {
                if (arg5 != 0x2::object::id_address<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry>(arg1)) {
                    arg5 != 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::derive_address(0x2::object::uid_to_inner(&arg0.id), arg3, arg4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13839566645663957030);
        assert!(assets_for<T0, T1>(arg0, v0) <= arg0.max_withdrawal_amount, 13838440754346524702);
        let v2 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::new<T1>(&mut arg0.id, arg2, arg3, arg4, arg5, arg6, arg0.cooldown_ms, arg0.fulfillment_window_ms, arg7);
        open_request<T0, T1>(arg0, v0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_withdrawal_requested<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1>>(&v2), arg4, arg3, arg5, arg6, v0, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::eligible_at_ms<T1>(&v2), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::expires_at_ms<T1>(&v2), net_assets<T0, T1>(arg0), total_supply<T0, T1>(arg0));
        v2
    }

    public(friend) fun request_withdrawal_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: address, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal::WithdrawalRequest<T1> {
        assert_coin_vault<T0, T1>(arg0);
        request_withdrawal<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), 0x2::tx_context::sender(arg7), arg3, arg4, arg5, arg6)
    }

    public fun revoke_operator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::revoke<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>(&mut arg0.roles, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_revoked(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::with_original_ids<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OperatorRole>(), arg3);
        };
    }

    public fun revoke_pauser<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: address) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::revoke<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::PauserRole>(&mut arg0.roles, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_revoked(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::with_original_ids<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::PauserRole>(), arg3);
        };
    }

    public fun schedule_management_fee_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::assert_management_fee_bps(arg3);
        let v0 = MgmtFeeKey{dummy_field: false};
        let (v1, _) = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::schedule<MgmtFeeKey, u64>(&mut arg0.id, v0, arg3, arg0.timelock_delay_ms, arg4);
        let v3 = MgmtFeeKey{dummy_field: false};
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_change_scheduled<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"management_fee"), arg3, v1, 0x1::option::destroy_some<u64>(0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock::expires_at_ms<MgmtFeeKey, u64>(&arg0.id, v3)));
    }

    public(friend) fun set_allocation<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::Allocation) {
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::allocation_key(arg1);
        if (0x2::dynamic_field::exists<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::AllocationKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::AllocationKey, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::Allocation>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::AllocationKey, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state::Allocation>(&mut arg0.id, v0, arg2);
        };
    }

    public fun set_aum_cumulative_limits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64, arg4: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::set_cumulative_limits(&mut arg0.aum_limits, arg3, arg4);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"set_aum_cumulative_limits"));
    }

    public fun set_aum_limits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64, arg4: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits::set_report_limits(&mut arg0.aum_limits, arg3, arg4)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"set_aum_limits"));
        };
    }

    public fun set_cooldown<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_cooldown(arg3);
        if (arg0.cooldown_ms != arg3) {
            arg0.cooldown_ms = arg3;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"set_cooldown"));
        };
    }

    public fun set_fulfillment_window<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_fulfillment_window(arg3);
        if (arg0.fulfillment_window_ms != arg3) {
            arg0.fulfillment_window_ms = arg3;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"set_fulfillment_window"));
        };
    }

    public fun set_min_deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (arg0.min_deposit != arg3) {
            arg0.min_deposit = arg3;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"set_min_deposit"));
        };
    }

    public(friend) fun share<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public(friend) fun share_coin_vault<T0, T1>(arg0: Vault<T0, T1>) {
        assert_coin_vault<T0, T1>(&arg0);
        share<T0, T1>(arg0);
    }

    fun shares_for<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::shares_for_deposit(arg1, total_supply<T0, T1>(arg0), net_assets<T0, T1>(arg0))
    }

    public fun subaccount_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.subaccount_count
    }

    public fun timelock_delay_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.timelock_delay_ms
    }

    public fun total_collectable_fees<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_collectable_fees
    }

    public fun treasury_cap_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T1>>(borrow_treasury_cap<T0, T1>(arg0))
    }

    public fun unpause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (arg0.paused) {
            arg0.paused = false;
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_unpaused<T0, T1>(0x2::object::uid_to_inner(&arg0.id));
        };
    }

    public fun update_fee_collectors<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: vector<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_fee_recipients<T0, T1>(arg0, arg1, &arg3);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::set_fee_collectors(&mut arg0.fee_state, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"update_fee_collectors"));
        };
    }

    public fun update_instant_redemption_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::set_instant_redemption_fee_bps(&mut arg0.fee_state, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"update_instant_redemption_fee"));
        };
    }

    public fun update_limits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64, arg4: u64, arg5: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_transaction_limits(arg4, arg5);
        let v0 = if (arg0.deposit_cap != arg3) {
            true
        } else if (arg0.max_deposit_amount != arg4) {
            true
        } else {
            arg0.max_withdrawal_amount != arg5
        };
        arg0.deposit_cap = arg3;
        arg0.max_deposit_amount = arg4;
        arg0.max_withdrawal_amount = arg5;
        if (v0) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"update_limits"));
        };
    }

    public fun update_metadata<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &mut 0x2::coin_registry::Currency<T1>, arg3: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        let v0 = if (0x2::coin_registry::name<T1>(arg2) == arg4) {
            if (0x2::coin_registry::description<T1>(arg2) == arg5) {
                0x2::coin_registry::icon_url<T1>(arg2) == arg6
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = borrow_metadata_cap<T0, T1>(arg0);
        0x2::coin_registry::set_name<T1>(arg2, v1, arg4);
        0x2::coin_registry::set_description<T1>(arg2, v1, arg5);
        0x2::coin_registry::set_icon_url<T1>(arg2, v1, arg6);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"update_metadata"));
    }

    public fun update_performance_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: u64) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::set_performance_fee_rate(&mut arg0.fee_state, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"update_performance_fee"));
        };
    }

    public fun update_performance_fee_collectors<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::Registry, arg2: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<T1, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::OwnerRole>, arg3: vector<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::Collector>) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry::assert_valid_version(arg1);
        assert_fee_recipients<T0, T1>(arg0, arg1, &arg3);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::set_performance_fee_recipients(&mut arg0.fee_state, arg3)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_config_updated<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(b"update_performance_fee_collectors"));
        };
    }

    // decompiled from Move bytecode v7
}

