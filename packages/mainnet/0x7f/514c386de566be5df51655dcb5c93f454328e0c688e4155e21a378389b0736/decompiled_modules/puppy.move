module 0x7f514c386de566be5df51655dcb5c93f454328e0c688e4155e21a378389b0736::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    struct OwnPuppy has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun editDesc(arg0: &mut OwnPuppy, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public entry fun editName(arg0: &mut OwnPuppy, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public entry fun editUrl(arg0: &mut OwnPuppy, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<PUPPY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<OwnPuppy>(&v4, v0, v2, arg1);
        0x2::display::update_version<OwnPuppy>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OwnPuppy>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnPuppy{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            image_url   : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
        };
        0x2::transfer::transfer<OwnPuppy>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

