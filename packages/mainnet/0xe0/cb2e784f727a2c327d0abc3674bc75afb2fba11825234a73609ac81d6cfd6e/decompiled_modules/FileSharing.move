module 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::FileSharing {
    struct File has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        file_blob_id: 0x1::string::String,
        file_type: 0x1::string::String,
        file_size: u64,
        created_at: u64,
        access_list: vector<address>,
        seal_id: vector<u8>,
        delegate: address,
    }

    struct FileRegistry has key {
        id: 0x2::object::UID,
        files_by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
        shared_to_me_files: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_files: u64,
        owner: address,
        seal_ids: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct EventFileBlobUpdated has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        old_blob_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
        old_file_size: u64,
        new_file_size: u64,
        actor: address,
        via_delegate: bool,
        updated_at_ms: u64,
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
        seal_id: vector<u8>,
    }

    struct EventAccessGranted has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        grantee_addresses: vector<address>,
        actor: address,
        via_admin_cap: bool,
        via_delegate: bool,
    }

    struct EventAccessRevoked has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        revokee: address,
        actor: address,
        via_admin_cap: bool,
        via_delegate: bool,
    }

    struct EventDelegateChanged has copy, drop {
        file_id: 0x2::object::ID,
        owner: address,
        old_delegate: address,
        new_delegate: address,
        actor: address,
        via_admin_cap: bool,
    }

    struct EventOwnershipTransferred has copy, drop {
        file_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        actor: address,
        via_admin_cap: bool,
        previous_owner_access_removed: bool,
    }

    struct FILESHARING has drop {
        dummy_field: bool,
    }

    public fun admin_cap_registry(arg0: &AdminCap) : 0x2::object::ID {
        arg0.registry
    }

    public entry fun admin_create_file(arg0: &AdminCap, arg1: &mut FileRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: vector<address>, arg8: vector<u8>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_cap_binds(arg0, arg1);
        create_file_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun admin_grant_access(arg0: &AdminCap, arg1: &mut FileRegistry, arg2: &mut File, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_cap_binds(arg0, arg1);
        grant_access_internal(arg1, arg2, arg3, 0x2::tx_context::sender(arg4), true, false);
    }

    public entry fun admin_revoke_access(arg0: &AdminCap, arg1: &mut FileRegistry, arg2: &mut File, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_cap_binds(arg0, arg1);
        revoke_access_internal(arg1, arg2, arg3, 0x2::tx_context::sender(arg4), true, false);
    }

    public entry fun admin_set_file_delegate(arg0: &AdminCap, arg1: &FileRegistry, arg2: &mut File, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_cap_binds(arg0, arg1);
        assert_file_in_registry(arg1, arg2);
        arg2.delegate = arg3;
        let v0 = EventDelegateChanged{
            file_id       : 0x2::object::uid_to_inner(&arg2.id),
            owner         : arg2.owner,
            old_delegate  : arg2.delegate,
            new_delegate  : arg3,
            actor         : 0x2::tx_context::sender(arg4),
            via_admin_cap : true,
        };
        0x2::event::emit<EventDelegateChanged>(v0);
    }

    fun assert_cap_binds(arg0: &AdminCap, arg1: &FileRegistry) {
        assert!(arg0.registry == 0x2::object::id<FileRegistry>(arg1), 17);
    }

    fun assert_file_in_registry(arg0: &FileRegistry, arg1: &File) {
        assert!(0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::utils::is_prefix(0x2::object::uid_to_bytes(&arg0.id), arg1.seal_id), 18);
    }

    fun assert_owner_or_delegate(arg0: &File, arg1: address) : bool {
        if (arg1 == arg0.owner) {
            return false
        };
        assert!(arg1 == arg0.delegate, 1);
        true
    }

    public entry fun create_file(arg0: &mut FileRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: vector<address>, arg7: vector<u8>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        create_file_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun create_file_internal(arg0: &mut FileRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: vector<address>, arg7: vector<u8>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 && arg4 <= 1000000000, 8);
        assert!(0x1::string::length(&arg1) > 0 && 0x1::string::length(&arg1) <= 255, 10);
        assert!(0x1::vector::length<address>(&arg6) <= 50, 9);
        assert!(arg0.total_files < 72057594037927935, 11);
        let v0 = derive_seal_id(arg0, 0x2::tx_context::sender(arg10), arg7);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.seal_ids, v0), 15);
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = File{
            id           : v1,
            owner        : arg5,
            name         : arg1,
            file_blob_id : arg2,
            file_type    : arg3,
            file_size    : arg4,
            created_at   : 0x2::clock::timestamp_ms(arg9),
            access_list  : 0x1::vector::empty<address>(),
            seal_id      : v0,
            delegate     : arg8,
        };
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.seal_ids, v0, v2);
        let v4 = EventDelegateChanged{
            file_id       : v2,
            owner         : arg5,
            old_delegate  : @0x0,
            new_delegate  : arg8,
            actor         : 0x2::tx_context::sender(arg10),
            via_admin_cap : false,
        };
        0x2::event::emit<EventDelegateChanged>(v4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.files_by_owner, arg5)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, arg5, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, arg5), v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg6)) {
            let v6 = *0x1::vector::borrow<address>(&arg6, v5);
            assert!(!0x1::vector::contains<address>(&v3.access_list, &v6), 6);
            0x1::vector::push_back<address>(&mut v3.access_list, v6);
            if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.shared_to_me_files, v6)) {
                0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, v6, 0x1::vector::empty<0x2::object::ID>());
            };
            let v7 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, v6);
            if (!0x1::vector::contains<0x2::object::ID>(v7, &v2)) {
                0x1::vector::push_back<0x2::object::ID>(v7, v2);
            };
            v5 = v5 + 1;
        };
        arg0.total_files = arg0.total_files + 1;
        let v8 = EventFileCreated{
            file_id           : v2,
            owner             : arg5,
            name              : arg1,
            created_at        : v3.created_at,
            file_blob_id      : arg2,
            file_type         : arg3,
            file_size         : arg4,
            grantee_addresses : arg6,
            seal_id           : v0,
        };
        0x2::event::emit<EventFileCreated>(v8);
        0x2::transfer::share_object<File>(v3);
    }

    fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FileRegistry{
            id                 : 0x2::object::new(arg0),
            files_by_owner     : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            shared_to_me_files : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_files        : 0,
            owner              : 0x2::tx_context::sender(arg0),
            seal_ids           : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<FileRegistry>(v0);
        let v1 = AdminCap{
            id       : 0x2::object::new(arg0),
            registry : 0x2::object::id<FileRegistry>(&v0),
        };
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun derive_seal_id(arg0: &FileRegistry, arg1: address, arg2: vector<u8>) : vector<u8> {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 16);
        assert!(0x1::vector::length<u8>(&arg2) <= 64, 16);
        let v0 = 0x2::address::to_bytes(arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        let v1 = 0x2::object::uid_to_bytes(&arg0.id);
        0x1::vector::append<u8>(&mut v1, 0x1::hash::sha2_256(v0));
        v1
    }

    fun drop_read_access(arg0: &mut FileRegistry, arg1: &mut File, arg2: address) : bool {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg1.access_list, &arg2);
        if (v1) {
            0x1::vector::remove<address>(&mut arg1.access_list, v2);
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.shared_to_me_files, arg2)) {
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.shared_to_me_files, arg2);
            let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(v3, &v0);
            if (v4) {
                0x1::vector::remove<0x2::object::ID>(v3, v5);
            };
        };
        v1
    }

    public fun file_access_list(arg0: &File) : vector<address> {
        arg0.access_list
    }

    public fun file_delegate(arg0: &File) : address {
        arg0.delegate
    }

    public fun file_owner(arg0: &File) : address {
        arg0.owner
    }

    public fun file_seal_id(arg0: &File) : vector<u8> {
        arg0.seal_id
    }

    public entry fun grant_access(arg0: &mut FileRegistry, arg1: &mut File, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = assert_owner_or_delegate(arg1, v0);
        grant_access_internal(arg0, arg1, arg2, v0, false, v1);
    }

    fun grant_access_internal(arg0: &mut FileRegistry, arg1: &mut File, arg2: vector<address>, arg3: address, arg4: bool, arg5: bool) {
        assert_file_in_registry(arg0, arg1);
        assert!(0x1::vector::length<address>(&arg1.access_list) + 0x1::vector::length<address>(&arg2) <= 100, 12);
        assert!(0x1::vector::length<address>(&arg2) <= 50, 9);
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
            actor             : arg3,
            via_admin_cap     : arg4,
            via_delegate      : arg5,
        };
        0x2::event::emit<EventAccessGranted>(v4);
    }

    fun init(arg0: FILESHARING, arg1: &mut 0x2::tx_context::TxContext) {
        create_registry(arg1);
    }

    fun is_authorised(arg0: &File, arg1: address) : bool {
        arg0.owner == arg1 || 0x1::vector::contains<address>(&arg0.access_list, &arg1)
    }

    public fun registry_seal_id_owner(arg0: &FileRegistry, arg1: vector<u8>) : 0x2::object::ID {
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.seal_ids, arg1)
    }

    public entry fun revoke_access(arg0: &mut FileRegistry, arg1: &mut File, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = assert_owner_or_delegate(arg1, v0);
        revoke_access_internal(arg0, arg1, arg2, v0, false, v1);
    }

    fun revoke_access_internal(arg0: &mut FileRegistry, arg1: &mut File, arg2: address, arg3: address, arg4: bool, arg5: bool) {
        assert_file_in_registry(arg0, arg1);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x1::vector::contains<address>(&arg1.access_list, &arg2), 4);
        drop_read_access(arg0, arg1, arg2);
        let v1 = EventAccessRevoked{
            file_id       : v0,
            owner         : arg1.owner,
            revokee       : arg2,
            actor         : arg3,
            via_admin_cap : arg4,
            via_delegate  : arg5,
        };
        0x2::event::emit<EventAccessRevoked>(v1);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &FileRegistry, arg2: &File, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::utils::is_prefix(0x2::object::uid_to_bytes(&arg1.id), arg0), 13);
        assert!(arg0 == arg2.seal_id, 14);
        assert!(is_authorised(arg2, 0x2::tx_context::sender(arg3)), 2);
    }

    public entry fun set_file_delegate(arg0: &mut File, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 1);
        arg0.delegate = arg1;
        let v1 = EventDelegateChanged{
            file_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner         : arg0.owner,
            old_delegate  : arg0.delegate,
            new_delegate  : arg1,
            actor         : v0,
            via_admin_cap : false,
        };
        0x2::event::emit<EventDelegateChanged>(v1);
    }

    public entry fun transfer_ownership(arg0: &mut FileRegistry, arg1: &mut File, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner, 1);
        assert!(arg2 != @0x0, 7);
        let v1 = arg1.delegate;
        arg1.delegate = @0x0;
        if (v1 != @0x0) {
            let v2 = EventDelegateChanged{
                file_id       : 0x2::object::uid_to_inner(&arg1.id),
                owner         : arg2,
                old_delegate  : v1,
                new_delegate  : @0x0,
                actor         : v0,
                via_admin_cap : false,
            };
            0x2::event::emit<EventDelegateChanged>(v2);
        };
        let v3 = 0x2::object::uid_to_inner(&arg1.id);
        let v4 = arg1.owner;
        let v5 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, v4);
        let (v6, v7) = 0x1::vector::index_of<0x2::object::ID>(v5, &v3);
        assert!(v6, 1);
        0x1::vector::remove<0x2::object::ID>(v5, v7);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.files_by_owner, arg2)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.files_by_owner, arg2), v3);
        let v8 = drop_read_access(arg0, arg1, v4);
        drop_read_access(arg0, arg1, arg2);
        arg1.owner = arg2;
        let v9 = EventOwnershipTransferred{
            file_id                       : v3,
            previous_owner                : v4,
            new_owner                     : arg2,
            actor                         : v0,
            via_admin_cap                 : false,
            previous_owner_access_removed : v8,
        };
        0x2::event::emit<EventOwnershipTransferred>(v9);
    }

    public entry fun update_file_blob(arg0: &FileRegistry, arg1: &mut File, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_file_in_registry(arg0, arg1);
        assert!(arg3 > 0 && arg3 <= 1000000000, 8);
        assert!(0x1::string::length(&arg2) > 0, 10);
        let v0 = 0x2::tx_context::sender(arg5);
        arg1.file_blob_id = arg2;
        arg1.file_size = arg3;
        let v1 = EventFileBlobUpdated{
            file_id       : 0x2::object::uid_to_inner(&arg1.id),
            owner         : arg1.owner,
            old_blob_id   : arg1.file_blob_id,
            new_blob_id   : arg2,
            old_file_size : arg1.file_size,
            new_file_size : arg3,
            actor         : v0,
            via_delegate  : assert_owner_or_delegate(arg1, v0),
            updated_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EventFileBlobUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

