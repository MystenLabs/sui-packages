module 0x97d5691c660a2c7876868ff30a057749d921b2c54579c9972c7f080b349c669d::simple_nft {
    struct BlockblockNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockblockNft{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            img_url : arg1,
        };
        0x2::transfer::transfer<BlockblockNft>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

