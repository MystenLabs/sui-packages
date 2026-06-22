module 0x1b998ebddfbad3cc5a6f9048ffec5a8956a44bba4c22c12c0d45f58e9e66bb88::coupon {
    struct Config has key {
        id: 0x2::object::UID,
        authorizer_pubkey: vector<u8>,
        paused: bool,
    }

    struct ConfigAdminCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct Coupon<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        owner: address,
        refund_to: address,
        campaign: 0x2::object::ID,
        policy: 0x2::object::ID,
        transferable: bool,
        min_subtotal: u64,
        expires_at_ms: u64,
    }

    struct CouponMinted has copy, drop {
        coupon_id: 0x2::object::ID,
        campaign: 0x2::object::ID,
        owner: address,
        refund_to: address,
        value: u64,
        expires_at_ms: u64,
    }

    struct CouponRedeemed has copy, drop {
        coupon_id: 0x2::object::ID,
        owner: address,
        merchant: address,
        amount: u64,
        remaining: u64,
        intent_ref: vector<u8>,
    }

    struct CouponDepleted has copy, drop {
        coupon_id: 0x2::object::ID,
    }

    struct CouponSwept has copy, drop {
        coupon_id: 0x2::object::ID,
        refund_to: address,
        amount: u64,
    }

    struct Gifted has copy, drop {
        coupon_id: 0x2::object::ID,
        campaign: 0x2::object::ID,
        owner: address,
        refund_to: address,
        value: u64,
        expires_at_ms: u64,
    }

    struct Claimed has copy, drop {
        coupon_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    public fun value<T0>(arg0: &Coupon<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun assert_admin(arg0: &Config, arg1: &ConfigAdminCap) {
        assert!(arg1.config_id == 0x2::object::id<Config>(arg0), 13906836575230099457);
    }

    public fun authorizer_pubkey(arg0: &Config) : vector<u8> {
        arg0.authorizer_pubkey
    }

    public fun campaign<T0>(arg0: &Coupon<T0>) : 0x2::object::ID {
        arg0.campaign
    }

    public fun claim<T0>(arg0: &mut Coupon<T0>, arg1: &Config, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 13906835574503899155);
        let v0 = 0x2::object::id<Coupon<T0>>(arg0);
        let v1 = arg0.owner;
        assert!(verify_claim_authorization(arg1, v0, v1, arg2, arg3, arg4), 13906835626043899929);
        arg0.owner = arg2;
        let v2 = Claimed{
            coupon_id      : v0,
            previous_owner : v1,
            new_owner      : arg2,
        };
        0x2::event::emit<Claimed>(v2);
    }

    public fun claim_message(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) : vector<u8> {
        let v0 = b"ARTOS_CASH_CLAIM_V2";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg3));
        v0
    }

    public fun create_config(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_config(arg0, arg1);
        0x2::transfer::public_transfer<ConfigAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v0);
    }

    public fun expires_at_ms<T0>(arg0: &Coupon<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun gift<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = new_coupon<T0>(arg0, arg3, arg4, arg1, arg2, arg5, arg6, arg7);
        let v1 = Gifted{
            coupon_id     : 0x2::object::id<Coupon<T0>>(&v0),
            campaign      : arg1,
            owner         : arg3,
            refund_to     : arg4,
            value         : 0x2::coin::value<T0>(&arg0),
            expires_at_ms : arg6,
        };
        0x2::event::emit<Gifted>(v1);
        0x2::transfer::share_object<Coupon<T0>>(v0);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_transferable<T0>(arg0: &Coupon<T0>) : bool {
        arg0.transferable
    }

    public fun min_subtotal<T0>(arg0: &Coupon<T0>) : u64 {
        arg0.min_subtotal
    }

    public fun mint<T0>(arg0: &Config, arg1: &ConfigAdminCap, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: address, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = new_coupon<T0>(arg2, arg5, v0, arg3, arg4, arg6, arg7, arg8);
        let v2 = CouponMinted{
            coupon_id     : 0x2::object::id<Coupon<T0>>(&v1),
            campaign      : arg3,
            owner         : arg5,
            refund_to     : v1.refund_to,
            value         : 0x2::coin::value<T0>(&arg2),
            expires_at_ms : arg7,
        };
        0x2::event::emit<CouponMinted>(v2);
        0x2::transfer::share_object<Coupon<T0>>(v1);
    }

    public fun new_config(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : (Config, ConfigAdminCap) {
        let v0 = Config{
            id                : 0x2::object::new(arg1),
            authorizer_pubkey : arg0,
            paused            : false,
        };
        let v1 = ConfigAdminCap{
            id        : 0x2::object::new(arg1),
            config_id : 0x2::object::id<Config>(&v0),
        };
        (v0, v1)
    }

    fun new_coupon<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Coupon<T0> {
        assert!(arg6 != 0, 13906835441360175127);
        Coupon<T0>{
            id            : 0x2::object::new(arg7),
            funds         : 0x2::coin::into_balance<T0>(arg0),
            owner         : arg1,
            refund_to     : arg2,
            campaign      : arg3,
            policy        : arg4,
            transferable  : false,
            min_subtotal  : arg5,
            expires_at_ms : arg6,
        }
    }

    public fun owner<T0>(arg0: &Coupon<T0>) : address {
        arg0.owner
    }

    public fun policy<T0>(arg0: &Coupon<T0>) : 0x2::object::ID {
        arg0.policy
    }

    public fun redeem<T0>(arg0: &mut Coupon<T0>, arg1: &Config, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg9) < arg6, 13906835737712656403);
        assert!(verify_redeem_authorization(arg1, 0x2::object::id<Coupon<T0>>(arg0), arg0.owner, arg3, arg2, arg7, arg6, arg5, arg8), 13906835797842329621);
        redeem_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg9, arg10);
    }

    fun redeem_internal<T0>(arg0: &mut Coupon<T0>, arg1: &Config, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 13906835879445528579);
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 13906835883740626949);
        assert!(0x2::clock::timestamp_ms(arg7) < arg0.expires_at_ms, 13906835888035725319);
        assert!(arg4 >= arg0.min_subtotal, 13906835892330954763);
        assert!(arg2 > 0, 13906835896626053133);
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 == arg5, 13906835905216249873);
        assert!(arg2 <= v0, 13906835909511086095);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg2), arg8), arg3);
        let v1 = 0x2::balance::value<T0>(&arg0.funds);
        let v2 = 0x2::object::id<Coupon<T0>>(arg0);
        let v3 = CouponRedeemed{
            coupon_id  : v2,
            owner      : arg0.owner,
            merchant   : arg3,
            amount     : arg2,
            remaining  : v1,
            intent_ref : arg6,
        };
        0x2::event::emit<CouponRedeemed>(v3);
        if (v1 == 0) {
            let v4 = CouponDepleted{coupon_id: v2};
            0x2::event::emit<CouponDepleted>(v4);
        };
    }

    public fun redeem_message(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>) : vector<u8> {
        let v0 = b"ARTOS_CASH_REDEEM_V2";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg5));
        0x1::vector::append<u8>(&mut v0, arg6);
        v0
    }

    public fun refund_to<T0>(arg0: &Coupon<T0>) : address {
        arg0.refund_to
    }

    public fun set_authorizer(arg0: &mut Config, arg1: &ConfigAdminCap, arg2: vector<u8>) {
        assert_admin(arg0, arg1);
        arg0.authorizer_pubkey = arg2;
    }

    public fun set_paused(arg0: &mut Config, arg1: &ConfigAdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun sweep_expired<T0>(arg0: Coupon<T0>, arg1: &Config, arg2: &ConfigAdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.expires_at_ms, 13906836046949646345);
        let Coupon {
            id            : v0,
            funds         : v1,
            owner         : _,
            refund_to     : v3,
            campaign      : _,
            policy        : _,
            transferable  : _,
            min_subtotal  : _,
            expires_at_ms : _,
        } = arg0;
        let v9 = v1;
        let v10 = v0;
        let v11 = 0x2::balance::value<T0>(&v9);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg4), v3);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        0x2::object::delete(v10);
        let v12 = CouponSwept{
            coupon_id : 0x2::object::uid_to_inner(&v10),
            refund_to : v3,
            amount    : v11,
        };
        0x2::event::emit<CouponSwept>(v12);
    }

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 56;
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> v1 & 255) as u8));
            if (v1 == 0) {
                break
            };
            v1 = v1 - 8;
        };
        v0
    }

    public fun verify_claim_authorization(arg0: &Config, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: vector<u8>) : bool {
        let v0 = claim_message(arg1, arg2, arg3, arg4);
        0x2::ed25519::ed25519_verify(&arg5, &arg0.authorizer_pubkey, &v0)
    }

    public fun verify_redeem_authorization(arg0: &Config, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>) : bool {
        let v0 = redeem_message(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::ed25519::ed25519_verify(&arg8, &arg0.authorizer_pubkey, &v0)
    }

    // decompiled from Move bytecode v7
}

