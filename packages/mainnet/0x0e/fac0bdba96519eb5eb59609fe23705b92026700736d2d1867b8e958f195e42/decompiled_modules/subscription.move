module 0xefac0bdba96519eb5eb59609fe23705b92026700736d2d1867b8e958f195e42::subscription {
    struct Tier has store, key {
        id: 0x2::object::UID,
        creator: address,
        price: u64,
        duration: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        active: bool,
        created_at: u64,
    }

    struct SubscriptionToken has store, key {
        id: 0x2::object::UID,
        subscriber: address,
        creator: address,
        tier_id: 0x2::object::ID,
        start_time: u64,
        expiry_time: u64,
        auto_renew: bool,
    }

    struct TierCreated has copy, drop {
        tier_id: 0x2::object::ID,
        creator: address,
        price: u64,
        duration: u64,
        name: 0x1::string::String,
        timestamp: u64,
    }

    struct TierUpdated has copy, drop {
        tier_id: 0x2::object::ID,
        creator: address,
        timestamp: u64,
    }

    struct TierDeactivated has copy, drop {
        tier_id: 0x2::object::ID,
        creator: address,
        timestamp: u64,
    }

    struct Subscribed has copy, drop {
        subscription_id: 0x2::object::ID,
        subscriber: address,
        creator: address,
        tier_id: 0x2::object::ID,
        start_time: u64,
        expiry_time: u64,
        amount_paid: u64,
        timestamp: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription_id: 0x2::object::ID,
        subscriber: address,
        new_expiry: u64,
        amount_paid: u64,
        timestamp: u64,
    }

    public entry fun create_tier(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 6);
        assert!(arg1 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Tier{
            id          : 0x2::object::new(arg5),
            creator     : v0,
            price       : arg0,
            duration    : arg1,
            name        : arg2,
            description : arg3,
            active      : true,
            created_at  : v1,
        };
        let v3 = TierCreated{
            tier_id   : 0x2::object::id<Tier>(&v2),
            creator   : v0,
            price     : arg0,
            duration  : arg1,
            name      : v2.name,
            timestamp : v1,
        };
        0x2::event::emit<TierCreated>(v3);
        0x2::transfer::public_transfer<Tier>(v2, v0);
    }

    public entry fun deactivate_tier(arg0: &mut Tier, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0, 1);
        arg0.active = false;
        let v1 = TierDeactivated{
            tier_id   : 0x2::object::id<Tier>(arg0),
            creator   : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TierDeactivated>(v1);
    }

    public fun get_subscriber(arg0: &SubscriptionToken) : address {
        arg0.subscriber
    }

    public fun get_subscription_creator(arg0: &SubscriptionToken) : address {
        arg0.creator
    }

    public fun get_subscription_expiry(arg0: &SubscriptionToken) : u64 {
        arg0.expiry_time
    }

    public fun get_subscription_tier_id(arg0: &SubscriptionToken) : 0x2::object::ID {
        arg0.tier_id
    }

    public fun get_tier_creator(arg0: &Tier) : address {
        arg0.creator
    }

    public fun get_tier_duration(arg0: &Tier) : u64 {
        arg0.duration
    }

    public fun get_tier_price(arg0: &Tier) : u64 {
        arg0.price
    }

    public fun is_subscription_active(arg0: &SubscriptionToken, arg1: u64) : bool {
        arg0.expiry_time > arg1
    }

    public fun is_tier_active(arg0: &Tier) : bool {
        arg0.active
    }

    public entry fun renew(arg0: &mut SubscriptionToken, arg1: &Tier, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.subscriber == v0, 1);
        assert!(arg1.active, 2);
        assert!(0x2::object::id<Tier>(arg1) == arg0.tier_id, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.price, 3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1.price, arg4), arg1.creator);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v2 = if (arg0.expiry_time < v1) {
            v1 + arg1.duration
        } else {
            arg0.expiry_time + arg1.duration
        };
        arg0.expiry_time = v2;
        let v3 = SubscriptionRenewed{
            subscription_id : 0x2::object::id<SubscriptionToken>(arg0),
            subscriber      : v0,
            new_expiry      : v2,
            amount_paid     : arg1.price,
            timestamp       : v1,
        };
        0x2::event::emit<SubscriptionRenewed>(v3);
    }

    public entry fun set_auto_renew(arg0: &mut SubscriptionToken, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.subscriber == 0x2::tx_context::sender(arg2), 1);
        arg0.auto_renew = arg1;
    }

    public entry fun subscribe(arg0: &Tier, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + arg0.duration;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.price, arg3), arg0.creator);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v3 = SubscriptionToken{
            id          : 0x2::object::new(arg3),
            subscriber  : v0,
            creator     : arg0.creator,
            tier_id     : 0x2::object::id<Tier>(arg0),
            start_time  : v1,
            expiry_time : v2,
            auto_renew  : false,
        };
        let v4 = Subscribed{
            subscription_id : 0x2::object::id<SubscriptionToken>(&v3),
            subscriber      : v0,
            creator         : arg0.creator,
            tier_id         : 0x2::object::id<Tier>(arg0),
            start_time      : v1,
            expiry_time     : v2,
            amount_paid     : arg0.price,
            timestamp       : v1,
        };
        0x2::event::emit<Subscribed>(v4);
        0x2::transfer::transfer<SubscriptionToken>(v3, v0);
    }

    public entry fun update_tier(arg0: &mut Tier, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.creator == v0, 1);
        assert!(arg1 > 0, 6);
        assert!(arg2 > 0, 5);
        arg0.price = arg1;
        arg0.duration = arg2;
        arg0.name = arg3;
        arg0.description = arg4;
        let v1 = TierUpdated{
            tier_id   : 0x2::object::id<Tier>(arg0),
            creator   : v0,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TierUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

