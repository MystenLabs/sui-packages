module 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::market {
    struct Offer<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        side: u8,
        maker: address,
        tokens: 0x2::balance::Balance<T0>,
        funds: 0x2::balance::Balance<T1>,
        price: u64,
        limit_price: u64,
        vesting_ms: u64,
        min_lot: u64,
        total_tokens: u64,
        filled_tokens: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct OfferListed<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        side: u8,
        maker: address,
        total_tokens: u64,
        price: u64,
        limit_price: u64,
        vesting_ms: u64,
        min_lot: u64,
        escrowed: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct OfferFilled<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        side: u8,
        taker: address,
        buyer: address,
        seller: address,
        tokens: u64,
        price: u64,
        cost: u64,
        buyer_fee: u64,
        seller_fee: u64,
        lock_id: 0x2::object::ID,
        vesting_ms: u64,
        left_tokens: u64,
        filled_ms: u64,
    }

    struct OfferClosed<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        reason: u8,
        tokens_returned: u64,
        funds_returned: u64,
        closed_ms: u64,
    }

    struct Bid<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        offer_id: 0x2::object::ID,
        offer_side: u8,
        bidder: address,
        tokens: u64,
        price: u64,
        vesting_ms: u64,
        funds: 0x2::balance::Balance<T1>,
        token_escrow: 0x2::balance::Balance<T0>,
        created_ms: u64,
        expires_ms: u64,
    }

    struct BidPlaced<phantom T0, phantom T1> has copy, drop {
        bid_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        offer_side: u8,
        bidder: address,
        tokens: u64,
        price: u64,
        vesting_ms: u64,
        escrowed: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct BidClosed<phantom T0, phantom T1> has copy, drop {
        bid_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        bidder: address,
        reason: u8,
        returned: u64,
        closed_ms: u64,
    }

    public fun accept_bid<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: &mut Offer<T0, T1>, arg2: Bid<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1.maker, 205);
        assert!(arg2.offer_id == 0x2::object::id<Offer<T0, T1>>(arg1), 214);
        assert!(arg2.offer_side == arg1.side, 200);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.expires_ms, 206);
        assert_fillable<T0, T1>(arg1, arg2.tokens, arg3);
        if (arg1.side == 0) {
            assert!(arg2.price >= arg1.limit_price, 215);
        } else {
            assert!(arg2.price <= arg1.limit_price, 215);
        };
        let v0 = 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_bps(arg0);
        let v1 = arg1.side == 0;
        let v2 = cost_of(arg2.tokens, arg2.price, v1);
        assert!(v2 > 0, 212);
        let v3 = fee_of(v2, v0, v1);
        let v4 = fee_of(v2, v0, v1);
        let Bid {
            id           : v5,
            offer_id     : _,
            offer_side   : _,
            bidder       : v8,
            tokens       : v9,
            price        : v10,
            vesting_ms   : v11,
            funds        : v12,
            token_escrow : v13,
            created_ms   : _,
            expires_ms   : _,
        } = arg2;
        let v16 = v12;
        let v17 = v5;
        let (v18, v19, v20) = if (v1) {
            assert!(0x2::balance::value<T1>(&v16) >= v2 + v3, 210);
            let v21 = 0x2::balance::split<T1>(&mut v16, v2 + v3);
            pay_out<T1>(0x2::balance::split<T1>(&mut v21, v3 + v4), 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_recipient(arg0), arg4);
            pay_out<T1>(v21, arg1.maker, arg4);
            pay_out<T1>(v16, v8, arg4);
            0x2::balance::destroy_zero<T0>(v13);
            let v22 = deliver<T0, T1>(arg1, v9, v8, arg3, arg4);
            (v22, v8, arg1.maker)
        } else {
            assert!(0x2::balance::value<T1>(&arg1.funds) >= v2 + v3, 210);
            let v23 = 0x2::balance::split<T1>(&mut arg1.funds, v2 + v3);
            pay_out<T1>(0x2::balance::split<T1>(&mut v23, v3 + v4), 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_recipient(arg0), arg4);
            pay_out<T1>(v23, v8, arg4);
            0x2::balance::destroy_zero<T1>(v16);
            let v24 = 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::new_lock<T0>(v13, 0x2::object::id<Offer<T0, T1>>(arg1), arg1.maker, v11, arg3, arg4);
            0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::keep<T0>(v24);
            (0x2::object::id<0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::VestingLock<T0>>(&v24), arg1.maker, v8)
        };
        0x2::object::delete(v17);
        arg1.filled_tokens = arg1.filled_tokens + v9;
        let v25 = BidClosed<T0, T1>{
            bid_id    : 0x2::object::uid_to_inner(&v17),
            offer_id  : 0x2::object::id<Offer<T0, T1>>(arg1),
            bidder    : v8,
            reason    : 0,
            returned  : 0,
            closed_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BidClosed<T0, T1>>(v25);
        let v26 = OfferFilled<T0, T1>{
            offer_id    : 0x2::object::id<Offer<T0, T1>>(arg1),
            side        : arg1.side,
            taker       : arg1.maker,
            buyer       : v19,
            seller      : v20,
            tokens      : v9,
            price       : v10,
            cost        : v2,
            buyer_fee   : v3,
            seller_fee  : v4,
            lock_id     : v18,
            vesting_ms  : v11,
            left_tokens : arg1.total_tokens - arg1.filled_tokens,
            filled_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OfferFilled<T0, T1>>(v26);
    }

    fun assert_biddable<T0, T1>(arg0: &Offer<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expires_ms, 206);
        assert!(arg2 >= 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::min_vesting_ms(arg4) && arg2 <= 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::max_vesting_ms(arg4), 202);
        assert!(arg3 > 0 && arg3 <= 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::max_listing_ms(arg4), 203);
        assert_fillable<T0, T1>(arg0, arg1, arg5);
    }

    fun assert_fillable<T0, T1>(arg0: &Offer<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_ms, 206);
        let v0 = arg0.total_tokens - arg0.filled_tokens;
        assert!(v0 > 0, 211);
        assert!(arg1 > 0 && arg1 <= v0, 204);
        assert!(arg1 >= arg0.min_lot || arg1 == v0, 209);
        let v1 = v0 - arg1;
        assert!(v1 == 0 || v1 >= arg0.min_lot, 208);
    }

    public fun bid_bidder<T0, T1>(arg0: &Bid<T0, T1>) : address {
        arg0.bidder
    }

    public fun bid_expires_ms<T0, T1>(arg0: &Bid<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun bid_funds<T0, T1>(arg0: &Bid<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.funds)
    }

    public fun bid_offer_id<T0, T1>(arg0: &Bid<T0, T1>) : 0x2::object::ID {
        arg0.offer_id
    }

    public fun bid_price<T0, T1>(arg0: &Bid<T0, T1>) : u64 {
        arg0.price
    }

    public fun bid_to_buy<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: &Offer<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_pay_allowed<T1>(arg0);
        assert!(arg1.side == 0, 200);
        assert!(0x2::tx_context::sender(arg8) != arg1.maker, 213);
        assert!(arg4 > 0, 201);
        assert_biddable<T0, T1>(arg1, arg3, arg5, arg6, arg0, arg7);
        let v0 = purchase_escrow(arg3, arg4, 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_bps(arg0));
        assert!(v0 > 0, 212);
        assert!(0x2::coin::value<T1>(&arg2) >= v0, 210);
        let v1 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v0, arg8));
        return_or_burn<T1>(arg2, arg8);
        place_bid<T0, T1>(arg1, v1, 0x2::balance::zero<T0>(), arg3, arg4, arg5, arg6, v0, arg7, arg8);
    }

    public fun bid_to_sell<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: &Offer<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_pay_allowed<T1>(arg0);
        assert!(arg1.side == 1, 200);
        assert!(0x2::tx_context::sender(arg7) != arg1.maker, 213);
        assert!(arg3 > 0, 201);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert_biddable<T0, T1>(arg1, v0, arg4, arg5, arg0, arg6);
        assert!(cost_of(v0, arg3, false) > 0, 212);
        place_bid<T0, T1>(arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(arg2), v0, arg3, arg4, arg5, v0, arg6, arg7);
    }

    public fun bid_token_escrow<T0, T1>(arg0: &Bid<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_escrow)
    }

    public fun bid_tokens<T0, T1>(arg0: &Bid<T0, T1>) : u64 {
        arg0.tokens
    }

    public fun bid_vesting_ms<T0, T1>(arg0: &Bid<T0, T1>) : u64 {
        arg0.vesting_ms
    }

    public fun buy<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: &mut Offer<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        assert!(arg1.side == 0, 200);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg1.maker, 213);
        assert_fillable<T0, T1>(arg1, arg3, arg4);
        let v1 = 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_bps(arg0);
        let v2 = cost_of(arg3, arg1.price, true);
        assert!(v2 > 0, 212);
        let v3 = fee_of(v2, v1, true);
        let v4 = fee_of(v2, v1, true);
        assert!(0x2::coin::value<T1>(&arg2) >= v2 + v3, 210);
        let v5 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v2 + v3, arg5));
        return_or_burn<T1>(arg2, arg5);
        pay_out<T1>(0x2::balance::split<T1>(&mut v5, v3 + v4), 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_recipient(arg0), arg5);
        pay_out<T1>(v5, arg1.maker, arg5);
        let v6 = deliver<T0, T1>(arg1, arg3, v0, arg4, arg5);
        arg1.filled_tokens = arg1.filled_tokens + arg3;
        let v7 = OfferFilled<T0, T1>{
            offer_id    : 0x2::object::id<Offer<T0, T1>>(arg1),
            side        : arg1.side,
            taker       : v0,
            buyer       : v0,
            seller      : arg1.maker,
            tokens      : arg3,
            price       : arg1.price,
            cost        : v2,
            buyer_fee   : v3,
            seller_fee  : v4,
            lock_id     : v6,
            vesting_ms  : arg1.vesting_ms,
            left_tokens : 0x2::balance::value<T0>(&arg1.tokens),
            filled_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<OfferFilled<T0, T1>>(v7);
    }

    public fun cancel<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: Offer<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.maker, 205);
        let v0 = if (arg1.filled_tokens == arg1.total_tokens) {
            0
        } else {
            1
        };
        close<T0, T1>(arg1, v0, arg2, arg3);
    }

    fun close<T0, T1>(arg0: Offer<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id            : v0,
            side          : _,
            maker         : v2,
            tokens        : v3,
            funds         : v4,
            price         : _,
            limit_price   : _,
            vesting_ms    : _,
            min_lot       : _,
            total_tokens  : _,
            filled_tokens : _,
            created_ms    : _,
            expires_ms    : _,
        } = arg0;
        let v13 = v4;
        let v14 = v3;
        pay_out<T0>(v14, v2, arg3);
        pay_out<T1>(v13, v2, arg3);
        let v15 = OfferClosed<T0, T1>{
            offer_id        : 0x2::object::id<Offer<T0, T1>>(&arg0),
            maker           : v2,
            reason          : arg1,
            tokens_returned : 0x2::balance::value<T0>(&v14),
            funds_returned  : 0x2::balance::value<T1>(&v13),
            closed_ms       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OfferClosed<T0, T1>>(v15);
        0x2::object::delete(v0);
    }

    fun close_bid<T0, T1>(arg0: Bid<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Bid {
            id           : v0,
            offer_id     : v1,
            offer_side   : _,
            bidder       : v3,
            tokens       : _,
            price        : _,
            vesting_ms   : _,
            funds        : v7,
            token_escrow : v8,
            created_ms   : _,
            expires_ms   : _,
        } = arg0;
        let v11 = v8;
        let v12 = v7;
        let v13 = v0;
        let v14 = if (0x2::balance::value<T1>(&v12) > 0) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v11)
        };
        pay_out<T1>(v12, v3, arg3);
        pay_out<T0>(v11, v3, arg3);
        let v15 = BidClosed<T0, T1>{
            bid_id    : 0x2::object::uid_to_inner(&v13),
            offer_id  : v1,
            bidder    : v3,
            reason    : arg1,
            returned  : v14,
            closed_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BidClosed<T0, T1>>(v15);
        0x2::object::delete(v13);
    }

    public fun cost_of(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::math::mul_div_up(arg0, arg1, 1000000000)
        } else {
            0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::math::mul_div(arg0, arg1, 1000000000)
        }
    }

    public fun created_ms<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.created_ms
    }

    fun deliver<T0, T1>(arg0: &mut Offer<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::new_lock<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg1), 0x2::object::id<Offer<T0, T1>>(arg0), arg2, arg0.vesting_ms, arg3, arg4);
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::keep<T0>(v0);
        0x2::object::id<0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::VestingLock<T0>>(&v0)
    }

    public fun expires_ms<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun fee_of(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::math::mul_div_up(arg0, arg1, 10000)
        } else {
            0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::math::mul_div(arg0, arg1, 10000)
        }
    }

    public fun filled_tokens<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.filled_tokens
    }

    public fun funds_escrowed<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.funds)
    }

    public fun limit_price<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.limit_price
    }

    public fun list_purchase<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_pay_allowed<T1>(arg0);
        assert!(arg2 > 0, 204);
        assert!(arg3 > 0 && arg4 >= arg3, 201);
        let v0 = purchase_escrow(arg2, arg3, 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_bps(arg0));
        assert!(v0 > 0, 212);
        assert!(0x2::coin::value<T1>(&arg1) >= v0, 210);
        let v1 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v0, arg9));
        return_or_burn<T1>(arg1, arg9);
        0x2::transfer::share_object<Offer<T0, T1>>(new_offer<T0, T1>(1, 0x2::balance::zero<T0>(), v1, arg2, arg3, arg4, arg5, arg6, arg7, arg0, arg8, arg9));
    }

    public fun list_sale<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_pay_allowed<T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 204);
        let v1 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg3 <= arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 201);
        assert!(cost_of(v0, arg2, false) > 0, 212);
        0x2::transfer::share_object<Offer<T0, T1>>(new_offer<T0, T1>(0, 0x2::coin::into_balance<T0>(arg1), 0x2::balance::zero<T1>(), v0, arg2, arg3, arg4, arg5, arg6, arg0, arg7, arg8));
    }

    public fun maker<T0, T1>(arg0: &Offer<T0, T1>) : address {
        arg0.maker
    }

    public fun min_lot<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.min_lot
    }

    fun new_offer<T0, T1>(arg0: u8, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : Offer<T0, T1> {
        assert!(arg6 >= 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::min_vesting_ms(arg9) && arg6 <= 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::max_vesting_ms(arg9), 202);
        assert!(arg8 > 0 && arg8 <= 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::max_listing_ms(arg9), 203);
        assert!(arg7 > 0 && arg7 <= arg3, 204);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = if (arg0 == 0) {
            0x2::balance::value<T0>(&arg1)
        } else {
            0x2::balance::value<T1>(&arg2)
        };
        let v2 = Offer<T0, T1>{
            id            : 0x2::object::new(arg11),
            side          : arg0,
            maker         : 0x2::tx_context::sender(arg11),
            tokens        : arg1,
            funds         : arg2,
            price         : arg4,
            limit_price   : arg5,
            vesting_ms    : arg6,
            min_lot       : arg7,
            total_tokens  : arg3,
            filled_tokens : 0,
            created_ms    : v0,
            expires_ms    : v0 + arg8,
        };
        let v3 = OfferListed<T0, T1>{
            offer_id     : 0x2::object::id<Offer<T0, T1>>(&v2),
            side         : arg0,
            maker        : v2.maker,
            total_tokens : arg3,
            price        : arg4,
            limit_price  : arg5,
            vesting_ms   : arg6,
            min_lot      : arg7,
            escrowed     : v1,
            created_ms   : v0,
            expires_ms   : v2.expires_ms,
        };
        0x2::event::emit<OfferListed<T0, T1>>(v3);
        v2
    }

    fun pay_out<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    fun place_bid<T0, T1>(arg0: &Offer<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = Bid<T0, T1>{
            id           : 0x2::object::new(arg9),
            offer_id     : 0x2::object::id<Offer<T0, T1>>(arg0),
            offer_side   : arg0.side,
            bidder       : 0x2::tx_context::sender(arg9),
            tokens       : arg3,
            price        : arg4,
            vesting_ms   : arg5,
            funds        : arg1,
            token_escrow : arg2,
            created_ms   : v0,
            expires_ms   : v0 + arg6,
        };
        let v2 = BidPlaced<T0, T1>{
            bid_id     : 0x2::object::id<Bid<T0, T1>>(&v1),
            offer_id   : v1.offer_id,
            offer_side : v1.offer_side,
            bidder     : v1.bidder,
            tokens     : arg3,
            price      : arg4,
            vesting_ms : arg5,
            escrowed   : arg7,
            created_ms : v0,
            expires_ms : v1.expires_ms,
        };
        0x2::event::emit<BidPlaced<T0, T1>>(v2);
        0x2::transfer::share_object<Bid<T0, T1>>(v1);
    }

    public fun price<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.price
    }

    public fun price_scale() : u64 {
        1000000000
    }

    public fun purchase_escrow(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = cost_of(arg0, arg1, true);
        v0 + fee_of(v0, arg2, true)
    }

    fun return_or_burn<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun sell<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: &mut Offer<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_open(arg0);
        assert!(arg1.side == 1, 200);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 != arg1.maker, 213);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert_fillable<T0, T1>(arg1, v1, arg3);
        let v2 = 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_bps(arg0);
        let v3 = cost_of(v1, arg1.price, false);
        assert!(v3 > 0, 212);
        let v4 = fee_of(v3, v2, false);
        let v5 = fee_of(v3, v2, false);
        assert!(0x2::balance::value<T1>(&arg1.funds) >= v3 + v4, 210);
        let v6 = 0x2::balance::split<T1>(&mut arg1.funds, v3 + v4);
        pay_out<T1>(0x2::balance::split<T1>(&mut v6, v4 + v5), 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::fee_recipient(arg0), arg4);
        pay_out<T1>(v6, v0, arg4);
        let v7 = 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::new_lock<T0>(0x2::coin::into_balance<T0>(arg2), 0x2::object::id<Offer<T0, T1>>(arg1), arg1.maker, arg1.vesting_ms, arg3, arg4);
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::keep<T0>(v7);
        arg1.filled_tokens = arg1.filled_tokens + v1;
        let v8 = OfferFilled<T0, T1>{
            offer_id    : 0x2::object::id<Offer<T0, T1>>(arg1),
            side        : arg1.side,
            taker       : v0,
            buyer       : arg1.maker,
            seller      : v0,
            tokens      : v1,
            price       : arg1.price,
            cost        : v3,
            buyer_fee   : v4,
            seller_fee  : v5,
            lock_id     : 0x2::object::id<0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting::VestingLock<T0>>(&v7),
            vesting_ms  : arg1.vesting_ms,
            left_tokens : arg1.total_tokens - arg1.filled_tokens,
            filled_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OfferFilled<T0, T1>>(v8);
    }

    public fun side<T0, T1>(arg0: &Offer<T0, T1>) : u8 {
        arg0.side
    }

    public fun side_purchase() : u8 {
        1
    }

    public fun side_sale() : u8 {
        0
    }

    public fun sweep_expired<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: Offer<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_ms, 207);
        close<T0, T1>(arg1, 2, arg2, arg3);
    }

    public fun sweep_expired_bid<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: Bid<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_ms, 207);
        close_bid<T0, T1>(arg1, 2, arg2, arg3);
    }

    public fun tokens_escrowed<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun tokens_left<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.total_tokens - arg0.filled_tokens
    }

    public fun total_tokens<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.total_tokens
    }

    public fun vesting_ms<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.vesting_ms
    }

    public fun withdraw_bid<T0, T1>(arg0: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg1: Bid<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.bidder, 216);
        close_bid<T0, T1>(arg1, 1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

