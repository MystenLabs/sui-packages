module 0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::rebalancing_counter {
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

    public entry fun increment<T0, T1>(arg0: &mut 0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::vault::Vault<T0, T1>, arg1: &mut Counter, arg2: &0x2::tx_context::TxContext) {
        assert!(0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::vault::is_address_whitelisted_for_trading<T0, T1>(arg0, 0x2::tx_context::sender(arg2)), 0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::error::address_not_whitelisted());
        arg1.value = arg1.value + 1;
    }

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public entry fun reset<T0, T1>(arg0: &mut 0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::vault::Vault<T0, T1>, arg1: &mut Counter, arg2: &0x2::tx_context::TxContext) {
        assert!(0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::vault::is_address_whitelisted_for_trading<T0, T1>(arg0, 0x2::tx_context::sender(arg2)), 0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::error::address_not_whitelisted());
        arg1.value = 0;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

