module 0xbc31983804469f71fd384ea4622c093d9c92ad8d91935e4abc0304e67b999f21::seal_subscription {
    struct SubscriptionPass has store, key {
        id: 0x2::object::UID,
        subscriber: address,
        merchant_id: address,
        plan_id: vector<u8>,
        expiration: u64,
        subscription_id: vector<u8>,
    }

    struct ContentRegistry has key {
        id: 0x2::object::UID,
        merchant: address,
    }

    public fun create_pass(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : SubscriptionPass {
        SubscriptionPass{
            id              : 0x2::object::new(arg6),
            subscriber      : arg0,
            merchant_id     : arg1,
            plan_id         : arg2,
            expiration      : 0x2::clock::timestamp_ms(arg5) + arg3,
            subscription_id : arg4,
        }
    }

    public fun expiration(arg0: &SubscriptionPass) : u64 {
        arg0.expiration
    }

    public fun is_valid(arg0: &SubscriptionPass, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.expiration
    }

    public fun renew_pass(arg0: &mut SubscriptionPass, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 < arg0.expiration) {
            arg0.expiration = arg0.expiration + arg1;
        } else {
            arg0.expiration = v0 + arg1;
        };
    }

    public fun revoke_pass(arg0: SubscriptionPass) {
        let SubscriptionPass {
            id              : v0,
            subscriber      : _,
            merchant_id     : _,
            plan_id         : _,
            expiration      : _,
            subscription_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &SubscriptionPass, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.subscriber, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.expiration, 1);
    }

    entry fun seal_approve_merchant_content(arg0: vector<u8>, arg1: &SubscriptionPass, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.subscriber, 0);
        assert!(arg1.merchant_id == arg2, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expiration, 1);
    }

    public fun subscriber(arg0: &SubscriptionPass) : address {
        arg0.subscriber
    }

    public fun transfer_pass(arg0: SubscriptionPass, arg1: address) {
        0x2::transfer::public_transfer<SubscriptionPass>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

