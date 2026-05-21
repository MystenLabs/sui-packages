module 0xf17bb62cdcb09e88da29ad8c770c6543df56c2c2962dfa4dbdcf590508e48a96::nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            url         : arg2,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, arg3);
    }

    // decompiled from Move bytecode v7
}

