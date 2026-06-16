module 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::resolver {
    struct ResolverRef has store, key {
        id: 0x2::object::UID,
        kind: u8,
        config: vector<u8>,
    }

    struct MergeProposal has key {
        id: 0x2::object::UID,
        tree_id: 0x2::object::ID,
        from_branch: 0x1::string::String,
        into_branch: 0x1::string::String,
        from_head: vector<u8>,
        into_head: vector<u8>,
        resolver: 0x2::object::ID,
        proposed_by: address,
        proposed_at_ms: u64,
        expires_at_ms: u64,
        status: u8,
        resolved_memwal_namespace: 0x1::option::Option<0x1::string::String>,
        resolved_memwal_blob_id: 0x1::option::Option<vector<u8>>,
        attestations: vector<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>,
    }

    struct MergeProposed has copy, drop {
        tree_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        from_branch: 0x1::string::String,
        into_branch: 0x1::string::String,
        from_head_blob_id: vector<u8>,
        into_head_blob_id: vector<u8>,
        resolver_id: 0x2::object::ID,
        expires_at_ms: u64,
    }

    struct AttestationSubmitted has copy, drop {
        proposal_id: 0x2::object::ID,
        signer: address,
        kind: u8,
    }

    struct MergeFinalized has copy, drop {
        tree_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        merge_commit_id: 0x2::object::ID,
        resolved_blob_id: vector<u8>,
    }

    struct MergeAborted has copy, drop {
        proposal_id: 0x2::object::ID,
        reason_code: u8,
    }

    struct MergeExpired has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    public fun abort_merge(arg0: &0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::MemoryTree, arg1: &mut MergeProposal, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == status_pending(), 16);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.proposed_by || v0 == 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::owner(arg0), 1);
        arg1.status = status_aborted();
        let v1 = MergeAborted{
            proposal_id : 0x2::object::id<MergeProposal>(arg1),
            reason_code : 0,
        };
        0x2::event::emit<MergeAborted>(v1);
    }

    fun can_submit(arg0: &vector<u8>, arg1: u8, arg2: address, arg3: u8) : bool {
        if (arg1 == 0 || arg1 == 1) {
            return false
        };
        if (arg1 == 2) {
            return can_submit_llm(arg0, arg2, arg3)
        };
        if (arg1 == 3) {
            return can_submit_jury(arg0, arg2, arg3)
        };
        if (arg1 == 5 || arg1 == 6) {
            return can_submit_composed(arg0, arg2, arg3)
        };
        false
    }

    fun can_submit_composed(arg0: &vector<u8>, arg1: address, arg2: u8) : bool {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v2 = 0x2::bcs::peel_vec_u8(&mut v0);
            if (can_submit(&v2, 0x2::bcs::peel_u8(&mut v0), arg1, arg2)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun can_submit_jury(arg0: &vector<u8>, arg1: address, arg2: u8) : bool {
        if (arg2 != 1) {
            return false
        };
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x2::bcs::peel_vec_address(&mut v0);
        0x1::vector::contains<address>(&v1, &arg1)
    }

    fun can_submit_llm(arg0: &vector<u8>, arg1: address, arg2: u8) : bool {
        if (arg2 != 4) {
            return false
        };
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x2::bcs::peel_option_address(&mut v0);
        0x1::option::is_some<address>(&v1) && arg1 == *0x1::option::borrow<address>(&v1) || true
    }

    public fun claim_expired(arg0: &mut MergeProposal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == status_pending(), 16);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.expires_at_ms, 17);
        arg0.status = status_expired();
        let v0 = MergeExpired{proposal_id: 0x2::object::id<MergeProposal>(arg0)};
        0x2::event::emit<MergeExpired>(v0);
    }

    fun composed_depth_leaves(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = arg1;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v4 = 0x2::bcs::peel_u8(&mut v0);
            let v5 = 0x2::bcs::peel_vec_u8(&mut v0);
            if (v4 == kind_sequence() || v4 == kind_and()) {
                let (v6, v7) = composed_depth_leaves(&v5, arg1 + 1);
                if (v6 > arg1) {
                    v1 = v6;
                };
                v2 = v2 + v7;
            } else {
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun create_and_keep_resolver(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ResolverRef>(create_resolver(arg0, arg1, arg2));
    }

    public fun create_resolver(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : ResolverRef {
        if (arg0 == kind_sequence() || arg0 == kind_and()) {
            let (v0, v1) = composed_depth_leaves(&arg1, 1);
            assert!(v0 <= 4, 23);
            assert!(v1 <= 16, 23);
        };
        ResolverRef{
            id     : 0x2::object::new(arg2),
            kind   : arg0,
            config : arg1,
        }
    }

    public fun finalize_merge(arg0: &mut 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::MemoryTree, arg1: &mut MergeProposal, arg2: &ResolverRef, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == status_pending(), 16);
        assert!(0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::has_permission(arg0, 0x2::tx_context::sender(arg6), 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::perm_merge(), &arg1.into_branch, 0x2::tx_context::epoch(arg6)), 2);
        assert!(0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::branch_head(arg0, &arg1.into_branch) == arg1.into_head, 18);
        assert!(verdict_approved(&arg2.config, arg2.kind, &arg1.attestations), 19);
        let v0 = 0x1::string::utf8(arg3);
        let v1 = 0x2::object::id<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::MemoryTree>(arg0);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = &mut v2;
        0x1::vector::push_back<vector<u8>>(v3, arg1.from_head);
        0x1::vector::push_back<vector<u8>>(v3, arg1.into_head);
        0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::advance_branch(arg0, &arg1.into_branch, arg4);
        arg1.status = status_finalized();
        arg1.resolved_memwal_namespace = 0x1::option::some<0x1::string::String>(v0);
        arg1.resolved_memwal_blob_id = 0x1::option::some<vector<u8>>(arg4);
        let v4 = MergeFinalized{
            tree_id          : v1,
            proposal_id      : 0x2::object::id<MergeProposal>(arg1),
            merge_commit_id  : 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::mint_merge_commit(v1, v2, v0, arg4, 0x2::tx_context::sender(arg6), arg1.into_branch, 0x1::string::utf8(b"merge"), arg1.resolver, arg1.attestations, 0x2::tx_context::epoch(arg6), arg5, arg6),
            resolved_blob_id : arg4,
        };
        0x2::event::emit<MergeFinalized>(v4);
    }

    public fun kind_and() : u8 {
        5
    }

    public fun kind_evaluator_pick() : u8 {
        4
    }

    public fun kind_jury_reconcile() : u8 {
        3
    }

    public fun kind_last_write_wins() : u8 {
        0
    }

    public fun kind_llm_reconcile() : u8 {
        2
    }

    public fun kind_sequence() : u8 {
        6
    }

    public fun kind_union() : u8 {
        1
    }

    public fun proposal_from_branch(arg0: &MergeProposal) : &0x1::string::String {
        &arg0.from_branch
    }

    public fun proposal_from_head(arg0: &MergeProposal) : vector<u8> {
        arg0.from_head
    }

    public fun proposal_into_branch(arg0: &MergeProposal) : &0x1::string::String {
        &arg0.into_branch
    }

    public fun proposal_into_head(arg0: &MergeProposal) : vector<u8> {
        arg0.into_head
    }

    public fun proposal_status(arg0: &MergeProposal) : u8 {
        arg0.status
    }

    public fun proposal_tree_id(arg0: &MergeProposal) : 0x2::object::ID {
        arg0.tree_id
    }

    public fun propose_merge(arg0: &0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::MemoryTree, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &ResolverRef, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::utf8(arg2);
        let v2 = 0x2::tx_context::sender(arg8);
        assert!(0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::has_permission(arg0, v2, 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::perm_propose(), &v0, 0x2::tx_context::epoch(arg8)), 2);
        assert!(0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::has_branch(arg0, &v0), 2);
        assert!(0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::has_branch(arg0, &v1), 2);
        let v3 = 0x2::object::id<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::MemoryTree>(arg0);
        let v4 = 0x2::object::id<ResolverRef>(arg5);
        let v5 = 0x2::clock::timestamp_ms(arg7);
        let v6 = MergeProposal{
            id                        : 0x2::object::new(arg8),
            tree_id                   : v3,
            from_branch               : v0,
            into_branch               : v1,
            from_head                 : arg3,
            into_head                 : arg4,
            resolver                  : v4,
            proposed_by               : v2,
            proposed_at_ms            : v5,
            expires_at_ms             : v5 + arg6,
            status                    : status_pending(),
            resolved_memwal_namespace : 0x1::option::none<0x1::string::String>(),
            resolved_memwal_blob_id   : 0x1::option::none<vector<u8>>(),
            attestations              : 0x1::vector::empty<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>(),
        };
        let v7 = MergeProposed{
            tree_id           : v3,
            proposal_id       : 0x2::object::id<MergeProposal>(&v6),
            from_branch       : v0,
            into_branch       : v1,
            from_head_blob_id : v6.from_head,
            into_head_blob_id : v6.into_head,
            resolver_id       : v4,
            expires_at_ms     : v6.expires_at_ms,
        };
        0x2::event::emit<MergeProposed>(v7);
        0x2::transfer::share_object<MergeProposal>(v6);
    }

    public fun resolver_config(arg0: &ResolverRef) : &vector<u8> {
        &arg0.config
    }

    public fun resolver_kind(arg0: &ResolverRef) : u8 {
        arg0.kind
    }

    public fun status_aborted() : u8 {
        2
    }

    public fun status_expired() : u8 {
        3
    }

    public fun status_finalized() : u8 {
        1
    }

    public fun status_pending() : u8 {
        0
    }

    public fun submit_attestation(arg0: &mut MergeProposal, arg1: &ResolverRef, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == status_pending(), 16);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg4, &arg3), 22);
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg4);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&v0)) == 0x2::tx_context::sender(arg6), 22);
        assert!(can_submit(&arg1.config, arg1.kind, 0x2::tx_context::sender(arg6), arg2), 22);
        let v1 = 0x2::tx_context::sender(arg6);
        0x1::vector::push_back<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>(&mut arg0.attestations, 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::new_attestation(v1, arg2, arg3));
        let v2 = AttestationSubmitted{
            proposal_id : 0x2::object::id<MergeProposal>(arg0),
            signer      : v1,
            kind        : arg2,
        };
        0x2::event::emit<AttestationSubmitted>(v2);
    }

    fun verdict_and(arg0: &vector<u8>, arg1: &vector<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>) : bool {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v2 = 0x2::bcs::peel_vec_u8(&mut v0);
            if (!verdict_approved(&v2, 0x2::bcs::peel_u8(&mut v0), arg1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun verdict_approved(arg0: &vector<u8>, arg1: u8, arg2: &vector<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>) : bool {
        if (arg1 == 0 || arg1 == 1) {
            return true
        };
        if (arg1 == 2) {
            return verdict_llm(arg0, arg2)
        };
        if (arg1 == 3) {
            return verdict_jury(arg0, arg2)
        };
        if (arg1 == 5) {
            return verdict_and(arg0, arg2)
        };
        if (arg1 == 6) {
            return verdict_sequence(arg0, arg2)
        };
        false
    }

    fun verdict_jury(arg0: &vector<u8>, arg1: &vector<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>) : bool {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x2::bcs::peel_vec_address(&mut v0);
        0x2::bcs::peel_u8(&mut v0);
        let v2 = vector[];
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>(arg1)) {
            let v5 = 0x1::vector::borrow<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>(arg1, v4);
            let v6 = 0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::attest_signer(v5);
            let v7 = if (0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::attest_kind(v5) == 1) {
                if (0x1::vector::contains<address>(&v1, &v6)) {
                    !0x1::vector::contains<address>(&v2, &v6)
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                0x1::vector::push_back<address>(&mut v2, v6);
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        v3 >= (0x2::bcs::peel_u8(&mut v0) as u64)
    }

    fun verdict_llm(arg0: &vector<u8>, arg1: &vector<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>) : bool {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x2::bcs::peel_option_address(&mut v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>(arg1)) {
            let v4 = 0x1::vector::borrow<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>(arg1, v3);
            if (0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::attest_kind(v4) == 4) {
                if (0x1::option::is_some<address>(&v1)) {
                    if (0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::attest_signer(v4) == *0x1::option::borrow<address>(&v1)) {
                        v2 = v2 + 1;
                    };
                } else {
                    v2 = v2 + 1;
                };
            };
            v3 = v3 + 1;
        };
        v2 >= 1
    }

    fun verdict_sequence(arg0: &vector<u8>, arg1: &vector<0xc13cc014fb8084b3468f6e5ffdc272e64ef35b7a912332eba7a0d44dd66b3121::tree::Attestation>) : bool {
        verdict_and(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

