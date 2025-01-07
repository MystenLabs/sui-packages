module 0x7fa0e39e9123941a1f0fe02e9319ae14204f8b06e8d3af2f2fba39990a940690::nft {
    struct BugNFT has store, key {
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
        minted_supply: u64,
        nfts: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun url(arg0: &BugNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: BugNFT) {
        let BugNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            tokenId     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &BugNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun getMintedSupply(arg0: &Collection) : u64 {
        arg0.minted_supply
    }

    public fun getTotalSupply(arg0: &Collection) : u64 {
        arg0.total_supply
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"token id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/QmQAH9pwWPTgzeAKdLg92sB1NYX7BWs981JS4Z4uMCc2JQ"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://t.me/suibug"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Bug"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BugNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BugNFT>(&mut v5);
        let v6 = Collection{
            id              : 0x2::object::new(arg1),
            tokenIdSequence : 0,
            name            : 0x1::string::utf8(b"Sui Bug NFTs"),
            description     : 0x1::string::utf8(b"A Collection of 30,000 NFTs on SUI"),
            total_supply    : 30000,
            minted_supply   : 0,
            nfts            : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<Collection>(v6);
        0x2::transfer::transfer<AdminCap>(v7, v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v8);
        0x2::transfer::public_transfer<0x2::display::Display<BugNFT>>(v5, v8);
    }

    public entry fun mint(arg0: &mut Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tokenIdSequence < arg0.total_supply, 0);
        let v0 = arg0.tokenIdSequence + 1;
        arg0.tokenIdSequence = v0;
        let v1 = BugNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Sui Bug NFT"),
            description : 0x1::string::utf8(b"A Collection of 30,000 Sui Bug NFTs"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmQAH9pwWPTgzeAKdLg92sB1NYX7BWs981JS4Z4uMCc2JQ"),
            tokenId     : v0,
        };
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg2), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v3, 1500000000, arg2), @0x968fa1041658d0ab16a38bb00cf3a24284d94c679cd42c171ac4f6da1ac2a363);
        let v4 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v2,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v4);
        arg0.minted_supply = arg0.minted_supply + 1;
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.nfts, v0, 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::public_transfer<BugNFT>(v1, v2);
    }

    public fun name(arg0: &BugNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

