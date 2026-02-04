module 0x3f3b1874133b417624fab4990ea8dd800cb6eff141fbc43ea216b11f2f2844f6::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
    }

    struct MintingFactory has key {
        id: 0x2::object::UID,
        admin: address,
        total_supply: u64,
        collection_name: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        owner: address,
        name: 0x1::string::String,
    }

    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct NFTDestroyed has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
    }

    public fun destroy(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTDestroyed{
            nft_id : 0x2::object::id<NFT>(&arg0),
            owner  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTDestroyed>(v0);
        let NFT {
            id          : v1,
            name        : _,
            description : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_factory_info(arg0: &MintingFactory) : (address, u64, 0x1::string::String) {
        (arg0.admin, arg0.total_supply, arg0.collection_name)
    }

    public fun get_info(arg0: &NFT) : (0x2::object::ID, 0x1::string::String, 0x1::string::String, address) {
        (0x2::object::id<NFT>(arg0), arg0.name, arg0.description, arg0.creator)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = MintingFactory{
            id              : 0x2::object::new(arg0),
            admin           : v0,
            total_supply    : 0,
            collection_name : 0x1::string::utf8(b"Sui NFT Collection"),
        };
        0x2::transfer::transfer<MintingFactory>(v1, v0);
    }

    public fun mint(arg0: &mut MintingFactory, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : NFT {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = NFT{
            id          : 0x2::object::new(arg3),
            name        : arg1,
            description : arg2,
            creator     : 0x2::tx_context::sender(arg3),
        };
        arg0.total_supply = arg0.total_supply + 1;
        let v1 = NFTMinted{
            nft_id  : 0x2::object::id<NFT>(&v0),
            creator : 0x2::tx_context::sender(arg3),
            owner   : 0x2::tx_context::sender(arg3),
            name    : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public fun transfer_factory_ownership(arg0: &mut MintingFactory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    public fun transfer_nft(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransferred{
            nft_id : 0x2::object::id<NFT>(&arg0),
            from   : 0x2::tx_context::sender(arg2),
            to     : arg1,
        };
        0x2::event::emit<NFTTransferred>(v0);
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

