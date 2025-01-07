module 0xdf10b59a9b1e3445b5b30f993a14b668029a9f4604785b02d8ddc69ee8709c0d::zkqa {
    struct QABox<T0: store> has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        answer: 0x1::string::String,
        reward: T0,
        validator: address,
    }

    public fun new<T0: store>(arg0: 0x1::string::String, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : QABox<T0> {
        QABox<T0>{
            id        : 0x2::object::new(arg2),
            question  : arg0,
            answer    : 0x1::string::utf8(b""),
            reward    : arg1,
            validator : 0x2::tx_context::sender(arg2),
        }
    }

    entry fun answer<T0: store>(arg0: &mut QABox<T0>, arg1: 0x1::string::String) {
        arg0.answer = arg1;
    }

    public fun get_reward<T0: store>(arg0: QABox<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        let QABox {
            id        : v0,
            question  : _,
            answer    : _,
            reward    : v3,
            validator : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    public fun send_back<T0: store>(arg0: QABox<T0>) {
        0x2::transfer::public_transfer<QABox<T0>>(arg0, arg0.validator);
    }

    // decompiled from Move bytecode v6
}

