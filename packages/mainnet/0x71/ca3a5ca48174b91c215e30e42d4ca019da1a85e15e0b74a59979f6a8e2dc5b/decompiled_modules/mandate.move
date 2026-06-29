module 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate {
    struct Mandate has key {
        id: 0x2::object::UID,
        owner: address,
        daily_cap: u64,
        spent_today: u64,
        day_epoch: u64,
        allowed_categories: 0x2::vec_set::VecSet<u8>,
        registry_id: 0x2::object::ID,
        expiry_ms: u64,
        revoked: bool,
        witness_commitment: vector<u8>,
        nonce: u64,
    }

    public fun id(arg0: &Mandate) : 0x2::object::ID {
        0x2::object::id<Mandate>(arg0)
    }

    public(friend) fun apply_spend(arg0: &mut Mandate, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = current_day(arg2);
        if (v0 != arg0.day_epoch) {
            arg0.day_epoch = v0;
            arg0.spent_today = 0;
        };
        arg0.spent_today = arg0.spent_today + arg1;
    }

    public(friend) fun assert_active(arg0: &Mandate, arg1: &0x2::clock::Clock) {
        assert!(!arg0.revoked, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::revoked());
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.expiry_ms, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::expired());
    }

    fun build(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Mandate {
        let v0 = 0x2::vec_set::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg2)) {
            let v2 = *0x1::vector::borrow<u8>(&arg2, v1);
            if (!0x2::vec_set::contains<u8>(&v0, &v2)) {
                0x2::vec_set::insert<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        Mandate{
            id                 : 0x2::object::new(arg5),
            owner              : 0x2::tx_context::sender(arg5),
            daily_cap          : arg1,
            spent_today        : 0,
            day_epoch          : 0,
            allowed_categories : v0,
            registry_id        : arg0,
            expiry_ms          : arg3,
            revoked            : false,
            witness_commitment : arg4,
            nonce              : 0,
        }
    }

    public fun category_allowed(arg0: &Mandate, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.allowed_categories, &arg1)
    }

    public fun current_day(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 86400000
    }

    public fun daily_cap(arg0: &Mandate) : u64 {
        arg0.daily_cap
    }

    public fun day_epoch(arg0: &Mandate) : u64 {
        arg0.day_epoch
    }

    public fun effective_spent(arg0: &Mandate, arg1: &0x2::clock::Clock) : u64 {
        if (current_day(arg1) != arg0.day_epoch) {
            0
        } else {
            arg0.spent_today
        }
    }

    public fun expiry_ms(arg0: &Mandate) : u64 {
        arg0.expiry_ms
    }

    public fun is_revoked(arg0: &Mandate) : bool {
        arg0.revoked
    }

    public fun new_mandate(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = build(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::share_object<Mandate>(v0);
        0x2::object::id<Mandate>(&v0)
    }

    public fun nonce(arg0: &Mandate) : u64 {
        arg0.nonce
    }

    public fun owner(arg0: &Mandate) : address {
        arg0.owner
    }

    public fun registry_id(arg0: &Mandate) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun revoke(arg0: &mut Mandate, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::not_owner());
        arg0.revoked = true;
    }

    public(friend) fun rotate(arg0: &mut Mandate, arg1: vector<u8>) {
        arg0.witness_commitment = arg1;
        arg0.nonce = arg0.nonce + 1;
    }

    public fun set_caps(arg0: &mut Mandate, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::not_owner());
        arg0.daily_cap = arg1;
    }

    public fun spent_today(arg0: &Mandate) : u64 {
        arg0.spent_today
    }

    public fun witness_commitment(arg0: &Mandate) : vector<u8> {
        arg0.witness_commitment
    }

    // decompiled from Move bytecode v7
}

