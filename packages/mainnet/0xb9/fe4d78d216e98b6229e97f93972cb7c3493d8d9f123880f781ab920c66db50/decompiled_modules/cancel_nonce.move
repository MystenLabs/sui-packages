module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::cancel_nonce {
    struct CancelNonce has key {
        id: 0x2::object::UID,
        nonces: 0x2::table::Table<address, u64>,
    }

    struct NonceConsumed has copy, drop {
        address: address,
        nonce: u64,
    }

    struct NonceCancelled has copy, drop {
        address: address,
        old_nonce: u64,
        new_nonce: u64,
    }

    public fun contains(arg0: &CancelNonce, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.nonces, arg1)
    }

    public(friend) entry fun cancel(arg0: &mut CancelNonce, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_or_zero(&arg0.nonces, v0);
        if (arg1 < v1) {
            return
        };
        let v2 = &mut arg0.nonces;
        set_nonce(v2, v0, arg1 + 1);
        let v3 = NonceCancelled{
            address   : v0,
            old_nonce : v1,
            new_nonce : arg1 + 1,
        };
        0x2::event::emit<NonceCancelled>(v3);
    }

    public(friend) fun consume(arg0: &mut CancelNonce, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(get_or_zero(&arg0.nonces, v0) == arg1, 1);
        let v1 = &mut arg0.nonces;
        set_nonce(v1, v0, arg1 + 1);
        let v2 = NonceConsumed{
            address : v0,
            nonce   : arg1,
        };
        0x2::event::emit<NonceConsumed>(v2);
        arg1
    }

    fun get_or_zero(arg0: &0x2::table::Table<address, u64>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CancelNonce{
            id     : 0x2::object::new(arg0),
            nonces : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<CancelNonce>(v0);
    }

    public fun nonce(arg0: &CancelNonce, arg1: address) : u64 {
        get_or_zero(&arg0.nonces, arg1)
    }

    fun set_nonce(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow_mut<address, u64>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

