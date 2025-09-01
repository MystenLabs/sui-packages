module 0x1e4adf33d170f23e8b6daa5003d89acf2f9ee89cce6a87b7e0212184a3c0629a::per_file_access {
    struct FileAllowlist has key {
        id: 0x2::object::UID,
        file_id: vector<u8>,
        owner: address,
        name: 0x1::string::String,
        members: vector<address>,
        created_at: u64,
        last_modified: u64,
        version: u64,
    }

    struct FileOwnerCap has key {
        id: 0x2::object::UID,
        file_allowlist_id: 0x2::object::ID,
    }

    public entry fun add_member(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: address) {
        assert!(arg1.file_allowlist_id == 0x2::object::id<FileAllowlist>(arg0), 2);
        assert!(!0x1::vector::contains<address>(&arg0.members, &arg2), 4);
        0x1::vector::push_back<address>(&mut arg0.members, arg2);
    }

    public entry fun check_access(arg0: &FileAllowlist, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.members, &arg1)
    }

    public entry fun create_file_allowlist(arg0: vector<u8>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FileAllowlist{
            id            : 0x2::object::new(arg2),
            file_id       : arg0,
            owner         : 0x2::tx_context::sender(arg2),
            name          : arg1,
            members       : 0x1::vector::empty<address>(),
            created_at    : 0x2::tx_context::epoch(arg2),
            last_modified : 0x2::tx_context::epoch(arg2),
            version       : 0,
        };
        let v1 = FileOwnerCap{
            id                : 0x2::object::new(arg2),
            file_allowlist_id : 0x2::object::id<FileAllowlist>(&v0),
        };
        0x1::vector::push_back<address>(&mut v0.members, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<FileAllowlist>(v0);
        0x2::transfer::transfer<FileOwnerCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun delete_file_allowlist(arg0: FileAllowlist, arg1: FileOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.file_allowlist_id == 0x2::object::id<FileAllowlist>(&arg0), 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        let FileAllowlist {
            id            : v0,
            file_id       : _,
            owner         : _,
            name          : _,
            members       : _,
            created_at    : _,
            last_modified : _,
            version       : _,
        } = arg0;
        let FileOwnerCap {
            id                : v8,
            file_allowlist_id : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v8);
    }

    public entry fun get_file_id(arg0: &FileAllowlist) : vector<u8> {
        arg0.file_id
    }

    public entry fun get_file_name(arg0: &FileAllowlist) : 0x1::string::String {
        arg0.name
    }

    public entry fun get_file_owner(arg0: &FileAllowlist) : address {
        arg0.owner
    }

    public entry fun get_member_count(arg0: &FileAllowlist) : u64 {
        0x1::vector::length<address>(&arg0.members)
    }

    public entry fun get_members(arg0: &FileAllowlist) : vector<address> {
        arg0.members
    }

    public entry fun get_modification_info(arg0: &FileAllowlist) : (u64, u64) {
        (arg0.last_modified, arg0.version)
    }

    public entry fun has_blob_id_been_updated(arg0: &FileAllowlist) : bool {
        arg0.version > 0
    }

    public fun namespace(arg0: &FileAllowlist) : vector<u8> {
        let v0 = 0x2::object::id<FileAllowlist>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    public entry fun remove_member(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: address) {
        assert!(arg1.file_allowlist_id == 0x2::object::id<FileAllowlist>(arg0), 2);
        assert!(arg2 != arg0.owner, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.members)) {
            if (*0x1::vector::borrow<address>(&arg0.members, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.members, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &FileAllowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg1.members, &v0), 1);
    }

    public entry fun transfer_ownership(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.file_allowlist_id == 0x2::object::id<FileAllowlist>(arg0), 2);
        assert!(arg2 != arg0.owner, 4);
        if (arg0.owner != arg2) {
            let v0 = 0;
            while (v0 < 0x1::vector::length<address>(&arg0.members)) {
                if (*0x1::vector::borrow<address>(&arg0.members, v0) == arg0.owner) {
                    0x1::vector::remove<address>(&mut arg0.members, v0);
                    break
                };
                v0 = v0 + 1;
            };
        };
        if (!0x1::vector::contains<address>(&arg0.members, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.members, arg2);
        };
        arg0.owner = arg2;
    }

    public entry fun update_file_blob_id(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.file_allowlist_id == 0x2::object::id<FileAllowlist>(arg0), 2);
        arg0.file_id = arg2;
        arg0.last_modified = 0x2::tx_context::epoch(arg3);
        arg0.version = arg0.version + 1;
    }

    // decompiled from Move bytecode v6
}

