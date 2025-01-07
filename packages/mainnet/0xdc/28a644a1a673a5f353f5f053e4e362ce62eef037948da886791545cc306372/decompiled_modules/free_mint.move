module 0xdc28a644a1a673a5f353f5f053e4e362ce62eef037948da886791545cc306372::free_mint {
    struct FREE_MINT has drop {
        dummy_field: bool,
    }

    struct JarJarFreemint has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy_ticket(arg0: 0x1::option::Option<JarJarFreemint>) {
        if (0x1::option::is_some<JarJarFreemint>(&arg0)) {
            let JarJarFreemint { id: v0 } = 0x1::option::destroy_some<JarJarFreemint>(arg0);
            0x2::object::delete(v0);
        } else {
            0x1::option::destroy_none<JarJarFreemint>(arg0);
        };
    }

    fun generated_freemint_ticket(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 100) {
            let v1 = JarJarFreemint{id: 0x2::object::new(arg0)};
            0x2::transfer::public_transfer<JarJarFreemint>(v1, 0x2::tx_context::sender(arg0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: FREE_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Freemint ticket for JarJar"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://jarjar-mainnet.s3.eu-north-1.amazonaws.com/freemint_ticket_edited.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://jarjar-mainnet.s3.eu-north-1.amazonaws.com/freemint_ticket_edited.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Freemint ticket for Jar Jar Binks Eggs NFTs the first AI collection generated at the smart contract level on $SUI"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://mint.jarjar.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/JARJARxyz"));
        let v4 = 0x2::package::claim<FREE_MINT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<JarJarFreemint>(&v4, v0, v2, arg1);
        0x2::display::update_version<JarJarFreemint>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JarJarFreemint>>(v5, 0x2::tx_context::sender(arg1));
        generated_freemint_ticket(arg1);
    }

    // decompiled from Move bytecode v6
}

