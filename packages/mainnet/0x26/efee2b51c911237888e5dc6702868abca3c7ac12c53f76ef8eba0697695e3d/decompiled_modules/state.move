module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state {
    struct LatestOnly has drop {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        governance_chain: u16,
        governance_contract: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        emitter_registry: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        token_registry: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::TokenRegistry,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public(friend) fun new(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg4: &mut 0x2::tx_context::TxContext) : State {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::sequence(&arg0) == 0, 2);
        let v0 = State{
            id                  : 0x2::object::new(arg4),
            governance_chain    : arg2,
            governance_contract : arg3,
            consumed_vaas       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg4),
            emitter_cap         : arg0,
            emitter_registry    : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg4),
            token_registry      : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::new(arg4),
            upgrade_cap         : arg1,
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::init_package_info<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__0_2_0>(&mut v0.id, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::current_version(), &v0.upgrade_cap);
        v0
    }

    public(friend) fun assert_authorized_digest(arg0: &LatestOnly, arg1: &State, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32) {
        assert!(arg2 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::authorized_digest(&arg1.id), 0);
    }

    public(friend) fun assert_latest_only(arg0: &State) : LatestOnly {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_version<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__0_2_0>(&arg0.id, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::current_version());
        LatestOnly{dummy_field: false}
    }

    public(friend) fun assert_latest_only_specified<T0>(arg0: &State) : LatestOnly {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::type_of_version<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__0_2_0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::current_version()) == 0x1::type_name::get<T0>(), 1);
        assert_latest_only(arg0)
    }

    public(friend) fun authorize_upgrade(arg0: &mut State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32) : 0x2::package::UpgradeTicket {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::authorize_upgrade(&mut arg0.id, &mut arg0.upgrade_cap, arg1)
    }

    public fun borrow_emitter_registry(arg0: &State) : &0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress> {
        &arg0.emitter_registry
    }

    public(friend) fun borrow_mut_consumed_vaas(arg0: &LatestOnly, arg1: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs {
        borrow_mut_consumed_vaas_unchecked(arg1)
    }

    public(friend) fun borrow_mut_consumed_vaas_unchecked(arg0: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs {
        &mut arg0.consumed_vaas
    }

    public(friend) fun borrow_mut_emitter_registry(arg0: &LatestOnly, arg1: &mut State) : &mut 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress> {
        &mut arg1.emitter_registry
    }

    public(friend) fun borrow_mut_token_registry(arg0: &LatestOnly, arg1: &mut State) : &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::TokenRegistry {
        &mut arg1.token_registry
    }

    public fun borrow_token_registry(arg0: &State) : &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::TokenRegistry {
        &arg0.token_registry
    }

    public(friend) fun commit_upgrade(arg0: &mut State, arg1: 0x2::package::UpgradeReceipt) : (0x2::object::ID, 0x2::object::ID) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::commit_upgrade(&mut arg0.id, &mut arg0.upgrade_cap, arg1)
    }

    public(friend) fun current_package(arg0: &LatestOnly, arg1: &State) : 0x2::object::ID {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::current_package(&arg1.id)
    }

    public fun governance_chain(arg0: &State) : u16 {
        arg0.governance_chain
    }

    public fun governance_contract(arg0: &State) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.governance_contract
    }

    public fun governance_module() : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(x"000000000000000000000000000000000000000000546f6b656e427269646765")
    }

    public(friend) fun migrate__v__0_2_0(arg0: &mut State) {
    }

    public(friend) fun migrate_version(arg0: &mut State) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::migrate_version<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__DUMMY, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__0_2_0>(&mut arg0.id, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::previous_version(), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::current_version());
    }

    public(friend) fun prepare_wormhole_message(arg0: &LatestOnly, arg1: &mut State, arg2: u32, arg3: vector<u8>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg1.emitter_cap, arg2, arg3)
    }

    public fun verified_asset<T0>(arg0: &State) : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0> {
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::assert_has<T0>(&arg0.token_registry);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::verified_asset<T0>(&arg0.token_registry)
    }

    // decompiled from Move bytecode v6
}

