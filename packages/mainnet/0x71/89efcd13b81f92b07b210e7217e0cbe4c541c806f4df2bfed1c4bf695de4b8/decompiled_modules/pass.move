module 0x7189efcd13b81f92b07b210e7217e0cbe4c541c806f4df2bfed1c4bf695de4b8::pass {
    struct PASS has drop {
        dummy_field: bool,
    }

    struct Pass has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Pass {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"epic"));
        Pass{
            id          : 0x2::object::new(arg1),
            name        : arg0,
            image_url   : 0x1::string::utf8(b"https://i.ibb.co/6Dv6rDy/card.png"),
            description : 0x1::string::utf8(b"Chain Pass"),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v0, v2),
        }
    }

    fun init(arg0: PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PASS>(arg0, arg1);
        let v1 = 0x2::display::new<Pass>(&v0, arg1);
        0x2::display::add<Pass>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Pass>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Pass>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<Pass>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Pass>>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::transfer_policy::new<Pass>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Pass>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Pass>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<Pass>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::lock<Pass>(arg0, arg1, arg2, new(0x1::string::utf8(b"Pass"), arg3));
    }

    // decompiled from Move bytecode v6
}

