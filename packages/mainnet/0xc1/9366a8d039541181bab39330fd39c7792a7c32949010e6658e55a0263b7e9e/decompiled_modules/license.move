module 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license {
    struct LICENSE has drop {
        dummy_field: bool,
    }

    struct License has store, key {
        id: 0x2::object::UID,
        template_id: 0x1::string::String,
        version: 0x1::string::String,
        order_id: 0x1::string::String,
        issued_ms: u64,
        url: 0x1::string::String,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct LicenseMinted has copy, drop {
        license_id: 0x2::object::ID,
        template_id: 0x1::string::String,
        order_id: 0x1::string::String,
        recipient: address,
    }

    fun init(arg0: LICENSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LICENSE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"546865205370696365204d656c616e676520e28094207b74656d706c6174655f69647d204c6963656e7365"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"License for The Spice Melange agent template {template_id} ({version}), order {order_id}."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thespicemelange.org/favicon.svg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thespicemelange.org/store/"));
        let v5 = 0x2::display::new_with_fields<License>(&v0, v1, v3, arg1);
        0x2::display::update_version<License>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<License>>(v5, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        let v7 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MinterCap>(v7, v6);
    }

    public fun issued_ms(arg0: &License) : u64 {
        arg0.issued_ms
    }

    public fun mint(arg0: &MinterCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public fun order_id(arg0: &License) : 0x1::string::String {
        arg0.order_id
    }

    public fun template_id(arg0: &License) : 0x1::string::String {
        arg0.template_id
    }

    public fun url(arg0: &License) : 0x1::string::String {
        arg0.url
    }

    public fun version(arg0: &License) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

