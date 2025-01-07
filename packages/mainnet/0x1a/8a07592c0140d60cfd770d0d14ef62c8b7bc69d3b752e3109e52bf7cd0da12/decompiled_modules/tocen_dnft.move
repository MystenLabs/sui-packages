module 0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::tocen_dnft {
    struct DynamicNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct InfoCollection has store, key {
        id: 0x2::object::UID,
        name_nft: 0x1::string::String,
        description_nft: 0x1::string::String,
        ourl: 0x1::string::String,
        sum_nft: u64,
        timestamp_mint: u64,
    }

    struct TOCEN_DNFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: DynamicNFT, arg1: address) {
        0x2::transfer::public_transfer<DynamicNFT>(arg0, arg1);
    }

    public entry fun burn_NFT(arg0: DynamicNFT) {
        let DynamicNFT {
            id      : v0,
            name    : _,
            img_url : _,
            creator : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun checkOwnerSign(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::sub_string(&v1, 0, 66) == v0 && 0x1::string::sub_string(&v1, 67, 0x1::string::length(&v1)) == 0x1::string::utf8(0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::config::get_project())
    }

    fun img_url(arg0: vector<u8>, arg1: address) : 0x2::url::Url {
        0x1::vector::append<u8>(&mut arg0, b"0x");
        0x1::vector::append<u8>(&mut arg0, 0x1::ascii::into_bytes(0x2::address::to_ascii_string(arg1)));
        0x1::vector::append<u8>(&mut arg0, b".png");
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    fun init(arg0: TOCEN_DNFT, arg1: &mut 0x2::tx_context::TxContext) {
        init_infocollection(arg1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::config::get_link_project()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true {name} of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://tocen.co"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<TOCEN_DNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DynamicNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DynamicNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DynamicNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun init_infocollection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InfoCollection{
            id              : 0x2::object::new(arg0),
            name_nft        : 0x1::string::utf8(0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::config::get_name_dnft()),
            description_nft : 0x1::string::utf8(0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::config::get_description_dnft()),
            ourl            : 0x1::string::utf8(0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::config::get_url()),
            sum_nft         : 0,
            timestamp_mint  : 0,
        };
        0x2::transfer::share_object<InfoCollection>(v0);
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x2::url::Url, arg2: &mut 0x2::tx_context::TxContext) : DynamicNFT {
        DynamicNFT{
            id      : 0x2::object::new(arg2),
            name    : arg0,
            img_url : arg1,
            creator : 0x2::tx_context::sender(arg2),
        }
    }

    public entry fun mintNFT(arg0: &mut InfoCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::config::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg2), 4);
        assert!(checkOwnerSign(arg2, arg3), 5);
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg3)), 6);
        let v1 = arg0.name_nft;
        arg0.sum_nft = arg0.sum_nft + 1;
        0x1::string::append_utf8(&mut v1, numberToStr(arg0.sum_nft));
        let v2 = img_url(*0x1::string::bytes(&arg0.ourl), 0x2::tx_context::sender(arg3));
        let v3 = mint(v1, v2, arg3);
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, 0x2::tx_context::sender(arg3), true);
        let v4 = NFTMinted{
            object_id : 0x2::object::id<DynamicNFT>(&v3),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v3.name,
            image_url : v3.img_url,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<DynamicNFT>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun numberToStr(arg0: u64) : vector<u8> {
        let v0 = b"";
        while (arg0 % 10 >= 0 && arg0 > 0) {
            let v1 = b"0123456789";
            0x1::vector::insert<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, arg0 % 10), 0);
            arg0 = arg0 / 10;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

