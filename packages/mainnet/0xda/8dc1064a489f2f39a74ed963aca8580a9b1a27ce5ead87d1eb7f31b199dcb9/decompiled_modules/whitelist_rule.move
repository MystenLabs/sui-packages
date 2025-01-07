module 0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        whitelist_id: 0x2::object::ID,
    }

    public fun exercise<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist::Whitelist, arg2: &mut 0x2::transfer_policy::TransferRequest<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::object::id<0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist::Whitelist>(arg1) == 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).whitelist_id, 0);
        0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist::exercise(arg1, arg3);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg2);
    }

    public entry fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist::Whitelist) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{whitelist_id: 0x2::object::id<0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist::Whitelist>(arg2)};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

