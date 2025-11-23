module 0x102f89f89ec4ceb9df757b1aade71f1d3a7cab1b55327397cd6ab9124087da1c::sealed_apology {
    struct SealedApology has key {
        id: 0x2::object::UID,
        owner: address,
        recipients: 0x2::vec_set::VecSet<address>,
        message_preview: 0x1::string::String,
        created_at: u64,
        expires_at: u64,
    }

    struct ApologyCap has key {
        id: 0x2::object::UID,
        apology_id: 0x2::object::ID,
    }

    struct ApologyCreated has copy, drop {
        apology_id: address,
        owner: address,
        recipients_count: u64,
        expires_at: u64,
    }

    struct RecipientAdded has copy, drop {
        apology_id: address,
        recipient: address,
        added_by: address,
    }

    struct ApologyAccessed has copy, drop {
        apology_id: address,
        accessed_by: address,
        document_id: vector<u8>,
        timestamp: u64,
    }

    struct WalrusBlobAttached has copy, drop {
        apology_id: address,
        blob_id: 0x1::string::String,
        attached_by: address,
    }

    public fun add_recipient(arg0: &mut SealedApology, arg1: &ApologyCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.apology_id == 0x2::object::id<SealedApology>(arg0), 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.recipients, &arg2), 2);
        0x2::vec_set::insert<address>(&mut arg0.recipients, arg2);
        let v0 = RecipientAdded{
            apology_id : 0x2::object::uid_to_address(&arg0.id),
            recipient  : arg2,
            added_by   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RecipientAdded>(v0);
    }

    public fun attach_walrus_blob(arg0: &mut SealedApology, arg1: &ApologyCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.apology_id == 0x2::object::id<SealedApology>(arg0), 3);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, arg2, 6);
        let v0 = WalrusBlobAttached{
            apology_id  : 0x2::object::uid_to_address(&arg0.id),
            blob_id     : arg2,
            attached_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WalrusBlobAttached>(v0);
    }

    entry fun create_apology_entry(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = create_sealed_apology(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<ApologyCap>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun create_sealed_apology(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ApologyCap {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        0x2::vec_set::insert<address>(&mut v1, arg0);
        0x2::vec_set::insert<address>(&mut v1, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = v2 + arg3 * 24 * 60 * 60 * 1000;
        let v4 = SealedApology{
            id              : 0x2::object::new(arg5),
            owner           : v0,
            recipients      : v1,
            message_preview : arg2,
            created_at      : v2,
            expires_at      : v3,
        };
        let v5 = ApologyCap{
            id         : 0x2::object::new(arg5),
            apology_id : 0x2::object::id<SealedApology>(&v4),
        };
        let v6 = ApologyCreated{
            apology_id       : 0x2::object::uid_to_address(&v4.id),
            owner            : v0,
            recipients_count : 3,
            expires_at       : v3,
        };
        0x2::event::emit<ApologyCreated>(v6);
        0x2::transfer::share_object<SealedApology>(v4);
        v5
    }

    public fun get_expiry(arg0: &SealedApology) : u64 {
        arg0.expires_at
    }

    public fun get_message_preview(arg0: &SealedApology) : 0x1::string::String {
        arg0.message_preview
    }

    public fun get_owner(arg0: &SealedApology) : address {
        arg0.owner
    }

    public fun get_recipients(arg0: &SealedApology) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.recipients)
    }

    public fun has_blob(arg0: &SealedApology, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun is_authorized(arg0: &SealedApology, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.recipients, &arg1)
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun namespace(arg0: &SealedApology) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun remove_recipient(arg0: &mut SealedApology, arg1: &ApologyCap, arg2: address) {
        assert!(arg1.apology_id == 0x2::object::id<SealedApology>(arg0), 3);
        0x2::vec_set::remove<address>(&mut arg0.recipients, &arg2);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &SealedApology, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 < arg1.expires_at, 5);
        assert!(is_prefix(namespace(arg1), arg0), 4);
        assert!(0x2::vec_set::contains<address>(&arg1.recipients, &v0), 1);
        let v2 = ApologyAccessed{
            apology_id  : 0x2::object::uid_to_address(&arg1.id),
            accessed_by : v0,
            document_id : arg0,
            timestamp   : v1,
        };
        0x2::event::emit<ApologyAccessed>(v2);
    }

    public fun transfer_apology(arg0: SealedApology, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.recipients, &arg1), 1);
        0x2::transfer::transfer<SealedApology>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

