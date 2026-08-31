module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy {
    struct PaymentPolicy has key {
        id: 0x2::object::UID,
        treasury: address,
        allowed_coins: vector<0x1::ascii::String>,
        platform_fee_bps: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        treasury: address,
        platform_fee_bps: u64,
    }

    struct CoinAllowed has copy, drop {
        policy_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct CoinDisallowed has copy, drop {
        policy_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct TreasuryUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        treasury: address,
    }

    public fun allow_coin<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: &mut PaymentPolicy) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!0x1::vector::contains<0x1::ascii::String>(&arg1.allowed_coins, &v0), 602);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.allowed_coins, v0);
        let v1 = CoinAllowed{
            policy_id : 0x2::object::id<PaymentPolicy>(arg1),
            coin_type : v0,
        };
        0x2::event::emit<CoinAllowed>(v1);
    }

    public fun allow_coin_by_name(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: &mut PaymentPolicy, arg2: vector<u8>) {
        let v0 = 0x1::ascii::string(arg2);
        assert!(!0x1::vector::contains<0x1::ascii::String>(&arg1.allowed_coins, &v0), 602);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.allowed_coins, v0);
        let v1 = CoinAllowed{
            policy_id : 0x2::object::id<PaymentPolicy>(arg1),
            coin_type : v0,
        };
        0x2::event::emit<CoinAllowed>(v1);
    }

    public fun allowed_coin_count(arg0: &PaymentPolicy) : u64 {
        0x1::vector::length<0x1::ascii::String>(&arg0.allowed_coins)
    }

    public fun assert_coin_allowed<T0>(arg0: &PaymentPolicy) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x1::vector::contains<0x1::ascii::String>(&arg0.allowed_coins, &v0), 600);
    }

    public fun create(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PaymentPolicy {
        assert!(arg2 <= 10000, 601);
        let v0 = PaymentPolicy{
            id               : 0x2::object::new(arg3),
            treasury         : arg1,
            allowed_coins    : 0x1::vector::empty<0x1::ascii::String>(),
            platform_fee_bps : arg2,
        };
        let v1 = PolicyCreated{
            policy_id        : 0x2::object::id<PaymentPolicy>(&v0),
            treasury         : arg1,
            platform_fee_bps : arg2,
        };
        0x2::event::emit<PolicyCreated>(v1);
        v0
    }

    public fun disallow_coin_by_name(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: &mut PaymentPolicy, arg2: vector<u8>) {
        let v0 = 0x1::ascii::string(arg2);
        let (v1, v2) = 0x1::vector::index_of<0x1::ascii::String>(&arg1.allowed_coins, &v0);
        assert!(v1, 603);
        0x1::vector::remove<0x1::ascii::String>(&mut arg1.allowed_coins, v2);
        let v3 = CoinDisallowed{
            policy_id : 0x2::object::id<PaymentPolicy>(arg1),
            coin_type : v0,
        };
        0x2::event::emit<CoinDisallowed>(v3);
    }

    public fun is_coin_allowed<T0>(arg0: &PaymentPolicy) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x1::vector::contains<0x1::ascii::String>(&arg0.allowed_coins, &v0)
    }

    public fun platform_fee_bps(arg0: &PaymentPolicy) : u64 {
        arg0.platform_fee_bps
    }

    public fun set_platform_fee_bps(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: &mut PaymentPolicy, arg2: u64) {
        assert!(arg2 <= 10000, 601);
        arg1.platform_fee_bps = arg2;
    }

    public fun set_treasury(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: &mut PaymentPolicy, arg2: address) {
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{
            policy_id : 0x2::object::id<PaymentPolicy>(arg1),
            treasury  : arg2,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun share(arg0: PaymentPolicy) {
        0x2::transfer::share_object<PaymentPolicy>(arg0);
    }

    public fun treasury(arg0: &PaymentPolicy) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

