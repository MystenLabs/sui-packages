module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement {
    struct Subscription has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        subscriber: address,
        tier: u64,
        price_paid: u64,
        started_at_ms: u64,
        expires_at_ms: u64,
        renewals: u64,
    }

    struct Unlock has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        buyer: address,
        content_key: vector<u8>,
        price_paid: u64,
        purchased_at_ms: u64,
    }

    struct SubscriptionStarted has copy, drop {
        subscription: 0x2::object::ID,
        vault: 0x2::object::ID,
        subscriber: address,
        tier: u64,
        price_paid: u64,
        expires_at_ms: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription: 0x2::object::ID,
        vault: 0x2::object::ID,
        subscriber: address,
        price_paid: u64,
        expires_at_ms: u64,
        renewals: u64,
    }

    struct ContentUnlocked has copy, drop {
        unlock: 0x2::object::ID,
        vault: 0x2::object::ID,
        buyer: address,
        content_key: vector<u8>,
        price_paid: u64,
    }

    public fun assert_subscribed(arg0: &Subscription, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg0.subscriber == arg2, 1);
        assert!(arg0.vault == arg1, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at_ms, 3);
    }

    public fun assert_unlocked(arg0: &Unlock, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>) {
        assert!(arg0.buyer == arg2, 1);
        assert!(arg0.vault == arg1, 2);
        assert!(arg0.content_key == arg3, 4);
    }

    public fun buyer(arg0: &Unlock) : address {
        arg0.buyer
    }

    public fun content_key(arg0: &Unlock) : &vector<u8> {
        &arg0.content_key
    }

    public fun covers_period(arg0: &Subscription, arg1: u64) : bool {
        let v0 = arg1 * 2592000000;
        arg0.started_at_ms <= v0 && v0 < arg0.expires_at_ms
    }

    public fun deprecated_approval_code() : u64 {
        8
    }

    public fun expires_at_ms(arg0: &Subscription) : u64 {
        arg0.expires_at_ms
    }

    public(friend) fun extend(arg0: &mut Subscription, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg0.expires_at_ms > v0) {
            arg0.expires_at_ms
        } else {
            v0
        };
        if (v0 > arg0.expires_at_ms) {
            arg0.started_at_ms = v0;
        };
        arg0.expires_at_ms = v1 + arg2;
        arg0.price_paid = arg1;
        arg0.renewals = arg0.renewals + 1;
        let v2 = SubscriptionRenewed{
            subscription  : 0x2::object::id<Subscription>(arg0),
            vault         : arg0.vault,
            subscriber    : arg0.subscriber,
            price_paid    : arg1,
            expires_at_ms : arg0.expires_at_ms,
            renewals      : arg0.renewals,
        };
        0x2::event::emit<SubscriptionRenewed>(v2);
    }

    public fun is_active(arg0: &Subscription, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : bool {
        if (arg0.vault == arg1) {
            if (arg0.subscriber == arg2) {
                0x2::clock::timestamp_ms(arg3) < arg0.expires_at_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun new_subscription(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Subscription{
            id            : 0x2::object::new(arg6),
            vault         : arg0,
            subscriber    : arg1,
            tier          : arg2,
            price_paid    : arg3,
            started_at_ms : v0,
            expires_at_ms : v0 + arg4,
            renewals      : 0,
        };
        let v2 = SubscriptionStarted{
            subscription  : 0x2::object::id<Subscription>(&v1),
            vault         : arg0,
            subscriber    : arg1,
            tier          : arg2,
            price_paid    : arg3,
            expires_at_ms : v1.expires_at_ms,
        };
        0x2::event::emit<SubscriptionStarted>(v2);
        0x2::transfer::transfer<Subscription>(v1, arg1);
    }

    public(friend) fun new_unlock(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Unlock{
            id              : 0x2::object::new(arg5),
            vault           : arg0,
            buyer           : arg1,
            content_key     : arg2,
            price_paid      : arg3,
            purchased_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        let v1 = ContentUnlocked{
            unlock      : 0x2::object::id<Unlock>(&v0),
            vault       : arg0,
            buyer       : arg1,
            content_key : v0.content_key,
            price_paid  : arg3,
        };
        0x2::event::emit<ContentUnlocked>(v1);
        0x2::transfer::transfer<Unlock>(v0, arg1);
    }

    public fun period_identity(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun period_not_paid_code() : u64 {
        6
    }

    public fun period_of(arg0: u64) : u64 {
        arg0 / 2592000000
    }

    public fun purchased_at_ms(arg0: &Unlock) : u64 {
        arg0.purchased_at_ms
    }

    public fun renewals(arg0: &Subscription) : u64 {
        arg0.renewals
    }

    entry fun seal_approve_subscription(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &Subscription, arg4: &0x2::tx_context::TxContext) {
        abort 8
    }

    entry fun seal_approve_unlock(arg0: vector<u8>, arg1: &Unlock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.buyer == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0 == unlock_identity(arg1.vault, arg1.content_key), 5);
    }

    public fun seal_period_ms() : u64 {
        2592000000
    }

    public fun started_at_ms(arg0: &Subscription) : u64 {
        arg0.started_at_ms
    }

    public fun subscriber(arg0: &Subscription) : address {
        arg0.subscriber
    }

    public fun subscription_price_paid(arg0: &Subscription) : u64 {
        arg0.price_paid
    }

    public fun subscription_vault(arg0: &Subscription) : 0x2::object::ID {
        arg0.vault
    }

    public fun tier(arg0: &Subscription) : u64 {
        arg0.tier
    }

    public fun tier_too_low_code() : u64 {
        7
    }

    public fun unlock_identity(arg0: 0x2::object::ID, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    public fun unlock_price_paid(arg0: &Unlock) : u64 {
        arg0.price_paid
    }

    public fun unlock_vault(arg0: &Unlock) : 0x2::object::ID {
        arg0.vault
    }

    public fun unlocks(arg0: &Unlock, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>) : bool {
        if (arg0.vault == arg1) {
            if (arg0.buyer == arg2) {
                arg0.content_key == arg3
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

