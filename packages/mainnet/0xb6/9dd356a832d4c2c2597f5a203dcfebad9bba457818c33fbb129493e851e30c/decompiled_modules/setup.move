module 0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete_setup(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::state::State>(0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::state::new_state(arg1, arg2));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

