module 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        min_pool_balance: u64,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339822316781571);
        Config{
            id               : 0x2::object::new(arg1),
            version          : 1,
            min_pool_balance : 50000000,
        }
    }

    public fun assert_package_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>) {
        assert!(has_active_package_authority<T0>(arg0, arg1), 13835622139107213317);
    }

    public fun assert_package_maintenance_cap_is_valid(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>) {
        assert!(has_active_package_maintenance_authority(arg0, arg1), 13835622186351853573);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835059150498824193);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derive_gas_pool_address_for_owner(arg0: &Config, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public(friend) fun has_active_package_authority<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() && 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&arg0.id, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>>(arg1))
    }

    public(friend) fun has_active_package_maintenance_authority(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>(&arg0.id, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>>(arg1))
    }

    public fun is_authority_cap_active<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<T0, T1>(&arg0.id, arg1)
    }

    public fun min_pool_balance(arg0: &Config) : u64 {
        arg0.min_pool_balance
    }

    public fun new_package_assistant_cap(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg0.id, &v0);
        v0
    }

    public fun new_package_maintenance_cap(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE> {
        assert_package_version(arg0);
        let v0 = 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::create_multiton_package_maintenance_cap(&mut arg0.id, arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>(&mut arg0.id, &v0);
        v0
    }

    public fun revoke_package_authority_cap<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::assert_is_not_admin<T0>();
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>(&arg0.id, arg2), 13835621761150091269);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::deauthorize_cap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>(&mut arg0.id, arg2);
    }

    public fun set_min_pool_balance<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>, arg2: u64) {
        assert_package_version(arg0);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.min_pool_balance = arg2;
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, T0>) {
        assert!(arg0.version < 1, 13835058888505819137);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

