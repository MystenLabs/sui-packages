module 0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<T0>,
        raised_coin: 0x2::balance::Balance<0x2::sui::SUI>,
        raised_amount: u64,
        start_time: u64,
        end_time: u64,
        usr_min_buy: u64,
        usr_max_buy: u64,
        token_sell_rate: u64,
        soft_cap: u64,
        hard_cap: u64,
        whitelist: vector<address>,
        is_whitelist: bool,
        owner: address,
        claim_time: u64,
        vesting_times: u64,
        tge_percent: u64,
        cycle_percent: u64,
        cycle_time: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        amount: u64,
        claimTimes: u64,
    }

    struct Buy has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    entry fun add_presale<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id              : 0x2::object::new(arg13),
            coin            : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, 0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::mul_div(arg7, arg8, 0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::pow_10(6)), arg13)),
            raised_coin     : 0x2::balance::zero<0x2::sui::SUI>(),
            raised_amount   : 0,
            start_time      : arg1,
            end_time        : arg2,
            usr_min_buy     : arg3,
            usr_max_buy     : arg4,
            token_sell_rate : arg8,
            soft_cap        : arg6,
            hard_cap        : arg7,
            whitelist       : 0x1::vector::empty<address>(),
            is_whitelist    : arg5,
            owner           : 0x2::tx_context::sender(arg13),
            claim_time      : 0,
            vesting_times   : arg12,
            tge_percent     : arg9,
            cycle_percent   : arg10,
            cycle_time      : arg11,
        };
        0x2::transfer::share_object<Presale<T0>>(v0);
    }

    entry fun add_users<T0>(arg0: &mut Presale<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let (v1, _) = 0x1::vector::index_of<address>(&arg0.whitelist, 0x1::vector::borrow<address>(&arg1, v0));
            if (!v1) {
                0x1::vector::push_back<address>(&mut arg0.whitelist, *0x1::vector::borrow<address>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    fun assert_whitelist<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (arg0.is_whitelist) {
            let (v1, _) = 0x1::vector::index_of<address>(&arg0.whitelist, &v0);
            assert!(v1, 1);
        };
    }

    entry fun buy<T0>(arg0: &0x2::clock::Clock, arg1: &mut Presale<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_whitelist<T0>(arg1, arg3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.raised_coin, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        assert!(v0 >= arg1.usr_min_buy && v0 <= arg1.usr_max_buy, 2);
        assert!(arg1.raised_amount <= arg1.hard_cap, 3);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(v1 > arg1.start_time && v1 < arg1.end_time, 5);
        if (!0x2::dynamic_object_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg3))) {
            let v2 = Ticket{
                id         : 0x2::object::new(arg3),
                amount     : 0,
                claimTimes : 0,
            };
            0x2::dynamic_object_field::add<address, Ticket>(&mut arg1.id, 0x2::tx_context::sender(arg3), v2);
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<address, Ticket>(&mut arg1.id, 0x2::tx_context::sender(arg3));
        assert!(v3.amount + v0 <= arg1.usr_max_buy, 3);
        assert!(arg1.raised_amount + v0 <= arg1.hard_cap, 3);
        v3.amount = v3.amount + v0;
        arg1.raised_amount = arg1.raised_amount + v0;
    }

    entry fun claim<T0>(arg0: &0x2::clock::Clock, arg1: &mut Presale<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg2)), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, Ticket>(&mut arg1.id, 0x2::tx_context::sender(arg2));
        assert!(v0.amount > 0, 2);
        let v1 = if (arg1.claim_time == 0 || v0.claimTimes > arg1.vesting_times) {
            0
        } else {
            arg1.claim_time + v0.claimTimes * arg1.cycle_time
        };
        assert!(v1 > 0 && v1 < 0x2::clock::timestamp_ms(arg0), 7);
        let v2 = if (v0.claimTimes == 0) {
            0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::mul_div(0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::mul_div(v0.amount, arg1.token_sell_rate, 0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::pow_10(6)), arg1.tge_percent, 10000)
        } else {
            0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::mul_div(0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::mul_div(v0.amount, arg1.token_sell_rate, 0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::math::pow_10(6)), arg1.cycle_percent, 10000)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coin, v2, arg2), 0x2::tx_context::sender(arg2));
        v0.claimTimes = v0.claimTimes + 1;
    }

    entry fun open_claim<T0>(arg0: &mut Presale<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.claim_time = arg1;
    }

    entry fun remove_users<T0>(arg0: &mut Presale<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.whitelist, 0x1::vector::borrow<address>(&arg1, v0));
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.whitelist, v2);
            };
            v0 = v0 + 1;
        };
    }

    entry fun set_whitelist_status<T0>(arg0: &mut Presale<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.is_whitelist = arg1;
    }

    entry fun settings<T0>(arg0: &mut Presale<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        arg0.start_time = arg1;
        arg0.end_time = arg2;
        arg0.usr_min_buy = arg3;
        arg0.usr_max_buy = arg4;
    }

    entry fun withdraw_fund<T0>(arg0: &mut Presale<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.raised_coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun withdraw_token<T0>(arg0: &mut Presale<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

