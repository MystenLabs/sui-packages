module 0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::dao_config {
    struct GlobalDaoConfig has key {
        id: 0x2::object::UID,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
        package_version: u64,
        verifier_pubkey: vector<u8>,
    }

    struct GlobalDaoConfigChangedEvent has copy, drop {
        sender: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    struct GlobalDaoConfigInitEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun check_package_version(arg0: &GlobalDaoConfig) {
        assert!(arg0.package_version == 1, 6000);
    }

    public(friend) fun get_dao_fee_config(arg0: &GlobalDaoConfig) : (u64, u64) {
        (arg0.platform_fee_numerator, arg0.platform_fee_denominator)
    }

    public(friend) fun get_verifier_pubkey(arg0: &GlobalDaoConfig) : vector<u8> {
        arg0.verifier_pubkey
    }

    public(friend) fun new_global_dao_fee_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalDaoConfig{
            id                       : 0x2::object::new(arg0),
            platform_fee_numerator   : 1,
            platform_fee_denominator : 100,
            package_version          : 1,
            verifier_pubkey          : 0x1::vector::empty<u8>(),
        };
        let v1 = 0x2::object::id<GlobalDaoConfig>(&v0);
        let v2 = GlobalDaoConfigInitEvent{
            id                       : v1,
            sender                   : 0x2::tx_context::sender(arg0),
            platform_fee_numerator   : v0.platform_fee_numerator,
            platform_fee_denominator : v0.platform_fee_denominator,
        };
        0x2::event::emit<GlobalDaoConfigInitEvent>(v2);
        0x2::transfer::share_object<GlobalDaoConfig>(v0);
        v1
    }

    public(friend) fun set_platform_fee(arg0: &mut GlobalDaoConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.platform_fee_numerator = arg1;
        arg0.platform_fee_denominator = arg2;
        let v0 = GlobalDaoConfigChangedEvent{
            sender                   : 0x2::tx_context::sender(arg3),
            platform_fee_numerator   : arg1,
            platform_fee_denominator : arg2,
        };
        0x2::event::emit<GlobalDaoConfigChangedEvent>(v0);
    }

    public fun set_verifier_pubkey(arg0: &0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::operator::OperatorCap, arg1: &mut GlobalDaoConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.verifier_pubkey = arg2;
    }

    public fun update_package_version(arg0: &0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::operator::OperatorCap, arg1: &mut GlobalDaoConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    // decompiled from Move bytecode v6
}

