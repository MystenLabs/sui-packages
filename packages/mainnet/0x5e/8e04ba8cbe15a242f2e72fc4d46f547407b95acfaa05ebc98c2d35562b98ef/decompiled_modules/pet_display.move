module 0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::pet_display {
    struct PET_DISPLAY has drop {
        dummy_field: bool,
    }

    fun create_display(arg0: PET_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<PET_DISPLAY>(arg0, arg1);
        let v2 = 0x2::display::new<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&v1, arg1);
        0x2::display::add<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"FRAJDER genesis pet #{catalog_id} with on-chain role {role.value}"));
        0x2::display::add<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&mut v2, 0x1::string::utf8(b"metadata_url"), 0x1::string::utf8(b"{metadata_url}"));
        0x2::display::add<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://frajder.com/profile"));
        0x2::display::update_version<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder::Pet>>(v2, v0);
    }

    fun init(arg0: PET_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        create_display(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

