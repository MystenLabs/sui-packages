module 0x2c9869645dcb686b9730c4ccf1c229e0403f9cdee407cee59c153fa9811afdbe::message {
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
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://i.imgur.com/vGPnyy7.png"));
        let v2 = 0x2::package::claim<MESSAGE>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<Message>(&v2, v0, v1, arg1);
        0x2::display::update_version<Message>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Message>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Message>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

