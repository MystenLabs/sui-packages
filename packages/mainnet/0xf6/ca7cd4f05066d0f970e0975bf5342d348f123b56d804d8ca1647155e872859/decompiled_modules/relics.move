module 0xf6ca7cd4f05066d0f970e0975bf5342d348f123b56d804d8ca1647155e872859::relics {
    struct RELICS has drop {
        dummy_field: bool,
    }

    struct Relic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        item_type: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: Relic) {
        let Relic {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            item_type   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: RELICS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RELICS>(arg0, arg1);
        let (v1, v2) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        let (v3, v4) = 0x2::transfer_policy::new<Relic>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Relic>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Relic>>(v4, 0x2::tx_context::sender(arg1));
        let v5 = 0x2::display::new<Relic>(&v0, arg1);
        0x2::display::add<Relic>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Relic>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Relic>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Relic>(&mut v5, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Relic>(&mut v5, 0x1::string::utf8(b"item_type"), 0x1::string::utf8(b"{item_type}"));
        0x2::display::update_version<Relic>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<Relic>>(v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<Relic>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Relic{
            id          : 0x2::object::new(arg9),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            rarity      : arg4,
            item_type   : arg5,
        };
        0x2::kiosk::place<Relic>(arg6, arg7, v0);
        let v1 = Relic{
            id          : 0x2::object::new(arg9),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            rarity      : arg4,
            item_type   : arg5,
        };
        0x2::kiosk::lock<Relic>(arg6, arg7, arg8, v1);
    }

    // decompiled from Move bytecode v6
}

