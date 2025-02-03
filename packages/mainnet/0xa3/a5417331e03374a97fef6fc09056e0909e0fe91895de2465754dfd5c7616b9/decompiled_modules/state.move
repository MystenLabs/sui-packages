module 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::state {
    struct State has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        relayer_fee: 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::relayer_fee::RelayerFee,
        foreign_contracts: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        guardian_addresses: 0x2::table::Table<u64, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        paid_tx: 0x2::table::Table<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>,
    }

    public(friend) fun new(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                 : 0x2::object::new(arg3),
            emitter_cap        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg3),
            relayer_fee        : 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::relayer_fee::new(arg1, arg2),
            foreign_contracts  : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg3),
            guardian_addresses : 0x2::table::new<u64, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg3),
            paid_tx            : 0x2::table::new<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>(arg3),
        }
    }

    public(friend) fun add_guardian(arg0: &mut State, arg1: u64, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        if (guadian_registered(arg0, arg1)) {
            0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::guardian::update(&mut arg0.guardian_addresses, arg1, arg2);
        } else {
            0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::guardian::add(&mut arg0.guardian_addresses, arg1, arg2);
        };
    }

    public(friend) fun add_paid_tx(arg0: &mut State, arg1: u64, arg2: 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32) {
        assert!(arg1 != 0, 0);
        if (!0x2::table::contains<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>(&arg0.paid_tx, arg1)) {
            let v0 = 0x1::vector::empty<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>();
            0x1::vector::push_back<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>(&mut v0, arg2);
            0x2::table::add<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>(&mut arg0.paid_tx, arg1, v0);
        } else {
            0x1::vector::push_back<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>(0x2::table::borrow_mut<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>(&mut arg0.paid_tx, arg1), arg2);
        };
    }

    public fun contract_registered(arg0: &State, arg1: u16) : bool {
        0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.foreign_contracts, arg1)
    }

    public(friend) fun emitter_cap(arg0: &State) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &arg0.emitter_cap
    }

    public fun fee_precision(arg0: &State) : u64 {
        0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::relayer_fee::precision(&arg0.relayer_fee)
    }

    public fun fee_value(arg0: &State) : u64 {
        0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::relayer_fee::value(&arg0.relayer_fee)
    }

    public fun foreign_contract_address(arg0: &State, arg1: u16) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        assert!(contract_registered(arg0, arg1), 2);
        *0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.foreign_contracts, arg1)
    }

    public fun get_relayer_fee(arg0: &State, arg1: u64) : u64 {
        0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::relayer_fee::compute(&arg0.relayer_fee, arg1)
    }

    public fun guadian_address(arg0: &State, arg1: u64) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        assert!(guadian_registered(arg0, arg1), 3);
        *0x2::table::borrow<u64, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.guardian_addresses, arg1)
    }

    public fun guadian_registered(arg0: &State, arg1: u64) : bool {
        0x2::table::contains<u64, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.guardian_addresses, arg1)
    }

    public fun is_paid(arg0: &State, arg1: u64, arg2: 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32) : bool {
        let v0 = false;
        if (0x2::table::contains<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>(&arg0.paid_tx, arg1)) {
            v0 = 0x1::vector::contains<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>(0x2::table::borrow<u64, vector<0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32::Bytes32>>(&arg0.paid_tx, arg1), &arg2);
        };
        v0
    }

    public(friend) fun register_foreign_contract(arg0: &mut State, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        if (contract_registered(arg0, arg1)) {
            0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::foreign_contracts::update(&mut arg0.foreign_contracts, arg1, arg2);
        } else {
            0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::foreign_contracts::add(&mut arg0.foreign_contracts, arg1, arg2);
        };
    }

    public(friend) fun update_relayer_fee(arg0: &mut State, arg1: u64, arg2: u64) {
        0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::relayer_fee::update(&mut arg0.relayer_fee, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

