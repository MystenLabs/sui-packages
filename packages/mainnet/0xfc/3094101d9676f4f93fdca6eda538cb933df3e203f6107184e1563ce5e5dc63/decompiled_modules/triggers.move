module 0xfc3094101d9676f4f93fdca6eda538cb933df3e203f6107184e1563ce5e5dc63::triggers {
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

    fun emit_set<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg1: u64, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: address) {
        let v0 = TriggerLevelsSetEvent{
            account  : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg0),
            position : arg1,
            tp       : arg2,
            sl       : arg3,
            revision : arg4,
            sender   : arg5,
        };
        let v1 = Event<TriggerLevelsSetEvent>{pos0: v0};
        0x2::event::emit<Event<TriggerLevelsSetEvent>>(v1);
    }

    public fun request_open_with_triggers<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::AccountCap, arg4: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: 0x1::option::Option<u128>, arg13: 0x1::option::Option<u128>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::order::request_open<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
        let v1 = TriggerLevelsCommitted{
            account    : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2),
            market     : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1),
            side       : arg7,
            request_id : v0,
            tp         : arg12,
            sl         : arg13,
        };
        let v2 = Event<TriggerLevelsCommitted>{pos0: v1};
        0x2::event::emit<Event<TriggerLevelsCommitted>>(v2);
        v0
    }

    public fun request_open_with_triggers_as_delegate<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: 0x1::option::Option<u128>, arg11: 0x1::option::Option<u128>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::order::request_open_as_delegate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
        let v1 = TriggerLevelsCommitted{
            account    : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2),
            market     : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1),
            side       : arg6,
            request_id : v0,
            tp         : arg10,
            sl         : arg11,
        };
        let v2 = Event<TriggerLevelsCommitted>{pos0: v1};
        0x2::event::emit<Event<TriggerLevelsCommitted>>(v2);
        v0
    }

    public fun set_trigger_levels<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::AccountCap, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: 0x1::option::Option<u128>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_cap<T0>(arg0, arg1);
        emit_set<T0>(arg0, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    public fun set_trigger_levels_as_delegate<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg1: u64, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5));
        emit_set<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

