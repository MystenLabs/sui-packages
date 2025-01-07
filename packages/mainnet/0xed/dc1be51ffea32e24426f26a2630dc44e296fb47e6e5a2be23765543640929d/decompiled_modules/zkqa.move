module 0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::zkqa {
    struct ZKQA has drop {
        dummy_field: bool,
    }

    struct QAEvent has copy, drop {
        sender: address,
        msg: 0x1::string::String,
    }

    struct QABox<T0: store> has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        reward: T0,
        validator: 0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::validator::Validator,
    }

    public fun new<T0: store>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : QABox<T0> {
        let v0 = QAEvent{
            sender : 0x2::tx_context::sender(arg3),
            msg    : 0x1::string::utf8(b"new qa box"),
        };
        0x2::event::emit<QAEvent>(v0);
        QABox<T0>{
            id        : 0x2::object::new(arg3),
            question  : arg0,
            reward    : arg2,
            validator : 0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::validator::new(arg3, 0x2::hex::decode(arg1)),
        }
    }

    public entry fun get_coin_reward<T0>(arg0: QABox<0x2::balance::Balance<T0>>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::validator::do_validate(&arg0.validator, &arg1, arg2), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(get_reward<0x2::balance::Balance<T0>>(arg0, arg2), arg2), 0x2::tx_context::sender(arg2));
    }

    fun get_reward<T0: store>(arg0: QABox<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        let v0 = QAEvent{
            sender : 0x2::tx_context::sender(arg1),
            msg    : 0x1::string::utf8(b"box opened"),
        };
        0x2::event::emit<QAEvent>(v0);
        let QABox {
            id        : v1,
            question  : _,
            reward    : v3,
            validator : v4,
        } = arg0;
        0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::validator::clean(v4);
        0x2::object::delete(v1);
        v3
    }

    fun init(arg0: ZKQA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ZKQA>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = QAEvent{
            sender : 0x2::tx_context::sender(arg1),
            msg    : 0x1::string::utf8(b"init zkqa module"),
        };
        0x2::event::emit<QAEvent>(v0);
    }

    public entry fun new_coinbox_to_me<T0>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<0x2::balance::Balance<T0>>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
        0x2::transfer::public_transfer<QABox<0x2::balance::Balance<T0>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun new_to_me<T0: store>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<QABox<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

