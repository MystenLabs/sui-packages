module 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::pair {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PairMetadata<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_x: 0x2::coin::Coin<T0>,
        reserve_y: 0x2::coin::Coin<T1>,
        k_last: u128,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        fee_rate: u64,
    }

    struct LiquidityAdded has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        liquidity: u64,
        fee: u64,
    }

    struct LiquidityRemoved has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        liquidity: u64,
        fee: u64,
    }

    struct Swapped has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_x_in: u64,
        amount_y_in: u64,
        amount_x_out: u64,
        amount_y_out: u64,
    }

    public fun swap<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2 > 0 || arg4 > 0, 3);
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        assert!(arg2 < v0 && arg4 < v1, 4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x2::coin::value<T1>(&arg3);
        assert!(v2 > 0 || v3 > 0, 2);
        deposit_x<T0, T1>(arg0, arg1);
        deposit_y<T0, T1>(arg0, arg3);
        let v4 = extract_x<T0, T1>(arg0, arg2, arg5);
        let v5 = extract_y<T0, T1>(arg0, arg4, arg5);
        let (v6, v7) = get_reserves<T0, T1>(arg0);
        assert!(((v6 as u256) * (10000 as u256) - (v2 as u256) * (arg0.fee_rate as u256)) * ((v7 as u256) * (10000 as u256) - (v3 as u256) * (arg0.fee_rate as u256)) >= (v0 as u256) * (v1 as u256) * (10000 as u256) * (10000 as u256), 5);
        let v8 = Swapped{
            user         : 0x2::tx_context::sender(arg5),
            coin_x       : 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T0>(),
            coin_y       : 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T1>(),
            amount_x_in  : v2,
            amount_y_in  : v3,
            amount_x_out : arg2,
            amount_y_out : arg4,
        };
        0x2::event::emit<Swapped>(v8);
        (v4, v5)
    }

    public fun burn<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: &0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::treasury::Treasury, arg2: 0x2::coin::Coin<LP<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        let v2 = 0x2::coin::value<LP<T0, T1>>(&arg2);
        let v3 = mint_fee<T0, T1>(arg0, 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::treasury::treasurer(arg1), arg3);
        let v4 = (total_lp_supply<T0, T1>(arg0) as u128);
        let v5 = (((v2 as u128) * (v0 as u128) / v4) as u64);
        let v6 = (((v2 as u128) * (v1 as u128) / v4) as u64);
        assert!(v5 > 0 && v6 > 0, 1);
        burn_lp<T0, T1>(arg0, arg2);
        let v7 = extract_x<T0, T1>(arg0, v5, arg3);
        let v8 = extract_y<T0, T1>(arg0, v6, arg3);
        update_k_last<T0, T1>(arg0);
        let v9 = LiquidityRemoved{
            user      : 0x2::tx_context::sender(arg3),
            coin_x    : 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T0>(),
            coin_y    : 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T1>(),
            amount_x  : v5,
            amount_y  : v6,
            liquidity : v2,
            fee       : v3,
        };
        0x2::event::emit<LiquidityRemoved>(v9);
        (v7, v8)
    }

    fun burn_lp<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>) {
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
    }

    public(friend) fun create_pair<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : PairMetadata<T0, T1> {
        let v0 = LP<T0, T1>{dummy_field: false};
        PairMetadata<T0, T1>{
            id        : 0x2::object::new(arg0),
            reserve_x : 0x2::coin::zero<T0>(arg0),
            reserve_y : 0x2::coin::zero<T1>(arg0),
            k_last    : 0,
            lp_supply : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            fee_rate  : 0,
        }
    }

    fun deposit_x<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.reserve_x, arg1);
    }

    fun deposit_y<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::join<T1>(&mut arg0.reserve_y, arg1);
    }

    fun extract_x<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(&mut arg0.reserve_x, arg1, arg2)
    }

    fun extract_y<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::split<T1>(&mut arg0.reserve_y, arg1, arg2)
    }

    public fun fee_rate<T0, T1>(arg0: &PairMetadata<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun get_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"LP-");
        0x1::string::append(&mut v0, 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T0>());
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T1>());
        v0
    }

    public fun get_reserves<T0, T1>(arg0: &PairMetadata<T0, T1>) : (u64, u64) {
        (0x2::coin::value<T0>(&arg0.reserve_x), 0x2::coin::value<T1>(&arg0.reserve_y))
    }

    public fun k<T0, T1>(arg0: &PairMetadata<T0, T1>) : u128 {
        arg0.k_last
    }

    public fun mint<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: &0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = 0x2::coin::value<T1>(&arg3);
        let v4 = mint_fee<T0, T1>(arg0, 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::treasury::treasurer(arg1), arg4);
        let v5 = (total_lp_supply<T0, T1>(arg0) as u128);
        let v6 = if (v5 == 0) {
            let v7 = 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::math::sqrt_u128((v2 as u128) * (v3 as u128));
            assert!(v7 > (1000 as u128), 0);
            let v8 = mint_lp<T0, T1>(arg0, 1000, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v8, @0x0);
            ((v7 - (1000 as u128)) as u64)
        } else {
            (0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::math::min_u128((v2 as u128) * v5 / (v0 as u128), (v3 as u128) * v5 / (v1 as u128)) as u64)
        };
        assert!(v6 > 0, 0);
        let v9 = mint_lp<T0, T1>(arg0, v6, arg4);
        deposit_x<T0, T1>(arg0, arg2);
        deposit_y<T0, T1>(arg0, arg3);
        update_k_last<T0, T1>(arg0);
        let v10 = LiquidityAdded{
            user      : 0x2::tx_context::sender(arg4),
            coin_x    : 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T0>(),
            coin_y    : 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper::get_type_name<T1>(),
            amount_x  : v2,
            amount_y  : v3,
            liquidity : v6,
            fee       : v4,
        };
        0x2::event::emit<LiquidityAdded>(v10);
        v9
    }

    fun mint_fee<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let (v1, v2) = get_reserves<T0, T1>(arg0);
        if (arg1 != @0x0) {
            if (arg0.k_last != 0) {
                let v3 = 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::math::sqrt_u128((v1 as u128) * (v2 as u128));
                let v4 = 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::math::sqrt_u128(arg0.k_last);
                if (v3 > v4) {
                    let v5 = (((total_lp_supply<T0, T1>(arg0) as u128) * (v3 - v4) / (v3 * 5 + v4)) as u64);
                    v0 = v5;
                    if (v5 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(mint_lp<T0, T1>(arg0, v5, arg2), arg1);
                    };
                };
            };
        };
        v0
    }

    fun mint_lp<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, arg1), arg2)
    }

    public(friend) fun set_fee_rate<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64) {
        assert!(arg1 < 10000, 6);
        arg0.fee_rate = arg1;
    }

    public fun total_lp_supply<T0, T1>(arg0: &PairMetadata<T0, T1>) : u64 {
        0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)
    }

    fun update_k_last<T0, T1>(arg0: &mut PairMetadata<T0, T1>) {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        arg0.k_last = (v0 as u128) * (v1 as u128);
    }

    // decompiled from Move bytecode v6
}

