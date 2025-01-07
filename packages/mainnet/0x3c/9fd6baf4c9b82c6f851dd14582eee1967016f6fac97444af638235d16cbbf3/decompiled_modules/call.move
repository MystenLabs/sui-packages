module 0x3c9fd6baf4c9b82c6f851dd14582eee1967016f6fac97444af638235d16cbbf3::call {
    public entry fun do(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xec33e95c4fba4633ecaf40afa1a48d06aedc680743a02545b34f72a727d8eeee::my_hero::mint(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

