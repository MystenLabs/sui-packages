module 0xbd98d13d5d8fcdc8d5930d0e7b1b6eedfd8bfaa1787fa7d046af8a196a256547::nft_mint {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ArtworkCollection has store, key {
        id: 0x2::object::UID,
        artwork_id: 0x1::string::String,
        total_supply: u64,
        minted_count: u64,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        artwork_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CollectionCreated has copy, drop {
        collection_object_id: 0x2::object::ID,
        artwork_id: 0x1::string::String,
        total_supply: u64,
    }

    struct NftMinted has copy, drop {
        collection_object_id: 0x2::object::ID,
        nft_object_id: 0x2::object::ID,
        artwork_id: 0x1::string::String,
        recipient: address,
    }

    public entry fun create_artwork_collection(arg0: &AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ArtworkCollection{
            id           : 0x2::object::new(arg3),
            artwork_id   : arg1,
            total_supply : arg2,
            minted_count : 0,
        };
        let v1 = CollectionCreated{
            collection_object_id : 0x2::object::uid_to_inner(&v0.id),
            artwork_id           : v0.artwork_id,
            total_supply         : v0.total_supply,
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::public_transfer<ArtworkCollection>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_and_send(arg0: &mut ArtworkCollection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted_count < arg0.total_supply, 2);
        arg0.minted_count = arg0.minted_count + 1;
        let v0 = Nft{
            id          : 0x2::object::new(arg5),
            artwork_id  : arg0.artwork_id,
            name        : arg1,
            description : arg2,
            url         : arg3,
        };
        let v1 = NftMinted{
            collection_object_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_object_id        : 0x2::object::uid_to_inner(&v0.id),
            artwork_id           : arg0.artwork_id,
            recipient            : arg4,
        };
        0x2::event::emit<NftMinted>(v1);
        0x2::transfer::public_transfer<Nft>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

