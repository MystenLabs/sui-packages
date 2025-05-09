module 0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::State>(0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::new_state(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun register_cctp_mayan_caller(arg0: &0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::AdminCap, arg1: &mut 0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: address) {
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::assert_valid_version(arg1);
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::add_cctp_mayan_caller(arg0, arg1, arg3, arg4);
    }

    entry fun register_cctp_mayan_recipient<T0>(arg0: &0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::AdminCap, arg1: &mut 0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: &0x2::coin::CoinMetadata<T0>, arg5: address) {
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::assert_valid_version(arg1);
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4);
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::add_cctp_mayan_recipient(arg0, arg1, arg3, 0x2::object::id_to_address(&v0), arg5);
    }

    entry fun register_paired_emitter(arg0: &0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::AdminCap, arg1: &mut 0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::State, arg2: u16, arg3: address) {
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::assert_valid_version(arg1);
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::add_paired_emitter(arg0, arg1, arg2, arg3);
    }

    entry fun register_wh_chain_cctp_domain(arg0: &0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::AdminCap, arg1: &mut 0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u16, arg4: u32) {
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::assert_valid_version(arg1);
        assert!(arg4 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        assert!(arg3 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        0x4653c86d00864cec10fb050ed4aaf596d2cfeffca4e5b62eb944e21a7ebd8cca::state::add_wh_chain_cctp_domain(arg0, arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

