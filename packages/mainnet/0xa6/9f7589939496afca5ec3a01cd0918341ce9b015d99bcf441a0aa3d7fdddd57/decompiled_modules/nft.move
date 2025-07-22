module 0xa69f7589939496afca5ec3a01cd0918341ce9b015d99bcf441a0aa3d7fdddd57::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn_nft(arg0: SimpleNFT) {
        let SimpleNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_nft_info(arg0: &SimpleNFT) : (0x1::string::String, 0x1::string::String, 0x2::url::Url, address) {
        (arg0.name, arg0.description, arg0.url, arg0.creator)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SimpleNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SimpleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SimpleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = SimpleNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id_address<SimpleNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SimpleNFT>(v1, v0);
    }

    public entry fun transfer_nft(arg0: SimpleNFT, arg1: address) {
        0x2::transfer::public_transfer<SimpleNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

