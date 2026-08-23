module 0x7c10bca72f01df4e575f158aaf30aa2042781db316ffe5f6e664edc818ecfded::builder_card {
    struct BUILDER_CARD has drop {
        dummy_field: bool,
    }

    struct BuilderCard has store, key {
        id: 0x2::object::UID,
        builder_name: 0x1::string::String,
        builder_no: u64,
        profession: 0x1::string::String,
        program: 0x1::string::String,
        country: 0x1::string::String,
        specialization: 0x1::string::String,
        building_since: 0x1::string::String,
        focus: 0x1::string::String,
        community: 0x1::string::String,
        skills: 0x1::string::String,
        issued: 0x1::string::String,
        about: 0x1::string::String,
        website_url: 0x1::string::String,
        photo_url: 0x1::string::String,
    }

    public fun create_builder_card(arg0: &mut 0x24c722f3ddac40d511ef390d052fe09a46a9949fdc8eca480780de99ec526114::builder_registry::BuilderRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = BuilderCard{
            id             : 0x2::object::new(arg13),
            builder_name   : arg1,
            builder_no     : 0x24c722f3ddac40d511ef390d052fe09a46a9949fdc8eca480780de99ec526114::builder_registry::claim_builder_number(arg0),
            profession     : arg2,
            program        : arg3,
            country        : arg4,
            specialization : arg5,
            building_since : arg6,
            focus          : arg7,
            community      : arg8,
            skills         : arg9,
            issued         : arg10,
            about          : arg11,
            website_url    : arg12,
            photo_url      : profile_photo_url(&arg12),
        };
        0x2::transfer::transfer<BuilderCard>(v0, 0x2::tx_context::sender(arg13));
    }

    fun init(arg0: BUILDER_CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BUILDER_CARD>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"builder_no"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"profession"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"program"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"country"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"specialization"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"building_since"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"focus"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"community"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"skills"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"issued"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"4372797074697461204275696c64657220237b6275696c6465725f6e6f7d20e28094207b6275696c6465725f6e616d657d"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Self-created Proof of Learning & Building portfolio produced during the Cryptita Builder Workshop. This on-chain BuilderCard records the participant's workshop portfolio and builder number."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{builder_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{photo_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{builder_no}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{profession}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{program}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{country}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{specialization}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{building_since}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{focus}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{community}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{skills}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{issued}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{website_url}"));
        let v5 = 0x2::display::new_with_fields<BuilderCard>(&v0, v1, v3, arg1);
        0x2::display::update_version<BuilderCard>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BuilderCard>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun profile_photo_url(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, *0x1::string::as_bytes(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/assets/profile.png"));
        v0
    }

    // decompiled from Move bytecode v7
}

