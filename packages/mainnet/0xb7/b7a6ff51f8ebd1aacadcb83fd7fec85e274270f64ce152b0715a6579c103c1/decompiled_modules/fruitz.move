module 0xb7b7a6ff51f8ebd1aacadcb83fd7fec85e274270f64ce152b0715a6579c103c1::fruitz {
    struct FRUITZ has drop {
        dummy_field: bool,
    }

    struct Fruitz has store, key {
        id: 0x2::object::UID,
        serial: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        minted: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun airdrop(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg2 <= 18888, 0);
        assert!(arg1.minted <= 18888 - arg2, 0);
        let v0 = 0;
        while (v0 < arg2) {
            0x2::transfer::public_transfer<Fruitz>(mint_admin(arg0, arg1, arg4), arg3);
            v0 = v0 + 1;
        };
    }

    entry fun airdrop_multi(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 1);
        assert!(arg2 > 0, 1);
        let v1 = 18888 - arg1.minted;
        assert!(arg2 <= v1, 0);
        assert!(v0 <= v1 / arg2, 0);
        let v2 = 0;
        while (v2 < v0) {
            airdrop(arg0, arg1, arg2, *0x1::vector::borrow<address>(&arg3, v2), arg4);
            v2 = v2 + 1;
        };
    }

    public fun description(arg0: &Fruitz) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &Fruitz) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: FRUITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FRUITZ>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Fruitz>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0xb7b7a6ff51f8ebd1aacadcb83fd7fec85e274270f64ce152b0715a6579c103c1::kiosk_lock_rule::add<Fruitz>(&mut v4, &v3);
        0xb7b7a6ff51f8ebd1aacadcb83fd7fec85e274270f64ce152b0715a6579c103c1::royalty_rule::add<Fruitz>(&mut v4, &v3, 1200, 0);
        let v5 = Registry{
            id     : 0x2::object::new(arg1),
            minted : 0,
        };
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        setup_display_v1(&v0, arg1);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Fruitz>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Registry>(v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Fruitz>>(v4);
    }

    public fun max_supply() : u64 {
        18888
    }

    fun mint_admin(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) : Fruitz {
        new_nft(arg1, arg2)
    }

    public fun minted(arg0: &Registry) : u64 {
        arg0.minted
    }

    public fun name(arg0: &Fruitz) : &0x1::string::String {
        &arg0.name
    }

    fun new_nft(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : Fruitz {
        assert!(arg0.minted < 18888, 0);
        let v0 = arg0.minted + 1;
        arg0.minted = v0;
        let v1 = 0x1::string::utf8(b"Fruitz #");
        0x1::string::append(&mut v1, 0x1::u64::to_string(v0));
        let v2 = 0x1::string::utf8(b"https://r2.bityou.app/bityou-assets/fruitz/");
        0x1::string::append(&mut v2, 0x1::u64::to_string(v0));
        0x1::string::append(&mut v2, 0x1::string::utf8(b".png"));
        Fruitz{
            id          : 0x2::object::new(arg1),
            serial      : v0,
            name        : v1,
            image_url   : v2,
            description : 0x1::string::utf8(x"46727569747a20e280942074686520626974796f752e61707020636f6c6c65637469626c6520736572696573206f6e205375692e"),
        }
    }

    public fun royalty_bps() : u16 {
        1200
    }

    public fun serial(arg0: &Fruitz) : u64 {
        arg0.serial
    }

    entry fun setup_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<Fruitz> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<Fruitz>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"46727569747a20e280942074686520626974796f752e61707020636f6c6c65637469626c6520736572696573206f6e205375692e"));
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"https://r2.bityou.app/bityou-assets/fruitz/thumbnail.png"));
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bityou.app/"));
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://bityou.app/"));
        0x2::display_registry::set<Fruitz>(&mut v3, &v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"bityou.app"));
        0x2::display_registry::share<Fruitz>(v3);
        v2
    }

    fun setup_display_v1(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"46727569747a20e280942074686520626974796f752e61707020636f6c6c65637469626c6520736572696573206f6e205375692e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bityou.app/"));
        0x2::transfer::public_transfer<0x2::display::Display<Fruitz>>(0x2::display::new_with_fields<Fruitz>(arg0, v0, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

