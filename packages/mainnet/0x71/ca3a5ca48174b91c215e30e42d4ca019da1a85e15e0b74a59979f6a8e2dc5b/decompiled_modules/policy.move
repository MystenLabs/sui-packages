module 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy {
    struct PaymentIntent has copy, drop, store {
        mandate_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        category: u8,
        amount: u64,
        recipient: address,
        nonce: u64,
        expiry_ms: u64,
    }

    public fun category(arg0: &PaymentIntent) : u8 {
        arg0.category
    }

    public fun nonce(arg0: &PaymentIntent) : u64 {
        arg0.nonce
    }

    public fun recipient(arg0: &PaymentIntent) : address {
        arg0.recipient
    }

    public fun amount(arg0: &PaymentIntent) : u64 {
        arg0.amount
    }

    public fun check(arg0: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg2: &PaymentIntent, arg3: &0x2::clock::Clock) {
        let v0 = evaluate(arg0, arg1, arg2, arg3);
        assert!(v0 == 0, v0);
    }

    public fun evaluate(arg0: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg2: &PaymentIntent, arg3: &0x2::clock::Clock) : u64 {
        if (0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::registry_id(arg0) != 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::id(arg1)) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::market()
        };
        if (arg2.recipient != 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::owner(arg0)) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::recipient()
        };
        if (0x2::clock::timestamp_ms(arg3) > arg2.expiry_ms) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::expired()
        };
        if (!0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::category_allowed(arg0, arg2.category)) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::category()
        };
        if (!0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::is_allowed(arg1, arg2.pool_id)) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::market()
        };
        if (arg2.nonce != 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::nonce(arg0)) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::nonce()
        };
        let v0 = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::daily_cap(arg0);
        let v1 = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::effective_spent(arg0, arg3);
        if (v1 > v0 || arg2.amount > v0 - v1) {
            return 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::over_cap()
        };
        0
    }

    public fun expiry_ms(arg0: &PaymentIntent) : u64 {
        arg0.expiry_ms
    }

    public fun mandate_id(arg0: &PaymentIntent) : 0x2::object::ID {
        arg0.mandate_id
    }

    public fun new_intent(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: u64) : PaymentIntent {
        PaymentIntent{
            mandate_id : arg0,
            pool_id    : arg1,
            category   : arg2,
            amount     : arg3,
            recipient  : arg4,
            nonce      : arg5,
            expiry_ms  : arg6,
        }
    }

    public fun pool_id(arg0: &PaymentIntent) : 0x2::object::ID {
        arg0.pool_id
    }

    // decompiled from Move bytecode v7
}

