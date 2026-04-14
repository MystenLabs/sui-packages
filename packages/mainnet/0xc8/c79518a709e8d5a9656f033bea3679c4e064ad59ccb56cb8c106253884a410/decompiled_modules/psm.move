module 0xe0e0113e44c38ef5cfbbac826cfff0cf0438109b0358b0039aca8d183065f5af::psm {
    struct Burned<phantom T0, phantom T1> has copy, drop {
        burner: address,
        t_amount: u64,
        s_out: u64,
    }

    struct Minted<phantom T0, phantom T1> has copy, drop {
        minter: address,
        s_in: u64,
        t_out: u64,
    }

    struct ReserveInit<phantom T0, phantom T1> has copy, drop {
        reserve_id: address,
        admin: address,
        fee_bps: u64,
    }

    struct Reserve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        s_balance: 0x2::balance::Balance<T1>,
        fee_bps: u64,
        collected_fee: 0x2::balance::Balance<T1>,
        admin: address,
        t_decimals: u8,
        s_decimals: u8,
        total_t_burned: u64,
        total_t_minted: u64,
        total_s_in: u64,
        total_s_out: u64,
    }

    public fun admin<T0, T1>(arg0: &Reserve<T0, T1>) : address {
        arg0.admin
    }

    public entry fun burn_for_usdc<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_for_usdc_coin<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun burn_for_usdc_coin<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = convert_t_to_s<T0, T1>(arg0, v0);
        assert!(v1 >= arg2, 2);
        assert!(0x2::balance::value<T1>(&arg0.s_balance) >= v1, 1);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        arg0.total_t_burned = arg0.total_t_burned + v0;
        arg0.total_s_out = arg0.total_s_out + v1;
        let v2 = if (arg0.t_decimals >= arg0.s_decimals) {
            v0 / pow10(arg0.t_decimals - arg0.s_decimals)
        } else {
            v0 * pow10(arg0.s_decimals - arg0.t_decimals)
        };
        0x2::balance::join<T1>(&mut arg0.collected_fee, 0x2::balance::split<T1>(&mut arg0.s_balance, v2 - v1));
        let v3 = Burned<T0, T1>{
            burner   : 0x2::tx_context::sender(arg3),
            t_amount : v0,
            s_out    : v1,
        };
        0x2::event::emit<Burned<T0, T1>>(v3);
        0x2::coin::take<T1>(&mut arg0.s_balance, v1, arg3)
    }

    public fun collected_fees<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.collected_fee)
    }

    fun convert_s_to_t<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64) : u64 {
        let v0 = arg0.t_decimals;
        let v1 = arg0.s_decimals;
        let v2 = if (v0 >= v1) {
            arg1 * pow10(v0 - v1)
        } else {
            arg1 / pow10(v1 - v0)
        };
        v2 * (10000 - arg0.fee_bps) / 10000
    }

    fun convert_t_to_s<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64) : u64 {
        let v0 = arg0.t_decimals;
        let v1 = arg0.s_decimals;
        let v2 = if (v0 >= v1) {
            arg1 / pow10(v0 - v1)
        } else {
            arg1 * pow10(v1 - v0)
        };
        v2 * (10000 - arg0.fee_bps) / 10000
    }

    public entry fun create_reserve<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 1000, 4);
        let v0 = Reserve<T0, T1>{
            id             : 0x2::object::new(arg4),
            treasury_cap   : arg0,
            s_balance      : 0x2::balance::zero<T1>(),
            fee_bps        : arg1,
            collected_fee  : 0x2::balance::zero<T1>(),
            admin          : 0x2::tx_context::sender(arg4),
            t_decimals     : arg2,
            s_decimals     : arg3,
            total_t_burned : 0,
            total_t_minted : 0,
            total_s_in     : 0,
            total_s_out    : 0,
        };
        let v1 = 0x2::object::id<Reserve<T0, T1>>(&v0);
        let v2 = ReserveInit<T0, T1>{
            reserve_id : 0x2::object::id_to_address(&v1),
            admin      : 0x2::tx_context::sender(arg4),
            fee_bps    : arg1,
        };
        0x2::event::emit<ReserveInit<T0, T1>>(v2);
        0x2::transfer::share_object<Reserve<T0, T1>>(v0);
    }

    public fun fee_bps<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public entry fun mint_from_usdc<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = convert_s_to_t<T0, T1>(arg0, v0);
        assert!(v1 >= arg2, 2);
        if (arg0.t_decimals >= arg0.s_decimals) {
        };
        0x2::balance::join<T1>(&mut arg0.s_balance, 0x2::coin::into_balance<T1>(arg1));
        arg0.total_t_minted = arg0.total_t_minted + v1;
        arg0.total_s_in = arg0.total_s_in + v0;
        let v2 = Minted<T0, T1>{
            minter : 0x2::tx_context::sender(arg3),
            s_in   : v0,
            t_out  : v1,
        };
        0x2::event::emit<Minted<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v1, arg3), 0x2::tx_context::sender(arg3));
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public fun s_reserve_balance<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.s_balance)
    }

    public entry fun set_fee<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(arg1 <= 1000, 4);
        arg0.fee_bps = arg1;
    }

    public entry fun top_up<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.s_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun transfer_admin<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.admin = arg1;
    }

    public entry fun withdraw_fees<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        let v0 = 0x2::balance::value<T1>(&arg0.collected_fee);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.collected_fee, v0), arg2), arg1);
        };
    }

    // decompiled from Move bytecode v7
}

