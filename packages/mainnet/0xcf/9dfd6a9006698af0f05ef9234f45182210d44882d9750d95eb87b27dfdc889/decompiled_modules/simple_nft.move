module 0xcf9dfd6a9006698af0f05ef9234f45182210d44882d9750d95eb87b27dfdc889::simple_nft {
    struct BlockblockNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockblockNft{
            id      : 0x2::object::new(arg2),
            name    : arg0,
            img_url : arg1,
        };
        0x2::transfer::transfer<BlockblockNft>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

