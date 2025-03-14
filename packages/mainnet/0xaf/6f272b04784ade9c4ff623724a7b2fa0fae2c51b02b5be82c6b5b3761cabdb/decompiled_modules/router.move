module 0xaf6f272b04784ade9c4ff623724a7b2fa0fae2c51b02b5be82c6b5b3761cabdb::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct PauseConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        admin: address,
    }

    public entry fun change_admin(arg0: &mut PauseConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 403);
        arg0.admin = arg1;
    }

    fun check_pause(arg0: &PauseConfig) {
        assert!(!arg0.paused, 999);
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: &PauseConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        assert!(arg3 == 0 || arg3 > 0 && arg4 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 < arg2) {
            abort 1
        };
        let v1 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        if (arg3 > 0) {
            let v2 = &mut arg1;
            let (v3, _) = split_with_percentage_for_commission<T0>(arg0, v2, arg3, arg4, arg7);
            destroy_or_transfer<T0>(v3, arg7);
            destroy_or_transfer<T0>(arg1, arg7);
        } else {
            destroy_or_transfer<T0>(arg1, arg7);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseConfig{
            id     : 0x2::object::new(arg0),
            paused : false,
            admin  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PauseConfig>(v0);
    }

    public fun split_with_percentage<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg1);
        let v1 = (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg1, v1, arg3), v1, 0x2::coin::split<T0>(arg1, v0 - v1, arg3), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 300, 3);
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg2, arg4);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referal_address   : arg3,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    public entry fun toggle_pause(arg0: &mut PauseConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 403);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

