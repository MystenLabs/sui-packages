module 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::context {
    struct PiggyBankContext has copy, drop, store {
        stake: u64,
        win: u64,
        current_position: u8,
        status: 0x1::string::String,
    }

    public(friend) fun empty() : PiggyBankContext {
        PiggyBankContext{
            stake            : 0,
            win              : 0,
            current_position : 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::empty_position(),
            status           : 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::new_status(),
        }
    }

    public(friend) fun advance_position(arg0: &mut PiggyBankContext) {
        if (arg0.current_position == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::empty_position()) {
            assert!(status(arg0) == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::initialized_status(), 1);
            arg0.current_position = 0;
            let v0 = 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_ongoing_status();
            assert_valid_state_transition(arg0, v0);
            arg0.status = v0;
        } else {
            assert!(status(arg0) == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_ongoing_status(), 1);
            arg0.current_position = arg0.current_position + 1;
        };
    }

    fun assert_valid_state_transition(arg0: &PiggyBankContext, arg1: 0x1::string::String) {
        if (arg0.status == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::new_status()) {
            assert!(arg1 == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::initialized_status(), 1);
        } else if (arg0.status == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::initialized_status()) {
            assert!(arg1 == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_ongoing_status() || arg1 == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_finished_status(), 1);
        } else if (arg0.status == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_ongoing_status()) {
            assert!(arg1 == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_ongoing_status() || arg1 == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_finished_status(), 1);
        } else {
            assert!(arg0.status == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_finished_status(), 1);
            assert!(arg1 == 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::initialized_status(), 1);
        };
    }

    public fun current_position(arg0: &PiggyBankContext) : u8 {
        arg0.current_position
    }

    public(friend) fun die(arg0: &mut PiggyBankContext) {
        let v0 = 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_finished_status();
        assert_valid_state_transition(arg0, v0);
        arg0.status = v0;
        arg0.win = 0;
    }

    public fun get_win(arg0: &PiggyBankContext) : u64 {
        arg0.win
    }

    public(friend) fun process_win(arg0: &mut PiggyBankContext, arg1: u64) {
        let v0 = 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::game_finished_status();
        assert_valid_state_transition(arg0, v0);
        arg0.status = v0;
        arg0.win = arg1;
    }

    public fun stake(arg0: &PiggyBankContext) : u64 {
        arg0.stake
    }

    public(friend) fun start_game(arg0: &mut PiggyBankContext, arg1: u64) {
        let v0 = 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::initialized_status();
        assert_valid_state_transition(arg0, v0);
        arg0.status = v0;
        arg0.stake = arg1;
        arg0.win = 0;
        arg0.current_position = 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants::empty_position();
    }

    public fun status(arg0: &PiggyBankContext) : 0x1::string::String {
        arg0.status
    }

    // decompiled from Move bytecode v6
}

