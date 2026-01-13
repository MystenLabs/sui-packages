module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_paused: bool,
        manager_cap_id: 0x2::object::ID,
        deleveraging_cap_id: 0x2::object::ID,
        funding_rate_cap_id: 0x2::object::ID,
        settlement_cap_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        maker_gas_fee: u128,
        taker_gas_fee: u128,
        privileged_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct PerpetualRegistry has store {
        perpetuals: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public(friend) fun add_settlement_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.settlement_cap_ids, arg1);
    }

    public(friend) fun borrow_perpetual_ids(arg0: &ProtocolConfig) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &0x2::dynamic_field::borrow<vector<u8>, PerpetualRegistry>(&arg0.id, b"perpetual_registry").perpetuals
    }

    public(friend) fun check_basic(arg0: &ProtocolConfig) {
        check_version(arg0);
        check_is_normal(arg0);
    }

    public(friend) fun check_is_normal(arg0: &ProtocolConfig) {
        assert!(!arg0.is_paused, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exchange_paused());
    }

    public(friend) fun check_version(arg0: &ProtocolConfig) {
        assert!(arg0.version == 2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_protocol_version());
    }

    public(friend) fun deleveraging_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        arg0.deleveraging_cap_id
    }

    public(friend) fun funding_rate_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        arg0.funding_rate_cap_id
    }

    public(friend) fun initialize(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                   : 0x2::object::new(arg3),
            version              : 2,
            is_paused            : false,
            manager_cap_id       : arg0,
            deleveraging_cap_id  : arg1,
            funding_rate_cap_id  : arg2,
            settlement_cap_ids   : 0x2::vec_set::empty<0x2::object::ID>(),
            maker_gas_fee        : 0,
            taker_gas_fee        : 0,
            privileged_addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
    }

    public(friend) fun is_paused(arg0: &ProtocolConfig) : bool {
        arg0.is_paused
    }

    public(friend) fun maker_gas_fee(arg0: &ProtocolConfig) : u128 {
        arg0.maker_gas_fee
    }

    public(friend) fun manager_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        arg0.manager_cap_id
    }

    public(friend) fun privileged_addresses(arg0: &ProtocolConfig) : &0x2::vec_set::VecSet<address> {
        &arg0.privileged_addresses
    }

    public(friend) fun privileged_addresses_mut(arg0: &mut ProtocolConfig) : &mut 0x2::vec_set::VecSet<address> {
        &mut arg0.privileged_addresses
    }

    public(friend) fun register_perpetual(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"perpetual_registry")) {
            let v0 = PerpetualRegistry{perpetuals: 0x2::vec_set::empty<0x2::object::ID>()};
            0x2::dynamic_field::add<vector<u8>, PerpetualRegistry>(&mut arg0.id, b"perpetual_registry", v0);
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, PerpetualRegistry>(&mut arg0.id, b"perpetual_registry").perpetuals, arg1);
    }

    public(friend) fun remove_settlement_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.settlement_cap_ids, &arg1);
    }

    public(friend) fun set_deleveraging_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        arg0.deleveraging_cap_id = arg1;
    }

    public(friend) fun set_funding_rate_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        arg0.funding_rate_cap_id = arg1;
    }

    public(friend) fun set_is_paused(arg0: &mut ProtocolConfig, arg1: bool) {
        arg0.is_paused = arg1;
    }

    public(friend) fun set_maker_gas_fee(arg0: &mut ProtocolConfig, arg1: u128) {
        arg0.maker_gas_fee = arg1;
    }

    public(friend) fun set_manager_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        arg0.manager_cap_id = arg1;
    }

    public(friend) fun set_taker_gas_fee(arg0: &mut ProtocolConfig, arg1: u128) {
        arg0.taker_gas_fee = arg1;
    }

    public(friend) fun settlement_cap_ids(arg0: &ProtocolConfig) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.settlement_cap_ids
    }

    public(friend) fun taker_gas_fee(arg0: &ProtocolConfig) : u128 {
        arg0.taker_gas_fee
    }

    public(friend) fun upgrade(arg0: &mut ProtocolConfig) {
        assert!(arg0.version + 1 == 2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_protocol_version());
        arg0.version = 2;
    }

    public(friend) fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

