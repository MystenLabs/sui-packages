module 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::ContractNft {
    struct DecotNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct DECOT_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: DecotNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<DecotNft>(arg0, arg1);
    }

    public fun url(arg0: &DecotNft) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: DecotNft, arg1: &mut 0x2::tx_context::TxContext) {
        let DecotNft {
            id   : v0,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun initializer(arg0: DECOT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-ui.decot.io/ipfs/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Decot"));
        let v4 = 0x2::package::claim<DECOT_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DecotNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<DecotNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DecotNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : DecotNft {
        let v0 = DecotNft{
            id   : 0x2::object::new(arg2),
            name : 0x1::string::utf8(arg0),
            url  : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<DecotNft>(&v0),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v0.name,
            url       : v0.url,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<DecotNft>(mint(arg0, arg1, arg2), v0);
    }

    public fun name(arg0: &DecotNft) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

