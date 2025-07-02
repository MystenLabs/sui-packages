module 0xf3a4728c0477373b7d25d6db82d3eef799a264b233fb5b5c957d190e37efca7f::message {
    struct Message has store, key {
        id: 0x2::object::UID,
    }

    struct MESSAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"lets stop gas war"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://i.imgur.com/U2t9A5D.png"));
        let v2 = 0x2::package::claim<MESSAGE>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<Message>(&v2, v0, v1, arg1);
        0x2::display::update_version<Message>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Message>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun msg_to_u_thru_object(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Message>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

