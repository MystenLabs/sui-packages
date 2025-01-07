module 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::state {
    struct GameState<phantom T0> has store, key {
        id: 0x2::object::UID,
        difficulty: 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty,
        bet: u64,
        reward: u64,
        randomness: 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::Randomness,
    }

    public(friend) fun delete<T0>(arg0: GameState<T0>) : 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::Randomness {
        let GameState {
            id         : v0,
            difficulty : _,
            bet        : _,
            reward     : _,
            randomness : v4,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    public fun new<T0>(arg0: &0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::Game<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness::Randomness, arg5: &mut 0x2::tx_context::TxContext) : GameState<T0> {
        GameState<T0>{
            id         : 0x2::object::new(arg5),
            difficulty : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::difficulty<T0>(arg0, arg1),
            bet        : arg2,
            reward     : arg3,
            randomness : arg4,
        }
    }

    public fun transfer<T0>(arg0: GameState<T0>, arg1: address) {
        0x2::transfer::transfer<GameState<T0>>(arg0, arg1);
    }

    public fun difficulty<T0>(arg0: &GameState<T0>) : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty {
        arg0.difficulty
    }

    public fun bet<T0>(arg0: &GameState<T0>) : u64 {
        arg0.bet
    }

    // decompiled from Move bytecode v6
}

