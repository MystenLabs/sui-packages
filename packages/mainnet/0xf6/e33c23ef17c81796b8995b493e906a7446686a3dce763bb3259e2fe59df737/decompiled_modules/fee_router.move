module 0xf6e33c23ef17c81796b8995b493e906a7446686a3dce763bb3259e2fe59df737::fee_router {
    struct FeeTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        admin: address,
        fee_bps: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        coin_in_type: vector<u8>,
        coin_out_type: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    public fun get_collected_fees<T0>(arg0: &FeeTreasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_fee_bps<T0>(arg0: &FeeTreasury<T0>) : u64 {
        arg0.fee_bps
    }

    public entry fun init_treasury<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 500, 2);
        let v0 = FeeTreasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            admin   : 0x2::tx_context::sender(arg1),
            fee_bps : arg0,
        };
        0x2::transfer::share_object<FeeTreasury<T0>>(v0);
    }

    public fun take_fee_and_return<T0>(arg0: &mut FeeTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = v0 * arg0.fee_bps / 10000;
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg2)));
        let v2 = SwapEvent{
            user          : 0x2::tx_context::sender(arg2),
            coin_in_type  : b"CoinIn",
            coin_out_type : b"CoinOut",
            amount_in     : v0,
            amount_out    : 0,
            fee_amount    : v1,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v2);
        arg1
    }

    public entry fun update_fee<T0>(arg0: &mut FeeTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 <= 500, 2);
        arg0.fee_bps = arg1;
    }

    public entry fun withdraw_fees<T0>(arg0: &mut FeeTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

