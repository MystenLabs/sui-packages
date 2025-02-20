module 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::State>(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::new(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

