module 0x18ccd2df18a902eb1ffe14db42fd0cc7e250138bc8a4fc1387bf825c78f4f30e::plinko {
    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        game_type: u8,
        bet_size: u64,
        ball_count: u64,
    }

    struct BallOutcome has copy, drop, store {
        ball_index: u64,
        ball_path: vector<u8>,
    }

    struct Outcome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        pnl: u64,
        bet_size: u64,
        ball_count: u64,
        game_type: u8,
        results: vector<BallOutcome>,
        challenged: bool,
    }

    struct Plinko has copy, drop, store {
        dummy_field: bool,
    }

    struct Verifier has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        verifier_pub_key: vector<u8>,
        ball_count: u64,
        bet_size: u64,
        game_type: u8,
        seed: vector<u8>,
        start_epoch: u64,
        stake: 0x2::coin::Coin<T0>,
    }

    public entry fun challenge<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg0, arg1), 3);
        let Game {
            id               : v0,
            player           : v1,
            verifier_pub_key : _,
            ball_count       : v3,
            bet_size         : v4,
            game_type        : v5,
            seed             : _,
            start_epoch      : v7,
            stake            : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v9 = v8;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::epoch(arg2) > v7 + 3, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v1);
        let v10 = Outcome<T0>{
            game_id    : arg1,
            player     : v1,
            pnl        : 0x2::coin::value<T0>(&v9),
            bet_size   : v4,
            ball_count : v3,
            game_type  : v5,
            results    : 0x1::vector::empty<BallOutcome>(),
            challenged : true,
        };
        0x2::event::emit<Outcome<T0>>(v10);
    }

    public entry fun create_verifier(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Verifier{
            id      : 0x2::object::new(arg2),
            pub_key : arg1,
        };
        0x2::transfer::share_object<Verifier>(v0);
    }

    public fun game_exists<T0>(arg0: &Verifier, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    fun get_ball_roll_and_path(arg0: vector<u64>, arg1: vector<u8>) : (vector<u8>, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = b"";
        let v3 = 0x2::hash::blake2b256(&arg1);
        while (v0 < 0x1::vector::length<u64>(&arg0) - 1) {
            v0 = v0 + 1;
            let v4 = safe_selection(2, &v3);
            let v5 = &v3;
            v3 = 0x2::hash::blake2b256(v5);
            v1 = v1 + v4;
            0x1::vector::push_back<u8>(&mut v2, (v4 as u8));
        };
        (v2, v1)
    }

    fun get_plinko_config(arg0: u8) : vector<u64> {
        assert!(arg0 == 0 || arg0 == 1 || arg0 == 2, 0);
        if (arg0 == 0) {
            return vector[600, 135, 80, 50, 80, 135, 600]
        };
        if (arg0 == 1) {
            return vector[3000, 600, 150, 70, 40, 40, 70, 150, 600, 3000]
        };
        vector[10000, 1000, 300, 150, 100, 65, 40, 65, 100, 150, 300, 1000, 10000]
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 100) as u64)
    }

    public fun pub_key(arg0: &Verifier) : vector<u8> {
        arg0.pub_key
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public fun settle<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Verifier, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg1, arg2), 3);
        let Game {
            id               : v0,
            player           : v1,
            verifier_pub_key : v2,
            ball_count       : v3,
            bet_size         : v4,
            game_type        : v5,
            seed             : v6,
            start_epoch      : _,
            stake            : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg1.id, arg2);
        let v9 = v8;
        let v10 = v2;
        let v11 = v0;
        let v12 = 0x2::object::uid_to_bytes(&v11);
        0x1::vector::append<u8>(&mut v12, v6);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v10, &v12), 6);
        0x2::object::delete(v11);
        let v13 = 0x1::hash::sha2_256(arg3);
        let v14 = 0;
        let v15 = 0;
        let v16 = 0x1::vector::empty<BallOutcome>();
        while (v14 < v3) {
            v14 = v14 + 1;
            let v17 = get_plinko_config(v5);
            let (v18, v19) = get_ball_roll_and_path(v17, v13);
            v15 = v15 + mul(v4, *0x1::vector::borrow<u64>(&v17, v19));
            let v20 = BallOutcome{
                ball_index : v19,
                ball_path  : v18,
            };
            0x1::vector::push_back<BallOutcome>(&mut v16, v20);
            v13 = 0x1::hash::sha2_256(v13);
        };
        let v21 = Plinko{dummy_field: false};
        0x2::coin::value<T0>(&v9);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, Plinko>(v21, arg0, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::take<T0, Plinko>(v21, arg0, v15, arg4), v1);
        let v22 = Outcome<T0>{
            game_id    : arg2,
            player     : v1,
            pnl        : v15,
            bet_size   : v4,
            ball_count : v3,
            game_type  : v5,
            results    : v16,
            challenged : false,
        };
        0x2::event::emit<Outcome<T0>>(v22);
    }

    public fun start_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Verifier, arg2: u64, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, Plinko>) {
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(v0 == arg2 * arg3, 2);
        assert!(0x1::vector::length<u8>(&arg5) >= 32, 4);
        let v1 = Plinko{dummy_field: false};
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::add_volume<T0, Plinko>(v1, arg0, v0, arg7);
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg7);
        let v5 = Game<T0>{
            id               : v2,
            player           : v4,
            verifier_pub_key : pub_key(arg1),
            ball_count       : arg2,
            bet_size         : arg3,
            game_type        : arg4,
            seed             : arg5,
            start_epoch      : 0x2::tx_context::epoch(arg7),
            stake            : arg6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg1.id, v3, v5);
        let v6 = NewGame<T0>{
            game_id    : v3,
            player     : v4,
            game_type  : arg4,
            bet_size   : arg3,
            ball_count : arg2,
        };
        0x2::event::emit<NewGame<T0>>(v6);
        (v3, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, Plinko>(v1, arg0, arg3 * arg2))
    }

    public entry fun update_pub_key(arg0: &AdminCap, arg1: &mut Verifier, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

