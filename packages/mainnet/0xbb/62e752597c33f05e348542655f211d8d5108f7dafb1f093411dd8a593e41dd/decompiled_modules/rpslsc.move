module 0xbb62e752597c33f05e348542655f211d8d5108f7dafb1f093411dd8a593e41dd::rpslsc {
    struct RPSLSC has drop {
        dummy_field: bool,
    }

    struct GameParticipant has store, key {
        id: 0x2::object::UID,
        game_addy: address,
    }

    struct RPS_Game has key {
        id: 0x2::object::UID,
        status: u8,
        games: u8,
        shoot1: vector<u8>,
        shoot2: u8,
        who_shoots_first: u8,
        proved_first_shoot: u8,
        player1: address,
        player2: address,
        wins1: u8,
        wins2: u8,
        playTo: u8,
        ties: u8,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RPSLSC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RPSLSC>>(0x2::coin::mint<RPSLSC>(arg0, arg1, arg3), arg2);
    }

    public fun byte_to_hex(arg0: u8) : vector<u8> {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((arg0 >> 4 & 15) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((arg0 & 15) as u64)));
        v1
    }

    public fun bytes_to_hex(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, byte_to_hex(*0x1::vector::borrow<u8>(&arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun check_for_win(arg0: &mut RPS_Game) {
        let v0 = arg0.proved_first_shoot;
        let v1 = arg0.shoot2;
        if (v0 != 0 && v1 != 0) {
            if (v0 != v1) {
                if (arg0.who_shoots_first == 1 && (v0 == 1 && v1 == 3 || v0 == 2 && v1 == 1 || v0 == 3 && v1 == 2) || arg0.who_shoots_first == 2 && (v0 == 3 && v1 == 1 || v0 == 1 && v1 == 2 || v0 == 2 && v1 == 3)) {
                    arg0.wins1 = arg0.wins1 + 1;
                } else {
                    arg0.wins2 = arg0.wins2 + 1;
                };
            } else {
                arg0.ties = arg0.ties + 1;
            };
            arg0.shoot1 = b"";
            arg0.shoot2 = 0;
            arg0.status = 0;
            if (arg0.who_shoots_first == 1) {
                arg0.who_shoots_first = 2;
            } else {
                arg0.who_shoots_first = 1;
            };
            arg0.games = arg0.games + 1;
        };
    }

    public fun create_game_participant(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : GameParticipant {
        GameParticipant{
            id        : 0x2::object::new(arg1),
            game_addy : arg0,
        }
    }

    public fun create_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(arg0))
    }

    public fun do_1st_shoot(arg0: &mut RPS_Game, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        if (arg0.player1 == 0x2::tx_context::sender(arg2) && arg0.who_shoots_first == 1 || arg0.player2 == 0x2::tx_context::sender(arg2) && arg0.who_shoots_first == 2) {
            arg0.shoot1 = arg1;
            arg0.status = 1;
        };
    }

    public fun do_2nd_shoot(arg0: &mut RPS_Game, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 4 && arg1 > 0 && arg0.status == 1, 0);
        if (arg0.who_shoots_first == 1 && arg0.player2 == 0x2::tx_context::sender(arg2) || arg0.who_shoots_first == 2 && arg0.player1 == 0x2::tx_context::sender(arg2)) {
            arg0.shoot2 = arg1;
            arg0.status = 2;
        };
    }

    public fun hard_reset(arg0: &mut RPS_Game, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.shoot1 = b"";
        arg0.shoot2 = 0;
        arg0.who_shoots_first = 1;
        arg0.proved_first_shoot = 0;
        arg0.status = 0;
    }

    fun init(arg0: RPSLSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPSLSC>(arg0, 6, b"RPSLSC", b"Rock Paper Scissors Lizard Spock Coin", b"Play to earn!", 0x1::option::some<0x2::url::Url>(create_url(b"https://i0.wp.com/puzzlewocky.com/wp-content/uploads/2016/10/RockPaperScissorsLizardSpock.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RPSLSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPSLSC>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun new_game(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = RPS_Game{
            id                 : v0,
            status             : 0,
            games              : 0,
            shoot1             : b"",
            shoot2             : 0,
            who_shoots_first   : 1,
            proved_first_shoot : 0,
            player1            : arg0,
            player2            : arg1,
            wins1              : 0,
            wins2              : 0,
            playTo             : 0,
            ties               : 0,
        };
        0x2::transfer::share_object<RPS_Game>(v2);
        let v3 = create_game_participant(v1, arg2);
        0x2::transfer::transfer<GameParticipant>(v3, arg0);
        0x2::transfer::transfer<GameParticipant>(create_game_participant(v1, arg2), arg1);
    }

    public fun prove_1st_shoot(arg0: u8, arg1: &mut RPS_Game, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 4 && arg0 > 0 && arg1.status == 2, 0);
        0x1::vector::push_back<u8>(&mut arg2, arg0 + 48);
        assert!(sha256_to_hex(arg2) == arg1.shoot1, 0);
        arg1.proved_first_shoot = arg0;
        check_for_win(arg1);
    }

    public fun sha256_to_hex(arg0: vector<u8>) : vector<u8> {
        bytes_to_hex(0x1::hash::sha2_256(arg0))
    }

    public fun wins1(arg0: &RPS_Game) : u8 {
        arg0.wins1
    }

    public fun wins2(arg0: &RPS_Game) : u8 {
        arg0.wins2
    }

    // decompiled from Move bytecode v6
}

