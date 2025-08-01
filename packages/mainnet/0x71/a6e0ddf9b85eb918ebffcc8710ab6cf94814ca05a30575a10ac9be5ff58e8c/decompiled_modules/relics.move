module 0x71a6e0ddf9b85eb918ebffcc8710ab6cf94814ca05a30575a10ac9be5ff58e8c::relics {
    struct RELICS has drop {
        dummy_field: bool,
    }

    struct Relic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        let Relic {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
        } = 0x2::kiosk::take<Relic>(arg0, arg1, arg2);
        0x2::object::delete(v0);
    }

    fun init(arg0: RELICS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RELICS>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v1);
        let (v4, v5) = 0x2::transfer_policy::new<Relic>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Relic>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Relic>>(v5, v1);
        let v6 = 0x2::display::new<Relic>(&v0, arg1);
        0x2::display::add<Relic>(&mut v6, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Relics of Mysten"));
        0x2::display::add<Relic>(&mut v6, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Ancient relics imbued with the power of Mysten."));
        0x2::display::add<Relic>(&mut v6, 0x1::string::utf8(b"icon_url"), 0x1::string::utf8(b"https://aggregator.mainnet.walrus.mirai.cloud/v1/blobs/ScREaq6fZq71Rbw0ncMYcq-dBoSNhXcAP8I9vkh6zY4"));
        0x2::display::add<Relic>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Relic>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Relic>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<Relic>(&mut v6);
        0x2::transfer::public_share_object<0x2::display::Display<Relic>>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v1);
    }

    public entry fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg4, v1), *0x1::vector::borrow<0x1::string::String>(&arg5, v1));
            v1 = v1 + 1;
        };
        let v2 = Relic{
            id          : 0x2::object::new(arg8),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            attributes  : v0,
        };
        0x2::kiosk::place<Relic>(arg6, arg7, v2);
    }

    // decompiled from Move bytecode v6
}

