module 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::dot_move_record {
    struct DotMoveRecord has store, key {
        id: 0x2::object::UID,
        dot_move_id: 0x2::object::ID,
        expiration_timestamp_ms: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : DotMoveRecord {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg1), 1);
        DotMoveRecord{
            id                      : 0x2::object::new(arg3),
            dot_move_id             : arg2,
            expiration_timestamp_ms : arg0,
        }
    }

    public fun id(arg0: &DotMoveRecord) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun burn(arg0: DotMoveRecord) {
        let DotMoveRecord {
            id                      : v0,
            dot_move_id             : _,
            expiration_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun has_expired(arg0: &DotMoveRecord, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expiration_timestamp_ms
    }

    public fun is_valid_for(arg0: &DotMoveRecord, arg1: &0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::dot_move::DotMove) : bool {
        arg0.dot_move_id == 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::dot_move::id(arg1)
    }

    public(friend) fun set_expiration_timestamp_ms(arg0: &mut DotMoveRecord, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 1);
        arg0.expiration_timestamp_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

