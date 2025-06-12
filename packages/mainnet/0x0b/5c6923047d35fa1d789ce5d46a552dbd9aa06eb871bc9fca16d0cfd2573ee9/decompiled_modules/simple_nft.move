module 0xb5c6923047d35fa1d789ce5d46a552dbd9aa06eb871bc9fca16d0cfd2573ee9::simple_nft {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        minter: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun url(arg0: &SimpleNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun attributes(arg0: &SimpleNFT) : &0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        &arg0.attributes
    }

    public entry fun batch_mint(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: vector<vector<u8>>, arg3: vector<vector<0x1::ascii::String>>, arg4: vector<vector<0x1::ascii::String>>, arg5: &AdminCap, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            mint_nft(*0x1::vector::borrow<0x1::string::String>(&arg0, v0), *0x1::vector::borrow<0x1::string::String>(&arg1, v0), *0x1::vector::borrow<vector<u8>>(&arg2, v0), *0x1::vector::borrow<vector<0x1::ascii::String>>(&arg3, v0), *0x1::vector::borrow<vector<0x1::ascii::String>>(&arg4, v0), arg5, *0x1::vector::borrow<address>(&arg6, v0), arg7);
            v0 = v0 + 1;
        };
    }

    public entry fun burn(arg0: SimpleNFT, arg1: &AdminCap) {
        let SimpleNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SimpleNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SIMPLE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<SimpleNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<SimpleNFT>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SimpleNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &AdminCap, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg3)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0, *0x1::vector::borrow<0x1::ascii::String>(&arg3, v1), *0x1::vector::borrow<0x1::ascii::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        let v2 = SimpleNFT{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : v0,
        };
        let v3 = NFTMinted{
            id     : 0x2::object::uid_to_inner(&v2.id),
            name   : v2.name,
            minter : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<SimpleNFT>(v2, arg6);
    }

    public fun name(arg0: &SimpleNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut SimpleNFT, arg1: 0x1::string::String, arg2: &AdminCap) {
        arg0.description = arg1;
    }

    // decompiled from Move bytecode v6
}

