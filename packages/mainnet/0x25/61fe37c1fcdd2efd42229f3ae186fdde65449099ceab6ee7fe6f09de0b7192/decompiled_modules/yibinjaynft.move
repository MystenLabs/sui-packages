module 0x2561fe37c1fcdd2efd42229f3ae186fdde65449099ceab6ee7fe6f09de0b7192::yibinjaynft {
    struct YIBINJAYNFT has drop {
        dummy_field: bool,
    }

    struct YIBINJAY has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: YIBINJAYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YIBINJAY"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"the first NFT for YibinJay"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/167294502"));
        let v4 = 0x2::package::claim<YIBINJAYNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<YIBINJAY>(&v4, v0, v2, arg1);
        0x2::display::update_version<YIBINJAY>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<YIBINJAY>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = YIBINJAY{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<YIBINJAY>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

