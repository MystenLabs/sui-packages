module 0x7566b364f84829713b0d6e6f337e2ab7ecb52b85cf3d10548b179ed91e13d348::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x7566b364f84829713b0d6e6f337e2ab7ecb52b85cf3d10548b179ed91e13d348::state::new(arg1, arg2);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

