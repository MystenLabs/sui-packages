module 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access {
    struct Config has key {
        id: 0x2::object::UID,
        operators: 0x2::vec_set::VecSet<address>,
    }

    public fun add_operator(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Config, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg1.operators, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.operators, arg2);
        };
    }

    public fun assert_operator(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(is_operator(arg0, 0x2::tx_context::sender(arg1)), 120);
    }

    public fun create_config(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg1),
            operators : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_operator(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators, &arg1)
    }

    public fun operators(arg0: &Config) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.operators)
    }

    public fun remove_operator(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Config, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.operators, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.operators, &arg2);
        };
    }

    // decompiled from Move bytecode v7
}

