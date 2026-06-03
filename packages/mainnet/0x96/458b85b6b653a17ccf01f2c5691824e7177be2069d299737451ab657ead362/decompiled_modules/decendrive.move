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

    fun assert_owner(arg0: &File, arg1: address) {
        assert!(arg0.owner == arg1, 1);
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

