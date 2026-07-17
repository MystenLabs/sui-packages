module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails {
    struct Guardrails has store, key {
        id: 0x2::object::UID,
        guardrails_hash: vector<u8>,
        canonical_preimage: vector<u8>,
        asset_allowlist: vector<vector<u8>>,
        opportunity_allowlist: vector<vector<u8>>,
        max_allocation_bps: u64,
        strategy_lead: address,
    }

    struct GuardrailsCreated has copy, drop {
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        max_allocation_bps: u64,
        asset_count: u64,
        opportunity_count: u64,
        strategy_lead: address,
    }

    public fun id(arg0: &Guardrails) : 0x2::object::ID {
        0x2::object::id<Guardrails>(arg0)
    }

    public fun allocation_allowed(arg0: &Guardrails, arg1: vector<u8>, arg2: u64) : bool {
        if (!contains_bytes(&arg0.opportunity_allowlist, &arg1)) {
            return false
        };
        if (arg2 == 0 || arg2 > arg0.max_allocation_bps) {
            return false
        };
        true
    }

    public fun assert_allocation_allowed(arg0: &Guardrails, arg1: vector<u8>, arg2: u64) {
        assert!(contains_bytes(&arg0.opportunity_allowlist, &arg1), 5);
        assert!(arg2 >= 1 && arg2 <= arg0.max_allocation_bps, 6);
    }

    public fun assert_allocation_with_asset(arg0: &Guardrails, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        assert!(contains_bytes(&arg0.asset_allowlist, &arg2), 7);
        assert_allocation_allowed(arg0, arg1, arg3);
    }

    public fun asset_allowed(arg0: &Guardrails, arg1: vector<u8>) : bool {
        contains_bytes(&arg0.asset_allowlist, &arg1)
    }

    public fun asset_allowlist(arg0: &Guardrails) : vector<vector<u8>> {
        arg0.asset_allowlist
    }

    public fun canonical_preimage(arg0: &Guardrails) : vector<u8> {
        arg0.canonical_preimage
    }

    fun contains_bytes(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (0x1::vector::borrow<vector<u8>>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_and_freeze(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 8);
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg2), 2);
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg3), 3);
        assert!(arg4 >= 1 && arg4 <= 10000, 4);
        assert!(0x1::hash::sha2_256(arg1) == arg0, 1);
        let v0 = Guardrails{
            id                    : 0x2::object::new(arg5),
            guardrails_hash       : arg0,
            canonical_preimage    : arg1,
            asset_allowlist       : arg2,
            opportunity_allowlist : arg3,
            max_allocation_bps    : arg4,
            strategy_lead         : 0x2::tx_context::sender(arg5),
        };
        let v1 = 0x2::object::id<Guardrails>(&v0);
        let v2 = GuardrailsCreated{
            guardrails_id      : v1,
            guardrails_hash    : v0.guardrails_hash,
            max_allocation_bps : v0.max_allocation_bps,
            asset_count        : 0x1::vector::length<vector<u8>>(&v0.asset_allowlist),
            opportunity_count  : 0x1::vector::length<vector<u8>>(&v0.opportunity_allowlist),
            strategy_lead      : v0.strategy_lead,
        };
        0x2::event::emit<GuardrailsCreated>(v2);
        0x2::transfer::freeze_object<Guardrails>(v0);
        v1
    }

    public fun guardrails_hash(arg0: &Guardrails) : vector<u8> {
        arg0.guardrails_hash
    }

    public fun matches_hash(arg0: &Guardrails, arg1: vector<u8>) : bool {
        arg1 == arg0.guardrails_hash
    }

    public fun max_allocation_bps(arg0: &Guardrails) : u64 {
        arg0.max_allocation_bps
    }

    public fun opportunity_allowlist(arg0: &Guardrails) : vector<vector<u8>> {
        arg0.opportunity_allowlist
    }

    public fun strategy_lead(arg0: &Guardrails) : address {
        arg0.strategy_lead
    }

    public fun verify_hash(arg0: &Guardrails) : bool {
        0x1::hash::sha2_256(arg0.canonical_preimage) == arg0.guardrails_hash
    }

    // decompiled from Move bytecode v7
}

