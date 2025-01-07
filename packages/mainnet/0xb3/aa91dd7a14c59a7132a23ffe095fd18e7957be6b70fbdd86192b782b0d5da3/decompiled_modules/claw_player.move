module 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::claw_player {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        vrf_input: vector<u8>,
        user_betting: u64,
    }

    struct WinStatus has copy, drop {
        status: u8,
        game_id: 0x2::object::ID,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        bet_placed_epoch: u64,
        total_betting: 0x2::balance::Balance<T0>,
        player: address,
        vrf_input: vector<u8>,
    }

    public fun bet_placed_epoch<T0>(arg0: &Game<T0>) : u64 {
        arg0.bet_placed_epoch
    }

    public fun betting<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_betting)
    }

    public fun borrow_game<T0>(arg0: 0x2::object::ID, arg1: &0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::GamePool<T0>) : &Game<T0> {
        assert!(game_exists<T0>(arg1, arg0), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::borrow<T0>(arg1), arg0)
    }

    public fun finish_game<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::GamePool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg2, arg0), 4);
        let Game {
            id               : v0,
            bet_placed_epoch : _,
            total_betting    : v2,
            player           : v3,
            vrf_input        : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::borrow_mut<T0>(arg2), arg0);
        let v5 = v4;
        let v6 = v2;
        0x2::object::delete(v0);
        let v7 = 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::public_key<T0>(arg2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &v7, &v5), 2);
        let v8 = 0x2::hash::blake2b256(&arg1);
        let v9 = hash_to_u8(&v8);
        let v10 = if (v9 < 18) {
            let v11 = WinStatus{
                status  : 0,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v11);
            0x2::balance::value<T0>(&v6)
        } else if (v9 < 33) {
            let v12 = WinStatus{
                status  : 0,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v12);
            0x2::balance::value<T0>(&v6) * 90 / 100
        } else if (v9 < 45) {
            let v13 = WinStatus{
                status  : 0,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v13);
            0x2::balance::value<T0>(&v6) * 80 / 100
        } else if (v9 < 55) {
            let v14 = WinStatus{
                status  : 0,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v14);
            0x2::balance::value<T0>(&v6) * 65 / 100
        } else if (v9 < 65) {
            let v15 = WinStatus{
                status  : 0,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v15);
            0x2::balance::value<T0>(&v6)
        } else if (v9 < 75) {
            let v16 = WinStatus{
                status  : 1,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v16);
            0x2::balance::value<T0>(&v6) * 35 / 100
        } else if (v9 < 83) {
            let v17 = WinStatus{
                status  : 1,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v17);
            0x2::balance::value<T0>(&v6) * 20 / 100
        } else if (v9 < 90) {
            let v18 = WinStatus{
                status  : 1,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v18);
            0x2::balance::value<T0>(&v6) * 10 / 100
        } else if (v9 < 100) {
            let v19 = WinStatus{
                status  : 1,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v19);
            0x2::balance::value<T0>(&v6) * 0 / 100
        } else {
            let v20 = WinStatus{
                status  : 1,
                game_id : arg0,
            };
            0x2::event::emit<WinStatus>(v20);
            0
        };
        0x2::balance::join<T0>(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::borrow_balance_mut<T0>(arg2), 0x2::balance::split<T0>(&mut v6, v10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), v3);
    }

    public fun game_exists<T0>(arg0: &0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::GamePool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::borrow<T0>(arg0), arg1)
    }

    public fun hash_to_u8(arg0: &vector<u8>) : u8 {
        ((0x2::address::to_u256(0x2::address::from_bytes(0x2::hash::blake2b256(arg0))) % 100) as u8)
    }

    fun internal_start_game<T0>(arg0: &mut 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::counter_nft::Counter, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::GamePool<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 <= 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::max_betting<T0>(arg2), 1);
        assert!(v0 >= 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::min_betting<T0>(arg2), 0);
        assert!(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::balance<T0>(arg2) >= v0, 3);
        let v1 = 0x2::balance::split<T0>(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::borrow_balance_mut<T0>(arg2), v0);
        0x2::coin::put<T0>(&mut v1, arg1);
        let v2 = 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::counter_nft::get_vrf_input_and_increment(arg0);
        let v3 = 0x2::object::new(arg3);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Game<T0>{
            id               : v3,
            bet_placed_epoch : 0x2::tx_context::epoch(arg3),
            total_betting    : v1,
            player           : 0x2::tx_context::sender(arg3),
            vrf_input        : v2,
        };
        let v6 = NewGame{
            game_id      : v4,
            player       : 0x2::tx_context::sender(arg3),
            vrf_input    : v2,
            user_betting : v0,
        };
        0x2::event::emit<NewGame>(v6);
        (v4, v5)
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public fun start_game<T0>(arg0: &mut 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::counter_nft::Counter, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::GamePool<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = internal_start_game<T0>(arg0, arg1, arg2, arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data::borrow_mut<T0>(arg2), v0, v1);
        v0
    }

    public fun vrf_input<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.vrf_input
    }

    // decompiled from Move bytecode v6
}

