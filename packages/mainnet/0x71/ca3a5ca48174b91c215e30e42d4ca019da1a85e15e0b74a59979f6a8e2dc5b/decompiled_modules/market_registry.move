module 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry {
    struct MarketRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        allowed: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun id(arg0: &MarketRegistry) : 0x2::object::ID {
        0x2::object::id<MarketRegistry>(arg0)
    }

    public fun add_market(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::not_owner());
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed, arg1);
        };
    }

    public fun admin(arg0: &MarketRegistry) : address {
        arg0.admin
    }

    fun build_registry(arg0: &mut 0x2::tx_context::TxContext) : MarketRegistry {
        MarketRegistry{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            allowed : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun is_allowed(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &arg1)
    }

    public fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = build_registry(arg0);
        0x2::transfer::share_object<MarketRegistry>(v0);
        0x2::object::id<MarketRegistry>(&v0)
    }

    public fun remove_market(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::not_owner());
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed, &arg1);
        };
    }

    // decompiled from Move bytecode v7
}

