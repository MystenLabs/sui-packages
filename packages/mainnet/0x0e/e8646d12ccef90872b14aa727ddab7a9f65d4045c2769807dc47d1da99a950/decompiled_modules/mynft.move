module 0xee8646d12ccef90872b14aa727ddab7a9f65d4045c2769807dc47d1da99a950::mynft {
    struct MYNFT has drop {
        dummy_field: bool,
    }

    struct LingLingcc has store, key {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"LingLingcc"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sample NFT for LingLingcc"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/167002362?s=400&u=d58cd662ae807d2e23b42f060ed48d6ed316b3ea&v=4"));
        let v4 = 0x2::package::claim<MYNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<LingLingcc>(&v4, v0, v2, arg1);
        0x2::display::update_version<LingLingcc>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<LingLingcc>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LingLingcc{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<LingLingcc>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

