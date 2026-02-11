module 0x473cdc6d074effc7f1f1a9d6d42215b6e16d1c0e6b5fc3c9e24f3eecbf3ba807::arb {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct ArbContext<phantom T0> {
        input_amount: u64,
        min_profit: u64,
        sender: address,
    }

    struct ArbSuccess has copy, drop {
        sender: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        fee: u64,
    }

    public fun finish<T0>(arg0: &Config, arg1: ArbContext<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let ArbContext {
            input_amount : v0,
            min_profit   : v1,
            sender       : v2,
        } = arg1;
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > v0, 1);
        let v4 = v3 - v0;
        assert!(v4 >= v1, 2);
        let v5 = if (arg0.fee_bps > 0) {
            let v6 = v4 * arg0.fee_bps / 10000;
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v6, arg3), arg0.fee_recipient);
                v6
            } else {
                0
            }
        } else {
            0
        };
        let v7 = ArbSuccess{
            sender        : v2,
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            fee           : v5,
        };
        0x2::event::emit<ArbSuccess>(v7);
        (0x2::coin::split<T0>(&mut arg2, v0, arg3), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            version       : 1,
            fee_bps       : 0,
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address) {
        assert!(arg2 <= 10000, 7);
        arg1.fee_bps = arg2;
        arg1.fee_recipient = arg3;
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.version = arg2;
    }

    public fun start<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (ArbContext<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg0.version == 1, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = ArbContext<T0>{
            input_amount : v0,
            min_profit   : arg2,
            sender       : 0x2::tx_context::sender(arg3),
        };
        (v1, arg1)
    }

    // decompiled from Move bytecode v6
}

