module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::message {
    struct Editable has drop {
        dummy_field: bool,
    }

    struct UnEditable has drop {
        dummy_field: bool,
    }

    struct Message<phantom T0: drop> has key {
        id: 0x2::object::UID,
        words: 0x1::string::String,
        to: vector<address>,
        at: vector<address>,
        ref: 0x1::option::Option<address>,
    }

    fun ASSERT_PARAM(arg0: &0x1::string::String, arg1: &vector<address>, arg2: &vector<address>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_STRLEN_LESS(arg0, (2048 as u64));
        assert!(0x1::vector::length<address>(arg1) <= (128 as u64), (500 as u64));
        assert!(0x1::vector::length<address>(arg2) <= (128 as u64), (501 as u64));
    }

    public fun create(arg0: 0x1::string::String, arg1: vector<address>, arg2: vector<address>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        create_imp<UnEditable>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun create_editable(arg0: 0x1::string::String, arg1: vector<address>, arg2: vector<address>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        create_imp<Editable>(arg0, arg1, arg2, arg3, arg4);
    }

    fun create_imp<T0: drop>(arg0: 0x1::string::String, arg1: vector<address>, arg2: vector<address>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        ASSERT_PARAM(&arg0, &arg1, &arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x1::vector::is_empty<address>(&arg1)) {
            0x1::vector::push_back<address>(&mut arg1, v0);
        };
        let v1 = Message<T0>{
            id    : 0x2::object::new(arg4),
            words : arg0,
            to    : arg1,
            at    : arg2,
            ref   : arg3,
        };
        0x2::transfer::transfer<Message<T0>>(v1, v0);
    }

    public fun destroy<T0: drop>(arg0: Message<T0>) {
        let Message {
            id    : v0,
            words : _,
            to    : _,
            at    : _,
            ref   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun edit(arg0: &mut Message<Editable>, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<address>, arg4: 0x1::option::Option<address>) {
        ASSERT_PARAM(&arg1, &arg2, &arg3);
        arg0.words = arg1;
        arg0.to = arg2;
        arg0.at = arg3;
        arg0.ref = arg4;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

