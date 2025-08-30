module 0x7f0edb9482334e3bcf360d960a701371aa58fc0ab1dfeae9e03e82c5ef85412c::guestbook_contract {
    struct Message has store {
        sender: address,
        content: 0x1::string::String,
    }

    struct GuestBook has store, key {
        id: 0x2::object::UID,
        messages: vector<Message>,
        number_of_messages: u64,
    }

    public fun create_message(arg0: vector<u8>, arg1: 0x2::tx_context::TxContext) : Message {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::length(&v0);
        assert!(v1 > 0 && v1 <= 100, 1);
        Message{
            sender  : 0x2::tx_context::sender(&arg1),
            content : 0x1::string::utf8(arg0),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GuestBook{
            id                 : 0x2::object::new(arg0),
            messages           : 0x1::vector::empty<Message>(),
            number_of_messages : 0,
        };
        0x2::transfer::share_object<GuestBook>(v0);
    }

    public fun post_message(arg0: &mut GuestBook, arg1: Message, arg2: 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::length(&arg1.content);
        assert!(v0 > 0 && v0 <= 100, 1);
        0x1::vector::push_back<Message>(&mut arg0.messages, arg1);
        arg0.number_of_messages = arg0.number_of_messages + 1;
    }

    // decompiled from Move bytecode v6
}

