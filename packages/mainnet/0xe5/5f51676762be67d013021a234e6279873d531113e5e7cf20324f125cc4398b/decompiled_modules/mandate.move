module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate {
    struct Mandate has key {
        id: 0x2::object::UID,
        owner: address,
        allowed_categories: vector<vector<u8>>,
        allowed_merchants: vector<address>,
        max_per_tx: u64,
        daily_limit: u64,
        expires_at_ms: u64,
        today_spent: u64,
        day_index: u64,
        auth_secret_hash: vector<u8>,
        ciphertext: vector<u8>,
        revoked: bool,
        nonce: u64,
        pending_init: bool,
    }

    struct MandateCreated has copy, drop {
        mandate_id: 0x2::object::ID,
        owner: address,
        daily_limit: u64,
        max_per_tx: u64,
        expires_at_ms: u64,
    }

    struct MandateInitialized has copy, drop {
        mandate_id: 0x2::object::ID,
    }

    struct MandateRevoked has copy, drop {
        mandate_id: 0x2::object::ID,
    }

    struct MandateRotated has copy, drop {
        mandate_id: 0x2::object::ID,
        new_nonce: u64,
        amount_spent: u64,
        today_spent_after: u64,
    }

    public fun allowed_categories(arg0: &Mandate) : vector<vector<u8>> {
        arg0.allowed_categories
    }

    public fun allowed_merchants(arg0: &Mandate) : vector<address> {
        arg0.allowed_merchants
    }

    public(friend) fun assert_initialized(arg0: &Mandate) {
        assert!(!arg0.pending_init, 13);
    }

    public fun auth_secret_hash(arg0: &Mandate) : vector<u8> {
        arg0.auth_secret_hash
    }

    public fun ciphertext(arg0: &Mandate) : vector<u8> {
        arg0.ciphertext
    }

    public fun create(arg0: vector<vector<u8>>, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = Mandate{
            id                 : 0x2::object::new(arg6),
            owner              : v1,
            allowed_categories : arg0,
            allowed_merchants  : arg1,
            max_per_tx         : arg2,
            daily_limit        : arg3,
            expires_at_ms      : v0 + arg4,
            today_spent        : 0,
            day_index          : v0 / 86400000,
            auth_secret_hash   : b"",
            ciphertext         : b"",
            revoked            : false,
            nonce              : 0,
            pending_init       : true,
        };
        let v3 = MandateCreated{
            mandate_id    : 0x2::object::id<Mandate>(&v2),
            owner         : v1,
            daily_limit   : arg3,
            max_per_tx    : arg2,
            expires_at_ms : v2.expires_at_ms,
        };
        0x2::event::emit<MandateCreated>(v3);
        0x2::transfer::transfer<Mandate>(v2, v1);
    }

    public fun daily_limit(arg0: &Mandate) : u64 {
        arg0.daily_limit
    }

    public fun day_index(arg0: &Mandate) : u64 {
        arg0.day_index
    }

    public fun expires_at_ms(arg0: &Mandate) : u64 {
        arg0.expires_at_ms
    }

    public fun initialize_seal(arg0: &mut Mandate, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 10);
        assert!(arg0.pending_init, 12);
        arg0.auth_secret_hash = arg1;
        arg0.ciphertext = arg2;
        arg0.pending_init = false;
        let v0 = MandateInitialized{mandate_id: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<MandateInitialized>(v0);
    }

    public fun is_category_allowed(arg0: &Mandate, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.allowed_categories)) {
            if (0x1::vector::borrow<vector<u8>>(&arg0.allowed_categories, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_merchant_allowed(arg0: &Mandate, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.allowed_merchants)) {
            if (*0x1::vector::borrow<address>(&arg0.allowed_merchants, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_revoked(arg0: &Mandate) : bool {
        arg0.revoked
    }

    public fun max_per_tx(arg0: &Mandate) : u64 {
        arg0.max_per_tx
    }

    public fun nonce(arg0: &Mandate) : u64 {
        arg0.nonce
    }

    public fun owner(arg0: &Mandate) : address {
        arg0.owner
    }

    public fun pending_init(arg0: &Mandate) : bool {
        arg0.pending_init
    }

    public fun projected_today_spent(arg0: &Mandate, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (0x2::clock::timestamp_ms(arg2) / 86400000 > arg0.day_index) {
            0
        } else {
            arg0.today_spent
        };
        v0 + arg1
    }

    public(friend) fun record_payment_and_rotate(arg0: &mut Mandate, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4) / 86400000;
        if (v0 > arg0.day_index) {
            arg0.day_index = v0;
            arg0.today_spent = 0;
        };
        arg0.today_spent = arg0.today_spent + arg1;
        arg0.auth_secret_hash = arg2;
        arg0.ciphertext = arg3;
        arg0.nonce = arg0.nonce + 1;
        let v1 = MandateRotated{
            mandate_id        : 0x2::object::id<Mandate>(arg0),
            new_nonce         : arg0.nonce,
            amount_spent      : arg1,
            today_spent_after : arg0.today_spent,
        };
        0x2::event::emit<MandateRotated>(v1);
    }

    public fun revoke(arg0: &mut Mandate, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 10);
        assert!(!arg0.revoked, 11);
        arg0.revoked = true;
        let v0 = MandateRevoked{mandate_id: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<MandateRevoked>(v0);
    }

    public fun today_spent(arg0: &Mandate) : u64 {
        arg0.today_spent
    }

    // decompiled from Move bytecode v7
}

