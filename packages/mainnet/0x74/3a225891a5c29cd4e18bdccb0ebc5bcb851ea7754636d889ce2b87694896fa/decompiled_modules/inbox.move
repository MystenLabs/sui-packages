module 0x743a225891a5c29cd4e18bdccb0ebc5bcb851ea7754636d889ce2b87694896fa::inbox {
    struct Registry has key {
        id: 0x2::object::UID,
    }

    struct Inbox has key {
        id: 0x2::object::UID,
        key: vector<u8>,
        owner: address,
        nonce: u64,
        pending: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Sent has copy, drop {
        inbox: address,
        key: vector<u8>,
        label: 0x1::string::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
        from: address,
    }

    struct Opened has copy, drop {
        inbox: address,
        key: vector<u8>,
        owner: address,
        nonce: u64,
    }

    struct Delivered has copy, drop {
        inbox: address,
        owner: address,
        amount: u64,
        tip: u64,
        by: address,
    }

    fun assert_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 33 && *0x1::vector::borrow<u8>(arg0, 0) == 0 || 0x1::vector::length<u8>(arg0) == 34 && *0x1::vector::borrow<u8>(arg0, 0) == 1, 13906835222315401217);
    }

    public fun collect(arg0: &mut Inbox, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1)));
    }

    public fun deliver(arg0: &mut Inbox, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pending);
        assert!(v0 > 0, 13906834994682527751);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = if (v1 == arg0.owner) {
            0
        } else {
            0x1::u64::min(20000000, v0)
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending, v2), arg1), v1);
        };
        if (v0 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pending), arg1), arg0.owner);
        };
        let v3 = Delivered{
            inbox  : 0x2::object::uid_to_address(&arg0.id),
            owner  : arg0.owner,
            amount : v0 - v2,
            tip    : v2,
            by     : v1,
        };
        0x2::event::emit<Delivered>(v3);
    }

    public fun forward<T0: store + key>(arg0: &mut Inbox, arg1: 0x2::transfer::Receiving<T0>) {
        0x2::transfer::public_transfer<T0>(0x2::transfer::public_receive<T0>(&mut arg0.id, arg1), arg0.owner);
    }

    public fun inbox_address(arg0: &Registry, arg1: vector<u8>) : address {
        assert_key(&arg1);
        0x2::derived_object::derive_address<vector<u8>>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_open(arg0: &Registry, arg1: vector<u8>) : bool {
        0x2::derived_object::exists<vector<u8>>(&arg0.id, arg1)
    }

    public fun key(arg0: &Inbox) : vector<u8> {
        arg0.key
    }

    public fun message(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"dotkeys: deliver my Sui inbox to 0x";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(arg0)));
        0x1::vector::append<u8>(&mut v0, b" (nonce ");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v0, b")");
        v0
    }

    public fun nonce(arg0: &Inbox) : u64 {
        arg0.nonce
    }

    public fun open(arg0: &mut Registry, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u8) : Inbox {
        assert_key(&arg1);
        assert!(verify(&arg1, &arg3, arg4, arg2, 0), 13906834857243312131);
        let v0 = 0x2::derived_object::claim<vector<u8>>(&mut arg0.id, arg1);
        let v1 = Opened{
            inbox : 0x2::object::uid_to_address(&v0),
            key   : arg1,
            owner : arg2,
            nonce : 0,
        };
        0x2::event::emit<Opened>(v1);
        Inbox{
            id      : v0,
            key     : arg1,
            owner   : arg2,
            nonce   : 0,
            pending : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun owner(arg0: &Inbox) : address {
        arg0.owner
    }

    public fun pending(arg0: &Inbox) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending)
    }

    fun put_string(arg0: &mut vector<u8>, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        0x1::vector::push_back<u8>(arg0, ((v0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((v0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((v0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((v0 & 255) as u8));
        0x1::vector::append<u8>(arg0, arg1);
    }

    public fun rebind(arg0: &mut Inbox, arg1: address, arg2: vector<u8>, arg3: u8) {
        let v0 = arg0.nonce + 1;
        assert!(verify(&arg0.key, &arg2, arg3, arg1, v0), 13906834913077886979);
        arg0.owner = arg1;
        arg0.nonce = v0;
        let v1 = Opened{
            inbox : 0x2::object::uid_to_address(&arg0.id),
            key   : arg0.key,
            owner : arg1,
            nonce : v0,
        };
        0x2::event::emit<Opened>(v1);
    }

    public fun send<T0>(arg0: &Registry, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) <= 80, 13906834745574555657);
        let v0 = inbox_address(arg0, arg1);
        let v1 = Sent{
            inbox     : v0,
            key       : arg1,
            label     : arg2,
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&arg3),
            from      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Sent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
    }

    public fun share(arg0: Inbox) {
        0x2::transfer::share_object<Inbox>(arg0);
    }

    fun sshsig_blob(arg0: &vector<u8>, arg1: bool) : vector<u8> {
        let v0 = b"SSHSIG";
        let v1 = &mut v0;
        put_string(v1, b"dotkeys");
        let v2 = &mut v0;
        put_string(v2, b"");
        if (arg1) {
            let v3 = &mut v0;
            put_string(v3, b"sha512");
            let v4 = &mut v0;
            put_string(v4, 0x743a225891a5c29cd4e18bdccb0ebc5bcb851ea7754636d889ce2b87694896fa::sha512::sha512(arg0));
        } else {
            let v5 = &mut v0;
            put_string(v5, b"sha256");
            let v6 = &mut v0;
            put_string(v6, 0x1::hash::sha2_256(*arg0));
        };
        v0
    }

    public fun tip() : u64 {
        20000000
    }

    fun verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u8, arg3: address, arg4: u64) : bool {
        assert!(arg2 <= 2, 13906835265265336325);
        let v0 = message(arg3, arg4);
        if (verify_message(arg0, arg1, arg2, &v0)) {
            return true
        };
        0x1::vector::push_back<u8>(&mut v0, 10);
        verify_message(arg0, arg1, arg2, &v0)
    }

    fun verify_message(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u8, arg3: &vector<u8>) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let v1 = *arg0;
        0x1::vector::remove<u8>(&mut v1, 0);
        let v2 = if (arg2 == 0) {
            assert!(v0 == 0, 13906835346869714949);
            *arg3
        } else {
            sshsig_blob(arg3, arg2 == 1)
        };
        let v3 = v2;
        v0 == 0 && 0x2::ed25519::ed25519_verify(arg1, &v1, &v3) || 0x2::ecdsa_r1::secp256r1_verify(arg1, &v1, &v3, 1)
    }

    // decompiled from Move bytecode v7
}

