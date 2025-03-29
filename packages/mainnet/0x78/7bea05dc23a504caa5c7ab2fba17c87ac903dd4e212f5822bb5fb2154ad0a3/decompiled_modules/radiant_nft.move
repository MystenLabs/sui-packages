module 0x787bea05dc23a504caa5c7ab2fba17c87ac903dd4e212f5822bb5fb2154ad0a3::radiant_nft {
    struct RadiantNFT has store, key {
        id: 0x2::object::UID,
        token_name: 0x1::string::String,
        metadata_cid: 0x1::string::String,
        owner: address,
        creator: address,
        collection: address,
    }

    struct RadiantCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        total_supply: u64,
    }

    struct NFTCreated has copy, drop {
        object_id: address,
        metadata_cid: 0x1::string::String,
        creator: address,
        owner: address,
    }

    public entry fun transfer(arg0: RadiantNFT, arg1: address, arg2: &0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        0x2::transfer::public_transfer<RadiantNFT>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RadiantCollection{
            id           : 0x2::object::new(arg0),
            name         : 0x1::string::utf8(b"RadiantTestCollection"),
            symbol       : 0x1::string::utf8(b"RADTEST"),
            total_supply : 0,
        };
        0x2::transfer::public_transfer<RadiantCollection>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut RadiantCollection, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = RadiantNFT{
            id           : 0x2::object::new(arg2),
            token_name   : 0x1::string::utf8(b"RadiantTest"),
            metadata_cid : arg0,
            owner        : v0,
            creator      : v0,
            collection   : 0x2::object::uid_to_address(&arg1.id),
        };
        arg1.total_supply = arg1.total_supply + 1;
        let v2 = NFTCreated{
            object_id    : 0x2::object::uid_to_address(&v1.id),
            metadata_cid : arg0,
            creator      : v0,
            owner        : v0,
        };
        0x2::event::emit<NFTCreated>(v2);
        0x2::transfer::public_transfer<RadiantNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

