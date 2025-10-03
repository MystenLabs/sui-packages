module 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types {
    struct Oracle has store, key {
        id: 0x2::object::UID,
        price: u64,
        last_update: u64,
        admin: address,
        updaters: vector<address>,
        update_count: u64,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Oracle {
        Oracle{
            id           : 0x2::object::new(arg3),
            price        : arg0,
            last_update  : arg1,
            admin        : arg2,
            updaters     : 0x1::vector::empty<address>(),
            update_count : 0,
        }
    }

    public(friend) fun add_updater(arg0: &mut Oracle, arg1: address) {
        if (!0x1::vector::contains<address>(&arg0.updaters, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.updaters, arg1);
        };
    }

    public fun admin(arg0: &Oracle) : address {
        arg0.admin
    }

    public fun id(arg0: &Oracle) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_updater(arg0: &Oracle, arg1: address) : bool {
        arg1 == arg0.admin || 0x1::vector::contains<address>(&arg0.updaters, &arg1)
    }

    public fun last_update(arg0: &Oracle) : u64 {
        arg0.last_update
    }

    public fun price(arg0: &Oracle) : u64 {
        arg0.price
    }

    public(friend) fun remove_updater(arg0: &mut Oracle, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.updaters, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.updaters, v1);
        };
    }

    public(friend) fun set_admin(arg0: &mut Oracle, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun set_price(arg0: &mut Oracle, arg1: u64, arg2: u64) {
        arg0.price = arg1;
        arg0.last_update = arg2;
        arg0.update_count = arg0.update_count + 1;
    }

    public fun update_count(arg0: &Oracle) : u64 {
        arg0.update_count
    }

    // decompiled from Move bytecode v6
}

