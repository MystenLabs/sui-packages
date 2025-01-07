module 0x89ca96affb8a4d1db84fc6682d4256be409d511b1de8547a05b26ecba266b1f3::liquid {
    struct Suisses has store, key {
        id: 0x2::object::UID,
        creator: 0x1::string::String,
        reward: 0x1::string::String,
    }

    struct LIQUID has drop {
        dummy_field: bool,
    }

    public entry fun airdrop(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = Suisses{
                id      : 0x2::object::new(arg1),
                creator : 0x1::string::utf8(b"Suisses"),
                reward  : 0x1::string::utf8(b"1"),
            };
            0x2::transfer::public_transfer<Suisses>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn(arg0: Suisses) {
        let Suisses {
            id      : v0,
            creator : _,
            reward  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: LIQUID, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUISSES"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"http://suisses.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.ibb.co/djH5K7P/nft-2.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suisses - Early adopter"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"http://suisses.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suisses"));
        let v4 = 0x2::package::claim<LIQUID>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Suisses>(&v4, v0, v2, arg1);
        0x2::display::update_version<Suisses>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Suisses>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Suisses{
            id      : 0x2::object::new(arg2),
            creator : arg0,
            reward  : arg1,
        };
        0x2::transfer::public_transfer<Suisses>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Suisses{
            id      : 0x2::object::new(arg1),
            creator : 0x1::string::utf8(b"Suisses"),
            reward  : 0x1::string::utf8(b"1"),
        };
        0x2::transfer::public_transfer<Suisses>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

