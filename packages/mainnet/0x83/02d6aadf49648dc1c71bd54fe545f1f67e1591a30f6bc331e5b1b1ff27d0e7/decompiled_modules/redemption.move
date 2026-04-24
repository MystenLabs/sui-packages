module 0x8302d6aadf49648dc1c71bd54fe545f1f67e1591a30f6bc331e5b1b1ff27d0e7::redemption {
    struct RedemptionVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        reserve: 0x2::balance::Balance<T1>,
        creator: address,
        rate_numerator: u64,
        rate_denominator: u64,
        opens_at: u64,
        closes_at: u64,
        total_coins_redeemed: u64,
        total_reserve_paid: u64,
        is_closed: bool,
    }

    struct RedemptionOpened<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        reserve_amount: u64,
        rate_numerator: u64,
        rate_denominator: u64,
        opens_at: u64,
        closes_at: u64,
    }

    struct CoinsRedeemed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        redeemer: address,
        coin_amount: u64,
        reserve_amount: u64,
    }

    struct RedemptionClosed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        total_coins_redeemed: u64,
        total_reserve_paid: u64,
        remaining_reserve: u64,
    }

    public fun calculate_redemption_amount<T0, T1>(arg0: &RedemptionVault<T0, T1>, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.rate_numerator as u128) / (arg0.rate_denominator as u128)) as u64)
    }

    public fun close_redemption<T0, T1>(arg0: RedemptionVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        assert!(!arg0.is_closed, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.closes_at, 2);
        let RedemptionVault {
            id                   : v0,
            treasury_cap         : v1,
            reserve              : v2,
            creator              : _,
            rate_numerator       : _,
            rate_denominator     : _,
            opens_at             : _,
            closes_at            : _,
            total_coins_redeemed : v8,
            total_reserve_paid   : v9,
            is_closed            : _,
        } = arg0;
        let v11 = v2;
        let v12 = v0;
        let v13 = RedemptionClosed<T0, T1>{
            vault_id             : 0x2::object::uid_to_inner(&v12),
            total_coins_redeemed : v8,
            total_reserve_paid   : v9,
            remaining_reserve    : 0x2::balance::value<T1>(&v11),
        };
        0x2::event::emit<RedemptionClosed<T0, T1>>(v13);
        0x2::object::delete(v12);
        (v1, 0x2::coin::from_balance<T1>(v11, arg2))
    }

    public fun emergency_close<T0, T1>(arg0: RedemptionVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        assert!(!arg0.is_closed, 6);
        let RedemptionVault {
            id                   : v0,
            treasury_cap         : v1,
            reserve              : v2,
            creator              : _,
            rate_numerator       : _,
            rate_denominator     : _,
            opens_at             : _,
            closes_at            : _,
            total_coins_redeemed : v8,
            total_reserve_paid   : v9,
            is_closed            : _,
        } = arg0;
        let v11 = v2;
        let v12 = v0;
        let v13 = RedemptionClosed<T0, T1>{
            vault_id             : 0x2::object::uid_to_inner(&v12),
            total_coins_redeemed : v8,
            total_reserve_paid   : v9,
            remaining_reserve    : 0x2::balance::value<T1>(&v11),
        };
        0x2::event::emit<RedemptionClosed<T0, T1>>(v13);
        0x2::object::delete(v12);
        (v1, 0x2::coin::from_balance<T1>(v11, arg1))
    }

    public fun get_vault_info<T0, T1>(arg0: &RedemptionVault<T0, T1>) : (address, u64, u64, u64, u64, u64, u64, u64, bool) {
        (arg0.creator, 0x2::balance::value<T1>(&arg0.reserve), arg0.rate_numerator, arg0.rate_denominator, arg0.opens_at, arg0.closes_at, arg0.total_coins_redeemed, arg0.total_reserve_paid, arg0.is_closed)
    }

    public fun is_redemption_active<T0, T1>(arg0: &RedemptionVault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.is_closed) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.opens_at && v0 < arg0.closes_at
    }

    public fun open_redemption<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg3 > 0, 4);
        assert!(arg5 > arg4, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = RedemptionVault<T0, T1>{
            id                   : v1,
            treasury_cap         : arg0,
            reserve              : 0x2::coin::into_balance<T1>(arg1),
            creator              : v0,
            rate_numerator       : arg2,
            rate_denominator     : arg3,
            opens_at             : arg4,
            closes_at            : arg5,
            total_coins_redeemed : 0,
            total_reserve_paid   : 0,
            is_closed            : false,
        };
        let v4 = RedemptionOpened<T0, T1>{
            vault_id         : v2,
            creator          : v0,
            reserve_amount   : 0x2::coin::value<T1>(&arg1),
            rate_numerator   : arg2,
            rate_denominator : arg3,
            opens_at         : arg4,
            closes_at        : arg5,
        };
        0x2::event::emit<RedemptionOpened<T0, T1>>(v4);
        0x2::transfer::share_object<RedemptionVault<T0, T1>>(v3);
        v2
    }

    public fun redeem<T0, T1>(arg0: &mut RedemptionVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_closed, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.opens_at && v0 < arg0.closes_at, 1);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 4);
        let v2 = (((v1 as u128) * (arg0.rate_numerator as u128) / (arg0.rate_denominator as u128)) as u64);
        assert!(0x2::balance::value<T1>(&arg0.reserve) >= v2, 3);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        arg0.total_coins_redeemed = arg0.total_coins_redeemed + v1;
        arg0.total_reserve_paid = arg0.total_reserve_paid + v2;
        let v3 = CoinsRedeemed<T0, T1>{
            vault_id       : 0x2::object::id<RedemptionVault<T0, T1>>(arg0),
            redeemer       : 0x2::tx_context::sender(arg3),
            coin_amount    : v1,
            reserve_amount : v2,
        };
        0x2::event::emit<CoinsRedeemed<T0, T1>>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve, v2), arg3)
    }

    // decompiled from Move bytecode v6
}

