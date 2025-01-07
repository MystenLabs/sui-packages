module 0x5b501f4d59e65326a294ba0aea52b21227b0c0e69030b402fea10804682e01b4::fast_nft {
    struct FASTNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct FASTNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct FAST_NFT has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: FASTNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let FASTNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_fast_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : FASTNFT {
        FASTNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        }
    }

    public fun description(arg0: &FASTNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &FASTNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: FAST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CreatorsDAO"));
        let v4 = 0x2::package::claim<FAST_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<FASTNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<FASTNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::display::Display<FASTNFT>>(v5);
    }

    entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = create_fast_nft(arg0, arg1, arg2, arg3);
        let v2 = FASTNFTMinted{
            object_id : 0x2::object::id<FASTNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<FASTNFTMinted>(v2);
        0x2::transfer::public_transfer<FASTNFT>(v1, v0);
    }

    public fun name(arg0: &FASTNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

