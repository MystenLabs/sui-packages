module 0x94f090cd7162900c6fd3cc9043e9151ff58abf0ba402a85bd504ed87f1970bd0::random_test {
    struct SharedObject has store, key {
        id: 0x2::object::UID,
        value: u256,
    }

    entry fun generate(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::random::new_generator(arg0, arg1);
        0x2::random::new_generator(arg0, arg1);
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64(&mut v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedObject{
            id    : 0x2::object::new(arg0),
            value : 123,
        };
        0x2::transfer::share_object<SharedObject>(v0);
    }

    entry fun mutate_with_random(arg0: &mut SharedObject, arg1: &0x2::random::Random, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg3);
        0x2::random::generate_bytes(&mut v0, (arg2 as u16));
        arg0.value = 0x2::random::generate_u256(&mut v0);
        assert!(arg0.value > 0, 0);
    }

    entry fun mutate_without(arg0: &mut SharedObject) {
        arg0.value = arg0.value % 27;
    }

    // decompiled from Move bytecode v6
}

