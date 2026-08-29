module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool {
    struct Holder has drop, store {
        amount: u64,
        refl_debt: u256,
        refl_unpaid: u64,
        pit_debt: u256,
        pit_unpaid: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        token_reserve: 0x2::balance::Balance<T0>,
        quote_reserve: 0x2::balance::Balance<T1>,
        virtual_quote: u64,
        virtual_token: u64,
        raised: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        reflection: bool,
        pit_mode: u8,
        graduated: bool,
        lp_locked: bool,
        graduation_threshold: u64,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        creator: address,
        created_ms: u64,
        holders: 0x2::table::Table<address, Holder>,
        total_registered: u64,
        reflection_pot: 0x2::balance::Balance<T1>,
        refl_mps: u256,
        pit_claim_pot: 0x2::balance::Balance<T1>,
        pit_mps: u256,
        creator_pot: 0x2::balance::Balance<T1>,
    }

    public fun total_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public fun id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Pool<T0, T1>>(arg0)
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert!(arg5 == 0 || arg5 == 1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_pit_mode());
        assert!(arg3 > 0 && arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        Pool<T0, T1>{
            id                   : 0x2::object::new(arg8),
            token_reserve        : 0x2::coin::mint_balance<T0>(&mut arg0, arg3),
            quote_reserve        : 0x2::balance::zero<T1>(),
            virtual_quote        : arg2,
            virtual_token        : arg3,
            raised               : 0,
            treasury_cap         : arg0,
            reflection           : arg6,
            pit_mode             : arg5,
            graduated            : false,
            lp_locked            : false,
            graduation_threshold : arg4,
            name                 : 0x2::coin::get_name<T0>(arg1),
            symbol               : 0x2::coin::get_symbol<T0>(arg1),
            creator              : 0x2::tx_context::sender(arg8),
            created_ms           : 0x2::clock::timestamp_ms(arg7),
            holders              : 0x2::table::new<address, Holder>(arg8),
            total_registered     : 0,
            reflection_pot       : 0x2::balance::zero<T1>(),
            refl_mps             : 0,
            pit_claim_pot        : 0x2::balance::zero<T1>(),
            pit_mps              : 0,
            creator_pot          : 0x2::balance::zero<T1>(),
        }
    }

    fun accure(arg0: &mut Holder, arg1: u256, arg2: u256) {
        let v0 = (arg0.amount as u256);
        let v1 = v0 * arg1;
        if (v1 > arg0.refl_debt) {
            arg0.refl_unpaid = arg0.refl_unpaid + u256_to_u64((v1 - arg0.refl_debt) / 1000000000000);
        };
        arg0.refl_debt = v1;
        let v2 = v0 * arg2;
        if (v2 > arg0.pit_debt) {
            arg0.pit_unpaid = arg0.pit_unpaid + u256_to_u64((v2 - arg0.pit_debt) / 1000000000000);
        };
        arg0.pit_debt = v2;
    }

    public fun burn_from_pit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return
        };
        0x2::balance::join<T1>(&mut arg0.quote_reserve, arg1);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::get_amount_out(v0, arg0.virtual_quote + 0x2::balance::value<T1>(&arg0.quote_reserve), 0x2::balance::value<T0>(&arg0.token_reserve))), arg2));
        arg0.raised = arg0.raised + v0;
        maybe_graduate<T0, T1>(arg0);
    }

    public fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::assert_not_paused(arg1);
        assert!(!arg0.graduated, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::graduated());
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let (v1, v2, v3, v4) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::fee_split(arg1, arg0.reflection, v0);
        let v5 = v0 - v1 - v2 - v3 - v4;
        assert!(v5 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let v6 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::get_amount_out(v5, arg0.virtual_quote + 0x2::balance::value<T1>(&arg0.quote_reserve), 0x2::balance::value<T0>(&arg0.token_reserve));
        assert!(v6 >= arg4, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::slippage());
        assert!(v6 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let v7 = &mut arg3;
        pipe_fees<T0, T1>(arg0, arg1, arg2, v7, v1, v2, v3, v4, arg6);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::coin::into_balance<T1>(arg3));
        let v8 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v6);
        arg0.raised = arg0.raised + v5;
        credit_holder<T0, T1>(arg0, 0x2::tx_context::sender(arg6), v6);
        if (v4 > 0) {
            distribute_reflection<T0, T1>(arg0, v4);
        };
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::nudge<T1>(arg2, 0x2::object::id<Pool<T0, T1>>(arg0), market_cap_metric<T0, T1>(arg0), arg0.graduated, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::round_ms(arg1), arg5);
        maybe_graduate<T0, T1>(arg0);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_trade(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::tx_context::sender(arg6), true, v5, v6, v3, v4, v1, v2, arg0.raised, 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::balance::value<T1>(&arg0.quote_reserve));
        0x2::coin::from_balance<T0>(v8, arg6)
    }

    public fun claim_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_creator());
        let v0 = 0x2::balance::value<T1>(&arg0.creator_pot);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_claim(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::tx_context::sender(arg1), v0, 2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.creator_pot, v0), arg1)
    }

    public fun claim_pit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = take_unpaid<T0, T1>(arg0, 0x2::tx_context::sender(arg1), 1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_claim(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::tx_context::sender(arg1), v0, 1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pit_claim_pot, v0), arg1)
    }

    public fun claim_reflection<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = take_unpaid<T0, T1>(arg0, 0x2::tx_context::sender(arg1), 0);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_claim(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::tx_context::sender(arg1), v0, 0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reflection_pot, v0), arg1)
    }

    public fun creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_pot_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.creator_pot)
    }

    fun credit_holder<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address, arg2: u64) {
        let v0 = arg0.refl_mps;
        let v1 = arg0.pit_mps;
        arg0.total_registered = arg0.total_registered + arg2;
        ensure_holder<T0, T1>(arg0, arg1);
        let v2 = 0x2::table::borrow_mut<address, Holder>(&mut arg0.holders, arg1);
        accure(v2, v0, v1);
        v2.amount = v2.amount + arg2;
        v2.refl_debt = (v2.amount as u256) * v0;
        v2.pit_debt = (v2.amount as u256) * v1;
    }

    fun debit_holder<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, Holder>(&arg0.holders, arg1)) {
            return
        };
        let v0 = arg0.refl_mps;
        let v1 = arg0.pit_mps;
        let v2 = 0x2::table::borrow_mut<address, Holder>(&mut arg0.holders, arg1);
        accure(v2, v0, v1);
        let v3 = if (v2.amount >= arg2) {
            arg2
        } else {
            v2.amount
        };
        v2.amount = v2.amount - v3;
        v2.refl_debt = (v2.amount as u256) * v0;
        v2.pit_debt = (v2.amount as u256) * v1;
        arg0.total_registered = arg0.total_registered - v3;
    }

    fun distribute_pit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        if (arg1 == 0 || arg0.total_registered == 0) {
            return
        };
        arg0.pit_mps = arg0.pit_mps + (arg1 as u256) * 1000000000000 / (arg0.total_registered as u256);
    }

    fun distribute_reflection<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        if (arg1 == 0 || arg0.total_registered == 0) {
            return
        };
        arg0.refl_mps = arg0.refl_mps + (arg1 as u256) * 1000000000000 / (arg0.total_registered as u256);
    }

    fun do_graduate<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.graduated = true;
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_graduation(0x2::object::id<Pool<T0, T1>>(arg0), arg0.raised, 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::balance::value<T1>(&arg0.quote_reserve));
    }

    fun ensure_holder<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address) {
        if (!0x2::table::contains<address, Holder>(&arg0.holders, arg1)) {
            let v0 = Holder{
                amount      : 0,
                refl_debt   : 0,
                refl_unpaid : 0,
                pit_debt    : 0,
                pit_unpaid  : 0,
            };
            0x2::table::add<address, Holder>(&mut arg0.holders, arg1, v0);
        };
    }

    public(friend) fun extract_for_lock<T0, T1>(arg0: &mut Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::object::ID, address) {
        let v0 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v1 = arg0.creator;
        let (v2, v3) = take_reserves_for_lock<T0, T1>(arg0);
        (v2, v3, v0, v1)
    }

    public fun graduate<T0, T1>(arg0: &mut Pool<T0, T1>) {
        assert!(!arg0.graduated, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::graduated());
        assert!(arg0.raised >= arg0.graduation_threshold, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_graduated());
        do_graduate<T0, T1>(arg0);
    }

    public fun holder_amount<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, Holder>(&arg0.holders, arg1)) {
            0
        } else {
            0x2::table::borrow<address, Holder>(&arg0.holders, arg1).amount
        }
    }

    public fun is_graduated<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.graduated
    }

    public fun is_lp_locked<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.lp_locked
    }

    public fun is_reflection<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.reflection
    }

    public fun lp_locked<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.lp_locked
    }

    public fun market_cap_metric<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.token_reserve);
        if (v0 == 0) {
            return 0
        };
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(arg0.virtual_quote + 0x2::balance::value<T1>(&arg0.quote_reserve), arg0.virtual_token, v0)
    }

    fun maybe_graduate<T0, T1>(arg0: &mut Pool<T0, T1>) {
        if (!arg0.graduated && arg0.raised >= arg0.graduation_threshold) {
            do_graduate<T0, T1>(arg0);
        };
    }

    public fun name<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        arg0.name
    }

    fun pipe_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg6 > 0) {
            0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::take_fee<T1>(arg2, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, arg6, arg8)));
        };
        if (arg4 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_pot, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, arg4, arg8)));
        };
        if (arg5 > 0) {
            0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::take_platform<T1>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, arg5, arg8)));
        };
        if (arg7 > 0) {
            0x2::balance::join<T1>(&mut arg0.reflection_pot, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, arg7, arg8)));
        };
    }

    public fun pit_buy_and_burn() : u8 {
        1
    }

    public fun pit_holders() : u8 {
        0
    }

    public fun pit_mode<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.pit_mode
    }

    public fun quote_reserves<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_reserve)
    }

    public fun raised<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.raised
    }

    public fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::assert_not_paused(arg1);
        assert!(!arg0.graduated, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::graduated());
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let v1 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::get_amount_out(v0, 0x2::balance::value<T0>(&arg0.token_reserve), arg0.virtual_quote + 0x2::balance::value<T1>(&arg0.quote_reserve));
        let v2 = v1;
        let v3 = 0x2::balance::value<T1>(&arg0.quote_reserve);
        if (v1 > v3) {
            v2 = v3;
        };
        assert!(v2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let (v4, v5, v6, v7) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::fee_split(arg1, arg0.reflection, v2);
        let v8 = v2 - v4 - v5 - v6 - v7;
        assert!(v8 >= arg4, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::slippage());
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg3));
        let v9 = 0x2::balance::split<T1>(&mut arg0.quote_reserve, v2);
        if (v6 > 0) {
            0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::take_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v9, v6));
        };
        if (v4 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_pot, 0x2::balance::split<T1>(&mut v9, v4));
        };
        if (v5 > 0) {
            0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::take_platform<T1>(arg1, 0x2::balance::split<T1>(&mut v9, v5));
        };
        if (v7 > 0) {
            0x2::balance::join<T1>(&mut arg0.reflection_pot, 0x2::balance::split<T1>(&mut v9, v7));
        };
        debit_holder<T0, T1>(arg0, 0x2::tx_context::sender(arg6), v0);
        if (v7 > 0) {
            distribute_reflection<T0, T1>(arg0, v7);
        };
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::nudge<T1>(arg2, 0x2::object::id<Pool<T0, T1>>(arg0), market_cap_metric<T0, T1>(arg0), arg0.graduated, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::round_ms(arg1), arg5);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_trade(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::tx_context::sender(arg6), false, v8, v0, v6, v7, v4, v5, arg0.raised, 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::balance::value<T1>(&arg0.quote_reserve));
        0x2::coin::from_balance<T1>(v9, arg6)
    }

    public fun settle_pit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.pit_mode == 0) {
            let v0 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::settle_to_holders<T1>(arg1, 0x2::object::id<Pool<T0, T1>>(arg0));
            0x2::balance::join<T1>(&mut arg0.pit_claim_pot, v0);
            distribute_pit<T0, T1>(arg0, 0x2::balance::value<T1>(&v0));
        } else {
            assert!(arg0.pit_mode == 1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_pit_mode());
            let v1 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::settle_burn_quote<T1>(arg1, 0x2::object::id<Pool<T0, T1>>(arg0));
            burn_from_pit<T0, T1>(arg0, v1, arg2);
        };
    }

    public(friend) fun share<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public fun symbol<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::ascii::String {
        arg0.symbol
    }

    public(friend) fun take_reserves_for_lock<T0, T1>(arg0: &mut Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.graduated, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_graduated());
        assert!(!arg0.lp_locked, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::already_locked());
        let v0 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.quote_reserve);
        assert!(v0 > 0 && v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::insufficient_liquidity());
        arg0.lp_locked = true;
        (0x2::balance::split<T0>(&mut arg0.token_reserve, v0), 0x2::balance::split<T1>(&mut arg0.quote_reserve, v1))
    }

    fun take_unpaid<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address, arg2: u8) : u64 {
        assert!(0x2::table::contains<address, Holder>(&arg0.holders, arg1), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        let v0 = 0x2::table::borrow_mut<address, Holder>(&mut arg0.holders, arg1);
        accure(v0, arg0.refl_mps, arg0.pit_mps);
        let v1 = if (arg2 == 0) {
            v0.refl_unpaid = 0;
            v0.refl_unpaid
        } else {
            v0.pit_unpaid = 0;
            v0.pit_unpaid
        };
        assert!(v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        v1
    }

    public fun token_reserves<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun total_registered<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.total_registered
    }

    fun u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (arg0 as u64)
    }

    public fun virtual_quote<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.virtual_quote
    }

    public fun virtual_token<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.virtual_token
    }

    // decompiled from Move bytecode v7
}

