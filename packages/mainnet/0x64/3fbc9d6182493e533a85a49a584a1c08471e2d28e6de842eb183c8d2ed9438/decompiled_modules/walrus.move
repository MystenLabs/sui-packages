module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus {
    struct WalrusRef has copy, drop, store {
        blob_id: u256,
        size: u64,
        end_epoch: u32,
        encoding: u8,
    }

    struct KbFile has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        mime: 0x1::string::String,
        walrus: WalrusRef,
        seal: 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef,
        content_hash: vector<u8>,
        delegates: 0x2::vec_set::VecSet<address>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct KbFileAdded has copy, drop {
        account_id: 0x2::object::ID,
        kb_file_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        blob_id: u256,
        timestamp_ms: u64,
    }

    struct KbFileRenewed has copy, drop {
        kb_file_id: 0x2::object::ID,
        end_epoch: u32,
        timestamp_ms: u64,
    }

    struct KbAccessGranted has copy, drop {
        kb_file_id: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    struct KbAccessRevoked has copy, drop {
        kb_file_id: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    public fun add_kb_file(arg0: &mut 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: WalrusRef, arg4: 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg5) == 32, 8);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::owner(arg0);
        let v2 = 0x2::object::id<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Account>(arg0);
        let v3 = KbFile{
            id            : 0x2::object::new(arg7),
            account_id    : v2,
            owner         : v1,
            name          : arg1,
            mime          : arg2,
            walrus        : arg3,
            seal          : arg4,
            content_hash  : arg5,
            delegates     : 0x2::vec_set::empty<address>(),
            created_at_ms : v0,
            updated_at_ms : v0,
        };
        let v4 = 0x2::object::id<KbFile>(&v3);
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::link_kb_file(arg0, v4, v0);
        let v5 = KbFileAdded{
            account_id   : v2,
            kb_file_id   : v4,
            owner        : v1,
            name         : arg1,
            blob_id      : blob_id(&arg3),
            timestamp_ms : v0,
        };
        0x2::event::emit<KbFileAdded>(v5);
        0x2::transfer::share_object<KbFile>(v3);
    }

    public fun blob_id(arg0: &WalrusRef) : u256 {
        arg0.blob_id
    }

    public fun default_encoding() : u8 {
        0
    }

    public fun encoding(arg0: &WalrusRef) : u8 {
        arg0.encoding
    }

    public fun end_epoch(arg0: &WalrusRef) : u32 {
        arg0.end_epoch
    }

    public fun epochs_remaining(arg0: &WalrusRef, arg1: u32) : u32 {
        if (arg0.end_epoch > arg1) {
            arg0.end_epoch - arg1
        } else {
            0
        }
    }

    public fun executor_grant_access(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::AccessRegistry, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::ExecutorCap, arg2: &mut KbFile, arg3: address, arg4: &0x2::clock::Clock) {
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::assert_executor(arg0, arg1);
        assert!(arg3 != arg2.owner, 7);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<address>(&mut arg2.delegates, arg3)) {
            let v0 = 0x2::clock::timestamp_ms(arg4);
            arg2.updated_at_ms = v0;
            let v1 = KbAccessGranted{
                kb_file_id   : 0x2::object::id<KbFile>(arg2),
                delegate     : arg3,
                timestamp_ms : v0,
            };
            0x2::event::emit<KbAccessGranted>(v1);
        };
    }

    public fun executor_renew(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::AccessRegistry, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::ExecutorCap, arg2: &mut KbFile, arg3: u32, arg4: &0x2::clock::Clock) {
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::assert_executor(arg0, arg1);
        assert!(arg3 > arg2.walrus.end_epoch, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.walrus.end_epoch = arg3;
        arg2.updated_at_ms = v0;
        let v1 = KbFileRenewed{
            kb_file_id   : 0x2::object::id<KbFile>(arg2),
            end_epoch    : arg3,
            timestamp_ms : v0,
        };
        0x2::event::emit<KbFileRenewed>(v1);
    }

    public fun executor_revoke_access(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::AccessRegistry, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::ExecutorCap, arg2: &mut KbFile, arg3: address, arg4: &0x2::clock::Clock) {
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::assert_executor(arg0, arg1);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<address>(&mut arg2.delegates, arg3)) {
            let v0 = 0x2::clock::timestamp_ms(arg4);
            arg2.updated_at_ms = v0;
            let v1 = KbAccessRevoked{
                kb_file_id   : 0x2::object::id<KbFile>(arg2),
                delegate     : arg3,
                timestamp_ms : v0,
            };
            0x2::event::emit<KbAccessRevoked>(v1);
        };
    }

    public fun grant_access(arg0: &mut KbFile, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg1 != arg0.owner, 7);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<address>(&mut arg0.delegates, arg1)) {
            let v0 = 0x2::clock::timestamp_ms(arg2);
            arg0.updated_at_ms = v0;
            let v1 = KbAccessGranted{
                kb_file_id   : 0x2::object::id<KbFile>(arg0),
                delegate     : arg1,
                timestamp_ms : v0,
            };
            0x2::event::emit<KbAccessGranted>(v1);
        };
    }

    public fun is_expired(arg0: &WalrusRef, arg1: u32) : bool {
        arg0.end_epoch <= arg1
    }

    public fun kb_account(arg0: &KbFile) : 0x2::object::ID {
        arg0.account_id
    }

    public fun kb_can_access(arg0: &KbFile, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.delegates, &arg1)
    }

    public fun kb_content_hash(arg0: &KbFile) : vector<u8> {
        arg0.content_hash
    }

    public fun kb_delegate_count(arg0: &KbFile) : u64 {
        0x2::vec_set::length<address>(&arg0.delegates)
    }

    public fun kb_mime(arg0: &KbFile) : 0x1::string::String {
        arg0.mime
    }

    public fun kb_name(arg0: &KbFile) : 0x1::string::String {
        arg0.name
    }

    public fun kb_owner(arg0: &KbFile) : address {
        arg0.owner
    }

    public fun kb_seal(arg0: &KbFile) : 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef {
        arg0.seal
    }

    public fun kb_walrus(arg0: &KbFile) : WalrusRef {
        arg0.walrus
    }

    public fun new_ref(arg0: u256, arg1: u64, arg2: u32, arg3: u8) : WalrusRef {
        assert!(arg1 > 0, 1);
        assert!(arg3 < 1, 2);
        WalrusRef{
            blob_id   : arg0,
            size      : arg1,
            end_epoch : arg2,
            encoding  : arg3,
        }
    }

    public fun renew(arg0: &mut KbFile, arg1: u32, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg1 > arg0.walrus.end_epoch, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.walrus.end_epoch = arg1;
        arg0.updated_at_ms = v0;
        let v1 = KbFileRenewed{
            kb_file_id   : 0x2::object::id<KbFile>(arg0),
            end_epoch    : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<KbFileRenewed>(v1);
    }

    public fun revoke_access(arg0: &mut KbFile, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<address>(&mut arg0.delegates, arg1)) {
            let v0 = 0x2::clock::timestamp_ms(arg2);
            arg0.updated_at_ms = v0;
            let v1 = KbAccessRevoked{
                kb_file_id   : 0x2::object::id<KbFile>(arg0),
                delegate     : arg1,
                timestamp_ms : v0,
            };
            0x2::event::emit<KbAccessRevoked>(v1);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &KbFile, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.owner || 0x2::vec_set::contains<address>(&arg1.delegates, &v0), 5);
        let v1 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::id_bytes(arg1.account_id);
        assert!(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::bytes_start_with(&arg0, &v1), 6);
    }

    public fun size(arg0: &WalrusRef) : u64 {
        arg0.size
    }

    // decompiled from Move bytecode v7
}

