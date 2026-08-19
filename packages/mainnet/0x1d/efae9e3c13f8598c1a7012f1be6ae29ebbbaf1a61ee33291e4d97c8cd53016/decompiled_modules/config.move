module 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        min_pool_balance: u64,
        approved_sponsors: vector<address>,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339873856389123);
        Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            min_pool_balance  : 50000000,
            approved_sponsors : vector[],
        }
    }

    public fun approve_sponsor<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>, arg2: address) {
        assert_package_version(arg0);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(!is_approved_sponsor(arg0, arg2), 13835903532479676423);
        0x1::vector::push_back<address>(&mut arg0.approved_sponsors, arg2);
        0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::events::emit_approve_sponsor_event(arg2);
    }

    public fun assert_package_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>) {
        assert!(has_active_package_authority<T0>(arg0, arg1), 13835622392510283781);
    }

    public fun assert_package_maintenance_cap_is_valid(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::MAINTENANCE>) {
        assert!(has_active_package_maintenance_authority(arg0, arg1), 13835622439754924037);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835059403901894657);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derive_gas_pool_address_for_owner(arg0: &Config, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public(friend) fun has_active_package_authority<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() && 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&arg0.id, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>>(arg1))
    }

    public(friend) fun has_active_package_maintenance_authority(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::MAINTENANCE>) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::MAINTENANCE>(&arg0.id, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::MAINTENANCE>>(arg1))
    }

    public fun is_approved_sponsor(arg0: &Config, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.approved_sponsors, &arg1)
    }

    public fun is_authority_cap_active<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<T0, T1>(&arg0.id, arg1)
    }

    public fun min_pool_balance(arg0: &Config) : u64 {
        arg0.min_pool_balance
    }

    public fun new_package_assistant_cap(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg0.id, &v0);
        v0
    }

    public fun new_package_maintenance_cap(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::MAINTENANCE> {
        assert_package_version(arg0);
        let v0 = 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::create_multiton_package_maintenance_cap(&mut arg0.id, arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::MAINTENANCE>(&mut arg0.id, &v0);
        v0
    }

    public fun revoke_package_authority_cap<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::assert_is_not_admin<T0>();
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>(&arg0.id, arg2), 13835621838459502597);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::deauthorize_cap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>(&mut arg0.id, arg2);
    }

    public fun set_min_pool_balance<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>, arg2: u64) {
        assert_package_version(arg0);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.min_pool_balance = arg2;
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun unapprove_sponsor<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>, arg2: address) {
        assert_package_version(arg0);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        let v0 = &arg0.approved_sponsors;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13836185097650831369);
                0x1::vector::remove<address>(&mut arg0.approved_sponsors, 0x1::option::destroy_some<u64>(v2));
                0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::events::emit_unapprove_sponsor_event(arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::PACKAGE, T0>) {
        assert!(arg0.version < 1, 13835058965815230465);
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

