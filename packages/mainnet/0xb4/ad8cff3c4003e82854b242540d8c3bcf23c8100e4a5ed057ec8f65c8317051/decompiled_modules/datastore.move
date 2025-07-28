module 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::datastore {
    struct Config has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, bool>,
    }

    public fun add_to_whitelist(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::asserts::sender_is_admin(0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_sender(arg2));
        if (!is_whitelisted(arg0, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelist, arg1, true);
        };
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::asserts::sender_is_admin(0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_sender(arg0));
        let v0 = Config{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun get_sender_if_whitelisted(arg0: &Config, arg1: &0x2::tx_context::TxContext) : address {
        let v0 = 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_sender(arg1);
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::asserts::sender_is_whitelisted(is_whitelisted(arg0, v0));
        v0
    }

    public(friend) fun is_whitelisted(arg0: &Config, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun remove_from_whitelist(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::asserts::sender_is_admin(0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_sender(arg2));
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::asserts::address_is_whitelisted(is_whitelisted(arg0, arg1));
        0x2::table::remove<address, bool>(&mut arg0.whitelist, arg1);
    }

    // decompiled from Move bytecode v6
}

