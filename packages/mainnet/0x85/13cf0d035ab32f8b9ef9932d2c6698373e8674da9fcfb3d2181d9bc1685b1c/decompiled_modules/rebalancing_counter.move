module 0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::rebalancing_counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public entry fun assert_value(arg0: &Counter, arg1: u64) : bool {
        arg0.value == arg1
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::public_share_object<Counter>(v0);
    }

    public entry fun increment<T0, T1>(arg0: &mut 0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::vault::Vault<T0, T1>, arg1: &mut Counter, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::vault::is_address_whitelisted_for_trading<T0, T1>(arg0, 0x2::tx_context::sender(arg2)), 0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::error::address_not_whitelisted());
        arg1.value = arg1.value + 1;
    }

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public entry fun reset<T0, T1>(arg0: &mut 0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::vault::Vault<T0, T1>, arg1: &mut Counter, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::vault::is_address_whitelisted_for_trading<T0, T1>(arg0, 0x2::tx_context::sender(arg2)), 0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::error::address_not_whitelisted());
        arg1.value = 0;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

