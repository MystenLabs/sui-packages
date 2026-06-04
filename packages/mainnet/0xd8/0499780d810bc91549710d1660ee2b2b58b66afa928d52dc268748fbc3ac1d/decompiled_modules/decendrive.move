module 0x96458b85b6b653a17ccf01f2c5691824e7177be2069d299737451ab657ead362::decendrive {
    struct AccessEntry has copy, drop, store {
        address: address,
        expires_at: u64,
        revoked: bool,
    }

    struct File has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        owner: address,
        size: u64,
        uploaded_at: u64,
        last_accessed: u64,
        in_trash: bool,
        encryption_key_hash: 0x1::string::String,
        access_list: vector<AccessEntry>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ShareInvitation has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        sender: address,
        recipient: address,
        filename: 0x1::string::String,
        mime_type: 0x1::string::String,
        size: u64,
        encryption_key_hash: 0x1::string::String,
        key_wrapper: 0x1::string::String,
        permissions: u8,
        expires_at: u64,
        status: u8,
        created_at: u64,
        accepted_at: u64,
        walrus_object_id: 0x1::option::Option<0x2::object::ID>,
        file_object_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ShareSentEvent has copy, drop {
        invitation_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        sender: address,
        recipient: address,
        permissions: u8,
        created_at: u64,
    }

    struct ShareAcceptedEvent has copy, drop {
        invitation_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        recipient: address,
        accepted_at: u64,
    }

    public entry fun accept_share_invitation(arg0: &mut ShareInvitation, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.recipient == v0, 3);
        assert!(arg0.status == 0, 4);
        arg0.status = 1;
        arg0.accepted_at = arg1;
        let v1 = ShareAcceptedEvent{
            invitation_id : 0x2::object::id<ShareInvitation>(arg0),
            blob_id       : arg0.blob_id,
            recipient     : v0,
            accepted_at   : arg1,
        };
        0x2::event::emit<ShareAcceptedEvent>(v1);
    }

    fun assert_owner(arg0: &File, arg1: address) {
        assert!(arg0.owner == arg1, 1);
    }

    public entry fun decline_share_invitation(arg0: ShareInvitation, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.recipient == 0x2::tx_context::sender(arg1), 3);
        assert!(arg0.status == 0, 4);
        let ShareInvitation {
            id                  : v0,
            blob_id             : _,
            sender              : _,
            recipient           : _,
            filename            : _,
            mime_type           : _,
            size                : _,
            encryption_key_hash : _,
            key_wrapper         : _,
            permissions         : _,
            expires_at          : _,
            status              : _,
            created_at          : _,
            accepted_at         : _,
            walrus_object_id    : _,
            file_object_id      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun find_access_index(arg0: &vector<AccessEntry>, arg1: address) : u64 {
        let v0 = 0x1::vector::length<AccessEntry>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<AccessEntry>(arg0, v1).address == arg1) {
                return v1
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_accessible(arg0: &File, arg1: address, arg2: u64) : bool {
        if (arg0.owner == arg1) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<AccessEntry>(&arg0.access_list)) {
            let v1 = 0x1::vector::borrow<AccessEntry>(&arg0.access_list, v0);
            let v2 = if (v1.address == arg1) {
                if (!v1.revoked) {
                    v1.expires_at == 0 || v1.expires_at > arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun move_to_trash(arg0: &mut File, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.in_trash = true;
    }

    public entry fun register_file(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = File{
            id                  : 0x2::object::new(arg4),
            blob_id             : arg0,
            owner               : v0,
            size                : arg1,
            uploaded_at         : arg2,
            last_accessed       : arg2,
            in_trash            : false,
            encryption_key_hash : arg3,
            access_list         : 0x1::vector::empty<AccessEntry>(),
            metadata            : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::transfer::public_transfer<File>(v1, v0);
    }

    public entry fun restore_from_trash(arg0: &mut File, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.in_trash = false;
    }

    public entry fun revoke_access(arg0: &mut File, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        let v0 = find_access_index(&arg0.access_list, arg1);
        assert!(v0 < 0x1::vector::length<AccessEntry>(&arg0.access_list), 2);
        0x1::vector::borrow_mut<AccessEntry>(&mut arg0.access_list, v0).revoked = true;
    }

    public entry fun send_private_share_invitation(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: u64, arg10: 0x1::option::Option<0x2::object::ID>, arg11: 0x1::option::Option<0x2::object::ID>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) != arg1, 5);
        let v0 = @0x0;
        let v1 = ShareInvitation{
            id                  : 0x2::object::new(arg12),
            blob_id             : arg0,
            sender              : v0,
            recipient           : arg1,
            filename            : arg2,
            mime_type           : arg3,
            size                : arg4,
            encryption_key_hash : arg5,
            key_wrapper         : arg6,
            permissions         : arg7,
            expires_at          : arg8,
            status              : 0,
            created_at          : arg9,
            accepted_at         : 0,
            walrus_object_id    : arg10,
            file_object_id      : arg11,
        };
        let v2 = ShareSentEvent{
            invitation_id : 0x2::object::id<ShareInvitation>(&v1),
            blob_id       : v1.blob_id,
            sender        : v0,
            recipient     : arg1,
            permissions   : arg7,
            created_at    : arg9,
        };
        0x2::event::emit<ShareSentEvent>(v2);
        0x2::transfer::public_transfer<ShareInvitation>(v1, arg1);
    }

    public entry fun send_share_invitation(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: u64, arg10: 0x1::option::Option<0x2::object::ID>, arg11: 0x1::option::Option<0x2::object::ID>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(v0 != arg1, 5);
        let v1 = ShareInvitation{
            id                  : 0x2::object::new(arg12),
            blob_id             : arg0,
            sender              : v0,
            recipient           : arg1,
            filename            : arg2,
            mime_type           : arg3,
            size                : arg4,
            encryption_key_hash : arg5,
            key_wrapper         : arg6,
            permissions         : arg7,
            expires_at          : arg8,
            status              : 0,
            created_at          : arg9,
            accepted_at         : 0,
            walrus_object_id    : arg10,
            file_object_id      : arg11,
        };
        let v2 = ShareSentEvent{
            invitation_id : 0x2::object::id<ShareInvitation>(&v1),
            blob_id       : v1.blob_id,
            sender        : v0,
            recipient     : arg1,
            permissions   : arg7,
            created_at    : arg9,
        };
        0x2::event::emit<ShareSentEvent>(v2);
        0x2::transfer::public_transfer<ShareInvitation>(v1, arg1);
    }

    public entry fun share_file(arg0: &mut File, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = find_access_index(&arg0.access_list, arg1);
        if (v0 < 0x1::vector::length<AccessEntry>(&arg0.access_list)) {
            let v1 = 0x1::vector::borrow_mut<AccessEntry>(&mut arg0.access_list, v0);
            v1.expires_at = arg2;
            v1.revoked = false;
        } else {
            let v2 = AccessEntry{
                address    : arg1,
                expires_at : arg2,
                revoked    : false,
            };
            0x1::vector::push_back<AccessEntry>(&mut arg0.access_list, v2);
        };
    }

    public entry fun touch_access(arg0: &mut File, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(is_accessible(arg0, 0x2::tx_context::sender(arg2), arg1), 1);
        arg0.last_accessed = arg1;
    }

    public entry fun update_metadata(arg0: &mut File, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg4));
        arg0.size = arg1;
        arg0.uploaded_at = arg2;
        arg0.last_accessed = arg2;
        arg0.encryption_key_hash = arg3;
    }

    public entry fun upsert_metadata_key(arg0: &mut File, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg3));
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

