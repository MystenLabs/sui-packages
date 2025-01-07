module 0x876e82ed5892b96e0b6ae8009d4f16b190fa2dd29a923539f4ed881f60601a4e::reward {
    struct Reward<phantom T0> has store {
        winner: u64,
        reward_amount: u64,
        reward: 0x2::balance::Balance<T0>,
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>) : Reward<T0> {
        Reward<T0>{
            winner        : 0,
            reward_amount : 0x2::balance::value<T0>(&arg0),
            reward        : arg0,
        }
    }

    public fun reward_amount<T0>(arg0: &Reward<T0>) : u64 {
        arg0.reward_amount
    }

    public fun set_winner<T0>(arg0: &mut Reward<T0>, arg1: u64) {
        arg0.winner = arg1;
    }

    public fun take_reward<T0>(arg0: &mut Reward<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.reward)
    }

    public fun winner<T0>(arg0: &Reward<T0>) : u64 {
        arg0.winner
    }

    // decompiled from Move bytecode v6
}

