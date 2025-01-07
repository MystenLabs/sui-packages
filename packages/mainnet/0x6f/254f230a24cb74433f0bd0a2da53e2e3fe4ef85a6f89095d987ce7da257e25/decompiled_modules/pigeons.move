module 0x6f254f230a24cb74433f0bd0a2da53e2e3fe4ef85a6f89095d987ce7da257e25::pigeons {
    struct PIGEONS has drop {
        dummy_field: bool,
    }

    struct Pigeons has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        number: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTKMinted has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun airdrop(arg0: &AdminCap, arg1: vector<address>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg2) && v0 == 0x1::vector::length<vector<u8>>(&arg3) && v0 == 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg4), 0);
        while (v1 < v0) {
            let v2 = Pigeons{
                id         : 0x2::object::new(arg5),
                name       : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg2)),
                number     : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg3)),
                attributes : 0x1::vector::pop_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg4),
            };
            let v3 = NFTKMinted{object_id: 0x2::object::id<Pigeons>(&v2)};
            0x2::event::emit<NFTKMinted>(v3);
            let (v4, v5) = 0x2::kiosk::new(arg5);
            let v6 = v5;
            let v7 = v4;
            0x2::kiosk::place<Pigeons>(&mut v7, &v6, v2);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, 0x1::vector::pop_back<address>(&mut arg1));
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
            v1 = v1 + 1;
        };
    }

    public fun airdropmulti(arg0: &AdminCap, arg1: address, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg2) && v0 == 0x1::vector::length<vector<u8>>(&arg3) && v0 == 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg4), 0);
        let (v2, v3) = 0x2::kiosk::new(arg5);
        let v4 = v3;
        let v5 = v2;
        while (v1 < v0) {
            let v6 = Pigeons{
                id         : 0x2::object::new(arg5),
                name       : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg2)),
                number     : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg3)),
                attributes : 0x1::vector::pop_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg4),
            };
            let v7 = NFTKMinted{object_id: 0x2::object::id<Pigeons>(&v6)};
            0x2::event::emit<NFTKMinted>(v7);
            0x2::kiosk::place<Pigeons>(&mut v5, &v4, v6);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
    }

    fun init(arg0: PIGEONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmbUWeu1ryJX5aKz8wF3bnoYyabw9A2abCfjDsJVDdJtio/{number}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"An Ancient Breed of Karrier Pigeons"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://karrier.one"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::package::claim<PIGEONS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Pigeons>(&v4, v0, v2, arg1);
        0x2::display::update_version<Pigeons>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Pigeons>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun setup_tp(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<PIGEONS>(arg0), 1);
        let (v0, v1) = 0x2::transfer_policy::new<Pigeons>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Pigeons>(&mut v3, &v2, 500, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Pigeons>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Pigeons>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

