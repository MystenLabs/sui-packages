module 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::example_client {
    struct Ticker has key {
        id: 0x2::object::UID,
        ticks: u64,
    }

    public fun execute(arg0: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg1: 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::PerformTicket, arg2: &mut Ticker, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg4);
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::roll_deadline(arg0, &arg1, 0x2::clock::timestamp_ms(arg3) + 0x2::bcs::peel_u64(&mut v0));
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::consume_ticket(arg0, arg1);
        arg2.ticks = arg2.ticks + 1;
    }

    public fun new_ticker(arg0: &mut 0x2::tx_context::TxContext) : Ticker {
        Ticker{
            id    : 0x2::object::new(arg0),
            ticks : 0,
        }
    }

    public fun share_ticker(arg0: Ticker) {
        0x2::transfer::share_object<Ticker>(arg0);
    }

    public fun ticks(arg0: &Ticker) : u64 {
        arg0.ticks
    }

    // decompiled from Move bytecode v7
}

