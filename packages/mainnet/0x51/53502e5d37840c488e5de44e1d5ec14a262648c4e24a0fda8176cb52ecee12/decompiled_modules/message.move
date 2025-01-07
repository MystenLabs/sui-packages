module 0x5153502e5d37840c488e5de44e1d5ec14a262648c4e24a0fda8176cb52ecee12::message {
    struct StringMsg has key {
        id: 0x2::object::UID,
        msg: 0x1::string::String,
    }

    struct ImageMsg has key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
    }

    struct MESSAGE has drop {
        dummy_field: bool,
    }

    struct DeleteStringEvent has copy, drop {
        sender: address,
        msg: 0x1::string::String,
    }

    struct DeleteImageEvent has copy, drop {
        sender: address,
        image_url: 0x1::string::String,
    }

    public fun delete_image_msg(arg0: ImageMsg, arg1: &0x2::tx_context::TxContext) {
        let ImageMsg {
            id        : v0,
            image_url : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = DeleteImageEvent{
            sender    : 0x2::tx_context::sender(arg1),
            image_url : v1,
        };
        0x2::event::emit<DeleteImageEvent>(v2);
    }

    public fun delete_string_msg(arg0: StringMsg, arg1: &0x2::tx_context::TxContext) {
        let StringMsg {
            id  : v0,
            msg : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = DeleteStringEvent{
            sender : 0x2::tx_context::sender(arg1),
            msg    : v1,
        };
        0x2::event::emit<DeleteStringEvent>(v2);
    }

    fun init(arg0: MESSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"{image_url}"));
        let v3 = 0x2::package::claim<MESSAGE>(arg0, arg1);
        let v4 = 0x2::display::new_with_fields<ImageMsg>(&v3, v1, v2, arg1);
        0x2::display::update_version<ImageMsg>(&mut v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x2::display::Display<ImageMsg>>(v4, v0);
    }

    public entry fun send_image(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ImageMsg{
            id        : 0x2::object::new(arg2),
            image_url : arg0,
        };
        0x2::transfer::transfer<ImageMsg>(v0, arg1);
    }

    public entry fun send_string(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StringMsg{
            id  : 0x2::object::new(arg2),
            msg : arg0,
        };
        0x2::transfer::transfer<StringMsg>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

