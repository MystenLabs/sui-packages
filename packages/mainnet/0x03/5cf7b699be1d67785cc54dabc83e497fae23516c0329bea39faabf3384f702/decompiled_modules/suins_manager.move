module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager {
    struct RegKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuiNSManager has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        suins_manager_id: 0x2::object::ID,
    }

    struct SuiNSManagerCreated has copy, drop {
        suins_manager_id: 0x2::object::ID,
        creator: address,
    }

    struct AdminCreated has copy, drop {
        suins_manager_id: 0x2::object::ID,
        admin_id: 0x2::object::ID,
        creator: address,
    }

    struct AppKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, AdminCap) {
        let v0 = SuiNSManager{id: 0x2::object::new(arg1)};
        let v1 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut v0.id, v1, true);
        let v2 = SuiNSManagerCreated{
            suins_manager_id : 0x2::object::id<SuiNSManager>(&v0),
            creator          : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<SuiNSManagerCreated>(v2);
        let v3 = 0x2::object::id<SuiNSManager>(&v0);
        let v4 = AdminCap{
            id               : 0x2::object::new(arg1),
            suins_manager_id : v3,
        };
        let v5 = AdminCreated{
            suins_manager_id : v3,
            admin_id         : 0x2::object::id<AdminCap>(&v4),
            creator          : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminCreated>(v5);
        0x2::transfer::share_object<SuiNSManager>(v0);
        (v3, v4)
    }

    public fun assert_app_is_authorized<T0: drop>(arg0: &SuiNSManager) {
        assert!(is_app_authorized<T0>(arg0), 3);
    }

    public fun authorize_app<T0: drop>(arg0: &mut SuiNSManager, arg1: &AdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut arg0.id, v0, true);
    }

    public fun deauthorize_app<T0: drop>(arg0: &mut SuiNSManager, arg1: &AdminCap) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut arg0.id, v0)
    }

    fun get_suins_nft(arg0: &SuiNSManager) : &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        let v0 = RegKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<RegKey>(&arg0.id, v0), 2);
        let v1 = RegKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<RegKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.id, v1)
    }

    public fun is_app_authorized<T0: drop>(arg0: &SuiNSManager) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.id, v0)
    }

    public fun register_subdomain<T0: drop>(arg0: &SuiNSManager, arg1: &T0, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_app_is_authorized<T0>(arg0);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new_leaf(arg2, get_suins_nft(arg0), arg3, arg4, arg5, arg6);
    }

    public fun remove_subdomain(arg0: &SuiNSManager, arg1: &AdminCap, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg2, get_suins_nft(arg0), arg4, arg3);
    }

    public fun remove_subdomain_for_app<T0: drop>(arg0: &SuiNSManager, arg1: &T0, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &0x2::clock::Clock, arg4: 0x1::string::String) {
        assert_app_is_authorized<T0>(arg0);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg2), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg4));
        if (!0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0)) {
            return
        };
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg2, get_suins_nft(arg0), arg3, arg4);
    }

    entry fun remove_suins_nft(arg0: &mut SuiNSManager, arg1: &AdminCap, arg2: address) {
        let v0 = RegKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<RegKey>(&arg0.id, v0), 2);
        let v1 = RegKey{dummy_field: false};
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x2::dynamic_object_field::remove<RegKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg0.id, v1), arg2);
    }

    entry fun set_suins_nft(arg0: &mut SuiNSManager, arg1: &AdminCap, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) {
        let v0 = RegKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_<RegKey>(&arg0.id, v0), 1);
        let v1 = RegKey{dummy_field: false};
        0x2::dynamic_object_field::add<RegKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg0.id, v1, arg2);
    }

    // decompiled from Move bytecode v6
}

