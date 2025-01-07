module 0xedabdad053d11fad1dba52e77efc870c480b42c0aabde4da75524c9d2baf3fe::zkqa {
    struct QABox<T0: store> has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        answer_hash: vector<u8>,
        reward: T0,
    }

    public fun new<T0: store>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : QABox<T0> {
        QABox<T0>{
            id          : 0x2::object::new(arg3),
            question    : arg0,
            answer_hash : 0x2::hex::decode(arg1),
            reward      : arg2,
        }
    }

    public fun answer<T0: store>(arg0: QABox<T0>, arg1: vector<u8>) : T0 {
        assert!(0x2::hash::blake2b256(&arg1) == arg0.answer_hash, 0);
        get_reward<T0>(arg0)
    }

    fun get_reward<T0: store>(arg0: QABox<T0>) : T0 {
        let QABox {
            id          : v0,
            question    : _,
            answer_hash : _,
            reward      : v3,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    // decompiled from Move bytecode v6
}

