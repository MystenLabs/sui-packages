module 0x63ab168083d9178b0ee1cf878392fd26c4f191899e8bebc2405dd7b6f447c3a2::saber_slayer_og_badge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Supply has store, key {
        id: 0x2::object::UID,
        count: u64,
        max: u64,
        closed: bool,
    }

    struct SaberSlayerOGBadge has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct SABER_SLAYER_OG_BADGE has drop {
        dummy_field: bool,
    }

    public fun close_mint(arg0: &AdminCap, arg1: &mut Supply) {
        arg1.closed = true;
    }

    public fun destroy_admincap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SABER_SLAYER_OG_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Supply{
            id     : 0x2::object::new(arg1),
            count  : 0,
            max    : 20,
            closed : false,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<Supply>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::package::claim<SABER_SLAYER_OG_BADGE>(arg0, arg1);
        let v3 = 0x2::display::new<SaberSlayerOGBadge>(&v2, arg1);
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"SaberSlayer OG Badge"));
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"SaberSama - OG Slayers"));
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"SaberSama - OG Slayers"));
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"project"), 0x1::string::utf8(b"SaberSama - OG Slayers"));
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"label"), 0x1::string::utf8(b"SaberSama - OG Slayers"));
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SaberSlayerOGBadge>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<SaberSlayerOGBadge>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<SaberSlayerOGBadge>>(v3, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v2);
    }

    public fun max_supply(arg0: &Supply) : u64 {
        arg0.max
    }

    public fun mint(arg0: &AdminCap, arg1: &mut Supply, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.closed, 2);
        assert!(arg1.count < arg1.max, 0);
        arg1.count = arg1.count + 1;
        0x2::transfer::public_transfer<SaberSlayerOGBadge>(mint_internal(arg3), arg2);
    }

    public fun mint_batch(arg0: &AdminCap, arg1: &mut Supply, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(!arg1.closed, 2);
        assert!(arg1.count + (v0 as u64) <= arg1.max, 1);
        let v1 = 0;
        while (v1 < v0) {
            arg1.count = arg1.count + 1;
            0x2::transfer::public_transfer<SaberSlayerOGBadge>(mint_internal(arg3), *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    fun mint_internal(arg0: &mut 0x2::tx_context::TxContext) : SaberSlayerOGBadge {
        SaberSlayerOGBadge{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"SaberSlayer OG Badge"),
            description : 0x1::string::utf8(x"546865205361626572536c61796572204f472042616467652069736e277420776f726e2c20697427732073747261707065642074696768742e0a4974207468726f627320616761696e737420796f75722063686573742e0a0a4974206973207573656420746f20726563656976652061697264726f70732e0a49742773207573656420746f20736c697020696e746f206576657279206368616d62657220746865205361626572206f70656e732e0a0a4c6f73652069742e2e2e20616e6420796f752077696c6c206e657665722062652063726f776e656420616761696e2e"),
            image_url   : 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeib4sk7273ov3o4ph7ikcptroqgia7eetz522cd2bh3xzw5zaftjiq"),
        }
    }

    public fun minted(arg0: &Supply) : u64 {
        arg0.count
    }

    public fun remaining(arg0: &Supply) : u64 {
        arg0.max - arg0.count
    }

    // decompiled from Move bytecode v6
}

