module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::rock_paper_scissors {
    struct ThePrize has store, key {
        id: 0x2::object::UID,
    }

    struct Game has key {
        id: 0x2::object::UID,
        prize: ThePrize,
        player_one: address,
        player_two: address,
        hash_one: vector<u8>,
        hash_two: vector<u8>,
        gesture_one: u8,
        gesture_two: u8,
    }

    struct PlayerTurn has key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        player: address,
    }

    struct Secret has key {
        id: 0x2::object::UID,
        salt: vector<u8>,
        player: address,
    }

    fun hash(arg0: u8, arg1: vector<u8>) : vector<u8> {
        0x1::vector::push_back<u8>(&mut arg1, arg0);
        0x1::hash::sha2_256(arg1)
    }

    public entry fun add_hash(arg0: &mut Game, arg1: PlayerTurn) {
        let PlayerTurn {
            id     : v0,
            hash   : v1,
            player : v2,
        } = arg1;
        let v3 = status(arg0);
        assert!(v3 == 1 || v3 == 0, 0);
        assert!(arg0.player_one == v2 || arg0.player_two == v2, 0);
        if (v2 == arg0.player_one && 0x1::vector::length<u8>(&arg0.hash_one) == 0) {
            arg0.hash_one = v1;
        } else {
            assert!(v2 == arg0.player_two && 0x1::vector::length<u8>(&arg0.hash_two) == 0, 0);
            arg0.hash_two = v1;
        };
        0x2::object::delete(v0);
    }

    fun find_gesture(arg0: vector<u8>, arg1: &vector<u8>) : u8 {
        if (hash(1, arg0) == *arg1) {
            1
        } else if (hash(2, arg0) == *arg1) {
            2
        } else if (hash(3, arg0) == *arg1) {
            3
        } else {
            111
        }
    }

    public entry fun match_secret(arg0: &mut Game, arg1: Secret) {
        let Secret {
            id     : v0,
            salt   : v1,
            player : v2,
        } = arg1;
        assert!(v2 == arg0.player_one || v2 == arg0.player_two, 0);
        if (v2 == arg0.player_one) {
            arg0.gesture_one = find_gesture(v1, &arg0.hash_one);
        } else if (v2 == arg0.player_two) {
            arg0.gesture_two = find_gesture(v1, &arg0.hash_two);
        };
        0x2::object::delete(v0);
    }

    public entry fun new_game(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ThePrize{id: 0x2::object::new(arg2)};
        let v1 = Game{
            id          : 0x2::object::new(arg2),
            prize       : v0,
            player_one  : arg0,
            player_two  : arg1,
            hash_one    : b"",
            hash_two    : b"",
            gesture_one : 0,
            gesture_two : 0,
        };
        0x2::transfer::transfer<Game>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun paper() : u8 {
        2
    }

    fun play(arg0: u8, arg1: u8) : bool {
        arg0 == 1 && arg1 == 3 || arg0 == 2 && arg1 == 1 || arg0 == 3 && arg1 == 2 || arg0 != 111 && arg1 == 111
    }

    public entry fun player_turn(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerTurn{
            id     : 0x2::object::new(arg2),
            hash   : arg1,
            player : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<PlayerTurn>(v0, arg0);
    }

    public entry fun reveal(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Secret{
            id     : 0x2::object::new(arg2),
            salt   : arg1,
            player : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<Secret>(v0, arg0);
    }

    public fun rock() : u8 {
        1
    }

    public fun scissors() : u8 {
        3
    }

    public entry fun select_winner(arg0: Game, arg1: &0x2::tx_context::TxContext) {
        assert!(status(&arg0) == 4, 0);
        let Game {
            id          : v0,
            prize       : v1,
            player_one  : v2,
            player_two  : v3,
            hash_one    : _,
            hash_two    : _,
            gesture_one : v6,
            gesture_two : v7,
        } = arg0;
        0x2::object::delete(v0);
        if (play(v6, v7)) {
            0x2::transfer::public_transfer<ThePrize>(v1, v2);
        } else if (play(v7, v6)) {
            0x2::transfer::public_transfer<ThePrize>(v1, v3);
        } else {
            0x2::transfer::public_transfer<ThePrize>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    public fun status(arg0: &Game) : u8 {
        let v0 = 0x1::vector::length<u8>(&arg0.hash_one);
        let v1 = 0x1::vector::length<u8>(&arg0.hash_two);
        if (arg0.gesture_one != 0 && arg0.gesture_two != 0) {
            4
        } else if (arg0.gesture_one != 0 || arg0.gesture_two != 0) {
            3
        } else if (v0 == 0 && v1 == 0) {
            0
        } else if (v0 != 0 && v1 != 0) {
            2
        } else if (v0 != 0 || v1 != 0) {
            1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

