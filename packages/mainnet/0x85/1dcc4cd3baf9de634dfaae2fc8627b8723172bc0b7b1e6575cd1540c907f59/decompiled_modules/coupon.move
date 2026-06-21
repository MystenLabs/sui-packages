module 0x851dcc4cd3baf9de634dfaae2fc8627b8723172bc0b7b1e6575cd1540c907f59::coupon {
    struct Coupon has key {
        id: 0x2::object::UID,
        campaign: 0x2::object::ID,
        value: u64,
        min_subtotal: u64,
        expires_at_ms: u64,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        paused: bool,
        per_tx_cap: u64,
    }

    struct TreasuryAdminCap has store, key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
    }

    struct CouponMinted has copy, drop {
        coupon_id: 0x2::object::ID,
        campaign: 0x2::object::ID,
        value: u64,
        recipient: address,
    }

    struct CouponRedeemed has copy, drop {
        coupon_id: 0x2::object::ID,
        campaign: 0x2::object::ID,
        value: u64,
        merchant: address,
        treasury_id: 0x2::object::ID,
        intent_ref: vector<u8>,
    }

    public fun value(arg0: &Coupon) : u64 {
        arg0.value
    }

    fun assert_admin<T0>(arg0: &Treasury<T0>, arg1: &TreasuryAdminCap) {
        assert!(arg1.treasury_id == 0x2::object::id<Treasury<T0>>(arg0), 13906835011862003713);
    }

    public fun campaign(arg0: &Coupon) : 0x2::object::ID {
        arg0.campaign
    }

    public fun create_treasury<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_treasury<T0>(arg0, arg1);
        0x2::transfer::public_transfer<TreasuryAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun expires_at_ms(arg0: &Coupon) : u64 {
        arg0.expires_at_ms
    }

    public fun fund<T0>(arg0: &mut Treasury<T0>, arg1: &TreasuryAdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert_admin<T0>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun is_paused<T0>(arg0: &Treasury<T0>) : bool {
        arg0.paused
    }

    public fun min_subtotal(arg0: &Coupon) : u64 {
        arg0.min_subtotal
    }

    public fun mint<T0>(arg0: &Treasury<T0>, arg1: &TreasuryAdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        let v0 = Coupon{
            id            : 0x2::object::new(arg7),
            campaign      : arg2,
            value         : arg3,
            min_subtotal  : arg4,
            expires_at_ms : arg5,
        };
        let v1 = CouponMinted{
            coupon_id : 0x2::object::id<Coupon>(&v0),
            campaign  : arg2,
            value     : arg3,
            recipient : arg6,
        };
        0x2::event::emit<CouponMinted>(v1);
        0x2::transfer::transfer<Coupon>(v0, arg6);
    }

    public fun new_treasury<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (Treasury<T0>, TreasuryAdminCap) {
        let v0 = Treasury<T0>{
            id         : 0x2::object::new(arg1),
            funds      : 0x2::balance::zero<T0>(),
            paused     : false,
            per_tx_cap : arg0,
        };
        let v1 = TreasuryAdminCap{
            id          : 0x2::object::new(arg1),
            treasury_id : 0x2::object::id<Treasury<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun per_tx_cap<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.per_tx_cap
    }

    public fun redeem<T0>(arg0: &mut Treasury<T0>, arg1: Coupon, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13906834822883573763);
        assert!(arg1.value == arg2, 13906834827178672133);
        assert!(arg1.expires_at_ms == 0 || 0x2::clock::timestamp_ms(arg5) < arg1.expires_at_ms, 13906834840063705095);
        assert!(arg3 >= arg1.min_subtotal, 13906834848653770761);
        assert!(arg0.per_tx_cap == 0 || arg1.value <= arg0.per_tx_cap, 13906834861538803723);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg1.value, 13906834870128869389);
        let Coupon {
            id            : v0,
            campaign      : v1,
            value         : v2,
            min_subtotal  : _,
            expires_at_ms : _,
        } = arg1;
        let v5 = v0;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v2), arg7), arg4);
        let v6 = CouponRedeemed{
            coupon_id   : 0x2::object::uid_to_inner(&v5),
            campaign    : v1,
            value       : v2,
            merchant    : arg4,
            treasury_id : 0x2::object::id<Treasury<T0>>(arg0),
            intent_ref  : arg6,
        };
        0x2::event::emit<CouponRedeemed>(v6);
    }

    public fun set_cap<T0>(arg0: &mut Treasury<T0>, arg1: &TreasuryAdminCap, arg2: u64) {
        assert_admin<T0>(arg0, arg1);
        arg0.per_tx_cap = arg2;
    }

    public fun set_paused<T0>(arg0: &mut Treasury<T0>, arg1: &TreasuryAdminCap, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    // decompiled from Move bytecode v7
}

