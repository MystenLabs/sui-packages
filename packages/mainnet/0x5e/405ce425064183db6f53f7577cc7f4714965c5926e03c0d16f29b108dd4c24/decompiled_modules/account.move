module 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account {
    struct AccountKey has copy, drop, store {
        owner: address,
    }

    struct AdapterKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        finalized: bool,
        coordinator_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct MultichainAccount has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        coordinator_id: 0x2::object::ID,
        owner: address,
        paused: bool,
        generation: u64,
        exhausted: bool,
        adapters: 0x2::bag::Bag,
    }

    struct AdapterInstallation has store {
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        cap: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>,
        curve: u32,
        public_output: vector<u8>,
        enabled: bool,
        generation: u64,
        exhausted: bool,
        next_sequence: u64,
        state: 0x2::bag::Bag,
    }

    struct SigningAttempt has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        adapter_type: 0x1::type_name::TypeName,
        dwallet_id: 0x2::object::ID,
        account_generation: u64,
        adapter_generation: u64,
        sequence: u64,
        requester: address,
        signature_algorithm: u32,
        hash_scheme: u32,
        message: vector<u8>,
        ika_sign_id: 0x2::object::ID,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        owner: address,
    }

    struct AccountChanged has copy, drop {
        account_id: 0x2::object::ID,
        paused: bool,
        generation: u64,
        exhausted: bool,
    }

    struct AdapterChanged has copy, drop {
        account_id: 0x2::object::ID,
        adapter_type: 0x1::type_name::TypeName,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        attached: bool,
        enabled: bool,
        generation: u64,
        exhausted: bool,
    }

    struct SigningRequested has copy, drop {
        account_id: 0x2::object::ID,
        adapter_type: 0x1::type_name::TypeName,
        attempt_id: 0x2::object::ID,
        ika_sign_id: 0x2::object::ID,
        account_generation: u64,
        adapter_generation: u64,
        sequence: u64,
    }

    struct DeploymentFinalized has copy, drop {
        registry_id: 0x2::object::ID,
        coordinator_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.finalized, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::id<Registry>(arg0);
        let v2 = AccountKey{owner: v0};
        let v3 = MultichainAccount{
            id             : 0x2::derived_object::claim<AccountKey>(&mut arg0.id, v2),
            registry_id    : v1,
            coordinator_id : *0x1::option::borrow<0x2::object::ID>(&arg0.coordinator_id),
            owner          : v0,
            paused         : false,
            generation     : 0,
            exhausted      : false,
            adapters       : 0x2::bag::new(arg1),
        };
        let v4 = 0x2::object::id<MultichainAccount>(&v3);
        let v5 = AccountCreated{
            account_id  : v4,
            registry_id : v1,
            owner       : v0,
        };
        0x2::event::emit<AccountCreated>(v5);
        0x2::transfer::share_object<MultichainAccount>(v3);
        v4
    }

    public fun adapter_enabled<T0>(arg0: &MultichainAccount) : bool {
        installation<T0>(arg0).enabled
    }

    public fun adapter_exhausted<T0>(arg0: &MultichainAccount) : bool {
        installation<T0>(arg0).exhausted
    }

    public fun adapter_generation<T0>(arg0: &MultichainAccount) : u64 {
        installation<T0>(arg0).generation
    }

    public fun adapter_state<T0: drop>(arg0: &MultichainAccount, arg1: T0) : &0x2::bag::Bag {
        &installation<T0>(arg0).state
    }

    public fun adapter_state_mut<T0: drop>(arg0: &mut MultichainAccount, arg1: T0, arg2: &0x2::tx_context::TxContext) : &mut 0x2::bag::Bag {
        assert_owner(arg0, arg2);
        assert_forward_counter(arg0.generation, arg0.exhausted);
        let v0 = installation_mut<T0>(arg0);
        assert_forward_counter(v0.generation, v0.exhausted);
        let v1 = &mut v0.generation;
        let v2 = &mut v0.exhausted;
        advance(v1, v2);
        &mut v0.state
    }

    fun advance(arg0: &mut u64, arg1: &mut bool) {
        if (*arg0 == 18446744073709551615) {
            *arg1 = true;
        } else {
            *arg0 = *arg0 + 1;
            if (*arg0 == 18446744073709551615) {
                *arg1 = true;
            };
        };
    }

    fun assert_forward_counter(arg0: u64, arg1: bool) {
        assert!(!arg1 && arg0 < 18446744073709551615, 8);
    }

    fun assert_owner(arg0: &MultichainAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    public fun attempt_account(arg0: &SigningAttempt) : 0x2::object::ID {
        arg0.account_id
    }

    public fun attempt_adapter(arg0: &SigningAttempt) : 0x1::type_name::TypeName {
        arg0.adapter_type
    }

    public fun attempt_dwallet(arg0: &SigningAttempt) : 0x2::object::ID {
        arg0.dwallet_id
    }

    public fun attempt_generations(arg0: &SigningAttempt) : (u64, u64) {
        (arg0.account_generation, arg0.adapter_generation)
    }

    public fun attempt_message(arg0: &SigningAttempt) : &vector<u8> {
        &arg0.message
    }

    public fun attempt_parameters(arg0: &SigningAttempt) : (u32, u32) {
        (arg0.signature_algorithm, arg0.hash_scheme)
    }

    public fun attempt_requester(arg0: &SigningAttempt) : address {
        arg0.requester
    }

    public fun attempt_sequence(arg0: &SigningAttempt) : u64 {
        arg0.sequence
    }

    public fun attempt_sign_id(arg0: &SigningAttempt) : 0x2::object::ID {
        arg0.ika_sign_id
    }

    public fun cap_attached<T0>(arg0: &MultichainAccount) : bool {
        0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&installation<T0>(arg0).cap)
    }

    fun check_sign<T0>(arg0: &MultichainAccount, arg1: u64, arg2: u64, arg3: u64) {
        assert!(!arg0.paused, 9);
        assert_forward_counter(arg0.generation, arg0.exhausted);
        assert!(arg0.generation == arg1, 11);
        let v0 = installation<T0>(arg0);
        assert!(v0.enabled, 10);
        assert!(0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v0.cap), 6);
        assert_forward_counter(v0.generation, v0.exhausted);
        assert!(v0.next_sequence < 18446744073709551615, 8);
        assert!(v0.generation == arg2, 12);
        assert!(v0.next_sequence == arg3, 13);
    }

    public fun coordinator_id(arg0: &MultichainAccount) : 0x2::object::ID {
        arg0.coordinator_id
    }

    public fun curve<T0>(arg0: &MultichainAccount) : u32 {
        installation<T0>(arg0).curve
    }

    public fun derived_address(arg0: &Registry, arg1: address) : address {
        let v0 = AccountKey{owner: arg1};
        0x2::derived_object::derive_address<AccountKey>(0x2::object::id<Registry>(arg0), v0)
    }

    public fun disable_adapter<T0>(arg0: &mut MultichainAccount, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = installation_mut<T0>(arg0);
        if (v0.enabled) {
            v0.enabled = false;
            let v1 = &mut v0.generation;
            let v2 = &mut v0.exhausted;
            advance(v1, v2);
            emit_adapter<T0>(arg0);
        };
    }

    public fun dwallet_id<T0>(arg0: &MultichainAccount) : 0x2::object::ID {
        installation<T0>(arg0).dwallet_id
    }

    fun emit_account(arg0: &MultichainAccount) {
        let v0 = AccountChanged{
            account_id : 0x2::object::id<MultichainAccount>(arg0),
            paused     : arg0.paused,
            generation : arg0.generation,
            exhausted  : arg0.exhausted,
        };
        0x2::event::emit<AccountChanged>(v0);
    }

    fun emit_adapter<T0>(arg0: &MultichainAccount) {
        let v0 = installation<T0>(arg0);
        let v1 = AdapterChanged{
            account_id   : 0x2::object::id<MultichainAccount>(arg0),
            adapter_type : 0x1::type_name::with_original_ids<T0>(),
            dwallet_id   : v0.dwallet_id,
            cap_id       : v0.cap_id,
            attached     : 0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v0.cap),
            enabled      : v0.enabled,
            generation   : v0.generation,
            exhausted    : v0.exhausted,
        };
        0x2::event::emit<AdapterChanged>(v1);
    }

    public fun enable_adapter<T0>(arg0: &mut MultichainAccount, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_forward_counter(arg0.generation, arg0.exhausted);
        let v0 = installation_mut<T0>(arg0);
        assert!(0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v0.cap), 6);
        assert_forward_counter(v0.generation, v0.exhausted);
        assert!(v0.next_sequence < 18446744073709551615, 8);
        if (!v0.enabled) {
            v0.enabled = true;
            let v1 = &mut v0.generation;
            let v2 = &mut v0.exhausted;
            advance(v1, v2);
            emit_adapter<T0>(arg0);
        };
    }

    public fun exhausted(arg0: &MultichainAccount) : bool {
        arg0.exhausted
    }

    public fun finalize(arg0: &mut Registry, arg1: 0x2::package::UpgradeCap, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator) {
        finalize_impl(arg0, arg1, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg2));
    }

    fun finalize_impl(arg0: &mut Registry, arg1: 0x2::package::UpgradeCap, arg2: 0x2::object::ID) {
        assert!(!arg0.finalized, 2);
        let v0 = 0x2::package::upgrade_package(&arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<Registry>(), 3);
        assert!(0x2::package::version(&arg1) == 1, 3);
        0x2::package::make_immutable(arg1);
        0x1::option::fill<0x2::object::ID>(&mut arg0.coordinator_id, arg2);
        arg0.finalized = true;
        let v1 = DeploymentFinalized{
            registry_id    : 0x2::object::id<Registry>(arg0),
            coordinator_id : arg2,
        };
        0x2::event::emit<DeploymentFinalized>(v1);
    }

    public fun finalized(arg0: &Registry) : bool {
        arg0.finalized
    }

    public fun generation(arg0: &MultichainAccount) : u64 {
        arg0.generation
    }

    public fun has_adapter<T0>(arg0: &MultichainAccount) : bool {
        let v0 = AdapterKey<T0>{dummy_field: false};
        0x2::bag::contains<AdapterKey<T0>>(&arg0.adapters, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            finalized      : false,
            coordinator_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun install<T0>(arg0: &mut MultichainAccount, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: u32, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!has_adapter<T0>(arg0), 4);
        assert_forward_counter(arg0.generation, arg0.exhausted);
        let v0 = AdapterKey<T0>{dummy_field: false};
        let v1 = AdapterInstallation{
            dwallet_id    : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg1),
            cap_id        : 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg1),
            cap           : 0x1::option::some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg1),
            curve         : arg2,
            public_output : arg3,
            enabled       : true,
            generation    : 0,
            exhausted     : false,
            next_sequence : 0,
            state         : 0x2::bag::new(arg4),
        };
        0x2::bag::add<AdapterKey<T0>, AdapterInstallation>(&mut arg0.adapters, v0, v1);
        emit_adapter<T0>(arg0);
    }

    public fun install_adapter<T0: drop>(arg0: &mut MultichainAccount, arg1: T0, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg2) == arg0.coordinator_id, 14);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg2, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg3));
        assert!(!0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_imported_key_dwallet(v0), 15);
        install<T0>(arg0, arg3, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::curve(v0), *0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::validate_active_and_get_public_output(v0), arg4);
    }

    fun installation<T0>(arg0: &MultichainAccount) : &AdapterInstallation {
        assert!(has_adapter<T0>(arg0), 5);
        let v0 = AdapterKey<T0>{dummy_field: false};
        0x2::bag::borrow<AdapterKey<T0>, AdapterInstallation>(&arg0.adapters, v0)
    }

    fun installation_mut<T0>(arg0: &mut MultichainAccount) : &mut AdapterInstallation {
        assert!(has_adapter<T0>(arg0), 5);
        let v0 = AdapterKey<T0>{dummy_field: false};
        0x2::bag::borrow_mut<AdapterKey<T0>, AdapterInstallation>(&mut arg0.adapters, v0)
    }

    public fun next_sequence<T0>(arg0: &MultichainAccount) : u64 {
        installation<T0>(arg0).next_sequence
    }

    public fun owner(arg0: &MultichainAccount) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut MultichainAccount, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        if (!arg0.paused) {
            arg0.paused = true;
            let v0 = &mut arg0.generation;
            let v1 = &mut arg0.exhausted;
            advance(v0, v1);
            emit_account(arg0);
        };
    }

    public fun paused(arg0: &MultichainAccount) : bool {
        arg0.paused
    }

    public fun public_output<T0>(arg0: &MultichainAccount) : &vector<u8> {
        &installation<T0>(arg0).public_output
    }

    public fun reattach_cap<T0>(arg0: &mut MultichainAccount, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = installation_mut<T0>(arg0);
        assert!(0x1::option::is_none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v0.cap), 16);
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg1) == v0.cap_id, 7);
        assert!(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg1) == v0.dwallet_id, 7);
        0x1::option::fill<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0.cap, arg1);
        v0.enabled = false;
        let v1 = &mut v0.generation;
        let v2 = &mut v0.exhausted;
        advance(v1, v2);
        emit_adapter<T0>(arg0);
    }

    public fun reclaim_cap<T0>(arg0: &mut MultichainAccount, arg1: &0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        assert_owner(arg0, arg1);
        let v0 = installation_mut<T0>(arg0);
        assert!(0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v0.cap), 6);
        v0.enabled = false;
        let v1 = &mut v0.generation;
        let v2 = &mut v0.exhausted;
        advance(v1, v2);
        emit_adapter<T0>(arg0);
        0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0.cap)
    }

    public fun registry_id(arg0: &MultichainAccount) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun request_sign<T0: drop>(arg0: &mut MultichainAccount, arg1: T0, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: vector<u8>, arg9: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg10: vector<u8>, arg11: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_sign<T0>(arg0, arg3, arg4, arg5);
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg2) == arg0.coordinator_id, 14);
        let v0 = 0x2::object::id<MultichainAccount>(arg0);
        let v1 = 0x2::object::new(arg13);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = installation_mut<T0>(arg0);
        let v4 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg2, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg2, arg9, arg13), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, 0x1::option::borrow<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v3.cap), arg6, arg7, arg8), arg10, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, 0x2::object::id_to_bytes(&v2), arg13), arg11, arg12, arg13);
        let v5 = 0x1::type_name::with_original_ids<T0>();
        let v6 = SigningAttempt{
            id                  : v1,
            account_id          : v0,
            adapter_type        : v5,
            dwallet_id          : v3.dwallet_id,
            account_generation  : arg3,
            adapter_generation  : arg4,
            sequence            : arg5,
            requester           : 0x2::tx_context::sender(arg13),
            signature_algorithm : arg6,
            hash_scheme         : arg7,
            message             : arg8,
            ika_sign_id         : v4,
        };
        0x2::transfer::freeze_object<SigningAttempt>(v6);
        v3.next_sequence = v3.next_sequence + 1;
        let v7 = SigningRequested{
            account_id         : v0,
            adapter_type       : v5,
            attempt_id         : v2,
            ika_sign_id        : v4,
            account_generation : arg3,
            adapter_generation : arg4,
            sequence           : arg5,
        };
        0x2::event::emit<SigningRequested>(v7);
        v2
    }

    public fun resume(arg0: &mut MultichainAccount, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_forward_counter(arg0.generation, arg0.exhausted);
        if (arg0.paused) {
            arg0.paused = false;
            let v0 = &mut arg0.generation;
            let v1 = &mut arg0.exhausted;
            advance(v0, v1);
            emit_account(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

