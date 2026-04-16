module 0x2318e33b1889391deb51bb55e645660bac51eb9a2cb688a11431c53b583fa30f::router {
    struct RouterConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct ArbReceipt<phantom T0> {
        repay_amount: u64,
        min_profit: u64,
        initial_amount: u64,
    }

    struct ArbProfit has copy, drop {
        trader: address,
        coin_type: 0x1::ascii::String,
        gross_profit: u64,
        fee_taken: u64,
        net_profit: u64,
        num_hops: u8,
    }

    public fun begin_arb<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : (0x2::coin::Coin<T0>, ArbReceipt<T0>) {
        let v0 = ArbReceipt<T0>{
            repay_amount   : arg1,
            min_profit     : arg2,
            initial_amount : 0x2::coin::value<T0>(&arg0),
        };
        (arg0, v0)
    }

    public fun complete_arb<T0>(arg0: &RouterConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: ArbReceipt<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let ArbReceipt {
            repay_amount   : v0,
            min_profit     : v1,
            initial_amount : _,
        } = arg2;
        assert!(0x2::coin::value<T0>(arg1) >= v0 + v1, 1);
        let v3 = 0x2::coin::value<T0>(arg1);
        let v4 = if (arg0.fee_bps > 0) {
            let v5 = v3 * arg0.fee_bps / 10000;
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v5, arg4), arg0.fee_recipient);
                v5
            } else {
                0
            }
        } else {
            0
        };
        let v6 = 0x2::coin::value<T0>(arg1);
        let v7 = ArbProfit{
            trader       : 0x2::tx_context::sender(arg4),
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            gross_profit : v3,
            fee_taken    : v4,
            net_profit   : v6,
            num_hops     : arg3,
        };
        0x2::event::emit<ArbProfit>(v7);
        (0x2::coin::split<T0>(arg1, v0, arg4), 0x2::coin::split<T0>(arg1, v6, arg4))
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

    public fun update_fee(arg0: &mut RouterConfig, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg1 <= 10000, 2);
        arg0.fee_bps = arg1;
        arg0.fee_recipient = arg2;
    }

    // decompiled from Move bytecode v6
}

