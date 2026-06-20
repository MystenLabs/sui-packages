module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::sharing {
    struct MemoryShare has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        owner: address,
        owner_handle: 0x1::string::String,
        title: 0x1::string::String,
        status: u8,
        walrus: 0x1::option::Option<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::WalrusRef>,
        seal: 0x1::option::Option<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef>,
        content_hash: vector<u8>,
        item_count: u64,
        recipients: 0x2::vec_set::VecSet<address>,
        recipient_names: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ShareCreated has copy, drop {
        share_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        owner_handle: 0x1::string::String,
        title: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ShareBundleSet has copy, drop {
        share_id: 0x2::object::ID,
        blob_id: u256,
        item_count: u64,
        timestamp_ms: u64,
    }

    struct RecipientAdded has copy, drop {
        share_id: 0x2::object::ID,
        recipient: address,
        recipient_name: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct RecipientRemoved has copy, drop {
        share_id: 0x2::object::ID,
        recipient: address,
        timestamp_ms: u64,
    }

    struct ShareRevoked has copy, drop {
        share_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    fun add_recipient(arg0: &mut MemoryShare, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<address>(&mut arg0.recipients, arg1)) {
            let v0 = 0x2::clock::timestamp_ms(arg3);
            0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::upsert<address, 0x1::string::String>(&mut arg0.recipient_names, arg1, arg2);
            arg0.updated_at_ms = v0;
            let v1 = RecipientAdded{
                share_id       : 0x2::object::id<MemoryShare>(arg0),
                recipient      : arg1,
                recipient_name : arg2,
                timestamp_ms   : v0,
            };
            0x2::event::emit<RecipientAdded>(v1);
        };
    }

    public fun can_access(arg0: &MemoryShare, arg1: address) : bool {
        arg1 == arg0.owner || arg0.status == 1 && 0x2::vec_set::contains<address>(&arg0.recipients, &arg1)
    }

    public fun content_hash(arg0: &MemoryShare) : vector<u8> {
        arg0.content_hash
    }

    public fun create_share(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::owner(arg0);
        let v2 = 0x2::object::id<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Account>(arg0);
        let v3 = full_name(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::handle(arg0));
        let v4 = MemoryShare{
            id              : 0x2::object::new(arg3),
            account_id      : v2,
            owner           : v1,
            owner_handle    : v3,
            title           : arg1,
            status          : 0,
            walrus          : 0x1::option::none<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::WalrusRef>(),
            seal            : 0x1::option::none<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef>(),
            content_hash    : b"",
            item_count      : 0,
            recipients      : 0x2::vec_set::empty<address>(),
            recipient_names : 0x2::vec_map::empty<address, 0x1::string::String>(),
            created_at_ms   : v0,
            updated_at_ms   : v0,
        };
        let v5 = ShareCreated{
            share_id     : 0x2::object::id<MemoryShare>(&v4),
            account_id   : v2,
            owner        : v1,
            owner_handle : v3,
            title        : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<ShareCreated>(v5);
        0x2::transfer::share_object<MemoryShare>(v4);
    }

    public fun full_name(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b".cortex.sui"));
        arg0
    }

    public fun has_bundle(arg0: &MemoryShare) : bool {
        0x1::option::is_some<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::WalrusRef>(&arg0.walrus)
    }

    public fun is_active(arg0: &MemoryShare) : bool {
        arg0.status == 1
    }

    public fun is_recipient(arg0: &MemoryShare, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.recipients, &arg1)
    }

    public fun item_count(arg0: &MemoryShare) : u64 {
        arg0.item_count
    }

    public fun owner_handle(arg0: &MemoryShare) : 0x1::string::String {
        arg0.owner_handle
    }

    public fun recipient_count(arg0: &MemoryShare) : u64 {
        0x2::vec_set::length<address>(&arg0.recipients)
    }

    public fun recipient_name(arg0: &MemoryShare, arg1: address) : 0x1::option::Option<0x1::string::String> {
        0x2::vec_map::try_get<address, 0x1::string::String>(&arg0.recipient_names, &arg1)
    }

    public fun revoke(arg0: &mut MemoryShare, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.status = 2;
        arg0.updated_at_ms = v0;
        let v1 = ShareRevoked{
            share_id     : 0x2::object::id<MemoryShare>(arg0),
            timestamp_ms : v0,
        };
        0x2::event::emit<ShareRevoked>(v1);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &MemoryShare, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.owner || arg1.status == 1 && 0x2::vec_set::contains<address>(&arg1.recipients, &v0), 3);
        let v1 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::id_bytes(0x2::object::id<MemoryShare>(arg1));
        assert!(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::bytes_start_with(&arg0, &v1), 4);
    }

    public fun set_bundle(arg0: &mut MemoryShare, arg1: 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::WalrusRef, arg2: 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 1);
        assert!(arg0.status != 2, 7);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 6);
        let v0 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::id_bytes(0x2::object::id<MemoryShare>(arg0));
        let v1 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::identity(&arg2);
        assert!(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::bytes_start_with(&v1, &v0), 5);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        arg0.walrus = 0x1::option::some<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::WalrusRef>(arg1);
        arg0.seal = 0x1::option::some<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef>(arg2);
        arg0.content_hash = arg3;
        arg0.item_count = arg4;
        arg0.status = 1;
        arg0.updated_at_ms = v2;
        let v3 = ShareBundleSet{
            share_id     : 0x2::object::id<MemoryShare>(arg0),
            blob_id      : 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::blob_id(&arg1),
            item_count   : arg4,
            timestamp_ms : v2,
        };
        0x2::event::emit<ShareBundleSet>(v3);
    }

    public fun share_account(arg0: &MemoryShare) : 0x2::object::ID {
        arg0.account_id
    }

    public fun share_owner(arg0: &MemoryShare) : address {
        arg0.owner
    }

    public fun share_seal(arg0: &MemoryShare) : 0x1::option::Option<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal::SealRef> {
        arg0.seal
    }

    public fun share_walrus(arg0: &MemoryShare) : 0x1::option::Option<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::walrus::WalrusRef> {
        arg0.walrus
    }

    public fun share_with_address(arg0: &mut MemoryShare, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        assert!(arg1 != arg0.owner, 2);
        add_recipient(arg0, arg1, arg2, arg3);
    }

    public fun share_with_handle(arg0: &mut MemoryShare, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Registry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::owner_of_handle(arg1, arg2);
        assert!(v0 != arg0.owner, 2);
        add_recipient(arg0, v0, full_name(arg2), arg3);
    }

    public fun status(arg0: &MemoryShare) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        1
    }

    public fun status_draft() : u8 {
        0
    }

    public fun status_revoked() : u8 {
        2
    }

    public fun title(arg0: &MemoryShare) : 0x1::string::String {
        arg0.title
    }

    public fun unshare(arg0: &mut MemoryShare, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<address>(&mut arg0.recipients, arg1)) {
            let v0 = 0x2::clock::timestamp_ms(arg2);
            if (0x2::vec_map::contains<address, 0x1::string::String>(&arg0.recipient_names, &arg1)) {
                let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut arg0.recipient_names, &arg1);
            };
            arg0.updated_at_ms = v0;
            let v3 = RecipientRemoved{
                share_id     : 0x2::object::id<MemoryShare>(arg0),
                recipient    : arg1,
                timestamp_ms : v0,
            };
            0x2::event::emit<RecipientRemoved>(v3);
        };
    }

    // decompiled from Move bytecode v7
}

