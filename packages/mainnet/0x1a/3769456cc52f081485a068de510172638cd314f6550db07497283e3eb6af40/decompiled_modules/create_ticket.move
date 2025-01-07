module 0x1a3769456cc52f081485a068de510172638cd314f6550db07497283e3eb6af40::create_ticket {
    struct Ticket has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct CREATE_TICKET has drop {
        dummy_field: bool,
    }

    public entry fun claim_ticket(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            img_url : arg1,
        };
        0x2::transfer::transfer<Ticket>(v0, arg2);
    }

    fun init(arg0: CREATE_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"vwin.wtf"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A Lottery Platform On Sui Blockchain"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"vwin.wtf"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"vwin.wtf"));
        let v4 = 0x2::package::claim<CREATE_TICKET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Ticket>(&v4, v0, v2, arg1);
        0x2::display::update_version<Ticket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

