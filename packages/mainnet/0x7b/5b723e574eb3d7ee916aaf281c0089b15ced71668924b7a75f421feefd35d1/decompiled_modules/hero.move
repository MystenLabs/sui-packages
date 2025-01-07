module 0x7b5b723e574eb3d7ee916aaf281c0089b15ced71668924b7a75f421feefd35d1::hero {
    struct Hero has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        media_url: 0x1::string::String,
        media_type: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct HERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"media_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"media_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"E4C Chip Collector"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.ambrus.studio/NFTs/Diamond_Chip.mp4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.ambrus.studio/NFTs/Diamond_Chip-ezgif.com-video-to-gif-converter.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"video/mp4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"417765736f6d65206e6577732120596f7527766520736e616767656420796f757220766572792066697273742045344320517565737420436869702120486f6c64206f6e207469676874e28094746865736520636869707320617265206d6f7265207468616e206a75737420636f6f6c20636f6c6c65637469626c65732e204b656570207468656d20636c6f73652c20616e6420736f6f6e20796f75276c6c20756e6c6f636b206578636974696e6720726577617264732077697468202445344320746f6b656e7321"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.ambrus.studio/#/"));
        let v4 = 0x2::package::claim<HERO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x7b5b723e574eb3d7ee916aaf281c0089b15ced71668924b7a75f421feefd35d1::verification::Verifier, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x1::string::utf8(b"hero");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = 0x1::string::utf8(b"mint");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg2)));
        0x7b5b723e574eb3d7ee916aaf281c0089b15ced71668924b7a75f421feefd35d1::verification::verify_signature(arg0, 0x2::tx_context::sender(arg2), arg1, &mut v0);
        let v3 = Hero{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"E4C Chip Collector"),
            image_url   : 0x1::string::utf8(b"https://cdn.ambrus.studio/NFTs/Diamond_Chip-ezgif.com-video-to-gif-converter.gif"),
            media_url   : 0x1::string::utf8(b"https://cdn.ambrus.studio/NFTs/Diamond_Chip.mp4"),
            media_type  : 0x1::string::utf8(b"video/mp4"),
            description : 0x1::string::utf8(x"417765736f6d65206e6577732120596f7527766520736e616767656420796f757220766572792066697273742045344320517565737420436869702120486f6c64206f6e207469676874e28094746865736520636869707320617265206d6f7265207468616e206a75737420636f6f6c20636f6c6c65637469626c65732e204b656570207468656d20636c6f73652c20616e6420736f6f6e20796f75276c6c20756e6c6f636b206578636974696e6720726577617264732077697468202445344320746f6b656e7321"),
        };
        0x2::transfer::transfer<Hero>(v3, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

