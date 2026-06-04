module 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::share {
    struct Share has key {
        id: 0x2::object::UID,
        version: u16,
        creator: address,
        blob_ids: vector<0x1::string::String>,
        is_quilt: bool,
        compressed: bool,
        ivs: vector<0x1::string::String>,
        expires_at_ms: 0x1::option::Option<u64>,
        envelope: 0x2::vec_map::VecMap<address, vector<u8>>,
    }

    struct ShareCreated has copy, drop {
        share_id: 0x2::object::ID,
        creator: address,
        blob_ids: vector<0x1::string::String>,
        is_quilt: bool,
        chunk_count: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        recipients: vector<address>,
    }

    struct ShareRecipientAdded has copy, drop {
        share_id: 0x2::object::ID,
        recipient: address,
    }

    struct ShareRecipientRemoved has copy, drop {
        share_id: 0x2::object::ID,
        recipient: address,
    }

    struct ShareExpiryUpdated has copy, drop {
        share_id: 0x2::object::ID,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct ShareDeleted has copy, drop {
        share_id: 0x2::object::ID,
    }

    public fun add_recipient(arg0: &mut Share, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 300);
        assert!(!is_expired_internal(arg0, arg3), 304);
        assert!(!0x2::vec_map::contains<address, vector<u8>>(&arg0.envelope, &arg1), 302);
        0x2::vec_map::insert<address, vector<u8>>(&mut arg0.envelope, arg1, arg2);
        let v0 = ShareRecipientAdded{
            share_id  : 0x2::object::id<Share>(arg0),
            recipient : arg1,
        };
        0x2::event::emit<ShareRecipientAdded>(v0);
    }

    public fun blob_ids(arg0: &Share) : vector<0x1::string::String> {
        arg0.blob_ids
    }

    public fun chunk_count(arg0: &Share) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.blob_ids)
    }

    public fun compressed(arg0: &Share) : bool {
        arg0.compressed
    }

    public fun create_share(arg0: vector<0x1::string::String>, arg1: bool, arg2: bool, arg3: vector<0x1::string::String>, arg4: 0x1::option::Option<u64>, arg5: vector<address>, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) : Share {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg0), 305);
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg3), 306);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<vector<u8>>(&arg6), 301);
        let v0 = 0x2::vec_map::empty<address, vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg5)) {
            let v2 = *0x1::vector::borrow<address>(&arg5, v1);
            if (!0x2::vec_map::contains<address, vector<u8>>(&v0, &v2)) {
                0x2::vec_map::insert<address, vector<u8>>(&mut v0, v2, *0x1::vector::borrow<vector<u8>>(&arg6, v1));
            };
            v1 = v1 + 1;
        };
        let v3 = 0x2::object::new(arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        let v5 = ShareCreated{
            share_id      : 0x2::object::uid_to_inner(&v3),
            creator       : v4,
            blob_ids      : arg0,
            is_quilt      : arg1,
            chunk_count   : 0x1::vector::length<0x1::string::String>(&arg0),
            expires_at_ms : arg4,
            recipients    : arg5,
        };
        0x2::event::emit<ShareCreated>(v5);
        Share{
            id            : v3,
            version       : 1,
            creator       : v4,
            blob_ids      : arg0,
            is_quilt      : arg1,
            compressed    : arg2,
            ivs           : arg3,
            expires_at_ms : arg4,
            envelope      : v0,
        }
    }

    public fun creator(arg0: &Share) : address {
        arg0.creator
    }

    public fun delete_share(arg0: Share, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 300);
        let Share {
            id            : v0,
            version       : _,
            creator       : _,
            blob_ids      : _,
            is_quilt      : _,
            compressed    : _,
            ivs           : _,
            expires_at_ms : _,
            envelope      : _,
        } = arg0;
        0x2::object::delete(v0);
        let v9 = ShareDeleted{share_id: 0x2::object::id<Share>(&arg0)};
        0x2::event::emit<ShareDeleted>(v9);
    }

    public fun envelope_for(arg0: &Share, arg1: address) : vector<u8> {
        *0x2::vec_map::get<address, vector<u8>>(&arg0.envelope, &arg1)
    }

    public fun expires_at_ms(arg0: &Share) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun has_recipient(arg0: &Share, arg1: address) : bool {
        0x2::vec_map::contains<address, vector<u8>>(&arg0.envelope, &arg1)
    }

    public fun is_expired(arg0: &Share, arg1: &0x2::clock::Clock) : bool {
        is_expired_internal(arg0, arg1)
    }

    fun is_expired_internal(arg0: &Share, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<u64>(&arg0.expires_at_ms)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.expires_at_ms)
    }

    public fun is_quilt(arg0: &Share) : bool {
        arg0.is_quilt
    }

    public fun ivs(arg0: &Share) : vector<0x1::string::String> {
        arg0.ivs
    }

    public fun keep_share(arg0: Share) {
        0x2::transfer::transfer<Share>(arg0, arg0.creator);
    }

    public fun recipients(arg0: &Share) : vector<address> {
        0x2::vec_map::keys<address, vector<u8>>(&arg0.envelope)
    }

    public fun remove_recipient(arg0: &mut Share, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 300);
        assert!(0x2::vec_map::contains<address, vector<u8>>(&arg0.envelope, &arg1), 303);
        let (_, _) = 0x2::vec_map::remove<address, vector<u8>>(&mut arg0.envelope, &arg1);
        let v2 = ShareRecipientRemoved{
            share_id  : 0x2::object::id<Share>(arg0),
            recipient : arg1,
        };
        0x2::event::emit<ShareRecipientRemoved>(v2);
    }

    public fun set_expires_at(arg0: &mut Share, arg1: 0x1::option::Option<u64>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 300);
        arg0.expires_at_ms = arg1;
        let v0 = ShareExpiryUpdated{
            share_id      : 0x2::object::id<Share>(arg0),
            expires_at_ms : arg1,
        };
        0x2::event::emit<ShareExpiryUpdated>(v0);
    }

    public fun version(arg0: &Share) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

