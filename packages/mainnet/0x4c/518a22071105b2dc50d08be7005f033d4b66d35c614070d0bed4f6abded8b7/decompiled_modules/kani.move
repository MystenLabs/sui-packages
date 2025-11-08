module 0x4c518a22071105b2dc50d08be7005f033d4b66d35c614070d0bed4f6abded8b7::kani {
    struct KaniNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        total_supply: u64,
        minted: u64,
    }

    struct NFTMinted has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        minter: address,
    }

    struct KANI has drop {
        dummy_field: bool,
    }

    public fun url(arg0: &KaniNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun collection_minted(arg0: &NFTCollection) : u64 {
        arg0.minted
    }

    public fun collection_name(arg0: &NFTCollection) : 0x1::string::String {
        arg0.name
    }

    public fun collection_total_supply(arg0: &NFTCollection) : u64 {
        arg0.total_supply
    }

    public fun create_collection(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<KANI>(arg0), 0);
        let v0 = NFTCollection{
            id           : 0x2::object::new(arg3),
            name         : arg1,
            total_supply : arg2,
            minted       : 0,
        };
        0x2::transfer::transfer<NFTCollection>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun description(arg0: &KaniNFT) : 0x1::string::String {
        arg0.description
    }

    fun init(arg0: KANI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KANI>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_sender(arg0: &mut NFTCollection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.total_supply, 1);
        arg0.minted = arg0.minted + 1;
        let v0 = KaniNFT{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            collection_id : 0x2::object::id<NFTCollection>(arg0),
            nft_id        : 0x2::object::id<KaniNFT>(&v0),
            minter        : arg4,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<KaniNFT>(v0, arg4);
    }

    public fun name(arg0: &KaniNFT) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

