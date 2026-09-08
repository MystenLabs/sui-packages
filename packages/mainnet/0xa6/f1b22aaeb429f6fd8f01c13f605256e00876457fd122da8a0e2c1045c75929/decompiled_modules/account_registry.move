module 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_registry {
    struct AccountAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccountRegistry has key {
        id: 0x2::object::UID,
    }

    struct AccountKey has copy, drop, store {
        pos0: address,
    }

    struct AccountWrapperKey has copy, drop, store {
        pos0: address,
    }

    struct AppKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new(arg0: &mut AccountRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper {
        let v0 = 0x2::tx_context::sender(arg1);
        new_for_owner(arg0, v0, false, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<address>(), arg1)
    }

    fun assert_account_does_not_exist(arg0: &AccountRegistry, arg1: address) {
        assert!(!derived_exists(arg0, arg1) && !derived_wrapper_exists(arg0, arg1), 2);
    }

    public fun assert_app_is_authorized<T0>(arg0: &AccountRegistry) {
        assert!(is_app_authorized<T0>(arg0), 1);
    }

    public fun authorize_app<T0>(arg0: &mut AccountRegistry, arg1: &AccountAdminCap) {
        assert!(!is_app_authorized<T0>(arg0), 0);
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut arg0.id, v0, true);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_events::emit_app_authorized(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
    }

    public fun deauthorize_app<T0>(arg0: &mut AccountRegistry, arg1: &AccountAdminCap) {
        assert_app_is_authorized<T0>(arg0);
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut arg0.id, v0);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_events::emit_app_deauthorized(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
    }

    public fun derived_address(arg0: &AccountRegistry, arg1: address) : address {
        let v0 = AccountKey{pos0: arg1};
        0x2::derived_object::derive_address<AccountKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun derived_exists(arg0: &AccountRegistry, arg1: address) : bool {
        let v0 = AccountKey{pos0: arg1};
        0x2::derived_object::exists<AccountKey>(&arg0.id, v0)
    }

    public fun derived_wrapper_address(arg0: &AccountRegistry, arg1: address) : address {
        let v0 = AccountWrapperKey{pos0: arg1};
        0x2::derived_object::derive_address<AccountWrapperKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun derived_wrapper_exists(arg0: &AccountRegistry, arg1: address) : bool {
        let v0 = AccountWrapperKey{pos0: arg1};
        0x2::derived_object::exists<AccountWrapperKey>(&arg0.id, v0)
    }

    public fun generate_auth_as_app<T0>(arg0: &AccountRegistry, arg1: 0x1::internal::Permit<T0>) : 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth {
        assert_app_is_authorized<T0>(arg0);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::new_app_auth()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AccountRegistry>(v0);
        let v1 = AccountAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AccountAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_app_authorized<T0>(arg0: &AccountRegistry) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<AppKey<T0>>(&arg0.id, v0)
    }

    fun new_for_owner(arg0: &mut AccountRegistry, arg1: address, arg2: bool, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) : 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper {
        assert_account_does_not_exist(arg0, arg1);
        let v0 = AccountWrapperKey{pos0: arg1};
        let v1 = AccountKey{pos0: arg1};
        let v2 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::new_derived<AccountWrapperKey, AccountKey>(&mut arg0.id, v0, v1, arg1, arg3, arg4, arg5);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_events::emit_account_created(0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::account_id(0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account(&v2)), 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::id(&v2), arg1, arg2, arg3);
        v2
    }

    public fun new_self_owned(arg0: &mut AccountRegistry, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::tx_context::TxContext) : 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper {
        let v0 = 0x2::object::uid_to_inner(arg1);
        new_for_owner(arg0, 0x2::object::id_to_address(&v0), true, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<address>(), arg2)
    }

    public fun new_with_referrer(arg0: &mut AccountRegistry, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg2: &mut 0x2::tx_context::TxContext) : 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account(arg1);
        new_for_owner(arg0, v0, false, 0x1::option::some<0x2::object::ID>(0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::account_id(v1)), 0x1::option::some<address>(0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::receive_address(v1)), arg2)
    }

    // decompiled from Move bytecode v7
}

