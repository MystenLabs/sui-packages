module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_dao {
    struct VotingDAO has store {
        delegates: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        nonces: 0x2::table::Table<address, u64>,
        num_checkpoints: 0x2::table::Table<0x2::object::ID, u64>,
        checkpoints: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>,
    }

    struct Checkpoint has copy, drop, store {
        from_timestamp: u64,
        owner: address,
        delegated_balance: u64,
        delegatee: 0x2::object::ID,
    }

    public(friend) fun checkpoint_delegatee(arg0: &mut VotingDAO, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0x2::object::id_from_address(@0x0)) {
            return
        };
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        let v1 = if (v0 > 0) {
            *0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1)
        } else {
            if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) {
                0x2::table::add<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1, 0x2::table::new<u64, Checkpoint>(arg5));
            };
            0x2::table::add<u64, Checkpoint>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1), 0, create_checkpoint());
            *0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), 0)
        };
        let v2 = v1;
        assert!(0x2::table::length<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) == v0, 9223372307437715455);
        let v3 = create_checkpoint();
        v3.from_timestamp = get_block_timestamp(arg4);
        assert!(v2.owner != @0x0, 9223372346092421119);
        v3.owner = v2.owner;
        let v4 = if (arg3) {
            v2.delegated_balance + arg2
        } else if (arg2 < v2.delegated_balance) {
            v2.delegated_balance - arg2
        } else {
            0
        };
        v3.delegated_balance = v4;
        v3.delegatee = v2.delegatee;
        if (is_checkpoint_in_new_block(arg0, arg1, get_block_timestamp(arg4))) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1, 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1) + 1);
            0x2::table::add<u64, Checkpoint>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1), v0, v3);
        } else {
            let v5 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1);
            0x2::table::remove<u64, Checkpoint>(v5, v0 - 1);
            0x2::table::add<u64, Checkpoint>(v5, v0 - 1, v3);
        };
    }

    public(friend) fun checkpoint_delegator(arg0: &mut VotingDAO, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1, 0);
            0
        };
        let v1 = if (v0 > 0) {
            *0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1)
        } else {
            if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) {
                0x2::table::add<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1, 0x2::table::new<u64, Checkpoint>(arg6));
            };
            create_checkpoint()
        };
        let v2 = v1;
        assert!(0x2::table::length<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) == v0, 9223372608085426175);
        checkpoint_delegatee(arg0, v2.delegatee, arg2, false, arg5, arg6);
        let v3 = create_checkpoint();
        v3.from_timestamp = get_block_timestamp(arg5);
        v3.delegated_balance = v2.delegated_balance;
        v3.delegatee = arg3;
        v3.owner = arg4;
        if (is_checkpoint_in_new_block(arg0, arg1, get_block_timestamp(arg5))) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1, 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1) + 1);
            0x2::table::add<u64, Checkpoint>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1), v0, v3);
        } else {
            0x2::table::remove<u64, Checkpoint>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1), v0 - 1);
            0x2::table::add<u64, Checkpoint>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1), v0 - 1, v3);
        };
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.delegates, arg1)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.delegates, arg1);
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.delegates, arg1, arg3);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : VotingDAO {
        VotingDAO{
            delegates       : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            nonces          : 0x2::table::new<address, u64>(arg0),
            num_checkpoints : 0x2::table::new<0x2::object::ID, u64>(arg0),
            checkpoints     : 0x2::table::new<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(arg0),
        }
    }

    fun create_checkpoint() : Checkpoint {
        Checkpoint{
            from_timestamp    : 0,
            owner             : @0x0,
            delegated_balance : 0,
            delegatee         : 0x2::object::id_from_address(@0x0),
        }
    }

    public(friend) fun delegatee(arg0: &VotingDAO, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.delegates, arg1)
    }

    fun get_block_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    fun is_checkpoint_in_new_block(arg0: &VotingDAO, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        let v1 = v0 > 0 && arg2 - 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1).from_timestamp < 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::get_time_to_finality();
        !v1
    }

    // decompiled from Move bytecode v6
}

