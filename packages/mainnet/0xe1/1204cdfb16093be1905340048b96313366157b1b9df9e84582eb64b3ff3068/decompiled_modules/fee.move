module 0xe11204cdfb16093be1905340048b96313366157b1b9df9e84582eb64b3ff3068::fee {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_wallet: address,
        fee_bps: u64,
    }

    struct FeeCollected has copy, drop {
        payer: address,
        coin_type: 0x1::type_name::TypeName,
        amount_in: u64,
        fee_amount: u64,
        fee_wallet: address,
    }

    public fun fee_bps(arg0: &FeeConfig) : u64 {
        arg0.fee_bps
    }

    public fun fee_wallet(arg0: &FeeConfig) : address {
        arg0.fee_wallet
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = FeeConfig{
            id         : 0x2::object::new(arg0),
            fee_wallet : v0,
            fee_bps    : 30,
        };
        0x2::transfer::share_object<FeeConfig>(v2);
    }

    public fun max_bps() : u64 {
        1000
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert!(arg2 <= 1000, 0);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_wallet(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        arg1.fee_wallet = arg2;
    }

    public fun take_fee<T0>(arg0: &FeeConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg2), arg0.fee_wallet);
        };
        let v2 = FeeCollected{
            payer      : 0x2::tx_context::sender(arg2),
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount_in  : v0,
            fee_amount : v1,
            fee_wallet : arg0.fee_wallet,
        };
        0x2::event::emit<FeeCollected>(v2);
        arg1
    }

    // decompiled from Move bytecode v7
}

