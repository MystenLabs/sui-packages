module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::registry {
    struct ProviderRecord has copy, drop, store {
        provider: address,
        capability: 0x1::string::String,
        endpoint_uri: 0x1::string::String,
        metadata_hash: vector<u8>,
        active: bool,
    }

    struct ProviderRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        providers: vector<ProviderRecord>,
    }

    struct CapabilityPolicy has copy, drop, store {
        capability: 0x1::string::String,
        providers: vector<address>,
        policy_uri: 0x1::string::String,
        policy_hash: vector<u8>,
        schema_version: u64,
    }

    struct ProviderPolicy has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        policies: vector<CapabilityPolicy>,
    }

    struct ProviderRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct ProviderRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        owner: address,
        provider: address,
        capability: 0x1::string::String,
        endpoint_uri: 0x1::string::String,
        active: bool,
        timestamp_ms: u64,
    }

    struct ProviderPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct CapabilityPolicySet has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        capability: 0x1::string::String,
        provider_count: u64,
        policy_uri: 0x1::string::String,
        schema_version: u64,
        timestamp_ms: u64,
    }

    fun assert_capability(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 272);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 276);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 275);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 278);
    }

    fun assert_policy_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ProviderPolicy, arg2: address) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 271);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 271);
    }

    public fun assert_provider_active(arg0: &ProviderRegistry, arg1: vector<u8>, arg2: address) {
        let v0 = 0x1::string::utf8(arg1);
        let (v1, v2) = find_provider(&arg0.providers, arg2, &v0);
        assert!(v1, 279);
        assert!(0x1::vector::borrow<ProviderRecord>(&arg0.providers, v2).active, 279);
    }

    fun assert_registered_providers(arg0: &ProviderRegistry, arg1: &0x1::string::String, arg2: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg2)) {
            let (v1, v2) = find_provider(&arg0.providers, *0x1::vector::borrow<address>(arg2, v0), arg1);
            assert!(v1, 279);
            assert!(0x1::vector::borrow<ProviderRecord>(&arg0.providers, v2).active, 279);
            v0 = v0 + 1;
        };
    }

    fun assert_registry_owner(arg0: &ProviderRegistry, arg1: address) {
        assert!(arg0.owner == arg1, 270);
    }

    fun assert_uri(arg0: &vector<u8>, arg1: u64) {
        assert!(0x1::vector::length<u8>(arg0) > 0, arg1);
        assert!(0x1::vector::length<u8>(arg0) <= 2048, 277);
    }

    public entry fun create_provider_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg2));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        let v0 = ProviderPolicy{
            id           : 0x2::object::new(arg2),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg2),
            policies     : 0x1::vector::empty<CapabilityPolicy>(),
        };
        let v1 = ProviderPolicyCreated{
            policy_id    : 0x2::object::uid_to_inner(&v0.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ProviderPolicyCreated>(v1);
        0x2::transfer::transfer<ProviderPolicy>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create_provider_registry(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProviderRegistry{
            id        : 0x2::object::new(arg1),
            owner     : 0x2::tx_context::sender(arg1),
            providers : 0x1::vector::empty<ProviderRecord>(),
        };
        let v1 = ProviderRegistryCreated{
            registry_id  : 0x2::object::uid_to_inner(&v0.id),
            owner        : 0x2::tx_context::sender(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<ProviderRegistryCreated>(v1);
        0x2::transfer::share_object<ProviderRegistry>(v0);
    }

    fun find_capability_policy(arg0: &vector<CapabilityPolicy>, arg1: &0x1::string::String) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CapabilityPolicy>(arg0)) {
            if (&0x1::vector::borrow<CapabilityPolicy>(arg0, v0).capability == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_provider(arg0: &vector<ProviderRecord>, arg1: address, arg2: &0x1::string::String) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ProviderRecord>(arg0)) {
            let v1 = 0x1::vector::borrow<ProviderRecord>(arg0, v0);
            if (v1.provider == arg1 && &v1.capability == arg2) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun policy_count(arg0: &ProviderPolicy) : u64 {
        0x1::vector::length<CapabilityPolicy>(&arg0.policies)
    }

    public fun provider_count(arg0: &ProviderRegistry) : u64 {
        0x1::vector::length<ProviderRecord>(&arg0.providers)
    }

    public entry fun register_provider(arg0: &mut ProviderRegistry, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_registry_owner(arg0, 0x2::tx_context::sender(arg7));
        assert_capability(&arg2);
        assert_uri(&arg3, 273);
        assert_hash(&arg4);
        let v0 = 0x1::string::utf8(arg2);
        let (v1, v2) = find_provider(&arg0.providers, arg1, &v0);
        let v3 = ProviderRecord{
            provider      : arg1,
            capability    : v0,
            endpoint_uri  : 0x1::string::utf8(arg3),
            metadata_hash : arg4,
            active        : arg5,
        };
        if (v1) {
            *0x1::vector::borrow_mut<ProviderRecord>(&mut arg0.providers, v2) = v3;
        } else {
            0x1::vector::push_back<ProviderRecord>(&mut arg0.providers, v3);
        };
        let v4 = if (v1) {
            v2
        } else {
            0x1::vector::length<ProviderRecord>(&arg0.providers) - 1
        };
        let v5 = 0x1::vector::borrow<ProviderRecord>(&arg0.providers, v4);
        let v6 = ProviderRegistered{
            registry_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            provider     : arg1,
            capability   : v5.capability,
            endpoint_uri : v5.endpoint_uri,
            active       : arg5,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ProviderRegistered>(v6);
    }

    public entry fun set_capability_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ProviderRegistry, arg2: &mut ProviderPolicy, arg3: vector<u8>, arg4: vector<address>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg2, 0x2::tx_context::sender(arg9));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_capability(&arg3);
        assert_uri(&arg5, 274);
        assert_hash(&arg6);
        let v0 = 0x1::string::utf8(arg3);
        assert_registered_providers(arg1, &v0, &arg4);
        let v1 = CapabilityPolicy{
            capability     : v0,
            providers      : arg4,
            policy_uri     : 0x1::string::utf8(arg5),
            policy_hash    : arg6,
            schema_version : arg7,
        };
        let (v2, v3) = find_capability_policy(&arg2.policies, &v1.capability);
        if (v2) {
            *0x1::vector::borrow_mut<CapabilityPolicy>(&mut arg2.policies, v3) = v1;
        } else {
            0x1::vector::push_back<CapabilityPolicy>(&mut arg2.policies, v1);
        };
        let v4 = if (v2) {
            v3
        } else {
            0x1::vector::length<CapabilityPolicy>(&arg2.policies) - 1
        };
        let v5 = 0x1::vector::borrow<CapabilityPolicy>(&arg2.policies, v4);
        let v6 = CapabilityPolicySet{
            policy_id      : 0x2::object::uid_to_inner(&arg2.id),
            character_id   : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner          : 0x2::tx_context::sender(arg9),
            capability     : v5.capability,
            provider_count : 0x1::vector::length<address>(&v5.providers),
            policy_uri     : v5.policy_uri,
            schema_version : arg7,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<CapabilityPolicySet>(v6);
    }

    // decompiled from Move bytecode v7
}

