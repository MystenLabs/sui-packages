module 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::chain {
    struct Chain has key {
        id: 0x2::object::UID,
        paused: bool,
        last_word: 0x1::string::String,
        word_histories: vector<WordHistory>,
    }

    struct WordHistory has store {
        word: 0x1::string::String,
        player_name: 0x1::string::String,
        timestamp: u64,
    }

    struct WordCreatedEvent has copy, drop {
        player: address,
        word: 0x1::string::String,
        points: u64,
    }

    public fun calculate_points(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (arg3) {
            (v0 * 5 + get_length_bonus(v0) + get_rare_letter_bonus(arg0) + get_daily_bonus(arg1) + arg2) * 2
        } else {
            v0 * 5 + get_length_bonus(v0) + get_rare_letter_bonus(arg0) + get_daily_bonus(arg1) + arg2
        }
    }

    public fun create_word(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player, arg1: &0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::config::Config, arg2: &mut Chain, arg3: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::PointManager, arg4: vector<0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>>, arg5: u8, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused, 0);
        let v0 = 0x2::tx_context::epoch(arg8);
        assert!(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::last_word_creation_epoch(arg0) < v0, 7);
        let v1 = b"";
        while (!0x1::vector::is_empty<0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>>(&arg4)) {
            let v2 = 0x2::transfer::public_receive<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::uid_mut(arg0), 0x1::vector::pop_back<0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>>(&mut arg4));
            0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::letter(&v2)));
            0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::drop(v2);
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>>(arg4);
        0x1::vector::reverse<u8>(&mut v1);
        assert!(0x1::vector::length<u8>(&v1) >= 3, 1);
        assert!(*0x1::vector::borrow<u8>(&v1, 0x1::vector::length<u8>(&v1) - 1) != 88, 2);
        let v3 = 0x1::string::into_bytes(arg2.last_word);
        assert!(*0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v3, 0x1::vector::length<u8>(&v3) - 1), 3);
        let v4 = 0x1::string::utf8(v1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<WordHistory>(&arg2.word_histories)) {
            assert!(0x1::vector::borrow<WordHistory>(&arg2.word_histories, v5).word != v4, 4);
            v5 = v5 + 1;
        };
        assert!(verify_word_signature(v1, arg5, 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::config::public_key(arg1), arg6), 6);
        arg2.last_word = v4;
        let v6 = WordHistory{
            word        : v4,
            player_name : 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::name(arg0),
            timestamp   : 0x2::clock::timestamp_ms(arg7),
        };
        0x1::vector::push_back<WordHistory>(&mut arg2.word_histories, v6);
        0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::set_last_word_creation_epoch(arg0, v0);
        let v7 = mint_points_for_word(arg3, v1, 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::update_consecutive_epochs(arg0, v0), (arg5 as u64), 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::point_getter(arg0), arg8);
        let v8 = WordCreatedEvent{
            player : 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0),
            word   : v4,
            points : 0x2::coin::value<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(&v7),
        };
        0x2::event::emit<WordCreatedEvent>(v8);
        0x2::balance::join<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::point_balance_mut(arg0), 0x2::coin::into_balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(v7));
    }

    fun get_daily_bonus(arg0: u64) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 <= 3) {
            5
        } else if (arg0 <= 10) {
            10
        } else {
            arg0 * 2
        }
    }

    fun get_length_bonus(arg0: u64) : u64 {
        if (arg0 == 7) {
            15
        } else if (arg0 == 8) {
            30
        } else if (arg0 >= 9) {
            45
        } else {
            0
        }
    }

    fun get_rare_letter_bonus(arg0: vector<u8>) : u64 {
        let v0 = 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::rare_letters();
        let v1 = 0;
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v2 = 0x1::vector::pop_back<u8>(&mut arg0);
            if (0x1::vector::contains<u8>(&v0, &v2)) {
                v1 = v1 + 50;
            };
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"GENESIS");
        let v1 = WordHistory{
            word        : v0,
            player_name : 0x1::string::utf8(b"admin"),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v2 = Chain{
            id             : 0x2::object::new(arg0),
            paused         : false,
            last_word      : v0,
            word_histories : 0x1::vector::singleton<WordHistory>(v1),
        };
        0x2::transfer::share_object<Chain>(v2);
    }

    fun mint_points_for_word(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::PointManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT> {
        0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::mint_points(arg0, calculate_points(arg1, arg2, arg3, arg4), arg5)
    }

    public fun set_pause(arg0: &0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::admin::AdminCap, arg1: &mut Chain, arg2: bool) {
        arg1.paused = arg2;
    }

    fun verify_word_signature(arg0: vector<u8>, arg1: u8, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::vector::singleton<u8>(arg1));
        0x2::ed25519::ed25519_verify(&arg3, &arg2, &v0)
    }

    // decompiled from Move bytecode v6
}

