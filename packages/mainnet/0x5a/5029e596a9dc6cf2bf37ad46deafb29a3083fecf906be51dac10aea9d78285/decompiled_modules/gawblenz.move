module 0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::gawblenz {
    struct GAWBLENZ has drop {
        dummy_field: bool,
    }

    struct Gawblen has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: u16,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        max_id: u16,
        current: u16,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        creator: address,
    }

    public fun attributes(arg0: &Gawblen) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun burn_cap(arg0: AdminCap) {
        assert!(arg0.current > arg0.max_id, 1);
        let AdminCap {
            id      : v0,
            max_id  : _,
            current : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create(arg0: &mut AdminCap, arg1: &mut 0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::distribution::Distribution<Gawblen>, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current <= arg0.max_id, 2);
        let v0 = 0x1::string::utf8(b"Gawblen #");
        0x1::string::append(&mut v0, 0x1::u16::to_string(arg0.current));
        let v1 = Gawblen{
            id          : 0x2::object::new(arg4),
            name        : v0,
            description : 0x1::string::utf8(b"No think. Just Gawblen"),
            image_url   : arg2,
            token_id    : arg0.current,
            attributes  : arg3,
        };
        0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::distribution::add_nft<Gawblen>(arg1, v1);
        arg0.current = arg0.current + 1;
    }

    public fun create_and_keep(arg0: &mut AdminCap, arg1: 0x1::string::String, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg3: &0x2::transfer_policy::TransferPolicy<Gawblen>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current <= arg0.max_id, 2);
        assert!(arg0.current <= arg0.max_id, 2);
        let v0 = 0x1::string::utf8(b"Gawblen #");
        0x1::string::append(&mut v0, 0x1::u16::to_string(arg0.current));
        let v1 = Gawblen{
            id          : 0x2::object::new(arg4),
            name        : v0,
            description : 0x1::string::utf8(b"No think. Just Gawblen"),
            image_url   : arg1,
            token_id    : arg0.current,
            attributes  : arg2,
        };
        let v2 = NFTMinted{
            id      : 0x2::object::id<Gawblen>(&v1),
            creator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTMinted>(v2);
        let (v3, v4) = 0x2::kiosk::new(arg4);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::lock<Gawblen>(&mut v6, &v5, arg3, v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        arg0.current = arg0.current + 1;
    }

    public fun image_url(arg0: &Gawblen) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: GAWBLENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAWBLENZ>(arg0, arg1);
        let v1 = 0x2::display::new<Gawblen>(&v0, arg1);
        0x2::display::add<Gawblen>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Gawblen>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Gawblen>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Gawblen>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Gawblen>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Gawblen>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{
            id      : 0x2::object::new(arg1),
            max_id  : 3333,
            current : 1,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun token_id(arg0: &Gawblen) : &u16 {
        &arg0.token_id
    }

    public fun update_nft_in_distribution(arg0: &mut 0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::distribution::Distribution<Gawblen>, arg1: 0x1::string::String, arg2: u16) {
    }

    public fun update_nft_in_distribution_v2(arg0: &mut 0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::distribution::Distribution<Gawblen>, arg1: &AdminCap, arg2: 0x1::string::String, arg3: u16) {
        let v0 = 0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::distribution::items<Gawblen>(arg0);
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<Gawblen>(0x70361cdc41d44c2e1f9c30c81837f7cf08c9bf0eaf30d178000070fda9c58b83::distribution::items<Gawblen>(arg0))) {
            let v2 = 0x2::table_vec::borrow_mut<Gawblen>(v0, v1);
            if (v2.token_id == arg3) {
                v2.image_url = arg2;
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

