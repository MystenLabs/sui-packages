module 0x96a53a6a6b5955b49a1c3dde97ed0b3596ba375387b7c59751fde5a25a48c7d5::mycoin {
    struct Receipt has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct Message has copy, drop {
        message: 0x1::string::String,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AA"));
        let v4 = 0x2::package::claim<MYCOIN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun send(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{message: 0x1::string::utf8(arg2)};
        0x2::event::emit<Message>(v0);
        let v1 = Receipt{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg2),
        };
        0x2::transfer::public_transfer<Receipt>(v1, arg0);
    }

    entry fun send_message_with_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: address) {
        let v0 = Message{message: 0x1::string::utf8(arg1)};
        0x2::event::emit<Message>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

