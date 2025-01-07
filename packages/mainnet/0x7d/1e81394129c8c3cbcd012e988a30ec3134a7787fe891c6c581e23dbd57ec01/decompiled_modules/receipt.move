module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt {
    struct GameReceipt<phantom T0, phantom T1: drop> has drop {
        bet_size: u64,
        is_pass_recorded: bool,
    }

    public fun consume_receipt_and_return<T0, T1: drop>(arg0: GameReceipt<T0, T1>) : (u64, bool) {
        let GameReceipt {
            bet_size         : v0,
            is_pass_recorded : v1,
        } = arg0;
        (v0, v1)
    }

    public fun game_receipt_bet_size<T0, T1: drop>(arg0: &GameReceipt<T0, T1>) : u64 {
        arg0.bet_size
    }

    public fun is_pass_recorded<T0, T1: drop>(arg0: &mut GameReceipt<T0, T1>) : bool {
        arg0.is_pass_recorded
    }

    public(friend) fun new_receipt<T0, T1: drop>(arg0: u64) : GameReceipt<T0, T1> {
        GameReceipt<T0, T1>{
            bet_size         : arg0,
            is_pass_recorded : false,
        }
    }

    public fun set_pass_recorded_true<T0, T1: drop>(arg0: &mut GameReceipt<T0, T1>) {
        arg0.is_pass_recorded = true;
    }

    // decompiled from Move bytecode v6
}

