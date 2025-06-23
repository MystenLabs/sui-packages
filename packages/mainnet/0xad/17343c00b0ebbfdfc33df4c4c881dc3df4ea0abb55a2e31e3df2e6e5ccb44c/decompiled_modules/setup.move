module 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::State>(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::new(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

