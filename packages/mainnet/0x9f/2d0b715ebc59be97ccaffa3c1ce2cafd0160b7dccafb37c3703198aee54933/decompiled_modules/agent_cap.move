module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::agent_cap {
    struct AgentCap has key {
        id: 0x2::object::UID,
        owner: address,
        grantee: address,
        managed_fund: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        guardrails_id: 0x1::option::Option<0x2::object::ID>,
        opportunity_allowlist: vector<0x1::string::String>,
        max_allocation_bps: u64,
        active: bool,
        reallocations: u64,
    }

    struct AgentCapGranted has copy, drop {
        cap_id: 0x2::object::ID,
        owner: address,
        grantee: address,
        managed_fund: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        opportunity_count: u64,
        max_allocation_bps: u64,
        guardrails_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AgentCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        owner: address,
    }

    struct Reallocated has copy, drop {
        cap_id: 0x2::object::ID,
        owner: address,
        grantee: address,
        managed_fund: 0x2::object::ID,
        from_opportunity: 0x1::string::String,
        to_opportunity: 0x1::string::String,
        amount_micros: u64,
        allocation_bps: u64,
        guardrails_hash: vector<u8>,
        sequence: u64,
    }

    public fun allowlist_len(arg0: &AgentCap) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.opportunity_allowlist)
    }

    public fun authorize_reallocate(arg0: &mut AgentCap, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.grantee, 10);
        assert!(arg1 == arg0.managed_fund, 11);
        assert!(arg0.active, 2);
        assert!(arg5 > 0, 7);
        assert!(arg2 == arg0.guardrails_hash, 4);
        assert!(arg6 > 0 && arg6 <= arg0.max_allocation_bps, 8);
        assert!(!string_eq(&arg3, &arg4), 9);
        assert!(contains(&arg0.opportunity_allowlist, &arg3), 3);
        assert!(contains(&arg0.opportunity_allowlist, &arg4), 3);
        arg0.reallocations = arg0.reallocations + 1;
        let v0 = Reallocated{
            cap_id           : 0x2::object::id<AgentCap>(arg0),
            owner            : arg0.owner,
            grantee          : arg0.grantee,
            managed_fund     : arg0.managed_fund,
            from_opportunity : arg3,
            to_opportunity   : arg4,
            amount_micros    : arg5,
            allocation_bps   : arg6,
            guardrails_hash  : arg0.guardrails_hash,
            sequence         : arg0.reallocations,
        };
        0x2::event::emit<Reallocated>(v0);
    }

    public fun authorize_reallocate_guarded(arg0: &mut AgentCap, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.grantee, 10);
        assert!(arg2 == arg0.managed_fund, 11);
        assert!(arg0.active, 2);
        assert!(arg5 > 0, 7);
        assert!(arg6 > 0, 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.guardrails_id), 14);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::id(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.guardrails_id), 13);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::guardrails_hash(arg1) == arg0.guardrails_hash, 4);
        assert!(!string_eq(&arg3, &arg4), 9);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::assert_allocation_allowed(arg1, *0x1::string::as_bytes(&arg3), arg6);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::assert_allocation_allowed(arg1, *0x1::string::as_bytes(&arg4), arg6);
        arg0.reallocations = arg0.reallocations + 1;
        let v0 = Reallocated{
            cap_id           : 0x2::object::id<AgentCap>(arg0),
            owner            : arg0.owner,
            grantee          : arg0.grantee,
            managed_fund     : arg0.managed_fund,
            from_opportunity : arg3,
            to_opportunity   : arg4,
            amount_micros    : arg5,
            allocation_bps   : arg6,
            guardrails_hash  : arg0.guardrails_hash,
            sequence         : arg0.reallocations,
        };
        0x2::event::emit<Reallocated>(v0);
    }

    fun contains(arg0: &vector<0x1::string::String>, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            if (string_eq(0x1::vector::borrow<0x1::string::String>(arg0, v0), arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun grant(arg0: address, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        grant_internal(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), arg3, arg4, arg5)
    }

    public fun grant_bound(arg0: address, arg1: 0x2::object::ID, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        grant_internal(arg0, arg1, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::guardrails_hash(arg2), 0x1::option::some<0x2::object::ID>(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::id(arg2)), opportunity_slugs_as_strings(arg2), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::max_allocation_bps(arg2), arg3)
    }

    fun grant_internal(arg0: address, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: vector<0x1::string::String>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 6);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg4), 5);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) <= 64, 12);
        assert!(arg5 > 0 && arg5 <= 10000, 8);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = AgentCap{
            id                    : 0x2::object::new(arg6),
            owner                 : v0,
            grantee               : arg0,
            managed_fund          : arg1,
            guardrails_hash       : arg2,
            guardrails_id         : arg3,
            opportunity_allowlist : arg4,
            max_allocation_bps    : arg5,
            active                : true,
            reallocations         : 0,
        };
        let v2 = 0x2::object::id<AgentCap>(&v1);
        let v3 = AgentCapGranted{
            cap_id             : v2,
            owner              : v0,
            grantee            : arg0,
            managed_fund       : arg1,
            guardrails_hash    : v1.guardrails_hash,
            opportunity_count  : 0x1::vector::length<0x1::string::String>(&v1.opportunity_allowlist),
            max_allocation_bps : arg5,
            guardrails_id      : v1.guardrails_id,
        };
        0x2::event::emit<AgentCapGranted>(v3);
        0x2::transfer::share_object<AgentCap>(v1);
        v2
    }

    public fun grantee(arg0: &AgentCap) : address {
        arg0.grantee
    }

    public fun guardrails_hash(arg0: &AgentCap) : vector<u8> {
        arg0.guardrails_hash
    }

    public fun guardrails_id(arg0: &AgentCap) : 0x1::option::Option<0x2::object::ID> {
        arg0.guardrails_id
    }

    public fun in_scope(arg0: &AgentCap, arg1: &0x1::string::String) : bool {
        arg0.active && contains(&arg0.opportunity_allowlist, arg1)
    }

    public fun is_active(arg0: &AgentCap) : bool {
        arg0.active
    }

    public fun is_guardrails_bound(arg0: &AgentCap) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.guardrails_id)
    }

    public fun managed_fund(arg0: &AgentCap) : 0x2::object::ID {
        arg0.managed_fund
    }

    public fun max_allocation_bps(arg0: &AgentCap) : u64 {
        arg0.max_allocation_bps
    }

    fun opportunity_slugs_as_strings(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails) : vector<0x1::string::String> {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::opportunity_allowlist(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun owner(arg0: &AgentCap) : address {
        arg0.owner
    }

    public fun reallocations(arg0: &AgentCap) : u64 {
        arg0.reallocations
    }

    public fun revoke(arg0: &mut AgentCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = false;
        arg0.opportunity_allowlist = 0x1::vector::empty<0x1::string::String>();
        let v0 = AgentCapRevoked{
            cap_id : 0x2::object::id<AgentCap>(arg0),
            owner  : arg0.owner,
        };
        0x2::event::emit<AgentCapRevoked>(v0);
    }

    fun string_eq(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        0x1::string::as_bytes(arg0) == 0x1::string::as_bytes(arg1)
    }

    // decompiled from Move bytecode v7
}

