module 0x700945ac0913a6f8659d0e440857fb74fa0959d9c7003501d8b311f7536978a8::myfirstnft {
    struct HuTou has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MYFIRSTNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYFIRSTNFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"HuTou"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Under construction!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"HuTou's first nft!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Under construction!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"HuTou"));
        let v4 = 0x2::package::claim<MYFIRSTNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<HuTou>(&v4, v0, v2, arg1);
        0x2::display::update_version<HuTou>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HuTou>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = HuTou{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<HuTou>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun update_imageurl(arg0: &mut HuTou, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    // decompiled from Move bytecode v6
}

