module 0x31ad8f5c1e765faeba4a4bd4b36d86289e17698671b5a370c5dd6b282feb29aa::simple_nft {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: SimpleNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SimpleNFT>(arg0, arg1);
    }

    public fun description(arg0: &SimpleNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SimpleNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Simple NFT"),
            description : 0x1::string::utf8(b"This is a simple NFT."),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SimpleNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SimpleNFT>(v1, v0);
    }

    public fun name(arg0: &SimpleNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

