module 0x34df00098837a1fa168b414c8de40250369de8a40cb2c2f1b42e632f486b7156::autoclaim {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFTModified has copy, drop {
        nft_id: address,
        modifier: address,
        new_name: 0x1::string::String,
    }

    struct AUTOCLAIM has drop {
        dummy_field: bool,
    }

    public fun get_description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &MyNFT) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_image_url(arg0: &MyNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    fun init(arg0: AUTOCLAIM, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<AUTOCLAIM>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
        };
        0x2::transfer::transfer<MyNFT>(v0, arg3);
    }

    public entry fun modify(arg0: &mut MyNFT, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        arg0.name = 0x1::string::utf8(arg1);
        let v0 = NFTModified{
            nft_id   : 0x2::object::uid_to_address(&arg0.id),
            modifier : 0x2::tx_context::sender(arg2),
            new_name : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<NFTModified>(v0);
    }

    // decompiled from Move bytecode v6
}

