module 0x25e967221f497c708e5d4c40240bec0fcf0035367a86b30601b5a9ba049b2ea8::snailmail {
    struct SnailMailNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct SNAILMAIL has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun transfer(arg0: SnailMailNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SnailMailNFT>(arg0, arg1);
    }

    public entry fun burn(arg0: SnailMailNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SnailMailNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SnailMailNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SnailMailNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SNAILMAIL, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<SNAILMAIL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SnailMailNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SnailMailNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SnailMailNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_recipient(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SnailMailNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id   : 0x2::object::id<SnailMailNFT>(&v0),
            creator     : 0x2::tx_context::sender(arg4),
            name        : v0.name,
            description : v0.description,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<SnailMailNFT>(v0, arg3);
    }

    public fun name(arg0: &SnailMailNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

