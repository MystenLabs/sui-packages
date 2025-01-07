module 0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca {
    struct DCA<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        delegatee: address,
        start_timestamp: u64,
        last_trade_timestamp: u64,
        every: u64,
        remaining_orders: u64,
        time_scale: u8,
        cooldown: u64,
        input_balance: 0x2::balance::Balance<T0>,
        amount_per_trade: u64,
        min: u64,
        max: u64,
        active: bool,
        owner_output: 0x2::balance::Balance<T1>,
        delegatee_output: 0x2::balance::Balance<T1>,
        fee_percent: u64,
    }

    struct Start<phantom T0, phantom T1> has copy, drop, store {
        every: u64,
        time_scale: u8,
        input: u64,
        dca_address: address,
        delegatee: address,
    }

    struct Resolve<phantom T0, phantom T1> has copy, drop, store {
        fee: u64,
        input: u64,
        output: u64,
        dca_address: address,
    }

    struct Destroy<phantom T0, phantom T1> has copy, drop, store {
        input: u64,
        owner_output: u64,
        delegatee_output: u64,
        dca_address: address,
        owner: address,
    }

    public(friend) fun take<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg0.input_balance, 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math64::min(arg0.amount_per_trade, 0x2::balance::value<T0>(&arg0.input_balance)), arg1)
    }

    public fun new<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : DCA<T0, T1> {
        assert!(3000000 > arg7, 6);
        assert_every(arg2, arg4);
        let v0 = timestamp_s(arg0);
        let v1 = DCA<T0, T1>{
            id                   : 0x2::object::new(arg9),
            owner                : 0x2::tx_context::sender(arg9),
            delegatee            : arg8,
            start_timestamp      : v0,
            last_trade_timestamp : v0,
            every                : arg2,
            remaining_orders     : arg3,
            time_scale           : arg4,
            cooldown             : convert_to_timestamp(arg4) * arg2,
            input_balance        : 0x2::coin::into_balance<T0>(arg1),
            amount_per_trade     : 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math64::div_down(0x2::coin::value<T0>(&arg1), arg3),
            min                  : arg5,
            max                  : arg6,
            active               : true,
            owner_output         : 0x2::balance::zero<T1>(),
            delegatee_output     : 0x2::balance::zero<T1>(),
            fee_percent          : arg7,
        };
        let v2 = Start<T0, T1>{
            every       : arg2,
            time_scale  : arg4,
            input       : 0x2::balance::value<T0>(&v1.input_balance),
            dca_address : 0x2::object::id_address<DCA<T0, T1>>(&v1),
            delegatee   : arg8,
        };
        0x2::event::emit<Start<T0, T1>>(v2);
        v1
    }

    public fun active<T0, T1>(arg0: &DCA<T0, T1>) : bool {
        arg0.active
    }

    public fun amount_per_trade<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.amount_per_trade
    }

    public fun assert_every(arg0: u64, arg1: u8) {
        let v0 = if (arg1 == 0) {
            arg0 >= 30 && arg0 <= 59
        } else if (arg1 == 1) {
            arg0 >= 1 && arg0 <= 59
        } else if (arg1 == 2) {
            arg0 >= 1 && arg0 <= 24
        } else if (arg1 == 3) {
            arg0 >= 1 && arg0 <= 6
        } else if (arg1 == 4) {
            arg0 >= 1 && arg0 <= 4
        } else {
            assert!(arg1 == 5, 2);
            arg0 >= 1 && arg0 <= 12
        };
        assert!(v0, 3);
    }

    fun convert_to_timestamp(arg0: u8) : u64 {
        if (arg0 == 0) {
            return 1
        };
        if (arg0 == 1) {
            return 60
        };
        if (arg0 == 2) {
            return 3600
        };
        if (arg0 == 3) {
            return 86400
        };
        if (arg0 == 4) {
            return 604800
        };
        assert!(arg0 == 5, 4);
        2419200
    }

    public fun cooldown<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.cooldown
    }

    public fun delegatee<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.delegatee
    }

    public fun delegatee_output<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.delegatee_output)
    }

    public fun destroy<T0, T1>(arg0: DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let DCA {
            id                   : v0,
            owner                : v1,
            delegatee            : v2,
            start_timestamp      : _,
            last_trade_timestamp : _,
            every                : _,
            remaining_orders     : _,
            time_scale           : _,
            cooldown             : _,
            input_balance        : v9,
            amount_per_trade     : _,
            min                  : _,
            max                  : _,
            active               : v13,
            owner_output         : v14,
            delegatee_output     : v15,
            fee_percent          : _,
        } = arg0;
        let v17 = v15;
        let v18 = v14;
        let v19 = v9;
        let v20 = v0;
        assert!(!v13, 8);
        let v21 = 0x2::balance::value<T0>(&v19);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg1), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg1), v2);
        let v22 = Destroy<T0, T1>{
            input            : v21,
            owner_output     : 0x2::balance::value<T1>(&v18),
            delegatee_output : 0x2::balance::value<T1>(&v17),
            dca_address      : 0x2::object::uid_to_address(&v20),
            owner            : v1,
        };
        0x2::event::emit<Destroy<T0, T1>>(v22);
        if (v21 == 0) {
            0x2::balance::destroy_zero<T0>(v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v19, arg1), v1);
        };
        0x2::object::delete(v20);
    }

    public fun every<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.every
    }

    public fun fee_percent<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.fee_percent
    }

    public fun input<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.input_balance)
    }

    public fun last_trade_timestamp<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.last_trade_timestamp
    }

    public fun max<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.max
    }

    public fun min<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.min
    }

    public fun owner<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.owner
    }

    public fun owner_output<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.owner_output)
    }

    public fun remaining_orders<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.remaining_orders
    }

    public(friend) fun resolve<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg0.active, 1);
        let v0 = timestamp_s(arg1);
        assert!(v0 - arg0.last_trade_timestamp >= arg0.cooldown, 5);
        arg0.last_trade_timestamp = v0;
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 >= arg0.min && arg0.max >= v1, 0);
        arg0.remaining_orders = arg0.remaining_orders - 1;
        if (arg0.remaining_orders == 0 || 0x2::balance::value<T0>(&arg0.input_balance) == 0) {
            arg0.active = false;
        };
        let v2 = 0x2::coin::into_balance<T1>(arg2);
        let v3 = 0x2::balance::split<T1>(&mut v2, 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math64::mul_div_up(v1, arg0.fee_percent, 1000000000));
        let v4 = Resolve<T0, T1>{
            fee         : 0x2::balance::value<T1>(&v3),
            input       : arg0.amount_per_trade,
            output      : v1,
            dca_address : 0x2::object::id_address<DCA<T0, T1>>(arg0),
        };
        0x2::event::emit<Resolve<T0, T1>>(v4);
        0x2::balance::join<T1>(&mut arg0.delegatee_output, v3);
        0x2::balance::join<T1>(&mut arg0.owner_output, v2);
    }

    public fun share<T0, T1>(arg0: DCA<T0, T1>) {
        0x2::transfer::share_object<DCA<T0, T1>>(arg0);
    }

    public fun start_timestamp<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    public fun stop<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 7);
        arg0.active = false;
    }

    public fun time_scale<T0, T1>(arg0: &DCA<T0, T1>) : u8 {
        arg0.time_scale
    }

    fun timestamp_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

