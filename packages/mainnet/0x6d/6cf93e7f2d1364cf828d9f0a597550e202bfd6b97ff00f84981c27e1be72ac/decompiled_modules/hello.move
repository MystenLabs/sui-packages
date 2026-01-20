module 0x6d6cf93e7f2d1364cf828d9f0a597550e202bfd6b97ff00f84981c27e1be72ac::hello {
    public entry fun say_hello(arg0: &mut 0x2::tx_context::TxContext) {
        0x1::string::utf8(b"Hello Sui Mainnet!");
    }

    // decompiled from Move bytecode v6
}

