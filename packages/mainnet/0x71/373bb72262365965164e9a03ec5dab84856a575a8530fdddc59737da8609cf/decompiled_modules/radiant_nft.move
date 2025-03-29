module 0x71373bb72262365965164e9a03ec5dab84856a575a8530fdddc59737da8609cf::radiant_nft {
    struct RadiantNFT has store, key {
        id: 0x2::object::UID,
        token_name: 0x1::string::String,
        metadata_cid: 0x1::string::String,
        creator: address,
        collection: address,
    }

    struct RadiantCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        total_supply: u64,
    }

    struct NFTCreated has copy, drop {
        object_id: address,
        metadata_cid: 0x1::string::String,
        creator: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RadiantCollection{
            id           : 0x2::object::new(arg0),
            name         : 0x1::string::utf8(b"RadiantTestCollection"),
            symbol       : 0x1::string::utf8(b"RADTEST"),
            total_supply : 0,
        };
        0x2::transfer::share_object<RadiantCollection>(v0);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut RadiantCollection, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = RadiantNFT{
            id           : 0x2::object::new(arg2),
            token_name   : 0x1::string::utf8(b"RadiantTest"),
            metadata_cid : arg0,
            creator      : v0,
            collection   : 0x2::object::uid_to_address(&arg1.id),
        };
        arg1.total_supply = arg1.total_supply + 1;
        let v2 = NFTCreated{
            object_id    : 0x2::object::uid_to_address(&v1.id),
            metadata_cid : arg0,
            creator      : v0,
        };
        0x2::event::emit<NFTCreated>(v2);
        0x2::transfer::public_transfer<RadiantNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

