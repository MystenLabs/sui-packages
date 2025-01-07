module 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::upgrade_service {
    struct UpgradeService<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<AdminRole<T0>>,
    }

    struct UpgradeCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminRole<phantom T0> has drop {
        dummy_field: bool,
    }

    struct UpgradeCapDeposited<phantom T0> has copy, drop {
        upgrade_cap_id: 0x2::object::ID,
    }

    struct UpgradeCapExtracted<phantom T0> has copy, drop {
        upgrade_cap_id: 0x2::object::ID,
    }

    struct UpgradeServiceDestroyed<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct AuthorizeUpgrade<phantom T0> has copy, drop {
        package_id: 0x2::object::ID,
        policy: u8,
    }

    struct CommitUpgrade<phantom T0> has copy, drop {
        package_id: 0x2::object::ID,
    }

    entry fun destroy_empty<T0>(arg0: UpgradeService<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<AdminRole<T0>>(&arg0.admin, arg1);
        assert_upgrade_cap_does_not_exist<T0>(&arg0);
        let UpgradeService {
            id    : v0,
            admin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::destroy<AdminRole<T0>>(v1);
        let v2 = UpgradeServiceDestroyed<T0>{dummy_field: false};
        0x2::event::emit<UpgradeServiceDestroyed<T0>>(v2);
    }

    public fun new<T0: drop>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (UpgradeService<T0>, T0) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = AdminRole<T0>{dummy_field: false};
        let v1 = UpgradeService<T0>{
            id    : 0x2::object::new(arg2),
            admin : 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<AdminRole<T0>>(v0, arg1),
        };
        (v1, arg0)
    }

    public fun authorize_upgrade<T0>(arg0: &mut UpgradeService<T0>, arg1: u8, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<AdminRole<T0>>(&arg0.admin, arg3);
        assert_upgrade_cap_exists<T0>(arg0);
        let v0 = 0x2::package::upgrade_package(borrow_upgrade_cap<T0>(arg0));
        let v1 = AuthorizeUpgrade<T0>{
            package_id : v0,
            policy     : arg1,
        };
        0x2::event::emit<AuthorizeUpgrade<T0>>(v1);
        0x2::package::authorize_upgrade(borrow_upgrade_cap_mut<T0>(arg0), arg1, arg2)
    }

    public fun commit_upgrade<T0>(arg0: &mut UpgradeService<T0>, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<AdminRole<T0>>(&arg0.admin, arg2);
        assert_upgrade_cap_exists<T0>(arg0);
        0x2::package::commit_upgrade(borrow_upgrade_cap_mut<T0>(arg0), arg1);
        let v0 = CommitUpgrade<T0>{package_id: 0x2::package::receipt_package(&arg1)};
        0x2::event::emit<CommitUpgrade<T0>>(v0);
    }

    entry fun accept_admin<T0>(arg0: &mut UpgradeService<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<AdminRole<T0>>(&mut arg0.admin, arg1);
    }

    fun add_upgrade_cap<T0>(arg0: &mut UpgradeService<T0>, arg1: 0x2::package::UpgradeCap) {
        let v0 = UpgradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<UpgradeCapKey, 0x2::package::UpgradeCap>(&mut arg0.id, v0, arg1);
    }

    public fun admin<T0>(arg0: &UpgradeService<T0>) : address {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<AdminRole<T0>>(&arg0.admin)
    }

    fun assert_upgrade_cap_does_not_exist<T0>(arg0: &UpgradeService<T0>) {
        assert!(!exists_upgrade_cap<T0>(arg0), 3);
    }

    fun assert_upgrade_cap_exists<T0>(arg0: &UpgradeService<T0>) {
        assert!(exists_upgrade_cap<T0>(arg0), 2);
    }

    fun borrow_upgrade_cap<T0>(arg0: &UpgradeService<T0>) : &0x2::package::UpgradeCap {
        let v0 = UpgradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<UpgradeCapKey, 0x2::package::UpgradeCap>(&arg0.id, v0)
    }

    fun borrow_upgrade_cap_mut<T0>(arg0: &mut UpgradeService<T0>) : &mut 0x2::package::UpgradeCap {
        let v0 = UpgradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<UpgradeCapKey, 0x2::package::UpgradeCap>(&mut arg0.id, v0)
    }

    entry fun change_admin<T0>(arg0: &mut UpgradeService<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<AdminRole<T0>>(&mut arg0.admin, arg1, arg2);
    }

    entry fun deposit<T0>(arg0: &mut UpgradeService<T0>, arg1: 0x2::package::UpgradeCap) {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        let v3 = 0x2::package::upgrade_package(&arg1);
        let v4 = 0x2::object::id_to_address(&v3);
        assert!(&v2 == &v4, 1);
        assert_upgrade_cap_does_not_exist<T0>(arg0);
        add_upgrade_cap<T0>(arg0, arg1);
        let v5 = UpgradeCapDeposited<T0>{upgrade_cap_id: 0x2::object::id<0x2::package::UpgradeCap>(&arg1)};
        0x2::event::emit<UpgradeCapDeposited<T0>>(v5);
    }

    public(friend) fun exists_upgrade_cap<T0>(arg0: &UpgradeService<T0>) : bool {
        let v0 = UpgradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<UpgradeCapKey, 0x2::package::UpgradeCap>(&arg0.id, v0)
    }

    entry fun extract<T0>(arg0: &mut UpgradeService<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<AdminRole<T0>>(&arg0.admin, arg2);
        assert_upgrade_cap_exists<T0>(arg0);
        let v0 = remove_upgrade_cap<T0>(arg0);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v0, arg1);
        let v1 = UpgradeCapExtracted<T0>{upgrade_cap_id: 0x2::object::id<0x2::package::UpgradeCap>(&v0)};
        0x2::event::emit<UpgradeCapExtracted<T0>>(v1);
    }

    public fun pending_admin<T0>(arg0: &UpgradeService<T0>) : 0x1::option::Option<address> {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::pending_address<AdminRole<T0>>(&arg0.admin)
    }

    fun remove_upgrade_cap<T0>(arg0: &mut UpgradeService<T0>) : 0x2::package::UpgradeCap {
        let v0 = UpgradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::remove<UpgradeCapKey, 0x2::package::UpgradeCap>(&mut arg0.id, v0)
    }

    public fun upgrade_cap_package<T0>(arg0: &UpgradeService<T0>) : 0x2::object::ID {
        assert_upgrade_cap_exists<T0>(arg0);
        0x2::package::upgrade_package(borrow_upgrade_cap<T0>(arg0))
    }

    public fun upgrade_cap_policy<T0>(arg0: &UpgradeService<T0>) : u8 {
        assert_upgrade_cap_exists<T0>(arg0);
        0x2::package::upgrade_policy(borrow_upgrade_cap<T0>(arg0))
    }

    public fun upgrade_cap_version<T0>(arg0: &UpgradeService<T0>) : u64 {
        assert_upgrade_cap_exists<T0>(arg0);
        0x2::package::version(borrow_upgrade_cap<T0>(arg0))
    }

    // decompiled from Move bytecode v6
}

