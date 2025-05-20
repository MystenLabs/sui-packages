module 0xf7d316e9baa04943649eddead5c22aa880997d4b79fafc4f49bf5f84ee47fdc8::mint_box {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct BoxNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_url: 0x1::string::String,
        collection_id: address,
    }

    struct MintEvent has copy, drop, store {
        recipient: address,
        name: 0x1::string::String,
        external_url: 0x1::string::String,
        collection_id: address,
    }

    struct BurnEvent has copy, drop, store {
        sender: address,
        nft_name: 0x1::string::String,
        collection_id: address,
    }

    public entry fun burn_nft(arg0: BoxNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let BoxNFT {
            id            : v0,
            name          : v1,
            description   : _,
            image_url     : _,
            external_url  : _,
            collection_id : v5,
        } = arg0;
        let v6 = BurnEvent{
            sender        : 0x2::tx_context::sender(arg1),
            nft_name      : v1,
            collection_id : v5,
        };
        0x2::event::emit<BurnEvent>(v6);
        0x2::object::delete(v0);
    }

    public entry fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xf56a962635321eacc2e66b8dbdccff6d801c4ea278c3eca6fe57751a619f60cf, 101);
        let v0 = Collection{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        0x2::transfer::public_transfer<Collection>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == @0xf56a962635321eacc2e66b8dbdccff6d801c4ea278c3eca6fe57751a619f60cf, 100);
        let v0 = BoxNFT{
            id            : 0x2::object::new(arg6),
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
            external_url  : arg3,
            collection_id : arg4,
        };
        0x2::transfer::public_transfer<BoxNFT>(v0, arg5);
        let v1 = MintEvent{
            recipient     : arg5,
            name          : arg0,
            external_url  : arg3,
            collection_id : arg4,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

