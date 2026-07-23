module 0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339796546977795);
        Config{
            id      : 0x2::object::new(arg1),
            version : 1,
        }
    }

    public fun assert_package_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, T0>) {
        assert!(has_active_package_authority<T0>(arg0, arg1), 13835621881409175557);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058892800786433);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derive_gas_pool_address_for_owner(arg0: &Config, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public(friend) fun has_active_package_authority<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() && 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&arg0.id, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, T0>>(arg1))
    }

    public fun is_authority_cap_active<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<T0, T1>(&arg0.id, arg1)
    }

    public fun new_package_assistant_cap(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg0.id, &v0);
        v0
    }

    public fun revoke_package_assistant_cap(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&arg0.id, arg2), 13835621610826235909);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::deauthorize_cap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg0.id, arg2);
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::PACKAGE, T0>) {
        assert!(arg0.version < 1, 13835058738181963777);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

