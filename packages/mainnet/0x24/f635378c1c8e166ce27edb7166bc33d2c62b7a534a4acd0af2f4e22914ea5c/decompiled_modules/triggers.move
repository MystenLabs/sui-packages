module 0xd5f915a7e700e53bdb433830a063206d5636e01e7e19c3bcc3232a2b779ce551::triggers {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct TriggerLevelsCommitted has copy, drop {
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        side: bool,
        request_id: 0x2::object::ID,
        tp: 0x1::option::Option<u128>,
        sl: 0x1::option::Option<u128>,
    }

    struct TriggerLevelsSetEvent has copy, drop {
        account: 0x2::object::ID,
        position: u64,
        tp: 0x1::option::Option<u128>,
        sl: 0x1::option::Option<u128>,
        revision: u64,
        sender: address,
    }

    fun emit_set<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: u64, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: address) {
        let v0 = TriggerLevelsSetEvent{
            account  : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg0),
            position : arg1,
            tp       : arg2,
            sl       : arg3,
            revision : arg4,
            sender   : arg5,
        };
        let v1 = Event<TriggerLevelsSetEvent>{pos0: v0};
        0x2::event::emit<Event<TriggerLevelsSetEvent>>(v1);
    }

    public fun request_open_with_triggers<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: 0x1::option::Option<u128>, arg13: 0x1::option::Option<u128>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::order::request_open<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
        let v1 = TriggerLevelsCommitted{
            account    : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2),
            market     : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1),
            side       : arg7,
            request_id : v0,
            tp         : arg12,
            sl         : arg13,
        };
        let v2 = Event<TriggerLevelsCommitted>{pos0: v1};
        0x2::event::emit<Event<TriggerLevelsCommitted>>(v2);
        v0
    }

    public fun request_open_with_triggers_and_card<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: u16, arg13: 0x1::option::Option<u128>, arg14: 0x1::option::Option<u128>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::order::request_open_with_card<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        let v1 = TriggerLevelsCommitted{
            account    : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2),
            market     : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1),
            side       : arg7,
            request_id : v0,
            tp         : arg13,
            sl         : arg14,
        };
        let v2 = Event<TriggerLevelsCommitted>{pos0: v1};
        0x2::event::emit<Event<TriggerLevelsCommitted>>(v2);
        v0
    }

    public fun request_open_with_triggers_and_card_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: u16, arg11: 0x1::option::Option<u128>, arg12: 0x1::option::Option<u128>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::order::request_open_with_card_as_delegate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14);
        let v1 = TriggerLevelsCommitted{
            account    : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2),
            market     : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1),
            side       : arg6,
            request_id : v0,
            tp         : arg11,
            sl         : arg12,
        };
        let v2 = Event<TriggerLevelsCommitted>{pos0: v1};
        0x2::event::emit<Event<TriggerLevelsCommitted>>(v2);
        v0
    }

    public fun request_open_with_triggers_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: 0x1::option::Option<u128>, arg11: 0x1::option::Option<u128>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::order::request_open_as_delegate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
        let v1 = TriggerLevelsCommitted{
            account    : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2),
            market     : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1),
            side       : arg6,
            request_id : v0,
            tp         : arg10,
            sl         : arg11,
        };
        let v2 = Event<TriggerLevelsCommitted>{pos0: v1};
        0x2::event::emit<Event<TriggerLevelsCommitted>>(v2);
        v0
    }

    public fun set_trigger_levels<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: 0x1::option::Option<u128>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg0, arg1);
        emit_set<T0>(arg0, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    public fun set_trigger_levels_as_delegate<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: u64, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5));
        emit_set<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

