module 0x9e679251cb0b105d0008e99ef9897c52e9819e0791ad342e96022a257767d681::sui_book {
    struct Book has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        author: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun create_book(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Book{
            id          : 0x2::object::new(arg3),
            title       : arg0,
            author      : arg1,
            description : arg2,
        };
        0x2::transfer::transfer<Book>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun update_description(arg0: &mut Book, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    // decompiled from Move bytecode v7
}

