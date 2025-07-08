module 0x2::package {
    struct Publisher has store, key {
        id: 0x2::object::UID,
        package: 0x1::ascii::String,
        module_name: 0x1::ascii::String,
    }

    struct UpgradeCap has store, key {
        id: 0x2::object::UID,
        package: 0x2::object::ID,
        version: u64,
        policy: u8,
    }

    struct UpgradeTicket {
        cap: 0x2::object::ID,
        package: 0x2::object::ID,
        policy: u8,
        digest: vector<u8>,
    }

    struct UpgradeReceipt {
        cap: 0x2::object::ID,
        package: 0x2::object::ID,
    }

    public fun additive_policy() : u8 {
        128
    }

    public fun authorize_upgrade(arg0: &mut UpgradeCap, arg1: u8, arg2: vector<u8>) : UpgradeTicket {
        let v0 = 0x2::object::id_from_address(@0x0);
        assert!(arg0.package != v0, 2);
        assert!(arg1 >= arg0.policy, 1);
        arg0.package = v0;
        UpgradeTicket{
            cap     : 0x2::object::id<UpgradeCap>(arg0),
            package : arg0.package,
            policy  : arg1,
            digest  : arg2,
        }
    }

    public fun burn_publisher(arg0: Publisher) {
        let Publisher {
            id          : v0,
            package     : _,
            module_name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun claim<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Publisher {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        Publisher{
            id          : 0x2::object::new(arg1),
            package     : 0x1::type_name::get_address(&v0),
            module_name : 0x1::type_name::get_module(&v0),
        }
    }

    public fun claim_and_keep<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1);
        0x2::transfer::public_transfer<Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun commit_upgrade(arg0: &mut UpgradeCap, arg1: UpgradeReceipt) {
        let UpgradeReceipt {
            cap     : v0,
            package : v1,
        } = arg1;
        assert!(0x2::object::id<UpgradeCap>(arg0) == v0, 4);
        assert!(0x2::object::id_to_address(&arg0.package) == @0x0, 3);
        arg0.package = v1;
        arg0.version = arg0.version + 1;
    }

    public fun compatible_policy() : u8 {
        0
    }

    public fun dep_only_policy() : u8 {
        192
    }

    public fun from_module<T0>(arg0: &Publisher) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        0x1::type_name::get_address(&v0) == arg0.package && 0x1::type_name::get_module(&v0) == arg0.module_name
    }

    public fun from_package<T0>(arg0: &Publisher) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        0x1::type_name::get_address(&v0) == arg0.package
    }

    public entry fun make_immutable(arg0: UpgradeCap) {
        let UpgradeCap {
            id      : v0,
            package : _,
            version : _,
            policy  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun only_additive_upgrades(arg0: &mut UpgradeCap) {
        restrict(arg0, 128);
    }

    public entry fun only_dep_upgrades(arg0: &mut UpgradeCap) {
        restrict(arg0, 192);
    }

    public fun published_module(arg0: &Publisher) : &0x1::ascii::String {
        &arg0.module_name
    }

    public fun published_package(arg0: &Publisher) : &0x1::ascii::String {
        &arg0.package
    }

    public fun receipt_cap(arg0: &UpgradeReceipt) : 0x2::object::ID {
        arg0.cap
    }

    public fun receipt_package(arg0: &UpgradeReceipt) : 0x2::object::ID {
        arg0.package
    }

    fun restrict(arg0: &mut UpgradeCap, arg1: u8) {
        assert!(arg0.policy <= arg1, 1);
        arg0.policy = arg1;
    }

    public fun ticket_digest(arg0: &UpgradeTicket) : &vector<u8> {
        &arg0.digest
    }

    public fun ticket_package(arg0: &UpgradeTicket) : 0x2::object::ID {
        arg0.package
    }

    public fun ticket_policy(arg0: &UpgradeTicket) : u8 {
        arg0.policy
    }

    public fun upgrade_package(arg0: &UpgradeCap) : 0x2::object::ID {
        arg0.package
    }

    public fun upgrade_policy(arg0: &UpgradeCap) : u8 {
        arg0.policy
    }

    public fun version(arg0: &UpgradeCap) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

