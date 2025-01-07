module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::amount_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove(arg0: &mut 0x2::transfer_policy::TransferRequest<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item) {
        assert!(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg1) == 0x2::transfer_policy::item<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0), 102);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::amount(arg1);
        assert!(v0 == 1 || v0 == 10 || v0 == 100, 101);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

