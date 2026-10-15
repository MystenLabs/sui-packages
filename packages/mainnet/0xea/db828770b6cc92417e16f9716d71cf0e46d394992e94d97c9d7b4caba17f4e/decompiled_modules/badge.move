module 0xeadb828770b6cc92417e16f9716d71cf0e46d394992e94d97c9d7b4caba17f4e::badge {
    struct BADGE has drop {
        dummy_field: bool,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: u8,
        season: 0x1::string::String,
        link: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    struct Claim has drop, store {
        recipient: address,
        rarity: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        season: 0x1::string::String,
        link: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    struct Ledger has key {
        id: 0x2::object::UID,
        claims: 0x2::vec_map::VecMap<vector<u8>, Claim>,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct BadgeClaimed has copy, drop {
        recipient: address,
        rarity: u8,
        season: 0x1::string::String,
    }

    public fun claim(arg0: &mut Ledger, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<vector<u8>, Claim>(&arg0.claims, &arg1), 0);
        let (_, v1) = 0x2::vec_map::remove<vector<u8>, Claim>(&mut arg0.claims, &arg1);
        let Claim {
            recipient   : v2,
            rarity      : v3,
            name        : v4,
            description : v5,
            image_url   : v6,
            season      : v7,
            link        : v8,
            project_url : v9,
        } = v1;
        assert!(v2 == 0x2::tx_context::sender(arg2), 1);
        let v10 = BadgeClaimed{
            recipient : v2,
            rarity    : v3,
            season    : v7,
        };
        0x2::event::emit<BadgeClaimed>(v10);
        let v11 = Badge{
            id          : 0x2::object::new(arg2),
            name        : v4,
            description : v5,
            image_url   : v6,
            rarity      : v3,
            season      : v7,
            link        : v8,
            project_url : v9,
        };
        0x2::transfer::public_transfer<Badge>(v11, v2);
    }

    fun init(arg0: BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BADGE>(arg0, arg1);
        let v1 = 0x2::display::new<Badge>(&v0, arg1);
        0x2::display::add<Badge>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Badge>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Badge>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Badge>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{link}"));
        0x2::display::add<Badge>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::update_version<Badge>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Badge>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Ledger{
            id     : 0x2::object::new(arg1),
            claims : 0x2::vec_map::empty<vector<u8>, Claim>(),
        };
        0x2::transfer::share_object<Ledger>(v2);
        let v3 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MinterCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &MinterCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 1 && arg4 <= 3, 3);
        let v0 = Badge{
            id          : 0x2::object::new(arg9),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            rarity      : arg4,
            season      : arg5,
            link        : arg6,
            project_url : arg7,
        };
        0x2::transfer::public_transfer<Badge>(v0, arg8);
    }

    public fun post(arg0: &MinterCap, arg1: &mut Ledger, arg2: vector<u8>, arg3: address, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String) {
        assert!(arg4 >= 1 && arg4 <= 3, 3);
        assert!(!0x2::vec_map::contains<vector<u8>, Claim>(&arg1.claims, &arg2), 2);
        let v0 = Claim{
            recipient   : arg3,
            rarity      : arg4,
            name        : arg5,
            description : arg6,
            image_url   : arg7,
            season      : arg8,
            link        : arg9,
            project_url : arg10,
        };
        0x2::vec_map::insert<vector<u8>, Claim>(&mut arg1.claims, arg2, v0);
    }

    // decompiled from Move bytecode v7
}

