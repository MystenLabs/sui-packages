module 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::tower {
    struct GameStarted<phantom T0> has copy, drop {
        player: address,
        difficulty: 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty,
        bet: u64,
    }

    struct GameEnded<phantom T0> has copy, drop {
        player: address,
        difficulty: 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty,
        bet: u64,
        bonus: u64,
    }

    public fun end<T0>(arg0: &mut 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::Game<T0>, arg1: 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::GameState<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::Randomness {
        let v0 = GameEnded<T0>{
            player     : 0x2::tx_context::sender(arg4),
            difficulty : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::difficulty<T0>(&arg1),
            bet        : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::bet<T0>(&arg1),
            bonus      : arg2,
        };
        0x2::event::emit<GameEnded<T0>>(v0);
        let v1 = 0x2::address::to_bytes(0x2::tx_context::sender(arg4));
        let v2 = &mut v1;
        0x1::vector::append<u8>(v2, 0x2::object::id_to_bytes(0x2::object::borrow_id<0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::GameState<T0>>(&arg1)));
        0x1::vector::append<u8>(v2, 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::u64_to_bytes(arg2));
        let v3 = 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::delete<T0>(arg1);
        0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::verify_used(&mut v3, v2, &arg3);
        if (arg2 > 0) {
            0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::send_bonus<T0>(arg0, arg2, arg4);
        };
        v3
    }

    public fun start<T0>(arg0: &mut 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::Game<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::Randomness, arg4: &mut 0x2::tx_context::TxContext) : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::GameState<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::min_bet<T0>(arg0), 101);
        assert!(v1 <= 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::max_bet<T0>(arg0), 102);
        0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::incr_balance<T0>(arg0, v0);
        let v2 = 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::reward_value<T0>(arg0, v1);
        let v3 = 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::new<T0>(arg0, arg1, v1, v2, arg3, arg4);
        0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::send_reward<T0>(arg0, v2, arg4);
        let v4 = GameStarted<T0>{
            player     : 0x2::tx_context::sender(arg4),
            difficulty : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::difficulty<T0>(&v3),
            bet        : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state::bet<T0>(&v3),
        };
        0x2::event::emit<GameStarted<T0>>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

