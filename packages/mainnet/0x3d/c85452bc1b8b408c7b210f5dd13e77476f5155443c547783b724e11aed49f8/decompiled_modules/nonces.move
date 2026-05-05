module 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces {
    struct UsedNonces has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<vector<u8>, u64>,
    }

    struct NonceUsed has copy, drop {
        nonce: vector<u8>,
        added_at: u64,
    }

    public(friend) fun check_and_mark_nonce(arg0: &vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut UsedNonces) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 >= v0 - 300000 && arg1 <= v0 + 30000, 1);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg3.entries, *arg0), 0);
        0x2::table::add<vector<u8>, u64>(&mut arg3.entries, *arg0, v0);
        let v1 = NonceUsed{
            nonce    : *arg0,
            added_at : v0,
        };
        0x2::event::emit<NonceUsed>(v1);
    }

    public fun cleanup_expired_nonces(arg0: &mut UsedNonces, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = 0x1::vector::borrow<vector<u8>>(&arg1, v0);
            if (0x2::table::contains<vector<u8>, u64>(&arg0.entries, *v1)) {
                if (0x2::clock::timestamp_ms(arg2) > *0x2::table::borrow<vector<u8>, u64>(&arg0.entries, *v1) + 300000 + 30000) {
                    0x2::table::remove<vector<u8>, u64>(&mut arg0.entries, *v1);
                };
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UsedNonces{
            id      : 0x2::object::new(arg0),
            entries : 0x2::table::new<vector<u8>, u64>(arg0),
        };
        0x2::transfer::share_object<UsedNonces>(v0);
    }

    // decompiled from Move bytecode v7
}

