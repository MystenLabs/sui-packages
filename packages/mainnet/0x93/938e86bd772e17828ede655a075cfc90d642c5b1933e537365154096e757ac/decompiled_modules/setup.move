module 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State>(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::new(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

