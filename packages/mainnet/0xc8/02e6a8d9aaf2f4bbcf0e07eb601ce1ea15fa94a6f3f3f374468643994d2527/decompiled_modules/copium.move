module 0xc802e6a8d9aaf2f4bbcf0e07eb601ce1ea15fa94a6f3f3f374468643994d2527::copium {
    struct COPIUM has drop {
        dummy_field: bool,
    }

    struct Copium has store, key {
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

    public fun attributes(arg0: &Copium) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
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

    public fun create(arg0: &mut AdminCap, arg1: &mut 0xc802e6a8d9aaf2f4bbcf0e07eb601ce1ea15fa94a6f3f3f374468643994d2527::distribution::Distribution<Copium>, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current <= arg0.max_id, 2);
        let v0 = 0x1::string::utf8(b"Gawblen #");
        0x1::string::append(&mut v0, 0x1::u16::to_string(arg0.current));
        let v1 = Copium{
            id          : 0x2::object::new(arg4),
            name        : v0,
            description : 0x1::string::utf8(b"No think. Just Gawblen"),
            image_url   : arg2,
            token_id    : arg0.current,
            attributes  : arg3,
        };
        0xc802e6a8d9aaf2f4bbcf0e07eb601ce1ea15fa94a6f3f3f374468643994d2527::distribution::add_nft<Copium>(arg1, v1);
        arg0.current = arg0.current + 1;
    }

    public fun create_and_keep(arg0: &mut AdminCap, arg1: 0x1::string::String, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg3: &0x2::transfer_policy::TransferPolicy<Copium>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current <= arg0.max_id, 2);
        assert!(arg0.current <= arg0.max_id, 2);
        let v0 = 0x1::string::utf8(b"Copium #");
        0x1::string::append(&mut v0, 0x1::u16::to_string(arg0.current));
        let v1 = Copium{
            id          : 0x2::object::new(arg4),
            name        : v0,
            description : 0x1::string::utf8(b"REFRESHING COPIUM"),
            image_url   : arg1,
            token_id    : arg0.current,
            attributes  : arg2,
        };
        let (v2, v3) = 0x2::kiosk::new(arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::lock<Copium>(&mut v5, &v4, arg3, v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        arg0.current = arg0.current + 1;
    }

    public fun image_url(arg0: &Copium) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: COPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COPIUM>(arg0, arg1);
        let v1 = 0x2::display::new<Copium>(&v0, arg1);
        0x2::display::add<Copium>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Copium>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Copium>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Copium>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Copium>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Copium>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{
            id      : 0x2::object::new(arg1),
            max_id  : 3333,
            current : 1,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun token_id(arg0: &Copium) : &u16 {
        &arg0.token_id
    }

    // decompiled from Move bytecode v6
}

