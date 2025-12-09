module 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer {
    struct DeployerState has key {
        id: 0x2::object::UID,
        upgrade_caps: 0x2::table::Table<address, 0x2::package::UpgradeCap>,
        cap_to_package: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct UpgradeCapRegistered has copy, drop {
        prev_owner: address,
        package_address: address,
        version: u64,
        policy: u8,
    }

    struct UpgradeTicketAuthorized has copy, drop {
        package_address: address,
        policy: u8,
        digest: vector<u8>,
    }

    struct UpgradeReceiptCommitted has copy, drop {
        old_package_address: address,
        new_package_address: address,
        old_version: u64,
        new_version: u64,
    }

    struct MCMS_DEPLOYER has drop {
        dummy_field: bool,
    }

    public fun authorize_upgrade(arg0: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap, arg1: &mut DeployerState, arg2: u8, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert!(0x2::table::contains<address, 0x2::package::UpgradeCap>(&arg1.upgrade_caps, arg4), 1);
        let v0 = UpgradeTicketAuthorized{
            package_address : arg4,
            policy          : arg2,
            digest          : arg3,
        };
        0x2::event::emit<UpgradeTicketAuthorized>(v0);
        0x2::package::authorize_upgrade(0x2::table::borrow_mut<address, 0x2::package::UpgradeCap>(&mut arg1.upgrade_caps, arg4), arg2, arg3)
    }

    public fun commit_upgrade(arg0: &mut DeployerState, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::receipt_package(&arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.cap_to_package, 0x2::package::receipt_cap(&arg1));
        assert!(0x2::table::contains<address, 0x2::package::UpgradeCap>(&arg0.upgrade_caps, v2), 1);
        let v3 = 0x2::table::remove<address, 0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, v2);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.cap_to_package, 0x2::object::id<0x2::package::UpgradeCap>(&v3));
        0x2::package::commit_upgrade(&mut v3, arg1);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.cap_to_package, 0x2::object::id<0x2::package::UpgradeCap>(&v3), v1);
        0x2::table::add<address, 0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, v1, v3);
        let v4 = UpgradeReceiptCommitted{
            old_package_address : v2,
            new_package_address : v1,
            old_version         : 0x2::package::version(&v3),
            new_version         : 0x2::package::version(&v3),
        };
        0x2::event::emit<UpgradeReceiptCommitted>(v4);
    }

    public fun has_upgrade_cap(arg0: &DeployerState, arg1: address) : bool {
        0x2::table::contains<address, 0x2::package::UpgradeCap>(&arg0.upgrade_caps, arg1)
    }

    fun init(arg0: MCMS_DEPLOYER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerState{
            id             : 0x2::object::new(arg1),
            upgrade_caps   : 0x2::table::new<address, 0x2::package::UpgradeCap>(arg1),
            cap_to_package : 0x2::table::new<0x2::object::ID, address>(arg1),
        };
        0x2::transfer::share_object<DeployerState>(v0);
    }

    public fun register_upgrade_cap(arg0: &mut DeployerState, arg1: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x2::package::UpgradeCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::upgrade_package(&arg2);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::is_package_registered(arg1, 0x2::address::to_ascii_string(v1)), 1);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.cap_to_package, 0x2::object::id<0x2::package::UpgradeCap>(&arg2), v1);
        0x2::table::add<address, 0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, v1, arg2);
        let v2 = UpgradeCapRegistered{
            prev_owner      : 0x2::tx_context::sender(arg3),
            package_address : v1,
            version         : 0x2::package::version(&arg2),
            policy          : 0x2::package::upgrade_policy(&arg2),
        };
        0x2::event::emit<UpgradeCapRegistered>(v2);
    }

    public fun release_upgrade_cap<T0: drop>(arg0: &mut DeployerState, arg1: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: T0) : 0x2::package::UpgradeCap {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::is_package_registered(arg1, v1), 1);
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_registered_proof_type(arg1, v1), 2);
        let v2 = 0x1::ascii::into_bytes(v1);
        let v3 = 0x2::address::from_ascii_bytes(&v2);
        assert!(0x2::table::contains<address, 0x2::package::UpgradeCap>(&arg0.upgrade_caps, v3), 1);
        let v4 = 0x2::table::remove<address, 0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, v3);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.cap_to_package, 0x2::object::id<0x2::package::UpgradeCap>(&v4));
        v4
    }

    // decompiled from Move bytecode v6
}

