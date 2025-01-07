module 0x251b1398f836526d7021571dc240bfa505538cad9124705ee919d088b3fc754e::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFTModified has copy, drop {
        nft_id: 0x2::object::ID,
        modifier: address,
    }

    struct MY_NFT has drop {
        dummy_field: bool,
    }

    public fun get_description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &MyNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_image_url(arg0: &MyNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
        };
        0x2::transfer::public_share_object<MyNFT>(v0);
    }

    public entry fun modify(arg0: &MyNFT, arg1: &0x2::tx_context::TxContext) {
        let v0 = NFTModified{
            nft_id   : 0x2::object::id<MyNFT>(arg0),
            modifier : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTModified>(v0);
    }

    // decompiled from Move bytecode v6
}

