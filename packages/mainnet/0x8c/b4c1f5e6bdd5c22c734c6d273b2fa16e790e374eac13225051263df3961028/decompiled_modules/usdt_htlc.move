module 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_htlc {
    struct USDTHTLCContract<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        receiver: address,
        amount: u64,
        balance: 0x2::balance::Balance<T0>,
        hash_lock: vector<u8>,
        time_lock: u64,
        completed: bool,
        refunded: bool,
    }

    struct HTLCCreated<phantom T0> has copy, drop {
        contract_id: address,
        sender: address,
        receiver: address,
        amount: u64,
        hash_lock: vector<u8>,
        time_lock: u64,
    }

    struct HTLCCompleted<phantom T0> has copy, drop {
        contract_id: address,
        secret: vector<u8>,
        receiver: address,
    }

    struct HTLCRefunded<phantom T0> has copy, drop {
        contract_id: address,
        sender: address,
    }

    public fun complete_usdt_htlc<T0>(arg0: &mut USDTHTLCContract<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.completed, 5);
        assert!(!arg0.refunded, 6);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.time_lock, 2);
        assert!(0x2::tx_context::sender(arg3) == arg0.receiver, 4);
        assert!(create_hash_lock(arg1) == arg0.hash_lock, 1);
        arg0.completed = true;
        0x2::balance::value<T0>(&arg0.balance);
        let v0 = HTLCCompleted<T0>{
            contract_id : 0x2::object::uid_to_address(&arg0.id),
            secret      : arg1,
            receiver    : arg0.receiver,
        };
        0x2::event::emit<HTLCCompleted<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg3)
    }

    public fun create_hash_lock(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    public fun create_usdt_htlc<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : USDTHTLCContract<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 7);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 2);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::new(arg5);
        let v3 = USDTHTLCContract<T0>{
            id        : v2,
            sender    : v1,
            receiver  : arg1,
            amount    : v0,
            balance   : 0x2::coin::into_balance<T0>(arg0),
            hash_lock : arg2,
            time_lock : arg3,
            completed : false,
            refunded  : false,
        };
        let v4 = HTLCCreated<T0>{
            contract_id : 0x2::object::uid_to_address(&v2),
            sender      : v1,
            receiver    : arg1,
            amount      : v0,
            hash_lock   : arg2,
            time_lock   : arg3,
        };
        0x2::event::emit<HTLCCreated<T0>>(v4);
        v3
    }

    public fun destroy_empty_contract<T0>(arg0: USDTHTLCContract<T0>) {
        let USDTHTLCContract {
            id        : v0,
            sender    : _,
            receiver  : _,
            amount    : _,
            balance   : v4,
            hash_lock : _,
            time_lock : _,
            completed : _,
            refunded  : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v4);
        0x2::object::delete(v0);
    }

    public fun get_amount<T0>(arg0: &USDTHTLCContract<T0>) : u64 {
        arg0.amount
    }

    public fun get_hash_lock<T0>(arg0: &USDTHTLCContract<T0>) : vector<u8> {
        arg0.hash_lock
    }

    public fun get_receiver<T0>(arg0: &USDTHTLCContract<T0>) : address {
        arg0.receiver
    }

    public fun get_sender<T0>(arg0: &USDTHTLCContract<T0>) : address {
        arg0.sender
    }

    public fun get_time_lock<T0>(arg0: &USDTHTLCContract<T0>) : u64 {
        arg0.time_lock
    }

    public fun is_completed<T0>(arg0: &USDTHTLCContract<T0>) : bool {
        arg0.completed
    }

    public fun is_refunded<T0>(arg0: &USDTHTLCContract<T0>) : bool {
        arg0.refunded
    }

    public fun refund_usdt_htlc<T0>(arg0: &mut USDTHTLCContract<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.completed, 5);
        assert!(!arg0.refunded, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.time_lock, 3);
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 4);
        arg0.refunded = true;
        let v0 = HTLCRefunded<T0>{
            contract_id : 0x2::object::uid_to_address(&arg0.id),
            sender      : arg0.sender,
        };
        0x2::event::emit<HTLCRefunded<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2)
    }

    // decompiled from Move bytecode v6
}

