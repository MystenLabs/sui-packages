module 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry {
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

    public(friend) fun borrow_mut_position(arg0: &mut PositionRegistry, arg1: u64, arg2: address) : &mut 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position {
        assert_registered(arg0, arg1, arg2);
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::borrow_mut<PositionDfKey, 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position>(&mut arg0.id, v0)
    }

    public fun borrow_position(arg0: &PositionRegistry, arg1: u64, arg2: address) : &0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position {
        assert_registered(arg0, arg1, arg2);
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::borrow<PositionDfKey, 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position>(&arg0.id, v0)
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

    public(friend) fun register(arg0: &mut PositionRegistry, arg1: u64, arg2: address, arg3: 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position) {
        let v0 = PositionDfKey{
            pool_idx : arg1,
            addr     : arg2,
        };
        0x2::dynamic_field::add<PositionDfKey, 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position>(&mut arg0.id, v0, arg3);
        arg0.num_positions = arg0.num_positions + 1;
    }

    // decompiled from Move bytecode v6
}

