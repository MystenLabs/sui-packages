module 0xf0eeb7971ea706b7b5877b591be081e7cda08d11649b02bc05c19fab8b8cb158::DiceGame {
    struct GameRecord has copy, drop {
        user_input: u64,
        real_number: u64,
        win: bool,
    }

    public entry fun play(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ((0x2::tx_context::epoch_timestamp_ms(arg1) % 6) as u64);
        let v1 = GameRecord{
            user_input  : arg0,
            real_number : v0,
            win         : v0 == arg0,
        };
        0x2::event::emit<GameRecord>(v1);
    }

    // decompiled from Move bytecode v6
}

