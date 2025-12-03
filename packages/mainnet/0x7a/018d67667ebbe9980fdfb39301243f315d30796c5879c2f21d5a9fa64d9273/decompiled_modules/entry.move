module 0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::entry {
    struct ENTRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ENTRY>(arg0, arg1);
        let v2 = 0x2::display::new<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&v1, arg1);
        0x2::display::add<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"author"), 0x1::string::utf8(b"{author}"));
        0x2::display::add<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"id_number"), 0x1::string::utf8(b"{id_number}"));
        0x2::display::add<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::update_version<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::Collectible>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::admin_cap::transfer_to(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::admin_cap::init_admin_cap(arg1), v0);
    }

    entry fun mint(arg0: &0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::admin_cap::AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::transfer_to(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::new(arg2, arg3), arg1);
    }

    entry fun mint_custom(arg0: &0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::admin_cap::AdminCap, arg1: address, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::transfer_to(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible::new_custom(arg2, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4), 0x1::string::utf8(arg5), 0x1::string::utf8(arg6), 0x1::string::utf8(arg7), arg8), arg1);
    }

    // decompiled from Move bytecode v6
}

