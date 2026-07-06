module 0xe6a1d2c4bf2aff2d5fb64f11b4bf8c4579335e9888da1b488dcfde1aabcbbecf::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owners: vector<vector<u8>>,
        weights: vector<u64>,
        timelocked: vector<bool>,
        threshold: u64,
        delay_ms: u64,
        allowed_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        nonce: u64,
        queue: 0x2::table::Table<vector<u8>, QueueEntry>,
    }

    struct QueueEntry has copy, drop, store {
        eta_ms: u64,
        expires_at_ms: u64,
    }

    struct Scheduled has copy, drop {
        id: vector<u8>,
        nonce: u64,
        token: vector<u8>,
        recipient: address,
        amount: u64,
        eta_ms: u64,
        expires_at_ms: u64,
        immediate: bool,
        signers: vector<u64>,
    }

    struct Executed has copy, drop {
        id: vector<u8>,
        token: vector<u8>,
        recipient: address,
        amount: u64,
        nonce: u64,
    }

    struct Cancelled has copy, drop {
        id: vector<u8>,
        token: vector<u8>,
        recipient: address,
        amount: u64,
        nonce: u64,
        signers: vector<u64>,
    }

    struct Deposited has copy, drop {
        token: vector<u8>,
        amount: u64,
    }

    fun build_message(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = b"VAULT_SIG_V1";
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, u16_be(0x1::vector::length<u8>(&arg2)));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, u64_be(arg4));
        0x1::vector::append<u8>(&mut v0, u64_be(arg5));
        v0
    }

    fun cancel_inner(arg0: &mut Vault, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &vector<u64>, arg6: &vector<vector<u8>>) {
        let v0 = 0x2::object::uid_to_bytes(&arg0.id);
        let v1 = build_message(0, v0, arg1, arg2, arg3, arg4);
        let v2 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::table::contains<vector<u8>, QueueEntry>(&arg0.queue, v2), 11);
        let v3 = build_message(1, v0, arg1, arg2, arg3, arg4);
        let (v4, _) = verify_sigs(arg0, &v3, arg5, arg6);
        assert!(v4 >= arg0.threshold, 6);
        0x2::table::remove<vector<u8>, QueueEntry>(&mut arg0.queue, v2);
        let v6 = Cancelled{
            id        : v2,
            token     : arg1,
            recipient : arg2,
            amount    : arg3,
            nonce     : arg4,
            signers   : *arg5,
        };
        0x2::event::emit<Cancelled>(v6);
    }

    public fun cancel_transfer<T0>(arg0: &mut Vault, arg1: address, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: vector<vector<u8>>) {
        cancel_inner(arg0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), arg1, arg2, arg3, &arg4, &arg5);
    }

    public fun create<T0>(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<bool>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        let v1 = new_internal(arg0, arg1, arg2, arg3, arg4, v0, arg5);
        0x2::transfer::share_object<Vault>(v1);
        0x2::object::id<Vault>(&v1)
    }

    public fun create_with_2<T0, T1>(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<bool>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T1>());
        let v1 = new_internal(arg0, arg1, arg2, arg3, arg4, v0, arg5);
        0x2::transfer::share_object<Vault>(v1);
        0x2::object::id<Vault>(&v1)
    }

    public fun create_with_3<T0, T1, T2>(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<bool>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T1>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T2>());
        let v1 = new_internal(arg0, arg1, arg2, arg3, arg4, v0, arg5);
        0x2::transfer::share_object<Vault>(v1);
        0x2::object::id<Vault>(&v1)
    }

    public fun delay_ms(arg0: &Vault) : u64 {
        arg0.delay_ms
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_tokens, &v0), 4);
        if (0x2::dynamic_field::exists<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = Deposited{
            token  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun dequeue(arg0: &mut Vault, arg1: vector<u8>, arg2: &0x2::clock::Clock) : QueueEntry {
        assert!(0x2::table::contains<vector<u8>, QueueEntry>(&arg0.queue, arg1), 11);
        let v0 = 0x2::table::remove<vector<u8>, QueueEntry>(&mut arg0.queue, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.eta_ms, 12);
        assert!(v1 <= v0.expires_at_ms, 22);
        v0
    }

    fun do_transfer<T0>(arg0: &mut Vault, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()), arg2), arg3), arg1);
    }

    public fun execute_transfer<T0>(arg0: &mut Vault, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = build_message(0, 0x2::object::uid_to_bytes(&arg0.id), v0, arg1, arg2, arg3);
        let v2 = 0x2::hash::blake2b256(&v1);
        dequeue(arg0, v2, arg4);
        do_transfer<T0>(arg0, arg1, arg2, arg5);
        let v3 = Executed{
            id        : v2,
            token     : v0,
            recipient : arg1,
            amount    : arg2,
            nonce     : arg3,
        };
        0x2::event::emit<Executed>(v3);
    }

    public fun is_queued(arg0: &Vault, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, QueueEntry>(&arg0.queue, arg1)
    }

    fun new_internal(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<bool>, arg3: u64, arg4: u64, arg5: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) : Vault {
        let v0 = 0x1::vector::length<vector<u8>>(&arg0);
        assert!(v0 > 0, 3);
        assert!(0x1::vector::length<u64>(&arg1) == v0 && 0x1::vector::length<bool>(&arg2) == v0, 17);
        assert!(arg4 >= 604800000 && arg4 <= 31536000000, 2);
        let v1 = 0;
        let v2 = 0x2::vec_set::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<vector<u8>>(&arg0, v3);
            assert!(0x1::vector::length<u8>(v4) == 32, 20);
            assert!(!0x2::vec_set::contains<vector<u8>>(&v2, v4), 19);
            0x2::vec_set::insert<vector<u8>>(&mut v2, *v4);
            let v5 = *0x1::vector::borrow<u64>(&arg1, v3);
            assert!(v5 > 0, 18);
            v1 = v1 + v5;
            v3 = v3 + 1;
        };
        assert!(arg3 > 0 && arg3 <= v1, 1);
        let v6 = 0;
        while (v6 < v0) {
            if (*0x1::vector::borrow<u64>(&arg1, v6) >= arg3) {
                assert!(*0x1::vector::borrow<bool>(&arg2, v6), 27);
            };
            v6 = v6 + 1;
        };
        Vault{
            id             : 0x2::object::new(arg6),
            owners         : arg0,
            weights        : arg1,
            timelocked     : arg2,
            threshold      : arg3,
            delay_ms       : arg4,
            allowed_tokens : arg5,
            nonce          : 0,
            queue          : 0x2::table::new<vector<u8>, QueueEntry>(arg6),
        }
    }

    public fun nonce(arg0: &Vault) : u64 {
        arg0.nonce
    }

    public fun owners(arg0: &Vault) : vector<vector<u8>> {
        arg0.owners
    }

    fun personal_message_digest(arg0: &vector<u8>) : vector<u8> {
        let v0 = x"030000";
        0x1::vector::append<u8>(&mut v0, uleb128(0x1::vector::length<u8>(arg0)));
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun schedule_transfer<T0>(arg0: &mut Vault, arg1: address, arg2: u64, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_tokens, &v0), 4);
        assert!(arg2 > 0, 5);
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(v0));
        let v2 = build_message(0, 0x2::object::uid_to_bytes(&arg0.id), v1, arg1, arg2, arg0.nonce);
        let (v3, v4) = verify_sigs(arg0, &v2, &arg3, &arg4);
        assert!(v3 >= arg0.threshold, 6);
        arg0.nonce = arg0.nonce + 1;
        let v5 = 0x2::hash::blake2b256(&v2);
        let v6 = if (v4) {
            arg0.delay_ms
        } else {
            0
        };
        let v7 = 0x2::clock::timestamp_ms(arg5) + v6;
        let v8 = v7 + 604800000;
        let v9 = QueueEntry{
            eta_ms        : v7,
            expires_at_ms : v8,
        };
        0x2::table::add<vector<u8>, QueueEntry>(&mut arg0.queue, v5, v9);
        let v10 = Scheduled{
            id            : v5,
            nonce         : arg0.nonce - 1,
            token         : v1,
            recipient     : arg1,
            amount        : arg2,
            eta_ms        : v7,
            expires_at_ms : v8,
            immediate     : v6 == 0,
            signers       : arg3,
        };
        0x2::event::emit<Scheduled>(v10);
    }

    public fun threshold(arg0: &Vault) : u64 {
        arg0.threshold
    }

    public fun timelocked(arg0: &Vault) : vector<bool> {
        arg0.timelocked
    }

    fun u16_be(arg0: u64) : vector<u8> {
        assert!(arg0 <= 65535, 26);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    fun u64_be(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> (((7 - v1) * 8) as u8) & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun uleb128(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = arg0;
        while (v1 >= 128) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 & 127) as u8) | 128);
            v1 = v1 >> 7;
        };
        0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
        v0
    }

    public fun vault_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun verify_sigs(arg0: &Vault, arg1: &vector<u8>, arg2: &vector<u64>, arg3: &vector<vector<u8>>) : (u64, bool) {
        let v0 = 0x1::vector::length<vector<u8>>(arg3);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 14);
        let v1 = personal_message_digest(arg1);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        let v5 = false;
        while (v4 < v0) {
            let v6 = *0x1::vector::borrow<u64>(arg2, v4);
            assert!(v6 < 0x1::vector::length<vector<u8>>(&arg0.owners), 10);
            if (v5) {
                assert!(v6 > 0, 9);
            };
            v5 = true;
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(arg3, v4), 0x1::vector::borrow<vector<u8>>(&arg0.owners, v6), &v1), 8);
            v2 = v2 + *0x1::vector::borrow<u64>(&arg0.weights, v6);
            if (*0x1::vector::borrow<bool>(&arg0.timelocked, v6)) {
                v3 = true;
            };
            v4 = v4 + 1;
        };
        (v2, v3)
    }

    public fun weights(arg0: &Vault) : vector<u64> {
        arg0.weights
    }

    // decompiled from Move bytecode v7
}

