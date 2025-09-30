module 0x211638cbf3d1595bcd14f2aa9f9faa77dd87ddbfe8edfa8628afeb76e86ee8b::nft {
    struct Badge has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        runner_number: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun claim(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::table::Table<u64, bool>, arg4: &mut 0x2::table::Table<address, bool>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, bool>(arg3, arg5), 1);
        assert!(!0x2::table::contains<address, bool>(arg4, arg6), 2);
        assert!(arg5 > 0 && arg5 <= 120, 3);
        0x2::table::add<u64, bool>(arg3, arg5, true);
        0x2::table::add<address, bool>(arg4, arg6, true);
        let v0 = Badge{
            id            : 0x2::object::new(arg7),
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
            runner_number : arg5,
        };
        0x2::transfer::transfer<Badge>(v0, arg6);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Badge>(&v4, v0, v2, arg1);
        0x2::display::update_version<Badge>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Badge>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::table::Table<u64, bool>>(0x2::table::new<u64, bool>(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::table::Table<address, bool>>(0x2::table::new<address, bool>(arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

