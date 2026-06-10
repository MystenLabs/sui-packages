module 0x7df9719d799386d34d657c49ae8cd6f5f03b39036f7c428b556095e42afd852f::tree {
    struct MemoryTree has key {
        id: 0x2::object::UID,
        owner: address,
        memwal_account: 0x2::object::ID,
        branches: 0x2::table::Table<0x1::string::String, vector<u8>>,
        default_branch: 0x1::string::String,
        delegates: 0x2::table::Table<address, DelegateCap>,
        commit_count: u64,
        created_at_ms: u64,
    }

    struct MemoryCommit has store, key {
        id: 0x2::object::UID,
        tree_id: 0x2::object::ID,
        parents: vector<vector<u8>>,
        memwal_namespace: 0x1::string::String,
        memwal_blob_id: vector<u8>,
        author: address,
        author_branch: 0x1::string::String,
        message: 0x1::string::String,
        merge_resolver: 0x1::option::Option<0x2::object::ID>,
        attestations: vector<Attestation>,
        epoch: u64,
        ts_ms: u64,
    }

    struct DelegateCap has drop, store {
        agent: address,
        allowed_branches: vector<0x1::string::String>,
        permissions: u8,
        expires_epoch: u64,
        revoked: bool,
    }

    struct Attestation has copy, drop, store {
        signer: address,
        kind: u8,
        payload: vector<u8>,
    }

    struct TreeCreated has copy, drop {
        tree_id: 0x2::object::ID,
        owner: address,
        memwal_account: 0x2::object::ID,
        default_branch: 0x1::string::String,
        ts_ms: u64,
    }

    struct DelegateGranted has copy, drop {
        tree_id: 0x2::object::ID,
        agent: address,
        permissions: u8,
        expires_epoch: u64,
    }

    struct DelegateRevoked has copy, drop {
        tree_id: 0x2::object::ID,
        agent: address,
    }

    struct BranchCreated has copy, drop {
        tree_id: 0x2::object::ID,
        branch: 0x1::string::String,
        from_branch: 0x1::string::String,
        memwal_namespace: 0x1::string::String,
    }

    public fun advance_branch(arg0: &mut MemoryTree, arg1: &0x1::string::String, arg2: vector<u8>) {
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.branches, *arg1), 6);
        0x2::table::remove<0x1::string::String, vector<u8>>(&mut arg0.branches, *arg1);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.branches, *arg1, arg2);
        arg0.commit_count = arg0.commit_count + 1;
    }

    fun assert_delegate(arg0: &MemoryTree, arg1: address, arg2: u8, arg3: &0x1::string::String, arg4: u64) {
        assert!(0x2::table::contains<address, DelegateCap>(&arg0.delegates, arg1), 2);
        let v0 = 0x2::table::borrow<address, DelegateCap>(&arg0.delegates, arg1);
        assert!(!v0.revoked, 3);
        assert!(v0.expires_epoch >= arg4, 4);
        assert!(v0.permissions & arg2 == arg2, 5);
        if (!0x1::vector::is_empty<0x1::string::String>(&v0.allowed_branches)) {
            let v1 = false;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&v0.allowed_branches)) {
                if (*0x1::vector::borrow<0x1::string::String>(&v0.allowed_branches, v2) == *arg3) {
                    v1 = true;
                    break
                };
                v2 = v2 + 1;
            };
            assert!(v1, 8);
        };
    }

    public fun attest_evaluator_verdict() : u8 {
        2
    }

    public fun attest_jury_vote() : u8 {
        1
    }

    public fun attest_kind(arg0: &Attestation) : u8 {
        arg0.kind
    }

    public fun attest_llm_resolve() : u8 {
        4
    }

    public fun attest_oracle_report() : u8 {
        3
    }

    public fun attest_payload(arg0: &Attestation) : &vector<u8> {
        &arg0.payload
    }

    public fun attest_signer(arg0: &Attestation) : address {
        arg0.signer
    }

    public fun branch(arg0: &mut MemoryTree, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::utf8(arg2);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.branches, v0), 6);
        assert!(!0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.branches, v1), 7);
        assert_delegate(arg0, 0x2::tx_context::sender(arg3), perm_fork(), &v0, 0x2::tx_context::epoch(arg3));
        let v2 = 0x2::object::id<MemoryTree>(arg0);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.branches, v1, *0x2::table::borrow<0x1::string::String, vector<u8>>(&arg0.branches, v0));
        let v3 = branch_namespace(0x2::object::id_to_bytes(&v2), &v1);
        0x7df9719d799386d34d657c49ae8cd6f5f03b39036f7c428b556095e42afd852f::acl::create(v2, v1, v3, arg3);
        let v4 = BranchCreated{
            tree_id          : v2,
            branch           : v1,
            from_branch      : v0,
            memwal_namespace : v3,
        };
        0x2::event::emit<BranchCreated>(v4);
    }

    public fun branch_head(arg0: &MemoryTree, arg1: &0x1::string::String) : vector<u8> {
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.branches, *arg1), 6);
        *0x2::table::borrow<0x1::string::String, vector<u8>>(&arg0.branches, *arg1)
    }

    fun branch_namespace(arg0: vector<u8>, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"memforks/");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(arg0)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    public fun commit_count(arg0: &MemoryTree) : u64 {
        arg0.commit_count
    }

    public fun default_branch(arg0: &MemoryTree) : &0x1::string::String {
        &arg0.default_branch
    }

    public fun grant_delegate(arg0: &mut MemoryTree, arg1: address, arg2: vector<0x1::string::String>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(arg3 & 224 == 0, 10);
        let v0 = DelegateCap{
            agent            : arg1,
            allowed_branches : arg2,
            permissions      : arg3,
            expires_epoch    : arg4,
            revoked          : false,
        };
        if (0x2::table::contains<address, DelegateCap>(&arg0.delegates, arg1)) {
            0x2::table::remove<address, DelegateCap>(&mut arg0.delegates, arg1);
        };
        0x2::table::add<address, DelegateCap>(&mut arg0.delegates, arg1, v0);
        let v1 = DelegateGranted{
            tree_id       : 0x2::object::id<MemoryTree>(arg0),
            agent         : arg1,
            permissions   : arg3,
            expires_epoch : arg4,
        };
        0x2::event::emit<DelegateGranted>(v1);
    }

    public fun has_branch(arg0: &MemoryTree, arg1: &0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.branches, *arg1)
    }

    public fun has_permission(arg0: &MemoryTree, arg1: address, arg2: u8, arg3: &0x1::string::String, arg4: u64) : bool {
        if (!0x2::table::contains<address, DelegateCap>(&arg0.delegates, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, DelegateCap>(&arg0.delegates, arg1);
        if (v0.revoked || v0.expires_epoch < arg4) {
            return false
        };
        if (v0.permissions & arg2 != arg2) {
            return false
        };
        if (!0x1::vector::is_empty<0x1::string::String>(&v0.allowed_branches)) {
            let v1 = false;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&v0.allowed_branches)) {
                if (*0x1::vector::borrow<0x1::string::String>(&v0.allowed_branches, v2) == *arg3) {
                    v1 = true;
                    break
                };
                v2 = v2 + 1;
            };
            if (!v1) {
                return false
            };
        };
        true
    }

    public fun init_tree(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x2::object::id_from_address(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = 0x2::table::new<address, DelegateCap>(arg3);
        let v5 = DelegateCap{
            agent            : v0,
            allowed_branches : 0x1::vector::empty<0x1::string::String>(),
            permissions      : 255,
            expires_epoch    : 18446744073709551615,
            revoked          : false,
        };
        0x2::table::add<address, DelegateCap>(&mut v4, v0, v5);
        let v6 = MemoryTree{
            id             : 0x2::object::new(arg3),
            owner          : v0,
            memwal_account : v2,
            branches       : 0x2::table::new<0x1::string::String, vector<u8>>(arg3),
            default_branch : v1,
            delegates      : v4,
            commit_count   : 0,
            created_at_ms  : v3,
        };
        let v7 = 0x2::object::id<MemoryTree>(&v6);
        let v8 = branch_namespace(0x2::object::id_to_bytes(&v7), &v1);
        let v9 = MemoryCommit{
            id               : 0x2::object::new(arg3),
            tree_id          : v7,
            parents          : vector[],
            memwal_namespace : v8,
            memwal_blob_id   : b"",
            author           : v0,
            author_branch    : v1,
            message          : 0x1::string::utf8(b"genesis"),
            merge_resolver   : 0x1::option::none<0x2::object::ID>(),
            attestations     : 0x1::vector::empty<Attestation>(),
            epoch            : 0x2::tx_context::epoch(arg3),
            ts_ms            : v3,
        };
        0x2::transfer::public_freeze_object<MemoryCommit>(v9);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut v6.branches, v1, b"");
        v6.commit_count = 0;
        0x7df9719d799386d34d657c49ae8cd6f5f03b39036f7c428b556095e42afd852f::acl::create(v7, v1, v8, arg3);
        let v10 = TreeCreated{
            tree_id        : v7,
            owner          : v0,
            memwal_account : v2,
            default_branch : v1,
            ts_ms          : v3,
        };
        0x2::event::emit<TreeCreated>(v10);
        0x2::transfer::share_object<MemoryTree>(v6);
    }

    public fun memwal_account(arg0: &MemoryTree) : 0x2::object::ID {
        arg0.memwal_account
    }

    public fun mint_merge_commit(arg0: 0x2::object::ID, arg1: vector<vector<u8>>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: address, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: vector<Attestation>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = MemoryCommit{
            id               : 0x2::object::new(arg11),
            tree_id          : arg0,
            parents          : arg1,
            memwal_namespace : arg2,
            memwal_blob_id   : arg3,
            author           : arg4,
            author_branch    : arg5,
            message          : arg6,
            merge_resolver   : 0x1::option::some<0x2::object::ID>(arg7),
            attestations     : arg8,
            epoch            : arg9,
            ts_ms            : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::transfer::public_freeze_object<MemoryCommit>(v0);
        0x2::object::id<MemoryCommit>(&v0)
    }

    public fun new_attestation(arg0: address, arg1: u8, arg2: vector<u8>) : Attestation {
        Attestation{
            signer  : arg0,
            kind    : arg1,
            payload : arg2,
        }
    }

    public fun owner(arg0: &MemoryTree) : address {
        arg0.owner
    }

    public fun perm_fork() : u8 {
        4
    }

    public fun perm_merge() : u8 {
        8
    }

    public fun perm_propose() : u8 {
        16
    }

    public fun perm_read() : u8 {
        1
    }

    public fun perm_reserved_mask() : u8 {
        224
    }

    public fun perm_write() : u8 {
        2
    }

    public fun revoke_delegate(arg0: &mut MemoryTree, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::table::contains<address, DelegateCap>(&arg0.delegates, arg1), 2);
        0x2::table::borrow_mut<address, DelegateCap>(&mut arg0.delegates, arg1).revoked = true;
        let v0 = DelegateRevoked{
            tree_id : 0x2::object::id<MemoryTree>(arg0),
            agent   : arg1,
        };
        0x2::event::emit<DelegateRevoked>(v0);
    }

    public fun set_branch_authority(arg0: &MemoryTree, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
    }

    public fun spec_version() : (u8, u8, u8) {
        (0, 1, 1)
    }

    // decompiled from Move bytecode v6
}

