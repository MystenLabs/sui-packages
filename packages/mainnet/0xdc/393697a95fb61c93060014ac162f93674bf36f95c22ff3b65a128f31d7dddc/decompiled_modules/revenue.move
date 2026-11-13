module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue {
    struct Revenue has key {
        id: 0x2::object::UID,
        currencies: vector<0x1::type_name::TypeName>,
    }

    struct PoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CurrencyPool<phantom T0> has store {
        pending: 0x2::balance::Balance<T0>,
        vault: 0x2::balance::Balance<T0>,
        acc_per_seal: u128,
        seals: u64,
        day: u64,
        fees_total: u64,
        paid_total: u64,
        debts: 0x2::table::Table<0x2::object::ID, u128>,
    }

    struct FeeCollected has copy, drop {
        currency: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct DayRolled has copy, drop {
        currency: 0x1::type_name::TypeName,
        day: u64,
        amount: u64,
        seals: u64,
    }

    struct ShareClaimed has copy, drop {
        currency: 0x1::type_name::TypeName,
        seal_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    public fun join<T0>(arg0: &mut Revenue, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::prove(arg1, arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        ensure_pool<T0>(arg0, v0, arg5);
        let v1 = PoolKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, CurrencyPool<T0>>(&mut arg0.id, v1);
        roll_pool<T0>(v2, v0);
        if (0x2::table::contains<0x2::object::ID, u128>(&v2.debts, arg3)) {
            return false
        };
        0x2::table::add<0x2::object::ID, u128>(&mut v2.debts, arg3, v2.acc_per_seal);
        v2.seals = v2.seals + 1;
        true
    }

    public fun claim<T0>(arg0: &mut Revenue, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        join<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = PoolKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, CurrencyPool<T0>>(&mut arg0.id, v0);
        let v2 = owed<T0>(v1, arg3);
        *0x2::table::borrow_mut<0x2::object::ID, u128>(&mut v1.debts, arg3) = v1.acc_per_seal;
        v1.paid_total = v1.paid_total + v2;
        let v3 = ShareClaimed{
            currency : 0x1::type_name::with_original_ids<T0>(),
            seal_id  : arg3,
            amount   : v2,
            to       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ShareClaimed>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.vault, v2), arg5)
    }

    public fun claim_nonzero<T0>(arg0: &mut Revenue, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v0) > 0, 2);
        v0
    }

    public fun claimable<T0>(arg0: &Revenue, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = PoolKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PoolKey<T0>, CurrencyPool<T0>>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = PoolKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<PoolKey<T0>, CurrencyPool<T0>>(&arg0.id, v1);
        let v3 = if (v2.seals == 0 || !0x2::table::contains<0x2::object::ID, u128>(&v2.debts, arg1)) {
            0
        } else {
            0x2::balance::value<T0>(&v2.pending) / v2.seals
        };
        (owed<T0>(v2, arg1), v3)
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Revenue {
        Revenue{
            id         : 0x2::object::new(arg0),
            currencies : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun currencies(arg0: &Revenue) : vector<0x1::type_name::TypeName> {
        arg0.currencies
    }

    public fun day_of(arg0: u64) : u64 {
        if (arg0 < 50400000) {
            0
        } else {
            (arg0 - 50400000) / 86400000
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Revenue, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        ensure_pool<T0>(arg0, v0, arg3);
        let v1 = PoolKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, CurrencyPool<T0>>(&mut arg0.id, v1);
        roll_pool<T0>(v2, v0);
        let v3 = 0x2::balance::value<T0>(&arg1);
        v2.fees_total = v2.fees_total + v3;
        0x2::balance::join<T0>(&mut v2.pending, arg1);
        let v4 = FeeCollected{
            currency : 0x1::type_name::with_original_ids<T0>(),
            amount   : v3,
        };
        0x2::event::emit<FeeCollected>(v4);
    }

    fun ensure_pool<T0>(arg0: &mut Revenue, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PoolKey<T0>, CurrencyPool<T0>>(&arg0.id, v0)) {
            let v1 = PoolKey<T0>{dummy_field: false};
            let v2 = CurrencyPool<T0>{
                pending      : 0x2::balance::zero<T0>(),
                vault        : 0x2::balance::zero<T0>(),
                acc_per_seal : 0,
                seals        : 0,
                day          : day_of(arg1),
                fees_total   : 0,
                paid_total   : 0,
                debts        : 0x2::table::new<0x2::object::ID, u128>(arg2),
            };
            0x2::dynamic_field::add<PoolKey<T0>, CurrencyPool<T0>>(&mut arg0.id, v1, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.currencies, 0x1::type_name::with_original_ids<T0>());
        };
    }

    public fun has_pool<T0>(arg0: &Revenue) : bool {
        let v0 = PoolKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<PoolKey<T0>, CurrencyPool<T0>>(&arg0.id, v0)
    }

    fun owed<T0>(arg0: &CurrencyPool<T0>, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, u128>(&arg0.debts, arg1)) {
            return 0
        };
        (((arg0.acc_per_seal - *0x2::table::borrow<0x2::object::ID, u128>(&arg0.debts, arg1)) / 1000000000000000000) as u64)
    }

    public fun pool_stats<T0>(arg0: &Revenue) : (u64, u64, u64, u64, u64) {
        let v0 = PoolKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PoolKey<T0>, CurrencyPool<T0>>(&arg0.id, v0);
        (0x2::balance::value<T0>(&v1.pending), 0x2::balance::value<T0>(&v1.vault), v1.seals, v1.fees_total, v1.paid_total)
    }

    public fun roll<T0>(arg0: &mut Revenue, arg1: &0x2::clock::Clock) {
        let v0 = PoolKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PoolKey<T0>, CurrencyPool<T0>>(&arg0.id, v0), 1);
        let v1 = PoolKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, CurrencyPool<T0>>(&mut arg0.id, v1);
        roll_pool<T0>(v2, 0x2::clock::timestamp_ms(arg1));
    }

    fun roll_pool<T0>(arg0: &mut CurrencyPool<T0>, arg1: u64) {
        let v0 = day_of(arg1);
        if (v0 <= arg0.day) {
            return
        };
        let v1 = 0x2::balance::value<T0>(&arg0.pending);
        if (v1 > 0 && arg0.seals > 0) {
            arg0.acc_per_seal = arg0.acc_per_seal + (v1 as u128) * 1000000000000000000 / (arg0.seals as u128);
            0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.pending, v1));
            let v2 = DayRolled{
                currency : 0x1::type_name::with_original_ids<T0>(),
                day      : arg0.day,
                amount   : v1,
                seals    : arg0.seals,
            };
            0x2::event::emit<DayRolled>(v2);
        };
        arg0.day = v0;
    }

    public(friend) fun share(arg0: Revenue) {
        0x2::transfer::share_object<Revenue>(arg0);
    }

    // decompiled from Move bytecode v7
}

