module 0x592540e7936da9c85a671bec203c1678a24831563e9177786e3a8c6d0220a2e::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x592540e7936da9c85a671bec203c1678a24831563e9177786e3a8c6d0220a2e::state::new(arg1, arg2);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

