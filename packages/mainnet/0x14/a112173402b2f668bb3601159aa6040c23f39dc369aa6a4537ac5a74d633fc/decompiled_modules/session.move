module 0x14a112173402b2f668bb3601159aa6040c23f39dc369aa6a4537ac5a74d633fc::session {
    struct Session<phantom T0> {
        principal: u64,
        min_profit: u64,
    }

    struct ProfitEvent has copy, drop {
        sender: address,
        principal: u64,
        out: u64,
        profit: u64,
    }

    public fun finish<T0>(arg0: &0x2::coin::Coin<T0>, arg1: Session<T0>, arg2: &0x2::tx_context::TxContext) {
        let Session {
            principal  : v0,
            min_profit : v1,
        } = arg1;
        let v2 = 0x2::coin::value<T0>(arg0);
        assert!(v2 >= v0 + v1, 0);
        let v3 = ProfitEvent{
            sender    : 0x2::tx_context::sender(arg2),
            principal : v0,
            out       : v2,
            profit    : v2 - v0,
        };
        0x2::event::emit<ProfitEvent>(v3);
    }

    public fun min_profit<T0>(arg0: &Session<T0>) : u64 {
        arg0.min_profit
    }

    public fun principal<T0>(arg0: &Session<T0>) : u64 {
        arg0.principal
    }

    public fun start<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : Session<T0> {
        Session<T0>{
            principal  : 0x2::coin::value<T0>(arg0),
            min_profit : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

