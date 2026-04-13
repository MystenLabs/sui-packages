module 0xadfe1faa16b9022a4500569770e5c5ef3de3d461ddfb8996247ab9efb01c136a::swap {
    struct Lock<phantom T0> has key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        sender: address,
        recipient: address,
        balance: 0x2::balance::Balance<T0>,
        expire_ms: u64,
    }

    struct Locked has copy, drop {
        lock_id: address,
        hash: vector<u8>,
        sender: address,
        recipient: address,
        amount: u64,
        expire_ms: u64,
    }

    struct Claimed has copy, drop {
        lock_id: address,
        preimage: vector<u8>,
        recipient: address,
        amount: u64,
    }

    struct Refunded has copy, drop {
        lock_id: address,
        sender: address,
        amount: u64,
    }

    public fun hash<T0>(arg0: &Lock<T0>) : vector<u8> {
        arg0.hash
    }

    public fun sender<T0>(arg0: &Lock<T0>) : address {
        arg0.sender
    }

    public fun amount<T0>(arg0: &Lock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun claim<T0>(arg0: Lock<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.recipient, 3);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expire_ms, 6);
        let v0 = 0x1::hash::sha2_256(arg1);
        assert!(vector_equal(&v0, &arg0.hash), 5);
        let Lock {
            id        : v1,
            hash      : _,
            sender    : _,
            recipient : v4,
            balance   : v5,
            expire_ms : _,
        } = arg0;
        let v7 = v5;
        let v8 = v1;
        let v9 = Claimed{
            lock_id   : 0x2::object::uid_to_address(&v8),
            preimage  : arg1,
            recipient : v4,
            amount    : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<Claimed>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), v4);
        0x2::object::delete(v8);
    }

    public fun expire_ms<T0>(arg0: &Lock<T0>) : u64 {
        arg0.expire_ms
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 2);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 8);
        let v1 = Lock<T0>{
            id        : 0x2::object::new(arg5),
            hash      : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            recipient : arg1,
            balance   : 0x2::coin::into_balance<T0>(arg0),
            expire_ms : arg3,
        };
        let v2 = Locked{
            lock_id   : 0x2::object::id_address<Lock<T0>>(&v1),
            hash      : v1.hash,
            sender    : v1.sender,
            recipient : arg1,
            amount    : v0,
            expire_ms : arg3,
        };
        0x2::event::emit<Locked>(v2);
        0x2::transfer::share_object<Lock<T0>>(v1);
    }

    public fun recipient<T0>(arg0: &Lock<T0>) : address {
        arg0.recipient
    }

    public entry fun refund<T0>(arg0: Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expire_ms, 7);
        let Lock {
            id        : v0,
            hash      : _,
            sender    : v2,
            recipient : _,
            balance   : v4,
            expire_ms : _,
        } = arg0;
        let v6 = v4;
        let v7 = v0;
        let v8 = Refunded{
            lock_id : 0x2::object::uid_to_address(&v7),
            sender  : v2,
            amount  : 0x2::balance::value<T0>(&v6),
        };
        0x2::event::emit<Refunded>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg2), v2);
        0x2::object::delete(v7);
    }

    fun vector_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 | *0x1::vector::borrow<u8>(arg0, v1) ^ *0x1::vector::borrow<u8>(arg1, v1);
            v1 = v1 + 1;
        };
        v2 == 0
    }

    // decompiled from Move bytecode v7
}

