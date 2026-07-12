module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::authority {
    struct RevocationRegistry has key {
        id: 0x2::object::UID,
        revoked_caps: vector<0x2::object::ID>,
    }

    struct AgentCap has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        delegate: address,
        scopes: vector<u8>,
        provider_bound: bool,
        provider: address,
        expires_at_ms: u64,
        issued_at_ms: u64,
    }

    struct AccessPolicy has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        resource_commitment: vector<u8>,
        policy_uri: 0x1::string::String,
        policy_hash: vector<u8>,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct AgentCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        delegate: address,
        provider_bound: bool,
        provider: address,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct AgentCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct AccessPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct AccessPolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct SealAccessAuthorized has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        delegate: address,
        provider: address,
        scope: u8,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct HubRevocationRegistryBound has copy, drop {
        hub_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    fun assert_cap_common(arg0: &AgentCap, arg1: &RevocationRegistry, arg2: address, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.delegate, 101);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_caps, &v0), 104);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_at_ms, 103);
        assert!(0x1::vector::contains<u8>(&arg0.scopes, &arg3), 105);
        if (arg0.provider_bound) {
            assert!(arg0.provider == arg2, 106);
        };
    }

    public fun assert_cap_scope(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &AgentCap, arg2: &RevocationRegistry, arg3: address, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 102);
        assert!(arg1.owner == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::owner(arg0), 100);
        assert_cap_common(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun assert_cap_scope_via_hub(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub, arg1: &AgentCap, arg2: &RevocationRegistry, arg3: address, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_hub_not_paused(arg0);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_hub_registry(arg0, 0x2::object::id<RevocationRegistry>(arg2));
        assert!(arg1.character_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg0), 102);
        assert!(arg1.owner == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_owner(arg0), 100);
        assert_cap_common(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun assert_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, arg1);
    }

    fun assert_owner_address(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 100);
    }

    fun assert_valid_commitment(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 108);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 110);
    }

    fun assert_valid_uri_hash(arg0: &vector<u8>, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 108);
        assert!(0x1::vector::length<u8>(arg0) <= 2048, 109);
        assert_valid_commitment(arg1);
    }

    entry fun authorize_seal_access(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &AccessPolicy, arg2: &AgentCap, arg3: &RevocationRegistry, arg4: address, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 102);
        assert_cap_scope(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = SealAccessAuthorized{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            cap_id       : 0x2::object::uid_to_inner(&arg2.id),
            delegate     : arg2.delegate,
            provider     : arg4,
            scope        : arg5,
            nonce        : arg1.nonce,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<SealAccessAuthorized>(v0);
    }

    entry fun authorize_seal_access_via_hub(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub, arg1: &AccessPolicy, arg2: &AgentCap, arg3: &RevocationRegistry, arg4: address, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.character_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg0), 102);
        assert_cap_scope_via_hub(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = SealAccessAuthorized{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg0),
            cap_id       : 0x2::object::uid_to_inner(&arg2.id),
            delegate     : arg2.delegate,
            provider     : arg4,
            scope        : arg5,
            nonce        : arg1.nonce,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<SealAccessAuthorized>(v0);
    }

    public fun cap_character_id(arg0: &AgentCap) : 0x2::object::ID {
        arg0.character_id
    }

    public fun cap_delegate(arg0: &AgentCap) : address {
        arg0.delegate
    }

    public fun cap_expires_at_ms(arg0: &AgentCap) : u64 {
        arg0.expires_at_ms
    }

    public fun cap_has_scope(arg0: &AgentCap, arg1: u8) : bool {
        0x1::vector::contains<u8>(&arg0.scopes, &arg1)
    }

    public fun cap_owner(arg0: &AgentCap) : address {
        arg0.owner
    }

    entry fun create_access_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg5));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_valid_commitment(&arg1);
        assert_valid_uri_hash(&arg2, &arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = AccessPolicy{
            id                  : 0x2::object::new(arg5),
            character_id        : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner               : 0x2::tx_context::sender(arg5),
            resource_commitment : arg1,
            policy_uri          : 0x1::string::utf8(arg2),
            policy_hash         : arg3,
            nonce               : 0,
            created_at_ms       : v0,
            updated_at_ms       : v0,
        };
        let v2 = AccessPolicyCreated{
            policy_id    : 0x2::object::uid_to_inner(&v1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg5),
            policy_uri   : v1.policy_uri,
            nonce        : v1.nonce,
            timestamp_ms : v0,
        };
        0x2::event::emit<AccessPolicyCreated>(v2);
        0x2::transfer::public_transfer<AccessPolicy>(v1, 0x2::tx_context::sender(arg5));
    }

    entry fun create_and_bind_hub_revocation_registry(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RevocationRegistry{
            id           : 0x2::object::new(arg2),
            revoked_caps : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::bind_hub_revocation_registry_id(arg0, v1);
        let v2 = HubRevocationRegistryBound{
            hub_id       : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub>(arg0),
            character_id : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg0),
            registry_id  : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<HubRevocationRegistryBound>(v2);
        0x2::transfer::share_object<RevocationRegistry>(v0);
    }

    entry fun create_revocation_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RevocationRegistry{
            id           : 0x2::object::new(arg0),
            revoked_caps : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<RevocationRegistry>(v0);
    }

    fun do_issue_cap(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: bool, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 107);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = AgentCap{
            id             : 0x2::object::new(arg7),
            character_id   : arg0,
            owner          : 0x2::tx_context::sender(arg7),
            delegate       : arg1,
            scopes         : arg2,
            provider_bound : arg3,
            provider       : arg4,
            expires_at_ms  : arg5,
            issued_at_ms   : v0,
        };
        let v2 = AgentCapIssued{
            cap_id         : 0x2::object::uid_to_inner(&v1.id),
            character_id   : arg0,
            owner          : 0x2::tx_context::sender(arg7),
            delegate       : arg1,
            provider_bound : arg3,
            provider       : arg4,
            expires_at_ms  : arg5,
            timestamp_ms   : v0,
        };
        0x2::event::emit<AgentCapIssued>(v2);
        0x2::transfer::transfer<AgentCap>(v1, arg1);
    }

    fun do_revoke_cap(arg0: 0x2::object::ID, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        if (!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_caps, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_caps, arg2);
        };
        let v0 = AgentCapRevoked{
            cap_id       : arg2,
            character_id : arg0,
            owner        : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AgentCapRevoked>(v0);
    }

    public fun is_cap_revoked(arg0: &RevocationRegistry, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &arg1)
    }

    entry fun issue_agent_cap(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address, arg2: vector<u8>, arg3: bool, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg7));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        do_issue_cap(0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun issue_agent_cap_via_hub(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub, arg1: address, arg2: vector<u8>, arg3: bool, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_hub_owner(arg0, 0x2::tx_context::sender(arg7));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_hub_not_paused(arg0);
        do_issue_cap(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun policy_nonce(arg0: &AccessPolicy) : u64 {
        arg0.nonce
    }

    public fun registry_revoked_count(arg0: &RevocationRegistry) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.revoked_caps)
    }

    entry fun revoke_agent_cap(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg4));
        do_revoke_cap(0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), arg1, arg2, arg3, arg4);
    }

    entry fun revoke_agent_cap_via_hub(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_hub_owner(arg0, 0x2::tx_context::sender(arg4));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_hub_registry(arg0, 0x2::object::id<RevocationRegistry>(arg1));
        do_revoke_cap(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg0), arg1, arg2, arg3, arg4);
    }

    public fun scope_authorize_payment() : u8 {
        4
    }

    public fun scope_read_encrypted() : u8 {
        2
    }

    public fun scope_request_inference() : u8 {
        1
    }

    public fun scope_write_memory() : u8 {
        3
    }

    entry fun update_access_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut AccessPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg6));
        assert_owner_address(arg1.owner, 0x2::tx_context::sender(arg6));
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 102);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_valid_commitment(&arg2);
        assert_valid_uri_hash(&arg3, &arg4);
        arg1.resource_commitment = arg2;
        arg1.policy_uri = 0x1::string::utf8(arg3);
        arg1.policy_hash = arg4;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = AccessPolicyUpdated{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg6),
            policy_uri   : arg1.policy_uri,
            nonce        : arg1.nonce,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<AccessPolicyUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

