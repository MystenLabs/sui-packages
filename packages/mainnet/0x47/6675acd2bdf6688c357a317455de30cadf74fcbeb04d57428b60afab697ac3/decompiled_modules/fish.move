module 0x476675acd2bdf6688c357a317455de30cadf74fcbeb04d57428b60afab697ac3::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    struct FISHNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"fish-yan"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT for fish-yan"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/15316488?v=4"));
        let v4 = 0x2::package::claim<FISH>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<FISHNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<FISHNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<FISHNFT>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FISHNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<FISHNFT>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

