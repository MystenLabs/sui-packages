module 0x9f74af29bc56dba5aeba39e75daae64727b62c5bfc4f6141bb22ad5cf011b3a0::FileSharing {
    struct File has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        file_blob_id: 0x1::string::String,
        file_type: 0x1::string::String,
        file_size: u64,
        created_at: u64,
        access_list: vector<address>,
    }

    struct FileRegistry has key {
        id: 0x2::object::UID,
        files_by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
        shared_to_me_files: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_files: u64,
    }

    struct EventFileCreated has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        created_at: u64,
        file_blob_id: 0x1::string::String,
        file_type: 0x1::string::String,
        file_size: u64,
        grantee_addresses: vector<address>,
    }

    struct EventAccessGranted has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        grantee_addresses: vector<address>,
    }

    struct EventAccessRevoked has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        revokee: address,
    }

    struct EventDebugApprove has copy, drop {
        caller: address,
        file_id: 0x2::object::ID,
        registry_id: vector<u8>,
        seal_id: vector<u8>,
        is_prefix: bool,
        is_owner: bool,
        in_access_list: bool,
        approved: bool,
    }

    fun approve_internal(arg0: address, arg1: vector<u8>, arg2: &FileRegistry, arg3: &File) : bool {
        let v0 = 0x9f74af29bc56dba5aeba39e75daae64727b62c5bfc4f6141bb22ad5cf011b3a0::utils::is_prefix(0x2::object::uid_to_bytes(&arg2.id), arg1);
        let v1 = arg3.owner == arg0;
        let v2 = 0x1::vector::contains<address>(&arg3.access_list, &arg0);
        let v3 = v0 && (v1 || v2);
        let v4 = EventDebugApprove{
            caller         : arg0,
            file_id        : 0x2::object::uid_to_inner(&arg3.id),
            registry_id    : 0x2::object::uid_to_bytes(&arg2.id),
            seal_id        : arg1,
            is_prefix      : v0,
            is_owner       : v1,
            in_access_list : v2,
            approved       : v3,
        };
        0x2::event::emit<EventDebugApprove>(v4);
        v3
    }

    public fun check_access(arg0: &File, arg1: address) : bool {
        arg0.owner == arg1 || 0x1::vector::contains<address>(&arg0.access_list, &arg1)
    }

    public entry fun create_file(arg0: &mut FileRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = File{
            id           : v0,
            owner        : v2,
            name         : arg1,
            file_blob_id : arg2,
            file_type    : arg3,
            file_size    : arg4,
            created_at   : 0x2::clock::timestamp_ms(arg6),
            access_list  : 0x1::vector::empty<address>(),
        };
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.files_by_owner, v2)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, v2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, v2), v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg5)) {
            let v5 = *0x1::vector::borrow<address>(&arg5, v4);
            assert!(!0x1::vector::contains<address>(&v3.access_list, &v5), 6);
            0x1::vector::push_back<address>(&mut v3.access_list, v5);
            if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.shared_to_me_files, v5)) {
                0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, v5, 0x1::vector::empty<0x2::object::ID>());
            };
            let v6 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, v5);
            if (!0x1::vector::contains<0x2::object::ID>(v6, &v1)) {
                0x1::vector::push_back<0x2::object::ID>(v6, v1);
            };
            v4 = v4 + 1;
        };
        let v7 = EventFileCreated{
            file_id           : v1,
            owner             : v2,
            name              : arg1,
            created_at        : v3.created_at,
            file_blob_id      : arg2,
            file_type         : arg3,
            file_size         : arg4,
            grantee_addresses : arg5,
        };
        0x2::event::emit<EventFileCreated>(v7);
        0x2::transfer::share_object<File>(v3);
    }

    public fun get_access_list(arg0: &File) : vector<address> {
        arg0.access_list
    }

    public fun get_file_info(arg0: &File) : (address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, vector<address>) {
        (arg0.owner, arg0.name, arg0.file_blob_id, arg0.file_type, arg0.file_size, arg0.created_at, arg0.access_list)
    }

    public entry fun grant_access(arg0: &mut FileRegistry, arg1: &mut File, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            assert!(!0x1::vector::contains<address>(&arg1.access_list, &v2), 3);
            0x1::vector::push_back<address>(&mut arg1.access_list, v2);
            if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.shared_to_me_files, v2)) {
                0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, v2, 0x1::vector::empty<0x2::object::ID>());
            };
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, v2);
            if (!0x1::vector::contains<0x2::object::ID>(v3, &v0)) {
                0x1::vector::push_back<0x2::object::ID>(v3, v0);
            };
            v1 = v1 + 1;
        };
        let v4 = EventAccessGranted{
            file_id           : v0,
            owner             : arg1.owner,
            grantee_addresses : arg2,
        };
        0x2::event::emit<EventAccessGranted>(v4);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FileRegistry{
            id                 : 0x2::object::new(arg0),
            files_by_owner     : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            shared_to_me_files : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_files        : 0,
        };
        0x2::transfer::share_object<FileRegistry>(v0);
    }

    public entry fun revoke_access(arg0: &mut FileRegistry, arg1: &mut File, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg1.access_list, &arg2);
        assert!(v1, 4);
        0x1::vector::remove<address>(&mut arg1.access_list, v2);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.shared_to_me_files, arg2)) {
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, arg2);
            let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(v3, &v0);
            if (v4) {
                0x1::vector::remove<0x2::object::ID>(v3, v5);
            };
        };
        let v6 = EventAccessRevoked{
            file_id : v0,
            owner   : arg1.owner,
            revokee : arg2,
        };
        0x2::event::emit<EventAccessRevoked>(v6);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &FileRegistry, arg2: &File, arg3: &0x2::tx_context::TxContext) {
        assert!(approve_internal(0x2::tx_context::sender(arg3), arg0, arg1, arg2), 2);
    }

    public entry fun update_file_info(arg0: &mut File, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

