module 0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::state {
    struct State has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        relayer_fee: 0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::relayer_fee::RelayerFee,
        foreign_contracts: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
    }

    public(friend) fun new(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                : 0x2::object::new(arg3),
            emitter_cap       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg3),
            relayer_fee       : 0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::relayer_fee::new(arg1, arg2),
            foreign_contracts : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg3),
        }
    }

    public fun contract_registered(arg0: &State, arg1: u16) : bool {
        0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.foreign_contracts, arg1)
    }

    public(friend) fun emitter_cap(arg0: &State) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &arg0.emitter_cap
    }

    public fun fee_precision(arg0: &State) : u64 {
        0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::relayer_fee::precision(&arg0.relayer_fee)
    }

    public fun fee_value(arg0: &State) : u64 {
        0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::relayer_fee::value(&arg0.relayer_fee)
    }

    public fun foreign_contract_address(arg0: &State, arg1: u16) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        assert!(contract_registered(arg0, arg1), 2);
        *0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.foreign_contracts, arg1)
    }

    public fun get_relayer_fee(arg0: &State, arg1: u64) : u64 {
        0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::relayer_fee::compute(&arg0.relayer_fee, arg1)
    }

    public(friend) fun register_foreign_contract(arg0: &mut State, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        if (contract_registered(arg0, arg1)) {
            0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::foreign_contracts::update(&mut arg0.foreign_contracts, arg1, arg2);
        } else {
            0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::foreign_contracts::add(&mut arg0.foreign_contracts, arg1, arg2);
        };
    }

    public(friend) fun update_relayer_fee(arg0: &mut State, arg1: u64, arg2: u64) {
        0x1135764227284113051d2d349dc4adf40ecea054001494e5d8ddf1cf91121e7e::relayer_fee::update(&mut arg0.relayer_fee, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

