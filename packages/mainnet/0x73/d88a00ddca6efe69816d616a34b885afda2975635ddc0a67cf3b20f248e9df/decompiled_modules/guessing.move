module 0x73d88a00ddca6efe69816d616a34b885afda2975635ddc0a67cf3b20f248e9df::guessing {
    struct GameRecord has copy, drop {
        user_input: u64,
        real_number: u64,
        win: bool,
    }

    public fun play(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ((0x2::tx_context::epoch_timestamp_ms(arg1) % 255) as u64);
        let v1 = GameRecord{
            user_input  : arg0,
            real_number : v0,
            win         : v0 == arg0,
        };
        0x2::event::emit<GameRecord>(v1);
    }

    // decompiled from Move bytecode v6
}

