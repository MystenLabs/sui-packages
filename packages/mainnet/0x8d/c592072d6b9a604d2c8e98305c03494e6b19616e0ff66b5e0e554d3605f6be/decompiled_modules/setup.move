module 0x8dc592072d6b9a604d2c8e98305c03494e6b19616e0ff66b5e0e554d3605f6be::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8dc592072d6b9a604d2c8e98305c03494e6b19616e0ff66b5e0e554d3605f6be::state::new(arg1, arg2);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

