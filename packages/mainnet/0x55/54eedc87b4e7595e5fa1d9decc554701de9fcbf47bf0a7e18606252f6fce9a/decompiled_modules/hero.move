module 0x5554eedc87b4e7595e5fa1d9decc554701de9fcbf47bf0a7e18606252f6fce9a::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Hero {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"strength"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"agility"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intelligence"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10"));
        Hero{
            id          : 0x2::object::new(arg1),
            name        : arg0,
            image_url   : 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDI0IiBoZWlnaHQ9IjEwMjQiIHZpZXdCb3g9IjAgMCAxMDI0IDEwMjQiPgogIDxyZWN0IHdpZHRoPSIxMDI0IiBoZWlnaHQ9IjEwMjQiIGZpbGw9ImJsYWNrIi8+CiAgPGNpcmNsZSBjeD0iNTEyIiBjeT0iNTEyIiByPSIyNTYiIGZpbGw9IndoaXRlIi8+Cjwvc3ZnPgo="),
            description : 0x1::string::utf8(b"Mega hero"),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v0, v2),
        }
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HERO>(arg0, arg1);
        let v1 = 0x2::display::new<Hero>(&v0, arg1);
        0x2::display::add<Hero>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Hero>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Hero>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<Hero>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::transfer_policy::new<Hero>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Hero>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Hero>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<Hero>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::lock<Hero>(arg0, arg1, arg2, new(0x1::string::utf8(b"Hero"), arg3));
    }

    // decompiled from Move bytecode v6
}

