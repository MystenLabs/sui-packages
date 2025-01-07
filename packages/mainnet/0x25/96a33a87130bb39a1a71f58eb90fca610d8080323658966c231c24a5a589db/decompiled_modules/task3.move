module 0x2596a33a87130bb39a1a71f58eb90fca610d8080323658966c231c24a5a589db::task3 {
    struct CourseInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        time: u64,
    }

    struct TASK3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASK3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"best {name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"this is my NTF"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sundy"));
        let v4 = 0x2::package::claim<TASK3>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CourseInfo>(&v4, v0, v2, arg1);
        0x2::display::update_version<CourseInfo>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CourseInfo>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CourseInfo{
            id        : 0x2::object::new(arg4),
            name      : arg0,
            image_url : arg1,
            time      : arg2,
        };
        0x2::transfer::transfer<CourseInfo>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

