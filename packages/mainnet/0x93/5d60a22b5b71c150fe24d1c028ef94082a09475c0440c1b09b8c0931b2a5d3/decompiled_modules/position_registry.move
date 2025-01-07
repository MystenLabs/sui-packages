module 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position_registry {
    struct Key has copy, drop, store {
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
        let v0 = Key{
            pool_idx : arg1,
            addr     : arg2,
        };
        assert!(0x2::dynamic_field::exists_<Key>(&arg0.id, v0), 0);
    }

    public(friend) fun borrow_mut_position(arg0: &mut PositionRegistry, arg1: u64, arg2: address) : &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position {
        assert_registered(arg0, arg1, arg2);
        let v0 = Key{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::borrow_mut<Key, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position>(&mut arg0.id, v0)
    }

    public fun borrow_position(arg0: &PositionRegistry, arg1: u64, arg2: address) : &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position {
        assert_registered(arg0, arg1, arg2);
        let v0 = Key{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::borrow<Key, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position>(&arg0.id, v0)
    }

    public fun num_positions(arg0: &PositionRegistry) : u64 {
        arg0.num_positions
    }

    public(friend) fun register(arg0: &mut PositionRegistry, arg1: u64, arg2: address, arg3: 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position) {
        let v0 = Key{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::add<Key, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position>(&mut arg0.id, v0, arg3);
        arg0.num_positions = arg0.num_positions + 1;
    }

    // decompiled from Move bytecode v6
}

