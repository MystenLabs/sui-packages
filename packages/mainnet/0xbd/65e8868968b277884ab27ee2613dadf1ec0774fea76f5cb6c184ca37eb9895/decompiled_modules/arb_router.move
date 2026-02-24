module 0xbd65e8868968b277884ab27ee2613dadf1ec0774fea76f5cb6c184ca37eb9895::arb_router {
    struct RouterConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct ArbReceipt<phantom T0> {
        repay_amount: u64,
        min_profit: u64,
        num_legs: u8,
    }

    struct ArbProfit has copy, drop {
        gross_amount: u64,
        repay_amount: u64,
        net_profit: u64,
        fee_taken: u64,
        num_legs: u8,
    }

    public fun begin_arb<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8) : (0x2::coin::Coin<T0>, ArbReceipt<T0>) {
        let v0 = ArbReceipt<T0>{
            repay_amount : arg1,
            min_profit   : arg2,
            num_legs     : arg3,
        };
        (arg0, v0)
    }

    public fun complete_arb<T0>(arg0: &RouterConfig, arg1: 0x2::coin::Coin<T0>, arg2: ArbReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let ArbReceipt {
            repay_amount : v0,
            min_profit   : v1,
            num_legs     : v2,
        } = arg2;
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 >= v0, 2);
        let v4 = v3 - v0;
        assert!(v4 >= v1, 1);
        let v5 = if (arg0.fee_bps > 0) {
            let v6 = v4 * arg0.fee_bps / 10000;
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v6, arg3), arg0.fee_recipient);
                v6
            } else {
                0
            }
        } else {
            0
        };
        let v7 = ArbProfit{
            gross_amount : v3,
            repay_amount : v0,
            net_profit   : v4 - v5,
            fee_taken    : v5,
            num_legs     : v2,
        };
        0x2::event::emit<ArbProfit>(v7);
        (0x2::coin::split<T0>(&mut arg1, v0, arg3), arg1)
    }

    public fun ge_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterConfig{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            fee_bps       : 0,
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<RouterConfig>(v0);
    }

    public fun set_fee(arg0: &mut RouterConfig, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg1 <= 1000, 3);
        arg0.fee_bps = arg1;
        arg0.fee_recipient = arg2;
    }

    public fun transfer_admin(arg0: &mut RouterConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

