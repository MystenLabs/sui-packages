module 0xff72af6d6a872bf165355712dccb4a6495029b16ed298fed0ed08226351e1c7e::devnet_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        tokenId: u64,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        tokenIdSequence: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        nfts: 0x2::table::Table<u64, 0x2::object::ID>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: NFT) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            tokenId     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun getMintedSupply(arg0: &Collection) : u64 {
        0x2::table::length<u64, 0x2::object::ID>(&arg0.nfts)
    }

    public fun getTotalSupply(arg0: &Collection) : u64 {
        arg0.total_supply
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id              : 0x2::object::new(arg0),
            tokenIdSequence : 0,
            name            : 0x1::string::utf8(b"Sui Doge NFTs"),
            description     : 0x1::string::utf8(b"A Collection of 3500 Doge NFTs on SUI"),
            total_supply    : 0,
            nfts            : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    public entry fun mint(arg0: &mut Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.tokenIdSequence + 1;
        arg0.tokenIdSequence = v0;
        let v1 = NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(b"A Collection of 3500 Doge NFTs on SUI"),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            tokenId     : v0,
        };
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut v3, 100000, arg4)));
        let v4 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v2,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v4);
        arg0.total_supply = arg0.total_supply + 1;
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.nfts, v0, 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::public_transfer<NFT>(v1, v2);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

