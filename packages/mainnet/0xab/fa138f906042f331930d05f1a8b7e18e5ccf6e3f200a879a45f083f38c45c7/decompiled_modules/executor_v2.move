module 0xa41de88b4f32d5d81456dc6b31d12d2bfc0703e0386b903f328b43226d501d15::executor_v2 {
    struct ArbTicketV2<phantom T0> {
        principal: u64,
        min_profit: u64,
    }

    struct ProfitRealized has copy, drop {
        principal: u64,
        out_value: u64,
        profit: u64,
    }

    public fun close<T0>(arg0: ArbTicketV2<T0>, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        let ArbTicketV2 {
            principal  : v0,
            min_profit : v1,
        } = arg0;
        assert!(0x2::coin::value<T0>(&arg1) >= v0 + v1, 1);
        arg1
    }

    public fun close_and_sweep_logged<T0>(arg0: ArbTicketV2<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(close_logged<T0>(arg0, arg1), arg2);
    }

    public fun close_logged<T0>(arg0: ArbTicketV2<T0>, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        let ArbTicketV2 {
            principal  : v0,
            min_profit : v1,
        } = arg0;
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v0 + v1, 1);
        let v3 = ProfitRealized{
            principal : v0,
            out_value : v2,
            profit    : v2 - v0,
        };
        0x2::event::emit<ProfitRealized>(v3);
        arg1
    }

    public fun close_with_deadline<T0>(arg0: ArbTicketV2<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg3, 7);
        close_logged<T0>(arg0, arg1)
    }

    public fun min_out<T0>(arg0: &ArbTicketV2<T0>) : u64 {
        arg0.principal + arg0.min_profit
    }

    public fun open<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : (0x2::coin::Coin<T0>, ArbTicketV2<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 6);
        let v1 = ArbTicketV2<T0>{
            principal  : v0,
            min_profit : arg1,
        };
        (arg0, v1)
    }

    public fun principal<T0>(arg0: &ArbTicketV2<T0>) : u64 {
        arg0.principal
    }

    // decompiled from Move bytecode v7
}

