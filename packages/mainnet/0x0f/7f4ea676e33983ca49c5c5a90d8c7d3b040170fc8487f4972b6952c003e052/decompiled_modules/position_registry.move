module 0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::position_registry {
    struct PositionKey has copy, drop, store {
        protocol: 0x1::string::String,
        owner: address,
    }

    struct PositionRegistry has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<PositionKey, 0x2::object::ID>,
    }

    public fun get_position_id(arg0: &PositionRegistry, arg1: 0x1::string::String, arg2: address) : 0x2::object::ID {
        let v0 = PositionKey{
            protocol : arg1,
            owner    : arg2,
        };
        *0x2::table::borrow<PositionKey, 0x2::object::ID>(&arg0.positions, v0)
    }

    public fun has_position(arg0: &PositionRegistry, arg1: 0x1::string::String, arg2: address) : bool {
        let v0 = PositionKey{
            protocol : arg1,
            owner    : arg2,
        };
        0x2::table::contains<PositionKey, 0x2::object::ID>(&arg0.positions, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id        : 0x2::object::new(arg0),
            positions : 0x2::table::new<PositionKey, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public fun register_position(arg0: &mut PositionRegistry, arg1: 0x1::string::String, arg2: address, arg3: 0x2::object::ID) {
        let v0 = PositionKey{
            protocol : arg1,
            owner    : arg2,
        };
        assert!(!0x2::table::contains<PositionKey, 0x2::object::ID>(&arg0.positions, v0), 300);
        0x2::table::add<PositionKey, 0x2::object::ID>(&mut arg0.positions, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

