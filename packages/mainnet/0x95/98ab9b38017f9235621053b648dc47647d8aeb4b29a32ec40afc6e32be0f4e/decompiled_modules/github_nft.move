module 0x9598ab9b38017f9235621053b648dc47647d8aeb4b29a32ec40afc6e32be0f4e::github_nft {
    struct GithubNFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct GITHUB_NFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut MintRecord, arg1: GithubNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.recipient;
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(&v0 == &v1, 0);
        0x2::table::remove<address, u64>(&mut arg0.record, arg1.recipient);
        let GithubNFT {
            id        : v2,
            nft_id    : _,
            name      : _,
            image_url : _,
            creator   : _,
            recipient : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    fun init(arg0: GITHUB_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A NFT for Nauxscript Github avatar"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, u64>(arg1),
        };
        let v5 = 0x2::package::claim<GITHUB_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<GithubNFT>(&v5, v0, v2, arg1);
        0x2::display::update_version<GithubNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GithubNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRecord>(v4);
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, u64>(&arg0.record, arg3), 1);
        let v0 = 0x2::table::length<address, u64>(&arg0.record) + 1;
        assert!(v0 <= 10, 0);
        0x2::table::add<address, u64>(&mut arg0.record, arg3, v0);
        let v1 = GithubNFT{
            id        : 0x2::object::new(arg4),
            nft_id    : v0,
            name      : arg1,
            image_url : arg2,
            creator   : 0x2::tx_context::sender(arg4),
            recipient : arg3,
        };
        0x2::transfer::public_transfer<GithubNFT>(v1, arg3);
        let v2 = NFTMinted{
            object_id : 0x2::object::id<GithubNFT>(&v1),
            creator   : 0x2::tx_context::sender(arg4),
            name      : arg1,
        };
        0x2::event::emit<NFTMinted>(v2);
    }

    // decompiled from Move bytecode v6
}

