module 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry {
    struct PositionDfKey has copy, drop, store {
        pool_idx: u64,
        addr: address,
    }

    struct PositionRegistry has store, key {
        id: 0x2::object::UID,
        num_positions: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PositionRegistry {
        PositionRegistry{
            id            : 0x2::object::new(arg0),
            num_positions : 0,
        }
    }

    public fun assert_registered(arg0: &PositionRegistry, arg1: u64, arg2: address) {
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        assert!(0x2::dynamic_field::exists_<PositionDfKey>(&arg0.id, v0), 0);
    }

    public(friend) fun borrow_mut_position(arg0: &mut PositionRegistry, arg1: u64, arg2: address) : &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position {
        assert_registered(arg0, arg1, arg2);
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::borrow_mut<PositionDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position>(&mut arg0.id, v0)
    }

    public fun borrow_position(arg0: &PositionRegistry, arg1: u64, arg2: address) : &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position {
        assert_registered(arg0, arg1, arg2);
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::borrow<PositionDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position>(&arg0.id, v0)
    }

    public fun is_registerd(arg0: &PositionRegistry, arg1: u64, arg2: address) : bool {
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::exists_<PositionDfKey>(&arg0.id, v0)
    }

    public fun num_positions(arg0: &PositionRegistry) : u64 {
        arg0.num_positions
    }

    public(friend) fun register(arg0: &mut PositionRegistry, arg1: u64, arg2: address, arg3: 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position) {
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::add<PositionDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position>(&mut arg0.id, v0, arg3);
        arg0.num_positions = arg0.num_positions + 1;
    }

    // decompiled from Move bytecode v6
}

