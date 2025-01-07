module 0x9e3fcbdd9040ca2e2ed12ab08c9e3eb2832dd932f89c8fa21cc09ada11b79eb0::nft {
    struct SeedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
    }

    struct NFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
    }

    struct NFTTransferredEvent has copy, drop {
        object_id: 0x2::object::ID,
        receiver: address,
    }

    struct NFTburnedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct NFTBridgedEvent has copy, drop {
        object_id: 0x2::object::ID,
        chain_id: u64,
    }

    public entry fun transfer(arg0: SeedNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 1);
        let v0 = NFTTransferredEvent{
            object_id : 0x2::object::id<SeedNFT>(&arg0),
            receiver  : arg1,
        };
        0x2::event::emit<NFTTransferredEvent>(v0);
        0x2::transfer::public_transfer<SeedNFT>(arg0, arg1);
    }

    public entry fun bridge(arg0: SeedNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTBridgedEvent{
            object_id : 0x2::object::id<SeedNFT>(&arg0),
            chain_id  : arg1,
        };
        0x2::event::emit<NFTBridgedEvent>(v0);
        let SeedNFT {
            id          : v1,
            name        : _,
            description : _,
            url         : _,
            nft_url     : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public entry fun burn(arg0: SeedNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTburnedEvent{object_id: 0x2::object::id<SeedNFT>(&arg0)};
        0x2::event::emit<NFTburnedEvent>(v0);
        let SeedNFT {
            id          : v1,
            name        : _,
            description : _,
            url         : _,
            nft_url     : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = SeedNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            nft_url     : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = NFTMintedEvent{
            object_id : 0x2::object::id<SeedNFT>(&v1),
            creator   : v0,
            name      : v1.name,
            url       : v1.url,
            nft_url   : v1.nft_url,
        };
        0x2::event::emit<NFTMintedEvent>(v2);
        0x2::transfer::transfer<SeedNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

