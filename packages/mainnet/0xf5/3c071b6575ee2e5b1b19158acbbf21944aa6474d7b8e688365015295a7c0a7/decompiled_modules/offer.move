module 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer {
    struct LiquidityOffer<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        offer_balance: 0x2::balance::Balance<T0>,
        initial_offer_amount: u64,
        min_price: u64,
        max_price: u64,
        status: u8,
        expiry_timestamp_ms: u64,
        fill_policy: u8,
        min_fill_amount: u64,
        total_filled: u64,
        fill_count: u64,
        maker: address,
    }

    struct FillReceipt<phantom T0, phantom T1> {
        offer_balance: 0x2::balance::Balance<T0>,
        fill_amount: u64,
        payment_amount: u64,
        price: u64,
        is_full: bool,
    }

    fun assert_fillable<T0, T1>(arg0: &LiquidityOffer<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0 || arg0.status == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_not_fillable());
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expiry_timestamp_ms, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_expired());
    }

    public fun calc_payment(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 1000000000 - 1) / 1000000000) as u64)
    }

    public fun calculate_price(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    fun check_no_dust<T0, T1>(arg0: &LiquidityOffer<T0, T1>, arg1: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.offer_balance) - arg1;
        if (v0 > 0 && arg0.min_fill_amount > 0) {
            assert!(v0 >= arg0.min_fill_amount, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::would_leave_dust());
        };
    }

    public fun create<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_amount());
        assert!(arg1 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_min_price());
        assert!(arg2 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_max_price());
        assert!(arg1 <= arg2, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::invalid_price_bounds());
        assert!(arg4 == 0 || arg4 == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::invalid_fill_policy());
        assert!(arg3 > 0x2::clock::timestamp_ms(arg6), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::expired_on_create());
        if (arg4 == 1) {
            assert!(arg5 <= v0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::min_fill_exceeds_amount());
        };
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = LiquidityOffer<T0, T1>{
            id                   : 0x2::object::new(arg7),
            offer_balance        : 0x2::coin::into_balance<T0>(arg0),
            initial_offer_amount : v0,
            min_price            : arg1,
            max_price            : arg2,
            status               : 0,
            expiry_timestamp_ms  : arg3,
            fill_policy          : arg4,
            min_fill_amount      : arg5,
            total_filled         : 0,
            fill_count           : 0,
            maker                : v1,
        };
        let v3 = 0x2::object::id<LiquidityOffer<T0, T1>>(&v2);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_created(v3, v1, v0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_share_object<LiquidityOffer<T0, T1>>(v2);
        v3
    }

    public fun expire<T0, T1>(arg0: LiquidityOffer<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_timestamp_ms, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::not_yet_expired());
        assert!(arg0.status == 0 || arg0.status == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::invalid_status_for_expire());
        let LiquidityOffer {
            id                   : v0,
            offer_balance        : v1,
            initial_offer_amount : _,
            min_price            : _,
            max_price            : _,
            status               : _,
            expiry_timestamp_ms  : _,
            fill_policy          : _,
            min_fill_amount      : _,
            total_filled         : v9,
            fill_count           : _,
            maker                : v11,
        } = arg0;
        let v12 = v1;
        let v13 = v0;
        let v14 = 0x2::balance::value<T0>(&v12);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_expired(0x2::object::uid_to_inner(&v13), v14, v9);
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg2), v11);
        } else {
            0x2::balance::destroy_zero<T0>(v12);
        };
        0x2::object::delete(v13);
    }

    public fun expiry_timestamp_ms<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u64 {
        arg0.expiry_timestamp_ms
    }

    public fun fill_count<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u64 {
        arg0.fill_count
    }

    public fun fill_full<T0, T1>(arg0: &mut LiquidityOffer<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (FillReceipt<T0, T1>, 0x2::coin::Coin<T1>) {
        assert_fillable<T0, T1>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(&arg0.offer_balance);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = calculate_price(v1, v0);
        validate_price_bounds(v2, arg0.min_price, arg0.max_price);
        arg0.total_filled = arg0.total_filled + v0;
        arg0.fill_count = arg0.fill_count + 1;
        arg0.status = 2;
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_filled(0x2::object::id<LiquidityOffer<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), v0, v1, v2, true, 0);
        let v3 = FillReceipt<T0, T1>{
            offer_balance  : 0x2::balance::split<T0>(&mut arg0.offer_balance, v0),
            fill_amount    : v0,
            payment_amount : v1,
            price          : v2,
            is_full        : true,
        };
        (v3, arg1)
    }

    public fun fill_full_and_settle<T0, T1>(arg0: &mut LiquidityOffer<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.maker;
        let v1 = 0x2::tx_context::sender(arg3);
        let (v2, v3) = fill_full<T0, T1>(arg0, arg1, arg2, arg3);
        let (v4, _, _, _, _) = unpack_receipt<T0, T1>(v2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public fun fill_partial<T0, T1>(arg0: &mut LiquidityOffer<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (FillReceipt<T0, T1>, 0x2::coin::Coin<T1>) {
        assert_fillable<T0, T1>(arg0, arg3);
        assert!(arg0.fill_policy == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::partial_fill_not_allowed());
        assert!(arg1 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_amount());
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.offer_balance), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::fill_exceeds_remaining());
        assert!(arg1 >= arg0.min_fill_amount, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::fill_below_minimum());
        check_no_dust<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = calculate_price(v0, arg1);
        validate_price_bounds(v1, arg0.min_price, arg0.max_price);
        arg0.total_filled = arg0.total_filled + arg1;
        arg0.fill_count = arg0.fill_count + 1;
        let v2 = 0x2::balance::value<T0>(&arg0.offer_balance);
        let v3 = v2 == 0;
        if (v3) {
            arg0.status = 2;
        } else {
            arg0.status = 1;
        };
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_filled(0x2::object::id<LiquidityOffer<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), arg1, v0, v1, v3, v2);
        let v4 = FillReceipt<T0, T1>{
            offer_balance  : 0x2::balance::split<T0>(&mut arg0.offer_balance, arg1),
            fill_amount    : arg1,
            payment_amount : v0,
            price          : v1,
            is_full        : v3,
        };
        (v4, arg2)
    }

    public fun fill_partial_and_settle<T0, T1>(arg0: &mut LiquidityOffer<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.maker;
        let v1 = 0x2::tx_context::sender(arg4);
        let (v2, v3) = fill_partial<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let (v4, _, _, _, _) = unpack_receipt<T0, T1>(v2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public fun fill_policy<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u8 {
        arg0.fill_policy
    }

    public fun fill_policy_full_only() : u8 {
        0
    }

    public fun fill_policy_partial_allowed() : u8 {
        1
    }

    public fun initial_amount<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u64 {
        arg0.initial_offer_amount
    }

    public fun is_fillable<T0, T1>(arg0: &LiquidityOffer<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        (arg0.status == 0 || arg0.status == 1) && 0x2::clock::timestamp_ms(arg1) < arg0.expiry_timestamp_ms
    }

    public fun maker<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : address {
        arg0.maker
    }

    public fun min_fill_amount<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u64 {
        arg0.min_fill_amount
    }

    public fun offer_id<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : 0x2::object::ID {
        0x2::object::id<LiquidityOffer<T0, T1>>(arg0)
    }

    public fun price_bounds<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : (u64, u64) {
        (arg0.min_price, arg0.max_price)
    }

    public fun quote_fill_amount<T0, T1>(arg0: &LiquidityOffer<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.offer_balance);
        assert!(arg0.status == 0 || arg0.status == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_not_fillable());
        assert!(arg1 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_amount());
        assert!(arg2 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_min_price());
        assert!(arg2 >= arg0.min_price, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_too_low());
        assert!(arg2 <= arg0.max_price, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_too_high());
        let v1 = (((arg1 as u128) * 1000000000 / (arg2 as u128)) as u64);
        if (v1 > v0) {
            v0
        } else {
            v1
        }
    }

    public fun quote_pay_amount<T0, T1>(arg0: &LiquidityOffer<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.offer_balance);
        assert!(arg0.status == 0 || arg0.status == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_not_fillable());
        assert!(arg1 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_amount());
        assert!(arg1 <= v0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::fill_exceeds_remaining());
        if (arg1 < v0) {
            assert!(arg0.fill_policy == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::partial_fill_not_allowed());
            assert!(arg1 >= arg0.min_fill_amount, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::fill_below_minimum());
            let v1 = v0 - arg1;
            if (v1 > 0) {
                assert!(v1 >= arg0.min_fill_amount, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::would_leave_dust());
            };
        };
        assert!(arg2 >= arg0.min_price, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_too_low());
        assert!(arg2 <= arg0.max_price, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_too_high());
        let v2 = 1000000000;
        ((((arg1 as u128) * (arg2 as u128) + v2 - 1) / v2) as u64)
    }

    public fun remaining_amount<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.offer_balance)
    }

    public fun status<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u8 {
        arg0.status
    }

    public fun status_created() : u8 {
        0
    }

    public fun status_expired() : u8 {
        3
    }

    public fun status_filled() : u8 {
        2
    }

    public fun status_partially_filled() : u8 {
        1
    }

    public fun status_withdrawn() : u8 {
        4
    }

    public fun total_filled<T0, T1>(arg0: &LiquidityOffer<T0, T1>) : u64 {
        arg0.total_filled
    }

    public fun unpack_receipt<T0, T1>(arg0: FillReceipt<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64, u64, bool) {
        let FillReceipt {
            offer_balance  : v0,
            fill_amount    : v1,
            payment_amount : v2,
            price          : v3,
            is_full        : v4,
        } = arg0;
        (0x2::coin::from_balance<T0>(v0, arg1), v1, v2, v3, v4)
    }

    fun validate_price_bounds(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_too_low());
        assert!(arg0 <= arg2, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_too_high());
    }

    public fun withdraw<T0, T1>(arg0: LiquidityOffer<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::not_maker());
        assert!(arg0.status == 0 || arg0.status == 1, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::invalid_status_for_withdraw());
        let LiquidityOffer {
            id                   : v0,
            offer_balance        : v1,
            initial_offer_amount : _,
            min_price            : _,
            max_price            : _,
            status               : _,
            expiry_timestamp_ms  : _,
            fill_policy          : _,
            min_fill_amount      : _,
            total_filled         : v9,
            fill_count           : _,
            maker                : v11,
        } = arg0;
        let v12 = v1;
        let v13 = v0;
        let v14 = 0x2::balance::value<T0>(&v12);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_withdrawn(0x2::object::uid_to_inner(&v13), v11, v14, v9);
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg1), v11);
        } else {
            0x2::balance::destroy_zero<T0>(v12);
        };
        0x2::object::delete(v13);
    }

    // decompiled from Move bytecode v6
}

