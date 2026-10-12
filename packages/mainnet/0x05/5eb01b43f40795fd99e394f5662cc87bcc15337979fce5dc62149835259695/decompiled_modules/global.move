module 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::global {
    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PackageUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    struct VaultGlobalConfig has key {
        id: 0x2::object::UID,
        created: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>,
        upgrade_cap: 0x1::option::Option<0x2::package::UpgradeCap>,
        global_wish: 0x2::bag::Bag,
        version: u16,
    }

    public fun authorize_upgrade(arg0: &mut VaultGlobalConfig, arg1: &SuperAdminCap, arg2: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        ensure_functional(arg0);
        let PackageUpgradeWish {
            policy : v0,
            digest : v1,
        } = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::timelock::execute<PackageUpgradeWish>(&mut arg0.global_wish, 0x2::object::id<VaultGlobalConfig>(arg0), arg2);
        0x2::package::authorize_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap), v0, v1)
    }

    public fun commit_upgrade(arg0: &mut VaultGlobalConfig, arg1: &SuperAdminCap, arg2: 0x2::package::UpgradeReceipt) {
        ensure_functional(arg0);
        0x2::package::commit_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap), arg2);
    }

    public fun cancel_upgrade_wish(arg0: &mut VaultGlobalConfig, arg1: &SuperAdminCap, arg2: &0x2::clock::Clock) {
        let PackageUpgradeWish {
            policy : _,
            digest : _,
        } = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::timelock::cancel<PackageUpgradeWish>(&mut arg0.global_wish, 0x2::object::id<VaultGlobalConfig>(arg0), true, arg2);
    }

    fun check_origin_id(arg0: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_original_ids<VaultGlobalConfig>();
        let v1 = 0x1::type_name::address_string(&v0);
        let v2 = 0x2::address::to_ascii_string(0x2::object::id_to_address(&arg0));
        assert!(0x1::ascii::substring(&v1, 0, 0x1::ascii::length(&v2)) == v2, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::wrong_upgrade_cap());
    }

    public(friend) fun ensure_functional(arg0: &VaultGlobalConfig) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::upgrade_cap_not_injected());
        assert!(arg0.version == 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::current_version(), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::version_mismatch());
    }

    public fun get_vault_id<T0, T1>(arg0: &VaultGlobalConfig) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::wrong_vault());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(v1, v2), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::not_coin_type());
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(v1, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultGlobalConfig{
            id          : 0x2::object::new(arg0),
            created     : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(arg0),
            upgrade_cap : 0x1::option::none<0x2::package::UpgradeCap>(),
            global_wish : 0x2::bag::new(arg0),
            version     : 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::current_version(),
        };
        0x2::transfer::share_object<VaultGlobalConfig>(v0);
        let v1 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun inject_upgrade_cap(arg0: &mut VaultGlobalConfig, arg1: 0x2::package::UpgradeCap) {
        check_origin_id(0x2::package::upgrade_package(&arg1));
        0x1::option::fill<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap, arg1);
    }

    public fun is_registered<T0, T1>(arg0: &VaultGlobalConfig) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0)) {
            return false
        };
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0), 0x1::type_name::with_defining_ids<T1>())
    }

    public fun migrate(arg0: &mut VaultGlobalConfig, arg1: &SuperAdminCap) {
        assert!(arg0.version < 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::current_version(), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::version_mismatch());
        arg0.version = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::current_version();
    }

    public(friend) fun register<T0, T1>(arg0: &mut VaultGlobalConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        ensure_functional(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut arg0.created, v0, 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg2));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut arg0.created, v0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(v2, v1), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::vault_already_exists());
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(v2, v1, arg1);
    }

    public fun wish_authorize_upgrade(arg0: &mut VaultGlobalConfig, arg1: &SuperAdminCap, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        ensure_functional(arg0);
        let v0 = PackageUpgradeWish{
            policy : arg2,
            digest : arg3,
        };
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::timelock::submit<PackageUpgradeWish>(&mut arg0.global_wish, 0x2::object::id<VaultGlobalConfig>(arg0), 172800000, v0, true, arg4);
    }

    // decompiled from Move bytecode v7
}

