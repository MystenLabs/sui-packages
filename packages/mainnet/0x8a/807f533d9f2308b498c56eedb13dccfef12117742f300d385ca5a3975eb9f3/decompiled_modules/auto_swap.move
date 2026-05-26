module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap {
    struct AutoSwapRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_validations: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AutoSwapCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        max_per_swap: u64,
        expires_at_ms: u64,
        paused: bool,
    }

    struct AutoSwapEnabled has copy, drop {
        owner: address,
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin_type: vector<u8>,
        max_per_swap: u64,
        expires_at_ms: u64,
    }

    struct AutoSwapDisabled has copy, drop {
        owner: address,
        cap_id: 0x2::object::ID,
        coin_type: vector<u8>,
    }

    struct AutoSwapPaused has copy, drop {
        owner: address,
        cap_id: 0x2::object::ID,
        paused: bool,
    }

    struct AutoSwapValidated has copy, drop {
        admin: address,
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        amount: u64,
        coin_type: vector<u8>,
    }

    struct AutoSwapRegistryV2 has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin_transfer: 0x1::option::Option<PendingAdminTransfer>,
        admin_transfer_delay_ms: u64,
        pending_delay_change: 0x1::option::Option<PendingDelayChange>,
        worker_addresses: vector<address>,
        oncall_addresses: vector<address>,
        treasury_addresses: vector<address>,
        allowed_dest_types: vector<0x1::type_name::TypeName>,
        allowed_providers: vector<vector<u8>>,
        paused: bool,
        total_validations: u64,
    }

    struct PendingAdminTransfer has drop, store {
        new_admin: address,
        scheduled_at_ms: u64,
        delay_at_schedule_ms: u64,
    }

    struct PendingDelayChange has drop, store {
        new_delay_ms: u64,
        scheduled_at_ms: u64,
        delay_at_schedule_ms: u64,
    }

    struct AutoSwapCapV2<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        max_per_swap: u64,
        expires_at_ms: u64,
        paused: bool,
        max_per_day: u64,
        used_today: u64,
        day_reset_at_ms: u64,
    }

    struct RegistryBootstrapped has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
    }

    struct WorkerGranted has copy, drop {
        addr: address,
        by: address,
    }

    struct WorkerRevoked has copy, drop {
        addr: address,
        by: address,
    }

    struct OncallGranted has copy, drop {
        addr: address,
        by: address,
    }

    struct OncallRevoked has copy, drop {
        addr: address,
        by: address,
    }

    struct TreasuryGranted has copy, drop {
        addr: address,
        by: address,
    }

    struct TreasuryRevoked has copy, drop {
        addr: address,
        by: address,
    }

    struct AdminTransferBegun has copy, drop {
        current: address,
        pending: address,
        executable_after_ms: u64,
    }

    struct AdminTransferAccepted has copy, drop {
        old: address,
        new: address,
    }

    struct AdminTransferCancelled has copy, drop {
        current: address,
        was_pending: address,
    }

    struct DelayChangeBegun has copy, drop {
        current_delay_ms: u64,
        pending_delay_ms: u64,
        executable_after_ms: u64,
    }

    struct DelayChangeAccepted has copy, drop {
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    struct DelayChangeCancelled has copy, drop {
        current_delay_ms: u64,
        was_pending_delay_ms: u64,
    }

    struct RegistryPaused has copy, drop {
        by: address,
    }

    struct RegistryUnpaused has copy, drop {
        by: address,
    }

    struct AllowedDestAdded has copy, drop {
        dest_type: 0x1::type_name::TypeName,
        by: address,
    }

    struct AllowedDestRemoved has copy, drop {
        dest_type: 0x1::type_name::TypeName,
        by: address,
    }

    struct AllowedProviderAdded has copy, drop {
        provider: vector<u8>,
        by: address,
    }

    struct AllowedProviderRemoved has copy, drop {
        provider: vector<u8>,
        by: address,
    }

    struct CapUpgradedToV2 has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct AutoSwapValidatedV2 has copy, drop {
        admin: address,
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        amount: u64,
        used_today_after: u64,
        day_reset_at_ms: u64,
        coin_type: vector<u8>,
    }

    public entry fun accept_admin_transfer(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin_transfer), 205);
        let PendingAdminTransfer {
            new_admin            : v0,
            scheduled_at_ms      : v1,
            delay_at_schedule_ms : v2,
        } = 0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_admin_transfer);
        assert!(0x2::tx_context::sender(arg2) == v0, 206);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1 + v2, 207);
        arg0.admin = v0;
        let v3 = AdminTransferAccepted{
            old : arg0.admin,
            new : v0,
        };
        0x2::event::emit<AdminTransferAccepted>(v3);
    }

    public entry fun accept_delay_change(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(0x1::option::is_some<PendingDelayChange>(&arg0.pending_delay_change), 209);
        let PendingDelayChange {
            new_delay_ms         : v0,
            scheduled_at_ms      : v1,
            delay_at_schedule_ms : v2,
        } = 0x1::option::extract<PendingDelayChange>(&mut arg0.pending_delay_change);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1 + v2, 207);
        arg0.admin_transfer_delay_ms = v0;
        let v3 = DelayChangeAccepted{
            old_delay_ms : arg0.admin_transfer_delay_ms,
            new_delay_ms : v0,
        };
        0x2::event::emit<DelayChangeAccepted>(v3);
    }

    public entry fun add_allowed_dest<T0>(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert_admin_or_treasury(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.allowed_dest_types, &v0), 220);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.allowed_dest_types, v0);
        let v1 = AllowedDestAdded{
            dest_type : v0,
            by        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AllowedDestAdded>(v1);
    }

    public entry fun add_allowed_provider(arg0: &mut AutoSwapRegistryV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_admin_or_treasury(arg0, arg2);
        assert!(!0x1::vector::contains<vector<u8>>(&arg0.allowed_providers, &arg1), 218);
        0x1::vector::push_back<vector<u8>>(&mut arg0.allowed_providers, arg1);
        let v0 = AllowedProviderAdded{
            provider : arg1,
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AllowedProviderAdded>(v0);
    }

    public fun admin(arg0: &AutoSwapRegistry) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 200);
    }

    fun assert_admin_or_oncall(arg0: &AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || 0x1::vector::contains<address>(&arg0.oncall_addresses, &v0), 202);
    }

    fun assert_admin_or_treasury(arg0: &AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || 0x1::vector::contains<address>(&arg0.treasury_addresses, &v0), 201);
    }

    public(friend) fun assert_dest_allowed<T0>(arg0: &AutoSwapRegistryV2) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.allowed_dest_types, &v0), 215);
    }

    public(friend) fun assert_not_paused(arg0: &AutoSwapRegistryV2) {
        assert!(!arg0.paused, 204);
    }

    public entry fun begin_admin_transfer(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(0x1::option::is_none<PendingAdminTransfer>(&arg0.pending_admin_transfer), 210);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.admin_transfer_delay_ms;
        let v2 = PendingAdminTransfer{
            new_admin            : arg1,
            scheduled_at_ms      : v0,
            delay_at_schedule_ms : v1,
        };
        0x1::option::fill<PendingAdminTransfer>(&mut arg0.pending_admin_transfer, v2);
        let v3 = AdminTransferBegun{
            current             : arg0.admin,
            pending             : arg1,
            executable_after_ms : v0 + v1,
        };
        0x2::event::emit<AdminTransferBegun>(v3);
    }

    public entry fun begin_delay_change(arg0: &mut AutoSwapRegistryV2, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(0x1::option::is_none<PendingDelayChange>(&arg0.pending_delay_change), 211);
        assert!(arg1 <= 5184000000, 208);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.admin_transfer_delay_ms;
        let v2 = PendingDelayChange{
            new_delay_ms         : arg1,
            scheduled_at_ms      : v0,
            delay_at_schedule_ms : v1,
        };
        0x1::option::fill<PendingDelayChange>(&mut arg0.pending_delay_change, v2);
        let v3 = DelayChangeBegun{
            current_delay_ms    : v1,
            pending_delay_ms    : arg1,
            executable_after_ms : v0 + v1,
        };
        0x2::event::emit<DelayChangeBegun>(v3);
    }

    public entry fun bootstrap_v7(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = AutoSwapRegistryV2{
            id                      : 0x2::object::new(arg0),
            admin                   : v0,
            pending_admin_transfer  : 0x1::option::none<PendingAdminTransfer>(),
            admin_transfer_delay_ms : 172800000,
            pending_delay_change    : 0x1::option::none<PendingDelayChange>(),
            worker_addresses        : v1,
            oncall_addresses        : vector[],
            treasury_addresses      : vector[],
            allowed_dest_types      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            allowed_providers       : vector[b"CETUS", b"DEEPBOOKV3", b"AFTERMATH", b"CETUSDLMM"],
            paused                  : false,
            total_validations       : 0,
        };
        let v3 = RegistryBootstrapped{
            registry_id : 0x2::object::id<AutoSwapRegistryV2>(&v2),
            admin       : v0,
        };
        0x2::event::emit<RegistryBootstrapped>(v3);
        0x2::transfer::share_object<AutoSwapRegistryV2>(v2);
    }

    public entry fun cancel_admin_transfer(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin_transfer), 205);
        let PendingAdminTransfer {
            new_admin            : v0,
            scheduled_at_ms      : _,
            delay_at_schedule_ms : _,
        } = 0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_admin_transfer);
        let v3 = AdminTransferCancelled{
            current     : arg0.admin,
            was_pending : v0,
        };
        0x2::event::emit<AdminTransferCancelled>(v3);
    }

    public entry fun cancel_delay_change(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<PendingDelayChange>(&arg0.pending_delay_change), 209);
        let PendingDelayChange {
            new_delay_ms         : v0,
            scheduled_at_ms      : _,
            delay_at_schedule_ms : _,
        } = 0x1::option::extract<PendingDelayChange>(&mut arg0.pending_delay_change);
        let v3 = DelayChangeCancelled{
            current_delay_ms     : arg0.admin_transfer_delay_ms,
            was_pending_delay_ms : v0,
        };
        0x2::event::emit<DelayChangeCancelled>(v3);
    }

    public fun cap_expiry<T0>(arg0: &AutoSwapCap<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun cap_max<T0>(arg0: &AutoSwapCap<T0>) : u64 {
        arg0.max_per_swap
    }

    public fun cap_owner<T0>(arg0: &AutoSwapCap<T0>) : address {
        arg0.owner
    }

    public fun cap_paused<T0>(arg0: &AutoSwapCap<T0>) : bool {
        arg0.paused
    }

    public fun cap_v2_day_reset_at_ms<T0>(arg0: &AutoSwapCapV2<T0>) : u64 {
        arg0.day_reset_at_ms
    }

    public fun cap_v2_expires_at_ms<T0>(arg0: &AutoSwapCapV2<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun cap_v2_max_per_day<T0>(arg0: &AutoSwapCapV2<T0>) : u64 {
        arg0.max_per_day
    }

    public fun cap_v2_max_per_swap<T0>(arg0: &AutoSwapCapV2<T0>) : u64 {
        arg0.max_per_swap
    }

    public fun cap_v2_owner<T0>(arg0: &AutoSwapCapV2<T0>) : address {
        arg0.owner
    }

    public fun cap_v2_paused<T0>(arg0: &AutoSwapCapV2<T0>) : bool {
        arg0.paused
    }

    public fun cap_v2_used_today<T0>(arg0: &AutoSwapCapV2<T0>) : u64 {
        arg0.used_today
    }

    public fun cap_v2_vault<T0>(arg0: &AutoSwapCapV2<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun cap_vault<T0>(arg0: &AutoSwapCap<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public entry fun disable<T0>(arg0: AutoSwapCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        let AutoSwapCap {
            id            : v0,
            vault_id      : _,
            owner         : v2,
            max_per_swap  : _,
            expires_at_ms : _,
            paused        : _,
        } = arg0;
        let v6 = v0;
        let v7 = AutoSwapDisabled{
            owner     : v2,
            cap_id    : 0x2::object::uid_to_inner(&v6),
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<AutoSwapDisabled>(v7);
        0x2::object::delete(v6);
    }

    public entry fun grant_oncall(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!0x1::vector::contains<address>(&arg0.oncall_addresses, &arg1), 216);
        0x1::vector::push_back<address>(&mut arg0.oncall_addresses, arg1);
        let v0 = OncallGranted{
            addr : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OncallGranted>(v0);
    }

    public entry fun grant_treasury(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!0x1::vector::contains<address>(&arg0.treasury_addresses, &arg1), 216);
        0x1::vector::push_back<address>(&mut arg0.treasury_addresses, arg1);
        let v0 = TreasuryGranted{
            addr : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TreasuryGranted>(v0);
    }

    public entry fun grant_worker(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!0x1::vector::contains<address>(&arg0.worker_addresses, &arg1), 216);
        0x1::vector::push_back<address>(&mut arg0.worker_addresses, arg1);
        let v0 = WorkerGranted{
            addr : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WorkerGranted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AutoSwapRegistry{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            total_validations : 0,
        };
        0x2::transfer::share_object<AutoSwapRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun mint_cap<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AutoSwapCap<T0> {
        assert!(arg2 > 0, 104);
        let v0 = AutoSwapCap<T0>{
            id            : 0x2::object::new(arg4),
            vault_id      : arg0,
            owner         : arg1,
            max_per_swap  : arg2,
            expires_at_ms : arg3,
            paused        : false,
        };
        let v1 = AutoSwapEnabled{
            owner         : arg1,
            vault_id      : arg0,
            cap_id        : 0x2::object::id<AutoSwapCap<T0>>(&v0),
            coin_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            max_per_swap  : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<AutoSwapEnabled>(v1);
        v0
    }

    public(friend) fun new_cap_v2<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AutoSwapCapV2<T0> {
        assert!(arg2 > 0, 104);
        assert!(arg3 > 0, 214);
        assert!(arg3 >= arg2, 214);
        let v0 = AutoSwapCapV2<T0>{
            id              : 0x2::object::new(arg6),
            vault_id        : arg0,
            owner           : arg1,
            max_per_swap    : arg2,
            expires_at_ms   : arg4,
            paused          : false,
            max_per_day     : arg3,
            used_today      : 0,
            day_reset_at_ms : 0x2::clock::timestamp_ms(arg5) + 86400000,
        };
        let v1 = AutoSwapEnabled{
            owner         : arg1,
            vault_id      : arg0,
            cap_id        : 0x2::object::id<AutoSwapCapV2<T0>>(&v0),
            coin_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            max_per_swap  : arg2,
            expires_at_ms : arg4,
        };
        0x2::event::emit<AutoSwapEnabled>(v1);
        v0
    }

    public entry fun pause<T0>(arg0: &mut AutoSwapCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        arg0.paused = true;
        let v0 = AutoSwapPaused{
            owner  : arg0.owner,
            cap_id : 0x2::object::id<AutoSwapCap<T0>>(arg0),
            paused : true,
        };
        0x2::event::emit<AutoSwapPaused>(v0);
    }

    public entry fun pause_registry(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert_admin_or_oncall(arg0, arg1);
        arg0.paused = true;
        let v0 = RegistryPaused{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<RegistryPaused>(v0);
    }

    public entry fun remove_allowed_dest<T0>(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert_admin_or_treasury(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.allowed_dest_types, &v0);
        assert!(v1, 215);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.allowed_dest_types, v2);
        let v3 = AllowedDestRemoved{
            dest_type : v0,
            by        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AllowedDestRemoved>(v3);
    }

    public entry fun remove_allowed_provider(arg0: &mut AutoSwapRegistryV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_admin_or_treasury(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.allowed_providers, &arg1);
        assert!(v0, 219);
        0x1::vector::remove<vector<u8>>(&mut arg0.allowed_providers, v1);
        let v2 = AllowedProviderRemoved{
            provider : arg1,
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AllowedProviderRemoved>(v2);
    }

    public entry fun resume<T0>(arg0: &mut AutoSwapCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        arg0.paused = false;
        let v0 = AutoSwapPaused{
            owner  : arg0.owner,
            cap_id : 0x2::object::id<AutoSwapCap<T0>>(arg0),
            paused : false,
        };
        0x2::event::emit<AutoSwapPaused>(v0);
    }

    public entry fun revoke_oncall(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.oncall_addresses, &arg1);
        assert!(v0, 217);
        0x1::vector::remove<address>(&mut arg0.oncall_addresses, v1);
        let v2 = OncallRevoked{
            addr : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OncallRevoked>(v2);
    }

    public entry fun revoke_treasury(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.treasury_addresses, &arg1);
        assert!(v0, 217);
        0x1::vector::remove<address>(&mut arg0.treasury_addresses, v1);
        let v2 = TreasuryRevoked{
            addr : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TreasuryRevoked>(v2);
    }

    public entry fun revoke_worker(arg0: &mut AutoSwapRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.worker_addresses, &arg1);
        assert!(v0, 217);
        0x1::vector::remove<address>(&mut arg0.worker_addresses, v1);
        let v2 = WorkerRevoked{
            addr : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WorkerRevoked>(v2);
    }

    public fun total_validations(arg0: &AutoSwapRegistry) : u64 {
        arg0.total_validations
    }

    public entry fun unpause_registry(arg0: &mut AutoSwapRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert_admin_or_oncall(arg0, arg1);
        arg0.paused = false;
        let v0 = RegistryUnpaused{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<RegistryUnpaused>(v0);
    }

    public entry fun update_bounds<T0>(arg0: &mut AutoSwapCap<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 106);
        assert!(arg1 > 0, 104);
        arg0.max_per_swap = arg1;
        arg0.expires_at_ms = arg2;
    }

    public entry fun upgrade_cap_to_v2<T0>(arg0: AutoSwapCap<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 106);
        assert!(arg1 > 0, 214);
        assert!(arg1 >= arg0.max_per_swap, 214);
        let AutoSwapCap {
            id            : v0,
            vault_id      : v1,
            owner         : v2,
            max_per_swap  : v3,
            expires_at_ms : v4,
            paused        : v5,
        } = arg0;
        let v6 = v0;
        0x2::object::delete(v6);
        let v7 = AutoSwapCapV2<T0>{
            id              : 0x2::object::new(arg3),
            vault_id        : v1,
            owner           : v2,
            max_per_swap    : v3,
            expires_at_ms   : v4,
            paused          : v5,
            max_per_day     : arg1,
            used_today      : 0,
            day_reset_at_ms : 0x2::clock::timestamp_ms(arg2) + 86400000,
        };
        let v8 = CapUpgradedToV2{
            old_cap_id : 0x2::object::uid_to_inner(&v6),
            new_cap_id : 0x2::object::id<AutoSwapCapV2<T0>>(&v7),
            owner      : v2,
        };
        0x2::event::emit<CapUpgradedToV2>(v8);
        0x2::transfer::share_object<AutoSwapCapV2<T0>>(v7);
    }

    public fun v2_admin(arg0: &AutoSwapRegistryV2) : address {
        arg0.admin
    }

    public fun v2_admin_transfer_delay_ms(arg0: &AutoSwapRegistryV2) : u64 {
        arg0.admin_transfer_delay_ms
    }

    public fun v2_allowed_dests(arg0: &AutoSwapRegistryV2) : &vector<0x1::type_name::TypeName> {
        &arg0.allowed_dest_types
    }

    public fun v2_allowed_providers(arg0: &AutoSwapRegistryV2) : &vector<vector<u8>> {
        &arg0.allowed_providers
    }

    public fun v2_has_pending_admin_transfer(arg0: &AutoSwapRegistryV2) : bool {
        0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin_transfer)
    }

    public fun v2_has_pending_delay_change(arg0: &AutoSwapRegistryV2) : bool {
        0x1::option::is_some<PendingDelayChange>(&arg0.pending_delay_change)
    }

    public fun v2_oncalls(arg0: &AutoSwapRegistryV2) : &vector<address> {
        &arg0.oncall_addresses
    }

    public fun v2_paused(arg0: &AutoSwapRegistryV2) : bool {
        arg0.paused
    }

    public fun v2_total_validations(arg0: &AutoSwapRegistryV2) : u64 {
        arg0.total_validations
    }

    public fun v2_treasuries(arg0: &AutoSwapRegistryV2) : &vector<address> {
        &arg0.treasury_addresses
    }

    public fun v2_workers(arg0: &AutoSwapRegistryV2) : &vector<address> {
        &arg0.worker_addresses
    }

    public(friend) fun validate_for_swap<T0>(arg0: &mut AutoSwapRegistry, arg1: &AutoSwapCap<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin, 103);
        assert!(!arg1.paused, 100);
        if (arg1.expires_at_ms != 0) {
            assert!(arg3 <= arg1.expires_at_ms, 101);
        };
        assert!(arg2 <= arg1.max_per_swap, 102);
        arg0.total_validations = arg0.total_validations + 1;
        let v1 = AutoSwapValidated{
            admin     : v0,
            vault_id  : arg1.vault_id,
            cap_id    : 0x2::object::id<AutoSwapCap<T0>>(arg1),
            amount    : arg2,
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<AutoSwapValidated>(v1);
    }

    public(friend) fun validate_for_swap_v2<T0>(arg0: &mut AutoSwapRegistryV2, arg1: &mut AutoSwapCapV2<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 204);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.worker_addresses, &v0), 203);
        assert!(!arg1.paused, 100);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.expires_at_ms != 0) {
            assert!(v1 <= arg1.expires_at_ms, 101);
        };
        assert!(arg2 <= arg1.max_per_swap, 102);
        if (v1 >= arg1.day_reset_at_ms) {
            arg1.used_today = 0;
            arg1.day_reset_at_ms = v1 + 86400000;
        };
        assert!(arg2 <= 18446744073709551615 - arg1.used_today, 213);
        let v2 = arg1.used_today + arg2;
        assert!(v2 <= arg1.max_per_day, 212);
        arg1.used_today = v2;
        arg0.total_validations = arg0.total_validations + 1;
        let v3 = AutoSwapValidatedV2{
            admin            : v0,
            vault_id         : arg1.vault_id,
            cap_id           : 0x2::object::id<AutoSwapCapV2<T0>>(arg1),
            amount           : arg2,
            used_today_after : arg1.used_today,
            day_reset_at_ms  : arg1.day_reset_at_ms,
            coin_type        : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<AutoSwapValidatedV2>(v3);
    }

    // decompiled from Move bytecode v7
}

