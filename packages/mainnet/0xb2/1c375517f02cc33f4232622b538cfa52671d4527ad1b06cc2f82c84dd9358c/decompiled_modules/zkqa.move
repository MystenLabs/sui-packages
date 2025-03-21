module 0xb21c375517f02cc33f4232622b538cfa52671d4527ad1b06cc2f82c84dd9358c::zkqa {
    struct ZKQA has drop {
        dummy_field: bool,
    }

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

    public fun get_coin_reward<T0>(arg0: QABox<0x2::balance::Balance<T0>>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::hash::blake2b256(&arg1) == arg0.answer_hash, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(get_reward<0x2::balance::Balance<T0>>(arg0), arg2), 0x2::tx_context::sender(arg2));
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

    fun init(arg0: ZKQA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ZKQA>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

