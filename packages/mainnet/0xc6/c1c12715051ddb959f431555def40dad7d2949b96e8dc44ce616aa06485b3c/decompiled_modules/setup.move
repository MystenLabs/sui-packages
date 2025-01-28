module 0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::state::new(arg1, arg2);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

