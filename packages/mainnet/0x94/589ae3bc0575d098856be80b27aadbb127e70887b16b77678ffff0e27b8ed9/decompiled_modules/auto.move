module 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::auto {
    struct AutoOrder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        pay: 0x2::balance::Balance<T0>,
        pay_total: u64,
        min_out_total: u64,
        kind: u8,
        trigger_out: u64,
        trail_bps: u64,
        chunk: u64,
        interval_ms: u64,
        next_ms: u64,
        filled_in: u64,
        filled_out: u64,
        fee_on_pay: bool,
        created_ms: u64,
        expires_ms: u64,
    }

    struct AutoFill<phantom T0, phantom T1> {
        order: 0x2::object::ID,
        amount_in: u64,
        fee_in: u64,
        required_out: u64,
    }

    struct AutoPlaced has copy, drop {
        order: 0x2::object::ID,
        owner: address,
        pay: 0x1::ascii::String,
        target: 0x1::ascii::String,
        kind: u8,
        pay_total: u64,
        min_out_total: u64,
        trigger_out: u64,
        trail_bps: u64,
        chunk: u64,
        interval_ms: u64,
        fee_on_pay: bool,
        expires_ms: u64,
    }

    struct AutoFilled has copy, drop {
        order: 0x2::object::ID,
        filler: address,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        fee_on_pay: bool,
        pay_left: u64,
        next_ms: u64,
    }

    struct AutoClosed has copy, drop {
        order: 0x2::object::ID,
        owner: address,
        reason: u8,
        pay_returned: u64,
    }

    public fun destroy_empty<T0, T1>(arg0: AutoOrder<T0, T1>) {
        assert!(0x2::balance::value<T0>(&arg0.pay) == 0, 310);
        let AutoOrder {
            id            : v0,
            owner         : _,
            pay           : v2,
            pay_total     : _,
            min_out_total : _,
            kind          : _,
            trigger_out   : _,
            trail_bps     : _,
            chunk         : _,
            interval_ms   : _,
            next_ms       : _,
            filled_in     : _,
            filled_out    : _,
            fee_on_pay    : _,
            created_ms    : _,
            expires_ms    : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun cancel<T0, T1>(arg0: AutoOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 307);
        close<T0, T1>(arg0, 1, arg1)
    }

    fun check_place<T0, T1>(arg0: &0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : bool {
        0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::assert_open(arg0);
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 301);
        assert!(arg1 > 0, 302);
        assert!(arg2 > 0, 311);
        let (v0, v1) = 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::base_min<T0>(arg0);
        let (v2, v3) = 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::base_min<T1>(arg0);
        if (v0) {
            assert!(arg3 >= v1, 302);
        } else if (v2) {
            assert!(0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::math::mul_div(arg3, arg2, arg1) >= v3, 302);
        };
        let v4 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > v4 && arg4 - v4 <= 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::max_order_ms(arg0), 303);
        v0
    }

    public fun chunk<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.chunk
    }

    fun close<T0, T1>(arg0: AutoOrder<T0, T1>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let AutoOrder {
            id            : v0,
            owner         : v1,
            pay           : v2,
            pay_total     : _,
            min_out_total : _,
            kind          : _,
            trigger_out   : _,
            trail_bps     : _,
            chunk         : _,
            interval_ms   : _,
            next_ms       : _,
            filled_in     : _,
            filled_out    : _,
            fee_on_pay    : _,
            created_ms    : _,
            expires_ms    : _,
        } = arg0;
        let v16 = v2;
        let v17 = v0;
        if (0x2::balance::value<T0>(&v16) > 0) {
            let v18 = AutoClosed{
                order        : 0x2::object::uid_to_inner(&v17),
                owner        : v1,
                reason       : arg1,
                pay_returned : 0x2::balance::value<T0>(&v16),
            };
            0x2::event::emit<AutoClosed>(v18);
        };
        0x2::object::delete(v17);
        0x2::coin::from_balance<T0>(v16, arg2)
    }

    public fun close_expired<T0, T1>(arg0: AutoOrder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 306);
        let v0 = close<T0, T1>(arg0, 2, arg2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.owner);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public fun expires_ms<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun fee_on_pay<T0, T1>(arg0: &AutoOrder<T0, T1>) : bool {
        arg0.fee_on_pay
    }

    public fun fill_amount_in<T0, T1>(arg0: &AutoFill<T0, T1>) : u64 {
        arg0.amount_in
    }

    public fun fill_required_out<T0, T1>(arg0: &AutoFill<T0, T1>) : u64 {
        arg0.required_out
    }

    public fun filled_in<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.filled_in
    }

    public fun filled_out<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.filled_out
    }

    public fun interval_ms<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.interval_ms
    }

    public fun kind<T0, T1>(arg0: &AutoOrder<T0, T1>) : u8 {
        arg0.kind
    }

    public fun max_trail_bps() : u64 {
        5000
    }

    public fun min_interval_ms() : u64 {
        300000
    }

    public fun min_out_total<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.min_out_total
    }

    fun new_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = AutoOrder<T0, T1>{
            id            : 0x2::object::new(arg10),
            owner         : 0x2::tx_context::sender(arg10),
            pay           : 0x2::coin::into_balance<T0>(arg0),
            pay_total     : v1,
            min_out_total : arg1,
            kind          : arg2,
            trigger_out   : arg3,
            trail_bps     : arg4,
            chunk         : arg5,
            interval_ms   : arg6,
            next_ms       : v0,
            filled_in     : 0,
            filled_out    : 0,
            fee_on_pay    : arg7,
            created_ms    : v0,
            expires_ms    : arg8,
        };
        let v3 = 0x2::object::id<AutoOrder<T0, T1>>(&v2);
        let v4 = AutoPlaced{
            order         : v3,
            owner         : v2.owner,
            pay           : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            target        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            kind          : arg2,
            pay_total     : v1,
            min_out_total : arg1,
            trigger_out   : arg3,
            trail_bps     : arg4,
            chunk         : arg5,
            interval_ms   : arg6,
            fee_on_pay    : arg7,
            expires_ms    : arg8,
        };
        0x2::event::emit<AutoPlaced>(v4);
        0x2::transfer::share_object<AutoOrder<T0, T1>>(v2);
        v3
    }

    public fun next_ms<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.next_ms
    }

    public fun owner<T0, T1>(arg0: &AutoOrder<T0, T1>) : address {
        arg0.owner
    }

    public fun pay_left<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.pay)
    }

    public fun pay_total<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.pay_total
    }

    public fun place_dca<T0, T1>(arg0: &0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg3 > 0 && arg3 <= v0, 315);
        assert!(arg4 >= 300000, 316);
        new_order<T0, T1>(arg1, arg2, 2, 0, 0, arg3, arg4, check_place<T0, T1>(arg0, v0, arg2, arg3, arg5, arg6), arg5, arg6, arg7)
    }

    public fun place_stop<T0, T1>(arg0: &0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = if (arg4 > 0) {
            assert!(arg4 <= 5000, 314);
            1
        } else {
            assert!(arg3 >= arg2, 313);
            0
        };
        let v2 = if (v1 == 1) {
            0
        } else {
            arg3
        };
        new_order<T0, T1>(arg1, arg2, v1, v2, arg4, 0, 0, check_place<T0, T1>(arg0, v0, arg2, v0, arg5, arg6), arg5, arg6, arg7)
    }

    public fun settle<T0, T1>(arg0: &0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::Config, arg1: &mut AutoOrder<T0, T1>, arg2: AutoFill<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::assert_version(arg0);
        let AutoFill {
            order        : v0,
            amount_in    : v1,
            fee_in       : v2,
            required_out : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<AutoOrder<T0, T1>>(arg1), 308);
        let v4 = if (arg1.fee_on_pay) {
            0
        } else {
            0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::fee_on(arg0, 0x2::coin::value<T1>(&arg3))
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v4, arg4), 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::fee_recipient(arg0));
        };
        let v5 = 0x2::coin::value<T1>(&arg3);
        assert!(v5 >= v3, 309);
        arg1.filled_out = arg1.filled_out + v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg1.owner);
        let v6 = 0x2::balance::value<T0>(&arg1.pay);
        let v7 = AutoFilled{
            order      : v0,
            filler     : 0x2::tx_context::sender(arg4),
            amount_in  : v1,
            amount_out : v5,
            fee        : v2 + v4,
            fee_on_pay : arg1.fee_on_pay,
            pay_left   : v6,
            next_ms    : arg1.next_ms,
        };
        0x2::event::emit<AutoFilled>(v7);
        if (v6 == 0) {
            let v8 = AutoClosed{
                order        : v0,
                owner        : arg1.owner,
                reason       : 0,
                pay_returned : 0,
            };
            0x2::event::emit<AutoClosed>(v8);
        };
    }

    public fun take<T0, T1>(arg0: &0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::Config, arg1: &mut AutoOrder<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, AutoFill<T0, T1>) {
        0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::assert_open(arg0);
        assert!(0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::is_keeper(arg0, 0x2::tx_context::sender(arg4)), 312);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg1.expires_ms, 305);
        if (arg1.kind == 2) {
            assert!(v0 >= arg1.next_ms, 317);
            assert!(arg2 == 0x1::u64::min(arg1.chunk, 0x2::balance::value<T0>(&arg1.pay)), 304);
            arg1.next_ms = v0 + arg1.interval_ms;
        } else {
            assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T0>(&arg1.pay), 304);
        };
        arg1.filled_in = arg1.filled_in + arg2;
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pay, arg2), arg4);
        let v2 = if (arg1.fee_on_pay) {
            0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::fee_on(arg0, arg2)
        } else {
            0
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v2, arg4), 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::config::fee_recipient(arg0));
        };
        let v3 = AutoFill<T0, T1>{
            order        : 0x2::object::id<AutoOrder<T0, T1>>(arg1),
            amount_in    : arg2,
            fee_in       : v2,
            required_out : 0x94589ae3bc0575d098856be80b27aadbb127e70887b16b77678ffff0e27b8ed9::math::mul_div_up(arg2, arg1.min_out_total, arg1.pay_total),
        };
        (v1, v3)
    }

    public fun trail_bps<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.trail_bps
    }

    public fun trigger_out<T0, T1>(arg0: &AutoOrder<T0, T1>) : u64 {
        arg0.trigger_out
    }

    // decompiled from Move bytecode v7
}

