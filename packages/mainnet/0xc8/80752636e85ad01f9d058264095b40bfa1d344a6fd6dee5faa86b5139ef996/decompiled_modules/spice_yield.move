module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_yield {
    struct SpiceYieldVault has key {
        id: 0x2::object::UID,
        coin: 0x1::ascii::String,
        ref_value: u64,
        apr_bps: u64,
        start_day: u64,
        paused: bool,
        funds: u64,
        funded_total: u64,
        paid_total: u64,
        records: 0x2::table::Table<0x2::object::ID, Accrual>,
    }

    struct Accrual has drop, store {
        last_day: u64,
        unpaid: u64,
    }

    struct FundsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultOpened has copy, drop {
        vault_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        ref_value: u64,
        apr_bps: u64,
        start_day: u64,
    }

    struct HbtcFunded has copy, drop {
        amount: u64,
        from: address,
    }

    struct HbtcCollected has copy, drop {
        spice_id: 0x2::object::ID,
        holder: address,
        amount: u64,
        days: u64,
        unpaid: u64,
    }

    public fun balance(arg0: &SpiceYieldVault) : u64 {
        arg0.funds
    }

    public fun coin(arg0: &SpiceYieldVault) : 0x1::ascii::String {
        arg0.coin
    }

    public fun apr_bps(arg0: &SpiceYieldVault) : u64 {
        arg0.apr_bps
    }

    fun coin_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public fun collect<T0>(arg0: &mut SpiceYieldVault, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.paused, 5);
        assert!(arg0.coin == coin_name<T0>(), 1);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) <= 200, 4);
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(0x2::clock::timestamp_ms(arg4));
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v2);
            assert!(0x2::kiosk::has_item_with_type<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>(arg1, v3), 3);
            if (!0x2::table::contains<0x2::object::ID, Accrual>(&arg0.records, v3)) {
                let v4 = Accrual{
                    last_day : first_day(arg0, 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::minted_ms(0x2::kiosk::borrow<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>(arg1, arg2, v3))),
                    unpaid   : 0,
                };
                0x2::table::add<0x2::object::ID, Accrual>(&mut arg0.records, v3, v4);
            };
            let v5 = 0x2::table::borrow<0x2::object::ID, Accrual>(&arg0.records, v3);
            let v6 = v5.last_day;
            let v7 = if (v0 > v6) {
                v0 - v6
            } else {
                0
            };
            let v8 = earned_for_days(arg0, v7) + v5.unpaid;
            let v9 = arg0.funds;
            let v10 = if (v8 < v9) {
                v8
            } else {
                v9
            };
            let v11 = 0x2::table::borrow_mut<0x2::object::ID, Accrual>(&mut arg0.records, v3);
            v11.unpaid = v8 - v10;
            if (v0 > v11.last_day) {
                v11.last_day = v0;
            };
            if (v10 > 0) {
                let v12 = funds_mut<T0>(arg0);
                0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(v12, v10));
                arg0.funds = arg0.funds - v10;
                arg0.paid_total = arg0.paid_total + v10;
            };
            let v13 = HbtcCollected{
                spice_id : v3,
                holder   : 0x2::tx_context::sender(arg5),
                amount   : v10,
                days     : v7,
                unpaid   : v8 - v10,
            };
            0x2::event::emit<HbtcCollected>(v13);
            v2 = v2 + 1;
        };
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    public fun default_apr_bps() : u64 {
        1700
    }

    public fun earned_for_days(arg0: &SpiceYieldVault, arg1: u64) : u64 {
        (((arg0.ref_value as u128) * (arg0.apr_bps as u128) * (arg1 as u128) / 3650000) as u64)
    }

    fun first_day(arg0: &SpiceYieldVault, arg1: u64) : u64 {
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(arg1);
        if (v0 > arg0.start_day) {
            v0
        } else {
            arg0.start_day
        }
    }

    public fun fund<T0>(arg0: &mut SpiceYieldVault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = funds_mut<T0>(arg0);
        0x2::balance::join<T0>(v1, 0x2::coin::into_balance<T0>(arg1));
        arg0.funds = arg0.funds + v0;
        arg0.funded_total = arg0.funded_total + v0;
        let v2 = HbtcFunded{
            amount : v0,
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<HbtcFunded>(v2);
    }

    fun funds_mut<T0>(arg0: &mut SpiceYieldVault) : &mut 0x2::balance::Balance<T0> {
        assert!(arg0.coin == coin_name<T0>(), 1);
        let v0 = FundsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FundsKey>(&arg0.id, v0)) {
            let v1 = FundsKey{dummy_field: false};
            0x2::dynamic_field::add<FundsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = FundsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FundsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2)
    }

    public fun is_paused(arg0: &SpiceYieldVault) : bool {
        arg0.paused
    }

    fun new_vault<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SpiceYieldVault {
        assert!(arg1 <= 5000, 2);
        assert!(arg0 > 0, 6);
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(0x2::clock::timestamp_ms(arg2));
        let v1 = SpiceYieldVault{
            id           : 0x2::object::new(arg3),
            coin         : coin_name<T0>(),
            ref_value    : arg0,
            apr_bps      : arg1,
            start_day    : v0,
            paused       : false,
            funds        : 0,
            funded_total : 0,
            paid_total   : 0,
            records      : 0x2::table::new<0x2::object::ID, Accrual>(arg3),
        };
        let v2 = VaultOpened{
            vault_id  : 0x2::object::id<SpiceYieldVault>(&v1),
            coin      : v1.coin,
            ref_value : arg0,
            apr_bps   : arg1,
            start_day : v0,
        };
        0x2::event::emit<VaultOpened>(v2);
        v1
    }

    public fun open<T0>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_vault<T0>(arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<SpiceYieldVault>(v0);
        0x2::object::id<SpiceYieldVault>(&v0)
    }

    public fun open_funded<T0>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_vault<T0>(arg1, arg2, arg4, arg5);
        let v1 = &mut v0;
        fund<T0>(v1, arg3, arg5);
        0x2::transfer::share_object<SpiceYieldVault>(v0);
        0x2::object::id<SpiceYieldVault>(&v0)
    }

    public fun owed_for(arg0: &SpiceYieldVault, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(0x2::clock::timestamp_ms(arg3));
        let (v1, v2) = if (0x2::table::contains<0x2::object::ID, Accrual>(&arg0.records, arg1)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, Accrual>(&arg0.records, arg1);
            (v3.last_day, v3.unpaid)
        } else {
            (first_day(arg0, arg2), 0)
        };
        let v4 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        earned_for_days(arg0, v4) + v2
    }

    public fun paid_total(arg0: &SpiceYieldVault) : u64 {
        arg0.paid_total
    }

    public fun ref_value(arg0: &SpiceYieldVault) : u64 {
        arg0.ref_value
    }

    public fun set_params(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut SpiceYieldVault, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg3 <= 5000, 2);
        assert!(arg2 > 0, 6);
        arg1.ref_value = arg2;
        arg1.apr_bps = arg3;
        arg1.paused = arg4;
    }

    public fun start_day(arg0: &SpiceYieldVault) : u64 {
        arg0.start_day
    }

    public fun withdraw<T0>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut SpiceYieldVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = funds_mut<T0>(arg1);
        arg1.funds = arg1.funds - arg2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

