module 0x7ddede74f71facd1c5aedd3d14783cc0bc8a31faa6caa586a282a39c193ebdb4::mynft {
    struct MYNFT has drop {
        dummy_field: bool,
    }

    struct Zeroc has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: MYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"zeroc"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A sample NFT for zeroc"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/100562605"));
        let v4 = 0x2::package::claim<MYNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Zeroc>(&v4, v0, v2, arg1);
        0x2::display::update_version<Zeroc>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<Zeroc>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Zeroc{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<Zeroc>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

