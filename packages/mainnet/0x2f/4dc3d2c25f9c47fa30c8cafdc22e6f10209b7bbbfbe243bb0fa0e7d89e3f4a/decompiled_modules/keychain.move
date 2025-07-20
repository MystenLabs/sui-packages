module 0x2f4dc3d2c25f9c47fa30c8cafdc22e6f10209b7bbbfbe243bb0fa0e7d89e3f4a::keychain {
    struct KeyChainMetadata has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        apps: vector<0x1::string::String>,
        version: 0x1::string::String,
    }

    struct DEKAccess has copy, drop, store {
        key_data: vector<u8>,
        granted_by: address,
        granted_at: u64,
    }

    struct ProxyKeyEntry has copy, drop, store {
        key_data: vector<u8>,
        created_by: address,
        created_at: u64,
        expires_at: 0x1::option::Option<u64>,
    }

    struct KeyChain has store, key {
        id: 0x2::object::UID,
        creator: address,
        encrypted_dek: vector<u8>,
        dek_access: 0x2::table::Table<address, DEKAccess>,
        user_access: 0x2::table::Table<address, ProxyKeyEntry>,
        metadata: KeyChainMetadata,
        created_at: u64,
    }

    struct KeyChainCreated has copy, drop {
        keychain_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct DEKAccessGranted has copy, drop {
        keychain_id: 0x2::object::ID,
        user: address,
        granted_by: address,
    }

    struct DEKAccessRevoked has copy, drop {
        keychain_id: 0x2::object::ID,
        user: address,
        revoked_by: address,
    }

    struct UserAccessGranted has copy, drop {
        keychain_id: 0x2::object::ID,
        user: address,
        granted_by: address,
        expires_at: 0x1::option::Option<u64>,
    }

    struct UserAccessRevoked has copy, drop {
        keychain_id: 0x2::object::ID,
        user: address,
        revoked_by: address,
    }

    public entry fun add_creator_dek_access(arg0: &mut KeyChain, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator, 0);
        assert!(!0x2::table::contains<address, DEKAccess>(&arg0.dek_access, v0), 3);
        let v1 = DEKAccess{
            key_data   : arg1,
            granted_by : v0,
            granted_at : 0x2::tx_context::epoch(arg2),
        };
        0x2::table::add<address, DEKAccess>(&mut arg0.dek_access, v0, v1);
        let v2 = DEKAccessGranted{
            keychain_id : 0x2::object::uid_to_inner(&arg0.id),
            user        : v0,
            granted_by  : v0,
        };
        0x2::event::emit<DEKAccessGranted>(v2);
    }

    public entry fun add_dek_access(arg0: &mut KeyChain, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, DEKAccess>(&arg0.dek_access, v0), 0);
        assert!(!0x2::table::contains<address, DEKAccess>(&arg0.dek_access, arg1), 3);
        let v1 = DEKAccess{
            key_data   : arg2,
            granted_by : v0,
            granted_at : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<address, DEKAccess>(&mut arg0.dek_access, arg1, v1);
        let v2 = DEKAccessGranted{
            keychain_id : 0x2::object::uid_to_inner(&arg0.id),
            user        : arg1,
            granted_by  : v0,
        };
        0x2::event::emit<DEKAccessGranted>(v2);
    }

    public entry fun add_user_access(arg0: &mut KeyChain, arg1: address, arg2: vector<u8>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, DEKAccess>(&arg0.dek_access, v0), 0);
        let v1 = 0x2::tx_context::epoch(arg4);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) > v1, 4);
        };
        let v2 = ProxyKeyEntry{
            key_data   : arg2,
            created_by : v0,
            created_at : v1,
            expires_at : arg3,
        };
        if (0x2::table::contains<address, ProxyKeyEntry>(&arg0.user_access, arg1)) {
            0x2::table::remove<address, ProxyKeyEntry>(&mut arg0.user_access, arg1);
        };
        0x2::table::add<address, ProxyKeyEntry>(&mut arg0.user_access, arg1, v2);
        let v3 = UserAccessGranted{
            keychain_id : 0x2::object::uid_to_inner(&arg0.id),
            user        : arg1,
            granted_by  : v0,
            expires_at  : arg3,
        };
        0x2::event::emit<UserAccessGranted>(v3);
    }

    public entry fun create_keychain(arg0: vector<u8>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::new(arg5);
        let v2 = KeyChainMetadata{
            name        : arg1,
            description : arg2,
            apps        : arg3,
            version     : arg4,
        };
        let v3 = KeyChain{
            id            : v1,
            creator       : v0,
            encrypted_dek : arg0,
            dek_access    : 0x2::table::new<address, DEKAccess>(arg5),
            user_access   : 0x2::table::new<address, ProxyKeyEntry>(arg5),
            metadata      : v2,
            created_at    : 0x2::tx_context::epoch(arg5),
        };
        let v4 = KeyChainCreated{
            keychain_id : 0x2::object::uid_to_inner(&v1),
            creator     : v0,
            name        : v3.metadata.name,
        };
        0x2::event::emit<KeyChainCreated>(v4);
        0x2::transfer::share_object<KeyChain>(v3);
    }

    public fun get_creator(arg0: &KeyChain) : address {
        arg0.creator
    }

    public fun get_dek_access_count(arg0: &KeyChain) : u64 {
        0x2::table::length<address, DEKAccess>(&arg0.dek_access)
    }

    public fun get_dek_access_info(arg0: &KeyChain, arg1: address) : &DEKAccess {
        0x2::table::borrow<address, DEKAccess>(&arg0.dek_access, arg1)
    }

    public fun get_encrypted_dek(arg0: &KeyChain) : &vector<u8> {
        &arg0.encrypted_dek
    }

    public fun get_metadata(arg0: &KeyChain) : &KeyChainMetadata {
        &arg0.metadata
    }

    public fun get_user_access_count(arg0: &KeyChain) : u64 {
        0x2::table::length<address, ProxyKeyEntry>(&arg0.user_access)
    }

    public fun get_user_access_info(arg0: &KeyChain, arg1: address) : &ProxyKeyEntry {
        0x2::table::borrow<address, ProxyKeyEntry>(&arg0.user_access, arg1)
    }

    public fun has_dek_access(arg0: &KeyChain, arg1: address) : bool {
        0x2::table::contains<address, DEKAccess>(&arg0.dek_access, arg1)
    }

    public fun has_user_access(arg0: &KeyChain, arg1: address) : bool {
        0x2::table::contains<address, ProxyKeyEntry>(&arg0.user_access, arg1)
    }

    public entry fun remove_dek_access(arg0: &mut KeyChain, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, DEKAccess>(&arg0.dek_access, v0), 0);
        assert!(arg1 != arg0.creator, 1);
        assert!(0x2::table::contains<address, DEKAccess>(&arg0.dek_access, arg1), 2);
        0x2::table::remove<address, DEKAccess>(&mut arg0.dek_access, arg1);
        let v1 = DEKAccessRevoked{
            keychain_id : 0x2::object::uid_to_inner(&arg0.id),
            user        : arg1,
            revoked_by  : v0,
        };
        0x2::event::emit<DEKAccessRevoked>(v1);
    }

    public entry fun remove_user_access(arg0: &mut KeyChain, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, DEKAccess>(&arg0.dek_access, v0), 0);
        assert!(0x2::table::contains<address, ProxyKeyEntry>(&arg0.user_access, arg1), 2);
        0x2::table::remove<address, ProxyKeyEntry>(&mut arg0.user_access, arg1);
        let v1 = UserAccessRevoked{
            keychain_id : 0x2::object::uid_to_inner(&arg0.id),
            user        : arg1,
            revoked_by  : v0,
        };
        0x2::event::emit<UserAccessRevoked>(v1);
    }

    // decompiled from Move bytecode v6
}

