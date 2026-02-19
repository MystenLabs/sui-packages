module 0x19e2184d21f2956d8cb290b3ac75d5ce4440fae1d420d425aa144ddb437f39e1::access_pass {
    struct AccessPass has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct GrantCap has store, key {
        id: 0x2::object::UID,
    }

    struct ACCESS_PASS has drop {
        dummy_field: bool,
    }

    public fun get_description(arg0: &AccessPass) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &AccessPass) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_image_url(arg0: &AccessPass) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &AccessPass) : &0x1::string::String {
        &arg0.name
    }

    public fun grant(arg0: &GrantCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPass{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
        };
        0x2::transfer::transfer<AccessPass>(v0, arg4);
    }

    fun init(arg0: ACCESS_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<ACCESS_PASS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AccessPass>(&v4, v0, v2, arg1);
        0x2::display::update_version<AccessPass>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AccessPass>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GrantCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GrantCap>(v6, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

