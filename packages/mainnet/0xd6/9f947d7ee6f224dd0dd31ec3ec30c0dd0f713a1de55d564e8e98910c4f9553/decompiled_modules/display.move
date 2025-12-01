module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::display {
    struct ObjectDisplay has key {
        id: 0x2::object::UID,
        inner: 0x2::object_bag::ObjectBag,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun create(arg0: 0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_bag::new(arg2);
        let v1 = init_staked_ika_display(&arg0, arg1, arg2);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>>(&mut v0, 0x1::type_name::with_defining_ids<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(), v1);
        let v2 = PublisherKey{dummy_field: false};
        0x2::object_bag::add<PublisherKey, 0x2::package::Publisher>(&mut v0, v2, arg0);
        let v3 = ObjectDisplay{
            id    : 0x2::object::new(arg2),
            inner : v0,
        };
        0x2::transfer::share_object<ObjectDisplay>(v3);
    }

    fun init_staked_ika_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka> {
        let v0 = 0x2::display::new<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(arg0, arg2);
        0x2::display::add<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Staked IKA ({principal} INKU)"));
        0x2::display::add<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Staked for validator: {validator_id}, activates at: {activation_epoch}"));
        0x2::display::add<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

