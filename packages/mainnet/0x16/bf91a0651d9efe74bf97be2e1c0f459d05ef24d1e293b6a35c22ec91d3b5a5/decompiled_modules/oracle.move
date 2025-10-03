module 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::oracle {
    public fun is_fresh(arg0: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg1: &0x2::clock::Clock) : bool {
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::is_fresh(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::last_update(arg0), 0x2::clock::timestamp_ms(arg1))
    }

    public fun add_updater(arg0: &mut 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::admin(arg0), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::not_authorized());
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::add_updater(arg0, arg1);
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::events::updater_added(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::id(arg0), arg1);
    }

    public fun change_admin(arg0: &mut 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::admin(arg0);
        assert!(0x2::tx_context::sender(arg2) == v0, 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::not_authorized());
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::set_admin(arg0, arg1);
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::events::admin_changed(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::id(arg0), v0, arg1);
    }

    public fun create(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::is_valid_price(arg0), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::price_invalid());
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::new(arg0, 0x2::clock::timestamp_ms(arg1), v0, arg2);
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::events::oracle_created(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::id(&v1), v0, arg0);
        0x2::transfer::public_share_object<0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle>(v1);
    }

    public fun get_price(arg0: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::is_fresh(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::last_update(arg0), 0x2::clock::timestamp_ms(arg1)), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::price_stale());
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::price(arg0)
    }

    public fun get_price_unsafe(arg0: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle) : u64 {
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::price(arg0)
    }

    public fun remove_updater(arg0: &mut 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::admin(arg0), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::not_authorized());
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::remove_updater(arg0, arg1);
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::events::updater_removed(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::id(arg0), arg1);
    }

    public fun update(arg0: &mut 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::is_updater(arg0, v0), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::not_authorized());
        assert!(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::is_valid_price(arg1), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors::price_invalid());
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::set_price(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::events::price_updated(0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::id(arg0), 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::price(arg0), arg1, v0);
    }

    // decompiled from Move bytecode v6
}

