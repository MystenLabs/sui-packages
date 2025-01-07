module 0xb5f16e3f8a7364cdd9c1252267de7b13649afef89914b5cfeade5dee21625100::cfa {
    struct CFACertificate has store, key {
        id: 0x2::object::UID,
        qualifier_name: 0x1::string::String,
        qualifier_image_url: 0x1::string::String,
        issuer: address,
        description: 0x1::string::String,
    }

    struct GrantCap has key {
        id: 0x2::object::UID,
    }

    struct CFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"logo"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"qualifier_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"qualifier_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"issuer"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{https://www.cfainstitute.org/themes/custom/cfa_base/logo.svg}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{qualifier_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{qualifier_image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.cfainstitute.org/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{issuer}"));
        let v4 = 0x2::package::claim<CFA>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CFACertificate>(&v4, v0, v2, arg1);
        0x2::display::update_version<CFACertificate>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CFACertificate>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GrantCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GrantCap>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CFACertificate{
            id                  : 0x2::object::new(arg4),
            qualifier_name      : arg0,
            qualifier_image_url : arg1,
            issuer              : 0x2::tx_context::sender(arg4),
            description         : arg2,
        };
        0x2::transfer::public_transfer<CFACertificate>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

