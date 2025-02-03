module 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::state {
    struct LatestOnly has drop {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        governance_chain: u16,
        governance_contract: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::external_address::ExternalAddress,
        guardian_set_index: u32,
        guardian_sets: 0x2::table::Table<u32, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet>,
        guardian_set_seconds_to_live: u32,
        consumed_vaas: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::consumed_vaas::ConsumedVAAs,
        fee_collector: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::fee_collector::FeeCollector,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public(friend) fun new(arg0: 0x2::package::UpgradeCap, arg1: u16, arg2: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::external_address::ExternalAddress, arg3: u32, arg4: vector<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>, arg5: u32, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : State {
        assert!(0x1::vector::length<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>(&arg4) > 0, 0);
        let v0 = State{
            id                           : 0x2::object::new(arg7),
            governance_chain             : arg1,
            governance_contract          : arg2,
            guardian_set_index           : arg3,
            guardian_sets                : 0x2::table::new<u32, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet>(arg7),
            guardian_set_seconds_to_live : arg5,
            consumed_vaas                : 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::consumed_vaas::new(arg7),
            fee_collector                : 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::fee_collector::new(arg6),
            upgrade_cap                  : arg0,
        };
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::init_package_info<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::V__0_2_0>(&mut v0.id, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::current_version(), &v0.upgrade_cap);
        let v1 = assert_latest_only(&v0);
        let v2 = &mut v0;
        add_new_guardian_set(&v1, v2, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::new(arg3, arg4));
        v0
    }

    public(friend) fun authorize_upgrade(arg0: &mut State, arg1: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32) : 0x2::package::UpgradeTicket {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::authorize_upgrade(&mut arg0.id, &mut arg0.upgrade_cap, arg1)
    }

    public(friend) fun commit_upgrade(arg0: &mut State, arg1: 0x2::package::UpgradeReceipt) : (0x2::object::ID, 0x2::object::ID) {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::commit_upgrade(&mut arg0.id, &mut arg0.upgrade_cap, arg1)
    }

    public(friend) fun current_package(arg0: &LatestOnly, arg1: &State) : 0x2::object::ID {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::current_package(&arg1.id)
    }

    public(friend) fun migrate_version(arg0: &mut State) {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::migrate_version<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::V__DUMMY, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::V__0_2_0>(&mut arg0.id, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::previous_version(), 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::current_version());
    }

    public(friend) fun add_new_guardian_set(arg0: &LatestOnly, arg1: &mut State, arg2: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet) {
        arg1.guardian_set_index = 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::index(&arg2);
        0x2::table::add<u32, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet>(&mut arg1.guardian_sets, arg1.guardian_set_index, arg2);
    }

    public(friend) fun assert_authorized_digest(arg0: &LatestOnly, arg1: &State, arg2: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32) {
        assert!(arg2 == 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::authorized_digest(&arg1.id), 1);
    }

    public(friend) fun assert_latest_only(arg0: &State) : LatestOnly {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::package_utils::assert_version<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::V__0_2_0>(&arg0.id, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::version_control::current_version());
        LatestOnly{dummy_field: false}
    }

    public(friend) fun borrow_mut_consumed_vaas(arg0: &LatestOnly, arg1: &mut State) : &mut 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::consumed_vaas::ConsumedVAAs {
        borrow_mut_consumed_vaas_unchecked(arg1)
    }

    public(friend) fun borrow_mut_consumed_vaas_unchecked(arg0: &mut State) : &mut 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::consumed_vaas::ConsumedVAAs {
        &mut arg0.consumed_vaas
    }

    public fun chain_id() : u16 {
        21
    }

    public(friend) fun deposit_fee(arg0: &LatestOnly, arg1: &mut State, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::fee_collector::deposit_balance(&mut arg1.fee_collector, arg2);
    }

    public(friend) fun expire_guardian_set(arg0: &LatestOnly, arg1: &mut State, arg2: &0x2::clock::Clock) {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::set_expiration(0x2::table::borrow_mut<u32, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet>(&mut arg1.guardian_sets, arg1.guardian_set_index), arg1.guardian_set_seconds_to_live, arg2);
    }

    public fun governance_chain(arg0: &State) : u16 {
        arg0.governance_chain
    }

    public fun governance_contract(arg0: &State) : 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::external_address::ExternalAddress {
        arg0.governance_contract
    }

    public fun governance_module() : 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32 {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::new(x"00000000000000000000000000000000000000000000000000000000436f7265")
    }

    public fun guardian_set_at(arg0: &State, arg1: u32) : &0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet {
        0x2::table::borrow<u32, 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set::GuardianSet>(&arg0.guardian_sets, arg1)
    }

    public fun guardian_set_index(arg0: &State) : u32 {
        arg0.guardian_set_index
    }

    public fun guardian_set_seconds_to_live(arg0: &State) : u32 {
        arg0.guardian_set_seconds_to_live
    }

    public fun message_fee(arg0: &State) : u64 {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::fee_collector::fee_amount(&arg0.fee_collector)
    }

    public(friend) fun migrate__v__0_2_0(arg0: &mut State) {
    }

    public(friend) fun set_message_fee(arg0: &LatestOnly, arg1: &mut State, arg2: u64) {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::fee_collector::change_fee(&mut arg1.fee_collector, arg2);
    }

    public(friend) fun withdraw_fee(arg0: &LatestOnly, arg1: &mut State, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::fee_collector::withdraw_balance(&mut arg1.fee_collector, arg2)
    }

    // decompiled from Move bytecode v6
}

