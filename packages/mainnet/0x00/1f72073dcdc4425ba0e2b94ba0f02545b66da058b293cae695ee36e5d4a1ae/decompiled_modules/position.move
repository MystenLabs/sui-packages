module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::position {
    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        offset: u64,
        margin: u64,
        margin_balance: 0x2::balance::Balance<T0>,
        leverage: u8,
        type: u8,
        status: u8,
        direction: u8,
        size: u64,
        lot: u64,
        open_price: u64,
        open_spread: u64,
        open_real_price: u64,
        close_price: u64,
        close_spread: u64,
        close_real_price: u64,
        profit: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64,
        stop_surplus_price: u64,
        stop_loss_price: u64,
        create_time: u64,
        open_time: u64,
        close_time: u64,
        validity_time: u64,
        open_operator: address,
        close_operator: address,
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
    }

    public fun get_offset<T0>(arg0: &Position<T0>) : u64 {
        arg0.offset
    }

    public fun get_uid<T0>(arg0: &Position<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_uid_mut<T0>(arg0: &mut Position<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_denominator<T0>() : u64 {
        10000
    }

    public fun get_size<T0>(arg0: &Position<T0>) : u64 {
        size(arg0.lot, arg0.size)
    }

    public fun get_status<T0>(arg0: &Position<T0>) : u8 {
        arg0.status
    }

    public fun burst_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid_mut<T1>(arg1), arg3);
        assert!(v0.status == 1, 607);
        assert!(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg1) == v0.account_id, 615);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid(arg0), v0.market_id);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_status<T0, T1>(v1) < 3, 609);
        if (v0.type == 1) {
            let v2 = get_equity<T0, T1>(arg0, arg1, arg2);
            if (!0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(&v2)) {
                let v3 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_margin_used<T1>(arg1);
                if (v3 > 0) {
                    assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v2) <= 5000 * v3 / 10000, 617);
                };
            };
        } else {
            let v4 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_price<T0, T1>(v1, arg2);
            let v5 = get_position_fund_fee<T0, T1>(v1, v0);
            let v6 = get_pl<T1>(v0, &v4);
            let v7 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::i64_add(&v5, &v6);
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::inc_u64(&mut v7, v0.margin);
            if (!0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(&v7)) {
                assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v7) <= 5000 * v0.margin / 10000, 617);
            };
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), v0.market_id);
        let v9 = 0x2::dynamic_object_field::remove<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid_mut<T1>(arg1), arg3);
        v9.status = 3;
        let v10 = &mut v9;
        settlement_pl<T0, T1>(v8, arg1, arg2, v10, 0x2::tx_context::sender(arg4));
        0x2::transfer::transfer<Position<T1>>(v9, 0x2::tx_context::sender(arg4));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(v8));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg1));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Position<T1>>(arg3);
    }

    public fun check_margin<T0>(arg0: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T0>, arg1: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64) {
        assert!(!0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(arg1), 616);
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_margin_used<T0>(arg0);
        if (v0 > 0) {
            assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(arg1) >= 5000 * v0 / 10000, 611);
        };
    }

    public fun close_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_owner<T1>(arg1), 606);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid_mut<T1>(arg1), arg3);
        assert!(v1.status == 1, 607);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_status<T0, T1>(arg0) != 3, 609);
        assert!(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(arg0) == v1.market_id, 614);
        assert!(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg1) == v1.account_id, 615);
        v1.status = 2;
        let v2 = &mut v1;
        settlement_pl<T0, T1>(arg0, arg1, arg2, v2, v0);
        0x2::transfer::transfer<Position<T1>>(v1, v0);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(arg0));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg1));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Position<T1>>(arg3);
    }

    fun collect_insurance<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: u64) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::join_insurance_balance<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(arg0), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::split_balance<T1>(arg1, (((arg2 as u128) * (0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_insurance_fee<T0, T1>(arg0) as u128) / (0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator() as u128)) as u64)));
    }

    fun collect_spread<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(arg0);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::join_spread_profit<T0, T1>(v0, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::split_profit_balance<T0, T1>(v0, arg2 * arg1 / 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator() / 2));
    }

    fun create_position_inner<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Price, arg7: &mut 0x2::tx_context::TxContext) : Position<T1> {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_offset<T1>(arg1) + 1;
        let v1 = Position<T1>{
            id                 : 0x2::object::new(arg7),
            offset             : v0,
            margin             : 0,
            margin_balance     : 0x2::balance::zero<T1>(),
            leverage           : arg2,
            type               : arg3,
            status             : 1,
            direction          : arg4,
            size               : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_size<T0, T1>(arg0),
            lot                : arg5,
            open_price         : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_direction_price(arg6, arg4),
            open_spread        : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_spread(arg6),
            open_real_price    : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_real_price(arg6),
            close_price        : 0,
            close_spread       : 0,
            close_real_price   : 0,
            profit             : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(0, false),
            stop_surplus_price : 0,
            stop_loss_price    : 0,
            create_time        : 0,
            open_time          : 0,
            close_time         : 0,
            validity_time      : 0,
            open_operator      : 0x2::tx_context::sender(arg7),
            close_operator     : @0x0,
            market_id          : 0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(arg0),
            account_id         : 0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg1),
        };
        let v2 = get_fund_size<T1>(&v1);
        let v3 = margin_size(v2, (v1.leverage as u64), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_margin_fee<T0, T1>(arg0), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator());
        v1.margin = v3;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::set_offset<T1>(arg1, v0);
        let v4 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_exposure<T0, T1>(arg0);
        inc_margin<T0, T1>(arg0, arg1, arg3, arg4, v3, v2);
        risk_assertion<T0, T1>(arg0, v2, arg4, v4);
        if (arg3 == 2) {
            0x2::balance::join<T1>(&mut v1.margin_balance, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::split_balance<T1>(arg1, v3));
        };
        collect_insurance<T0, T1>(arg0, arg1, v3);
        collect_spread<T0, T1>(arg0, v1.open_spread, size(arg5, v1.size));
        v1
    }

    fun dec_margin<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: u8, arg3: u8, arg4: u64, arg5: u64) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_total<T1>(arg1, arg4);
        if (arg2 == 1) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_cross_total<T1>(arg1, arg4);
            if (arg3 == 1) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_cross_buy_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::dec_long_position_total<T0, T1>(arg0, arg5);
            } else {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_cross_sell_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::dec_short_position_total<T0, T1>(arg0, arg5);
            };
        } else {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_isolated_total<T1>(arg1, arg4);
            if (arg3 == 1) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_isolated_buy_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::dec_long_position_total<T0, T1>(arg0, arg5);
            } else {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_margin_isolated_sell_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::dec_short_position_total<T0, T1>(arg0, arg5);
            };
        };
    }

    public fun fund_size(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) * (arg2 as u128) / 10000;
        assert!(v0 <= 18446744073709551615, 608);
        (v0 as u64)
    }

    public fun get_account_id<T0>(arg0: &Position<T0>) : &0x2::object::ID {
        &arg0.account_id
    }

    public fun get_close_operator<T0>(arg0: &Position<T0>) : &address {
        &arg0.close_operator
    }

    public fun get_close_price<T0>(arg0: &Position<T0>) : u64 {
        arg0.close_price
    }

    public fun get_close_real_price<T0>(arg0: &Position<T0>) : u64 {
        arg0.close_real_price
    }

    public fun get_close_spread<T0>(arg0: &Position<T0>) : u64 {
        arg0.close_spread
    }

    public fun get_close_time<T0>(arg0: &Position<T0>) : u64 {
        arg0.close_time
    }

    public fun get_create_time<T0>(arg0: &Position<T0>) : u64 {
        arg0.create_time
    }

    public fun get_denominator128<T0>() : u64 {
        (10000 as u64)
    }

    public fun get_direction<T0>(arg0: &Position<T0>) : u8 {
        arg0.direction
    }

    public fun get_equity<T0, T1>(arg0: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root) : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64 {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_pfk_ids<T1>(arg1);
        let v1 = 0;
        let v2 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(0, false);
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid<T1>(arg1), *0x1::vector::borrow<0x2::object::ID>(&v0, v1));
            if (v3.status == 1) {
                let v4 = 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid(arg0), v3.market_id);
                let v5 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_price<T0, T1>(v4, arg2);
                let v6 = &v2;
                let v7 = get_position_fund_fee<T0, T1>(v4, v3);
                let v8 = get_pl<T1>(v3, &v5);
                let v9 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::i64_add(&v7, &v8);
                v2 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::i64_add(v6, &v9);
            };
            v1 = v1 + 1;
        };
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::inc_u64(&mut v2, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_balance<T1>(arg1));
        v2
    }

    public fun get_fund_size<T0>(arg0: &Position<T0>) : u64 {
        fund_size(arg0.size, arg0.lot, arg0.open_real_price)
    }

    public fun get_leverage<T0>(arg0: &Position<T0>) : u8 {
        arg0.leverage
    }

    public fun get_lot<T0>(arg0: &Position<T0>) : u64 {
        arg0.lot
    }

    public fun get_margin<T0>(arg0: &Position<T0>) : u64 {
        arg0.margin
    }

    public fun get_margin_balance<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.margin_balance)
    }

    public fun get_margin_size<T0, T1>(arg0: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &Position<T1>) : u64 {
        margin_size(get_fund_size<T1>(arg1), (arg1.leverage as u64), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_margin_fee<T0, T1>(arg0), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator())
    }

    public fun get_market_id<T0>(arg0: &Position<T0>) : &0x2::object::ID {
        &arg0.market_id
    }

    public fun get_open_operator<T0>(arg0: &Position<T0>) : &address {
        &arg0.open_operator
    }

    public fun get_open_price<T0>(arg0: &Position<T0>) : u64 {
        arg0.open_price
    }

    public fun get_open_real_price<T0>(arg0: &Position<T0>) : u64 {
        arg0.open_real_price
    }

    public fun get_open_spread<T0>(arg0: &Position<T0>) : u64 {
        arg0.open_spread
    }

    public fun get_open_time<T0>(arg0: &Position<T0>) : u64 {
        arg0.open_time
    }

    public fun get_pl<T0>(arg0: &Position<T0>, arg1: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Price) : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64 {
        if (arg0.direction == 1) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::u64_sub(fund_size(arg0.size, arg0.lot, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_sell_price(arg1)), get_fund_size<T0>(arg0))
        } else {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::u64_sub(get_fund_size<T0>(arg0), fund_size(arg0.size, arg0.lot, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_buy_price(arg1)))
        }
    }

    public fun get_position_fund_fee<T0, T1>(arg0: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &Position<T1>) : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64 {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_dominant_direction<T0, T1>(arg0);
        if (v0 == 3) {
            return 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(0, false)
        };
        if (arg1.direction == v0) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(get_fund_size<T1>(arg1) * 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_fund_fee<T0, T1>(arg0) / 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator(), true)
        } else {
            let v2 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_min_position_total<T0, T1>(arg0);
            if (v2 == 0) {
                return 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(0, false)
            };
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_max_position_total<T0, T1>(arg0) * 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_fund_fee<T0, T1>(arg0) / 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator() * get_fund_size<T1>(arg1) / v2, false)
        }
    }

    public fun get_profit<T0>(arg0: &Position<T0>) : &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64 {
        &arg0.profit
    }

    public fun get_size_value<T0>(arg0: &Position<T0>) : u64 {
        arg0.size
    }

    public fun get_stop_loss_price<T0>(arg0: &Position<T0>) : u64 {
        arg0.stop_loss_price
    }

    public fun get_stop_surplus_price<T0>(arg0: &Position<T0>) : u64 {
        arg0.stop_surplus_price
    }

    public fun get_type<T0>(arg0: &Position<T0>) : u8 {
        arg0.type
    }

    public fun get_validity_time<T0>(arg0: &Position<T0>) : u64 {
        arg0.validity_time
    }

    fun inc_margin<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: u8, arg3: u8, arg4: u64, arg5: u64) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_total<T1>(arg1, arg4);
        if (arg2 == 1) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_cross_total<T1>(arg1, arg4);
            if (arg3 == 1) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_cross_buy_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::inc_long_position_total<T0, T1>(arg0, arg5);
            } else {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_cross_sell_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::inc_short_position_total<T0, T1>(arg0, arg5);
            };
        } else {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_isolated_total<T1>(arg1, arg4);
            if (arg3 == 1) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_isolated_buy_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::inc_long_position_total<T0, T1>(arg0, arg5);
            } else {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_margin_isolated_sell_total<T1>(arg1, arg4);
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::inc_short_position_total<T0, T1>(arg0, arg5);
            };
        };
    }

    fun margin_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128) * (arg2 as u128) / (arg3 as u128)) as u64)
    }

    fun merge_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Price, arg3: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::PFK, arg4: u64, arg5: u8, arg6: u8, arg7: u64) : 0x1::option::Option<0x2::object::ID> {
        if (0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::contains_pfk<T1>(arg1, arg3)) {
            let v1 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_pfk_id<T1>(arg1, arg3);
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid_mut<T1>(arg1), v1);
            assert!(v2.status == 1, 607);
            let v3 = get_fund_size<T1>(v2);
            let v4 = fund_size(arg4, arg7, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_real_price(arg2));
            let v5 = ((v3 as u128) + (v4 as u128)) * 10000 / ((arg4 * arg7 + v2.size * v2.lot) as u128);
            assert!(v5 <= 18446744073709551615, 608);
            let v6 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_price_by_real<T0, T1>(arg0, (v5 as u64));
            v2.open_price = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_direction_price(&v6, arg6);
            v2.open_spread = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_spread(&v6);
            v2.open_real_price = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_real_price(&v6);
            v2.lot = v2.lot + arg7;
            v2.leverage = arg5;
            v2.open_time = 0;
            let v7 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_margin_fee<T0, T1>(arg0);
            let v8 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_denominator();
            let v9 = v2.type;
            let v10 = get_fund_size<T1>(v2);
            let v11 = margin_size(v10, (arg5 as u64), v7, v8);
            v2.margin = v11;
            let v12 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_exposure<T0, T1>(arg0);
            dec_margin<T0, T1>(arg0, arg1, v9, arg6, v2.margin, v3);
            inc_margin<T0, T1>(arg0, arg1, v9, arg6, v11, v10);
            risk_assertion<T0, T1>(arg0, v10, arg6, v12);
            collect_insurance<T0, T1>(arg0, arg1, margin_size(v4, (arg5 as u64), v7, v8));
            collect_spread<T0, T1>(arg0, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_spread(arg2), size(arg7, v2.size));
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Position<T1>>(v1);
            0x1::option::some<0x2::object::ID>(v1)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun open_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg3: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg4: u64, arg5: u8, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), arg1);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_status<T0, T1>(v0) == 1, 609);
        assert!(arg4 > 0, 602);
        assert!(arg5 > 0 && arg5 <= 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_max_leverage<T0, T1>(v0), 603);
        assert!(arg6 == 1 || arg6 == 2, 604);
        assert!(arg7 == 1 || arg7 == 2, 605);
        assert!(0x2::tx_context::sender(arg8) == 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_owner<T1>(arg2), 606);
        let v1 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_price<T0, T1>(v0, arg3);
        let v2 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_size<T0, T1>(v0);
        let v3 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::new_PFK(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(v0), 0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg2), arg7);
        let v4 = 0x1::option::none<0x2::object::ID>();
        let v5 = if (arg6 == 1) {
            let v6 = &mut v1;
            v4 = merge_position<T0, T1>(v0, arg2, v6, &v3, v2, arg5, arg7, arg4);
            0x1::option::is_some<0x2::object::ID>(&v4)
        } else {
            false
        };
        if (!v5) {
            let v7 = create_position_inner<T0, T1>(v0, arg2, arg5, arg6, arg7, arg4, &v1, arg8);
            let v8 = 0x2::object::uid_to_inner(&v7.id);
            0x2::dynamic_object_field::add<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid_mut<T1>(arg2), v8, v7);
            if (arg6 == 1) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::add_pfk_id<T1>(arg2, v3, v8);
            } else {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::add_isolated_position_id<T1>(arg2, v8);
            };
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::create<Position<T1>>(v8);
            v4 = 0x1::option::some<0x2::object::ID>(v8);
        };
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg2));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(v0));
        let v9 = get_equity<T0, T1>(arg0, arg2, arg3);
        check_margin<T1>(arg2, &v9);
        0x1::option::extract<0x2::object::ID>(&mut v4)
    }

    public fun process_fund_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_all_position_ids<T1>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Position<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::get_uid<T1>(arg1), *0x1::vector::borrow<0x2::object::ID>(&v0, v1));
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), v2.market_id);
            let v4 = get_position_fund_fee<T0, T1>(v3, v2);
            if (0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(&v4)) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::join_profit_balance<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(v3), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::split_balance<T1>(arg1, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v4)));
            } else {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::join_balance<T1>(arg1, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::split_profit_balance<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(v3), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v4)));
            };
            v1 = v1 + 1;
        };
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>>(arg1));
    }

    fun risk_assertion<T0, T1>(arg0: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: u64, arg2: u8, arg3: u64) {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_exposure<T0, T1>(arg0);
        let v1 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_total_liquidity<T0, T1>(arg0);
        if (v0 > v1 / 10000 * 7000) {
            assert!(v0 < arg3, 610);
        };
        assert!(arg1 < v1 / 10000 * 2000, 612);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_curr_position_total<T0, T1>(arg0, arg2) / 15000 < v1 / 10000, 613);
    }

    fun settlement_pl<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg3: &mut Position<T1>, arg4: address) {
        let v0 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_price<T0, T1>(arg0, arg2);
        arg3.close_spread = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_spread(&v0);
        arg3.close_price = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_direction_price(&v0, arg3.direction);
        arg3.close_real_price = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_real_price(&v0);
        arg3.close_time = 0;
        arg3.close_operator = arg4;
        collect_spread<T0, T1>(arg0, arg3.close_spread, size(arg3.lot, arg3.size));
        let v1 = get_pl<T1>(arg3, &v0);
        if (!0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(&v1)) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::join_balance<T1>(arg1, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::split_profit_balance<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(arg0), 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v1)));
        } else {
            let v2 = if (arg3.type == 1) {
                0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::split_balance<T1>(arg1, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v1))
            } else {
                0x2::balance::split<T1>(&mut arg3.margin_balance, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v1))
            };
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::join_profit_balance<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(arg0), v2);
        };
        let v3 = 0x2::balance::value<T1>(&arg3.margin_balance);
        if (v3 > 0) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::join_balance<T1>(arg1, 0x2::balance::split<T1>(&mut arg3.margin_balance, v3));
        };
        if (0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(&v1)) {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::dec_profit<T1>(arg1, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v1));
        } else {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::inc_profit<T1>(arg1, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&v1));
        };
        arg3.profit = v1;
        dec_margin<T0, T1>(arg0, arg1, arg3.type, arg3.direction, arg3.margin, get_fund_size<T1>(arg3));
        if (arg3.type == 1) {
            let v4 = 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::new_PFK(arg3.market_id, arg3.account_id, arg3.direction);
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::remove_pfk_id<T1>(arg1, &v4);
        } else {
            0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::remove_isolated_position_id<T1>(arg1, 0x2::object::uid_to_inner(&arg3.id));
        };
    }

    fun size(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0 as u128) / 10000;
        assert!(v0 <= 18446744073709551615, 608);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

