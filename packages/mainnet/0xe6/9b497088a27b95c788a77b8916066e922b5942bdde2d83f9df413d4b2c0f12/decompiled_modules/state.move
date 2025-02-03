module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state {
    struct LatestOnly has drop {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        governance_data_source: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource,
        stale_price_threshold: u64,
        base_update_fee: u64,
        fee_recipient_address: address,
        last_executed_governance_sequence: u64,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    struct CurrentDigest has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x2::package::UpgradeCap, arg1: vector<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>, arg2: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x2::object::new(arg5);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::new_data_source_registry(&mut v0, arg5);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_info::new_price_info_registry(&mut v0, arg5);
        while (!0x1::vector::is_empty<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>(&arg1)) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::add(&mut v0, 0x1::vector::pop_back<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>(&mut arg1));
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::init_package_info<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::V__0_1_1>(&mut v0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::current_version(), &arg0);
        State{
            id                                : v0,
            governance_data_source            : arg2,
            stale_price_threshold             : arg3,
            base_update_fee                   : arg4,
            fee_recipient_address             : 0x2::tx_context::sender(arg5),
            last_executed_governance_sequence : 0,
            consumed_vaas                     : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg5),
            upgrade_cap                       : arg0,
        }
    }

    public(friend) fun authorize_upgrade(arg0: &mut State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32) : 0x2::package::UpgradeTicket {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::authorize_upgrade(&mut arg0.id, &mut arg0.upgrade_cap, arg1)
    }

    public(friend) fun commit_upgrade(arg0: &mut State, arg1: 0x2::package::UpgradeReceipt) : (0x2::object::ID, 0x2::object::ID) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::commit_upgrade(&mut arg0.id, &mut arg0.upgrade_cap, arg1)
    }

    public(friend) fun current_package(arg0: &LatestOnly, arg1: &State) : 0x2::object::ID {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::current_package(&arg1.id)
    }

    public(friend) fun migrate_version(arg0: &mut State) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::migrate_version<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::V__DUMMY, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::V__0_1_1>(&mut arg0.id, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::previous_version(), 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::current_version());
    }

    public(friend) fun assert_authorized_digest(arg0: &LatestOnly, arg1: &State, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32) {
        assert!(arg2 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::authorized_digest(&arg1.id), 0);
    }

    public(friend) fun assert_latest_only(arg0: &State) : LatestOnly {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_version<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::V__0_1_1>(&arg0.id, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::current_version());
        LatestOnly{dummy_field: false}
    }

    public(friend) fun borrow_mut_consumed_vaas(arg0: &LatestOnly, arg1: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs {
        borrow_mut_consumed_vaas_unchecked(arg1)
    }

    public(friend) fun borrow_mut_consumed_vaas_unchecked(arg0: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs {
        &mut arg0.consumed_vaas
    }

    public fun get_base_update_fee(arg0: &State) : u64 {
        arg0.base_update_fee
    }

    public fun get_fee_recipient(arg0: &State) : address {
        arg0.fee_recipient_address
    }

    public fun get_last_executed_governance_sequence(arg0: &State) : u64 {
        arg0.last_executed_governance_sequence
    }

    public fun get_price_info_object_id(arg0: &State, arg1: vector<u8>) : 0x2::object::ID {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_info::get_id(&arg0.id, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier::from_byte_vec(arg1))
    }

    public fun get_stale_price_threshold_secs(arg0: &State) : u64 {
        arg0.stale_price_threshold
    }

    public fun governance_chain(arg0: &State) : u16 {
        let v0 = governance_data_source(arg0);
        (0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::emitter_chain(&v0) as u16)
    }

    public fun governance_contract(arg0: &State) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        let v0 = governance_data_source(arg0);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::emitter_address(&v0)
    }

    public fun governance_data_source(arg0: &State) : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource {
        arg0.governance_data_source
    }

    public fun governance_module() : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(x"0000000000000000000000000000000000000000000000000000000000000001")
    }

    public fun is_valid_data_source(arg0: &State, arg1: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource) : bool {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::contains(&arg0.id, arg1)
    }

    public fun is_valid_governance_data_source(arg0: &State, arg1: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource) : bool {
        arg0.governance_data_source == arg1
    }

    public(friend) fun migrate__v__0_1_1(arg0: &mut State) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::init_package_info<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::V__0_1_1>(&mut arg0.id, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::version_control::current_version(), &arg0.upgrade_cap);
    }

    public fun price_feed_object_exists(arg0: &State, arg1: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier::PriceIdentifier) : bool {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_info::contains(&arg0.id, arg1)
    }

    public(friend) fun register_price_info_object(arg0: &LatestOnly, arg1: &mut State, arg2: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier::PriceIdentifier, arg3: 0x2::object::ID) {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_info::add(&mut arg1.id, arg2, arg3);
    }

    public(friend) fun set_base_update_fee(arg0: &LatestOnly, arg1: &mut State, arg2: u64) {
        arg1.base_update_fee = arg2;
    }

    public(friend) fun set_data_sources(arg0: &LatestOnly, arg1: &mut State, arg2: vector<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>) {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::empty(&mut arg1.id);
        while (!0x1::vector::is_empty<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>(&arg2)) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::add(&mut arg1.id, 0x1::vector::pop_back<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>(&mut arg2));
        };
    }

    public(friend) fun set_fee_recipient(arg0: &LatestOnly, arg1: &mut State, arg2: address) {
        arg1.fee_recipient_address = arg2;
    }

    public(friend) fun set_governance_data_source(arg0: &LatestOnly, arg1: &mut State, arg2: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource) {
        arg1.governance_data_source = arg2;
    }

    public(friend) fun set_last_executed_governance_sequence(arg0: &LatestOnly, arg1: &mut State, arg2: u64) {
        arg1.last_executed_governance_sequence = arg2;
    }

    public(friend) fun set_last_executed_governance_sequence_unchecked(arg0: &mut State, arg1: u64) {
        arg0.last_executed_governance_sequence = arg1;
    }

    public(friend) fun set_stale_price_threshold_secs(arg0: &LatestOnly, arg1: &mut State, arg2: u64) {
        arg1.stale_price_threshold = arg2;
    }

    // decompiled from Move bytecode v6
}

