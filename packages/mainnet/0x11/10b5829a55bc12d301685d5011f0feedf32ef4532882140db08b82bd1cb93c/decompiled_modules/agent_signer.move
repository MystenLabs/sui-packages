module 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer {
    struct App has drop {
        dummy_field: bool,
    }

    struct AgentSignerOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct AgentSigner has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: 0x2::object::ID,
        open: bool,
        connectors: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        destination_count: u64,
        vault_count: u64,
        last_owner_activity_ts: u64,
        last_signing_activity_ts: u64,
        version: u64,
    }

    struct DestinationKey has copy, drop, store {
        connector: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
    }

    struct VaultKey has copy, drop, store {
        connector: 0x1::type_name::TypeName,
        key: vector<u8>,
    }

    public fun rotate_spender<T0>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: &mut 0x2::allowance::Allowance<T0>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_pinned<T0>(arg0, arg2);
        0x2::allowance::rotate_spender<T0, App>(arg2, 0x2::allowance::settings_permit<App>(0x1::internal::permit<App>()), arg3);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg4);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::spender_rotated(0x2::object::id<AgentSigner>(arg0), 0x2::object::id<0x2::allowance::Allowance<T0>>(arg2), arg3);
    }

    public fun add_destination<T0: drop>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = DestinationKey{
            connector : 0x1::type_name::with_original_ids<T0>(),
            id        : arg2,
        };
        if (!0x2::dynamic_field::exists<DestinationKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<DestinationKey, bool>(&mut arg0.id, v0, true);
            arg0.destination_count = arg0.destination_count + 1;
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::settings_changed(0x2::object::id<AgentSigner>(arg0));
    }

    public fun allow_connector<T0: drop>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.connectors, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.connectors, v0);
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::settings_changed(0x2::object::id<AgentSigner>(arg0));
    }

    public fun assert_destination<T0: drop>(arg0: &T0, arg1: &AgentSigner, arg2: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.connectors, &v0), 35);
        assert!(is_destination<T0>(arg1, arg2), 36);
    }

    fun assert_owner(arg0: &AgentSigner, arg1: &AgentSignerOwnerCap) {
        assert_version(arg0);
        assert!(has_access(arg0, arg1), 0);
    }

    fun assert_pinned<T0>(arg0: &AgentSigner, arg1: &0x2::allowance::Allowance<T0>) {
        let v0 = 0x2::allowance::allowance_settings<T0>(arg1);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 30);
        assert!(*0x1::string::as_bytes(0x2::allowance::name(v0)) == binding_name(arg0), 31);
    }

    fun assert_version(arg0: &AgentSigner) {
        assert!(arg0.version == 1, 20);
    }

    public fun binding_name(arg0: &AgentSigner) : vector<u8> {
        let v0 = 0x2::object::id<AgentSigner>(arg0);
        0x2::hex::encode(0x2::object::id_to_bytes(&v0))
    }

    public fun close(arg0: AgentSigner, arg1: AgentSignerOwnerCap) {
        let AgentSigner {
            id                       : v0,
            owner                    : _,
            policy_id                : _,
            open                     : _,
            connectors               : _,
            destination_count        : v5,
            vault_count              : v6,
            last_owner_activity_ts   : _,
            last_signing_activity_ts : _,
            version                  : v9,
        } = arg0;
        let v10 = v0;
        let AgentSignerOwnerCap {
            id  : v11,
            for : v12,
        } = arg1;
        assert!(v9 == 1, 20);
        assert!(0x2::object::uid_to_inner(&v10) == v12, 0);
        assert!(v6 == 0 && v5 == 0, 2);
        0x2::object::delete(v11);
        0x2::object::delete(v10);
    }

    entry fun default(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3, v4) = new_with_policy(arg0, arg1);
        0x2::transfer::share_object<AgentSigner>(v1);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::share(v3);
        0x2::transfer::transfer<AgentSignerOwnerCap>(v2, v0);
        0x2::transfer::public_transfer<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap>(v4, v0);
    }

    public fun destination_count(arg0: &AgentSigner) : u64 {
        arg0.destination_count
    }

    public fun draw<T0, T1: drop>(arg0: T1, arg1: &mut AgentSigner, arg2: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg3: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg4: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg5: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.connectors, &v0), 35);
        draw_internal<T0>(arg1, arg2, arg3, arg4, arg5, 0x1::option::some<0x1::type_name::TypeName>(v0), arg6, arg7)
    }

    fun draw_internal<T0>(arg0: &mut AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_version(arg0);
        assert!(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::signer_id(&arg2) == 0x2::object::id<AgentSigner>(arg0), 7);
        assert!(0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy>(arg1) == arg0.policy_id, 8);
        assert!(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::intent_hash(&arg2) == *0x2::tx_context::digest(arg7), 19);
        assert!(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::coin(&arg2) == 0x1::type_name::with_original_ids<T0>(), 32);
        let v0 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::amount(&arg2);
        assert!(v0 > 0, 34);
        assert_pinned<0x2::balance::Balance<T0>>(arg0, arg3);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::enforce_request(arg1, &arg2);
        let v1 = 0x2::allowance::app_balance_spend<T0, App>(arg3, 0x2::allowance::spend_permit<App>(0x1::internal::permit<App>()), arg4, arg6, arg7);
        assert!(0x2::balance::value<T0>(&v1) == v0, 33);
        arg0.last_signing_activity_ts = 0x2::clock::timestamp_ms(arg6);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::spend_occurred(0x2::object::id<AgentSigner>(arg0), 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<T0>>>(arg3), 0x2::tx_context::sender(arg7), 0x1::type_name::with_original_ids<T0>(), v0, arg5, 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::destroy_request(arg2));
        v1
    }

    public fun has_access(arg0: &AgentSigner, arg1: &AgentSignerOwnerCap) : bool {
        0x2::object::id<AgentSigner>(arg0) == arg1.for
    }

    public fun is_connector<T0>(arg0: &AgentSigner) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.connectors, &v0)
    }

    public fun is_destination<T0: drop>(arg0: &AgentSigner, arg1: 0x2::object::ID) : bool {
        let v0 = DestinationKey{
            connector : 0x1::type_name::with_original_ids<T0>(),
            id        : arg1,
        };
        0x2::dynamic_field::exists<DestinationKey>(&arg0.id, v0)
    }

    public fun is_open(arg0: &AgentSigner) : bool {
        arg0.open
    }

    public fun is_pinned<T0>(arg0: &AgentSigner, arg1: &0x2::allowance::Allowance<T0>) : bool {
        let v0 = 0x2::allowance::allowance_settings<T0>(arg1);
        0x2::allowance::funder(v0) == arg0.owner && *0x1::string::as_bytes(0x2::allowance::name(v0)) == binding_name(arg0)
    }

    public fun issue_allowance<T0>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: 0x2::allowance::AllowanceProposal<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = 0x2::allowance::allowance_proposal_settings<T0>(&arg2);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 30);
        assert!(*0x1::string::as_bytes(0x2::allowance::name(v0)) == binding_name(arg0), 31);
        let v1 = 0x2::allowance::spender(v0);
        0x2::allowance::issue<T0, App>(arg2, 0x2::allowance::settings_permit<App>(0x1::internal::permit<App>()), arg3);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::allowance_issued(0x2::object::id<AgentSigner>(arg0), 0x1::type_name::with_original_ids<T0>(), *0x1::option::borrow<address>(&v1));
    }

    public fun last_owner_activity_ts(arg0: &AgentSigner) : u64 {
        arg0.last_owner_activity_ts
    }

    public fun last_signing_activity_ts(arg0: &AgentSigner) : u64 {
        arg0.last_signing_activity_ts
    }

    public fun migrate(arg0: &mut AgentSigner) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun new_request<T0>(arg0: &AgentSigner, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest {
        assert_version(arg0);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::new_request<T0>(0x2::object::id<AgentSigner>(arg0), arg0.policy_id, arg1, arg2)
    }

    public fun new_with_policy(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : (AgentSigner, AgentSignerOwnerCap, 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::new(arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy>(&v4);
        let v6 = AgentSigner{
            id                       : 0x2::object::new(arg1),
            owner                    : v0,
            policy_id                : v5,
            open                     : false,
            connectors               : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            destination_count        : 0,
            vault_count              : 0,
            last_owner_activity_ts   : 0x2::tx_context::epoch_timestamp_ms(arg1),
            last_signing_activity_ts : 0,
            version                  : 1,
        };
        let v7 = AgentSignerOwnerCap{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::id<AgentSigner>(&v6),
        };
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::authorization_rule::add(&mut v4, &v3, arg0);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::signer_created(0x2::object::id<AgentSigner>(&v6), v0, v5);
        (v6, v7, v4, v3)
    }

    public fun owner(arg0: &AgentSigner) : address {
        arg0.owner
    }

    public fun owner_take<T0, T1: store + key>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : T1 {
        assert_owner(arg0, arg1);
        let v0 = VaultKey{
            connector : 0x1::type_name::with_original_ids<T0>(),
            key       : arg2,
        };
        arg0.vault_count = arg0.vault_count - 1;
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x2::dynamic_object_field::remove<VaultKey, T1>(&mut arg0.id, v0)
    }

    public fun pay_owner<T0>(arg0: &AgentSigner, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::send_funds<T0>(arg1, arg0.owner);
    }

    public fun policy_id(arg0: &AgentSigner) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun remove_connector<T0: drop>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.connectors, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.connectors, &v0);
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::settings_changed(0x2::object::id<AgentSigner>(arg0));
    }

    public fun remove_destination<T0: drop>(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = DestinationKey{
            connector : 0x1::type_name::with_original_ids<T0>(),
            id        : arg2,
        };
        if (0x2::dynamic_field::exists<DestinationKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<DestinationKey, bool>(&mut arg0.id, v0);
            arg0.destination_count = arg0.destination_count - 1;
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::settings_changed(0x2::object::id<AgentSigner>(arg0));
    }

    public fun set_open(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.open = arg2;
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events::settings_changed(0x2::object::id<AgentSigner>(arg0));
    }

    public fun set_owner(arg0: &mut AgentSigner, arg1: &AgentSignerOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.owner = 0x2::tx_context::sender(arg2);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun signer_owner_cap_for(arg0: &AgentSignerOwnerCap) : 0x2::object::ID {
        arg0.for
    }

    public fun spend<T0>(arg0: &mut AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.open, 37);
        draw_internal<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x1::type_name::TypeName>(), arg5, arg6)
    }

    public fun uid(arg0: &AgentSigner) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut AgentSigner) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun vault_add<T0: drop, T1: store + key>(arg0: &T0, arg1: &mut AgentSigner, arg2: vector<u8>, arg3: T1) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.connectors, &v0), 35);
        let v1 = VaultKey{
            connector : v0,
            key       : arg2,
        };
        0x2::dynamic_object_field::add<VaultKey, T1>(&mut arg1.id, v1, arg3);
        arg1.vault_count = arg1.vault_count + 1;
    }

    public fun vault_borrow<T0, T1: store + key>(arg0: &AgentSigner, arg1: vector<u8>) : &T1 {
        let v0 = VaultKey{
            connector : 0x1::type_name::with_original_ids<T0>(),
            key       : arg1,
        };
        0x2::dynamic_object_field::borrow<VaultKey, T1>(&arg0.id, v0)
    }

    public fun vault_borrow_mut<T0: drop, T1: store + key>(arg0: &T0, arg1: &mut AgentSigner, arg2: vector<u8>) : &mut T1 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.connectors, &v0), 35);
        let v1 = VaultKey{
            connector : v0,
            key       : arg2,
        };
        0x2::dynamic_object_field::borrow_mut<VaultKey, T1>(&mut arg1.id, v1)
    }

    public fun vault_contains<T0>(arg0: &AgentSigner, arg1: vector<u8>) : bool {
        let v0 = VaultKey{
            connector : 0x1::type_name::with_original_ids<T0>(),
            key       : arg1,
        };
        0x2::dynamic_object_field::exists<VaultKey>(&arg0.id, v0)
    }

    public fun vault_count(arg0: &AgentSigner) : u64 {
        arg0.vault_count
    }

    // decompiled from Move bytecode v7
}

