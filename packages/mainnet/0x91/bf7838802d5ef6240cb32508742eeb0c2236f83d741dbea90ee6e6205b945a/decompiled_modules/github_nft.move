module 0x91bf7838802d5ef6240cb32508742eeb0c2236f83d741dbea90ee6e6205b945a::github_nft {
    struct GITHUB_NFT has drop {
        dummy_field: bool,
    }

    struct GithubNFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    public entry fun burn(arg0: &mut MintRecord, arg1: GithubNFT) {
        0x2::table::remove<address, u64>(&mut arg0.record, arg1.recipient);
        let GithubNFT {
            id        : v0,
            nft_id    : _,
            name      : _,
            image_url : _,
            creator   : _,
            recipient : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: GITHUB_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_base_uri"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"price"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{Seal Early Contributor} #{ID}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This exclusive Seal Early Contributor badge is part of a limited collection..."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmVArFyFRV4Cqa4xGwwHaC6EGUF7q46fRG4FN7P6o4VdwU"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0x29ae162b4245983529221213663f6157c2fce260333c5312c6d95828ad352499"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0.1"));
        let v4 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, u64>(arg1),
        };
        let v5 = 0x2::package::claim<GITHUB_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<GithubNFT>(&v5, v0, v2, arg1);
        0x2::transfer::share_object<MintRecord>(v4);
        0x2::display::update_version<GithubNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GithubNFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 10000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x29ae162b4245983529221213663f6157c2fce260333c5312c6d95828ad352499);
        assert!(!0x2::table::contains<address, u64>(&arg0.record, arg4), 1);
        let v0 = 0x2::table::length<address, u64>(&arg0.record) + 1;
        assert!(v0 <= 5000, 0);
        0x2::table::add<address, u64>(&mut arg0.record, arg4, v0);
        let v1 = GithubNFT{
            id        : 0x2::object::new(arg5),
            nft_id    : v0,
            name      : arg1,
            image_url : arg2,
            creator   : 0x2::tx_context::sender(arg5),
            recipient : arg4,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<GithubNFT>(&v1),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<GithubNFT>(v1, arg4);
    }

    // decompiled from Move bytecode v6
}

