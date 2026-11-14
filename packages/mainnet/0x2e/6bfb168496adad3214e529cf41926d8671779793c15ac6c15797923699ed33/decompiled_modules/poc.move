module 0xa8f990c6f30607011e255209423004f729f92b899ef10c6d94825170aa8ae9e8::poc {
    struct Event has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        token_per_share: u64,
    }

    struct EventMarket has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        resolved_yes: bool,
        win_balance: u64,
    }

    public fun new_event(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Event {
        Event{
            id              : 0x2::object::new(arg2),
            pool            : arg0,
            token_per_share : arg1,
        }
    }

    public fun new_event_from_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Event {
        Event{
            id              : 0x2::object::new(arg2),
            pool            : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            token_per_share : arg1,
        }
    }

    public fun new_market(arg0: &Event, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : EventMarket {
        EventMarket{
            id           : 0x2::object::new(arg2),
            event_id     : 0x2::object::id<Event>(arg0),
            resolved_yes : true,
            win_balance  : arg1,
        }
    }

    public fun pool_value(arg0: &Event) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    public fun withdraw_win_FIXED(arg0: &mut Event, arg1: &mut EventMarket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.resolved_yes, 1);
        assert!(arg1.event_id == 0x2::object::id<Event>(arg0), 99);
        arg1.win_balance = 0;
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.pool, arg0.token_per_share * arg1.win_balance, arg2)
    }

    public fun withdraw_win_VULN(arg0: &mut Event, arg1: &mut EventMarket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.resolved_yes, 1);
        arg1.win_balance = 0;
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.pool, arg0.token_per_share * arg1.win_balance, arg2)
    }

    // decompiled from Move bytecode v7
}

