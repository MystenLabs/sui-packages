module 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete_setup(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::State>(0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::new_state(arg1, arg2));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        let v1 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

