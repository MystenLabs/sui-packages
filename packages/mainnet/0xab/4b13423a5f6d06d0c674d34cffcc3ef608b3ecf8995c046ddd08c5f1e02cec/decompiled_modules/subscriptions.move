module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::subscriptions {
    struct Tier<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        recipient: address,
        metadata_uri: 0x1::string::String,
        price: u64,
        period_ms: u64,
        active: bool,
        subs: 0x2::table::Table<address, u64>,
        subscriber_count: u64,
    }

    struct TierCap has store, key {
        id: 0x2::object::UID,
        tier: 0x2::object::ID,
    }

    struct TierCreated has copy, drop {
        tier: 0x2::object::ID,
        creator: address,
        price: u64,
        period_ms: u64,
    }

    struct Subscribed has copy, drop {
        tier: 0x2::object::ID,
        subscriber: address,
        payer: address,
        amount: u64,
        fee: u64,
        expires_ms: u64,
    }

    struct TierPriceChanged has copy, drop {
        tier: 0x2::object::ID,
        price: u64,
    }

    struct TierActiveChanged has copy, drop {
        tier: 0x2::object::ID,
        active: bool,
    }

    fun assert_cap<T0>(arg0: &Tier<T0>, arg1: &TierCap) {
        assert!(arg1.tier == 0x2::object::id<Tier<T0>>(arg0), 1);
    }

    fun assert_version<T0>(arg0: &Tier<T0>) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 3);
    }

    public fun create<T0>(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : TierCap {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg1 <= 315360000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = Tier<T0>{
            id               : 0x2::object::new(arg3),
            version          : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            recipient        : 0x2::tx_context::sender(arg3),
            metadata_uri     : arg2,
            price            : arg0,
            period_ms        : arg1,
            active           : true,
            subs             : 0x2::table::new<address, u64>(arg3),
            subscriber_count : 0,
        };
        let v2 = TierCap{
            id   : 0x2::object::new(arg3),
            tier : 0x2::object::id<Tier<T0>>(&v1),
        };
        let v3 = TierCreated{
            tier      : 0x2::object::id<Tier<T0>>(&v1),
            creator   : 0x2::tx_context::sender(arg3),
            price     : arg0,
            period_ms : arg1,
        };
        0x2::event::emit<TierCreated>(v3);
        0x2::transfer::share_object<Tier<T0>>(v1);
        v2
    }

    public fun expires_ms<T0>(arg0: &Tier<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::table::contains<address, u64>(&arg0.subs, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.subs, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun is_active_subscriber<T0>(arg0: &Tier<T0>, arg1: address, arg2: &0x2::clock::Clock) : bool {
        0x2::table::contains<address, u64>(&arg0.subs, arg1) && *0x2::table::borrow<address, u64>(&arg0.subs, arg1) > 0x2::clock::timestamp_ms(arg2)
    }

    public fun is_open<T0>(arg0: &Tier<T0>) : bool {
        arg0.active
    }

    public fun migrate<T0>(arg0: &mut Tier<T0>, arg1: &TierCap) {
        assert_cap<T0>(arg0, arg1);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 4);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun period_ms<T0>(arg0: &Tier<T0>) : u64 {
        arg0.period_ms
    }

    public fun price<T0>(arg0: &Tier<T0>) : u64 {
        arg0.price
    }

    public fun recipient<T0>(arg0: &Tier<T0>) : address {
        arg0.recipient
    }

    public fun set_active<T0>(arg0: &mut Tier<T0>, arg1: &TierCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        arg0.active = arg2;
        let v0 = TierActiveChanged{
            tier   : 0x2::object::id<Tier<T0>>(arg0),
            active : arg2,
        };
        0x2::event::emit<TierActiveChanged>(v0);
    }

    public fun set_metadata_uri<T0>(arg0: &mut Tier<T0>, arg1: &TierCap, arg2: 0x1::string::String) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        arg0.metadata_uri = arg2;
    }

    public fun set_price<T0>(arg0: &mut Tier<T0>, arg1: &TierCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(arg2 > 0, 2);
        arg0.price = arg2;
        let v0 = TierPriceChanged{
            tier  : 0x2::object::id<Tier<T0>>(arg0),
            price : arg2,
        };
        0x2::event::emit<TierPriceChanged>(v0);
    }

    public fun set_recipient<T0>(arg0: &mut Tier<T0>, arg1: &TierCap, arg2: address) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        arg0.recipient = arg2;
    }

    public fun subscribe<T0>(arg0: &mut Tier<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfig, arg2: address, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.active, 0);
        assert!(arg0.price == arg3, 5);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.subs, arg2)) {
            let v2 = 0x2::table::remove<address, u64>(&mut arg0.subs, arg2);
            let v3 = if (v2 > v0) {
                v2
            } else {
                v0
            };
            v3 + arg0.period_ms
        } else {
            arg0.subscriber_count = arg0.subscriber_count + 1;
            v0 + arg0.period_ms
        };
        0x2::table::add<address, u64>(&mut arg0.subs, arg2, v1);
        let v4 = Subscribed{
            tier       : 0x2::object::id<Tier<T0>>(arg0),
            subscriber : arg2,
            payer      : 0x2::tx_context::sender(arg6),
            amount     : arg0.price,
            fee        : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::collect<T0>(arg1, arg4, arg0.price, arg0.recipient, arg6),
            expires_ms : v1,
        };
        0x2::event::emit<Subscribed>(v4);
    }

    public fun subscriber_count<T0>(arg0: &Tier<T0>) : u64 {
        arg0.subscriber_count
    }

    public fun version<T0>(arg0: &Tier<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

