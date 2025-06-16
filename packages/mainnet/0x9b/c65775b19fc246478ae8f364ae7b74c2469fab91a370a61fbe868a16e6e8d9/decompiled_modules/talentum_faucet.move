module 0x9bc65775b19fc246478ae8f364ae7b74c2469fab91a370a61fbe868a16e6e8d9::talentum_faucet {
    struct FaucetEvent has copy, drop {
        event_type: u8,
        address: address,
        amount: u64,
        timestamp: u64,
    }

    struct ConfigUpdateEvent has copy, drop {
        withdrawal_amount: u64,
        timeout_period: u64,
        timestamp: u64,
    }

    struct NonceInfo has copy, drop, store {
        nonce: u64,
        timestamp: u64,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        owner: address,
        pubkey: vector<u8>,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        timeouts: 0x2::table::Table<address, u64>,
        used_nonces: 0x2::vec_map::VecMap<u64, NonceInfo>,
        withdrawal_amount: u64,
        timeout_period: u64,
        withdrawal_amount_pro: u64,
        is_paused: bool,
        is_deactivated: bool,
    }

    public entry fun clean_expired_nonces(arg0: &mut Faucet, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = 0x2::vec_map::keys<u64, NonceInfo>(&arg0.used_nonces);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = 0x1::vector::borrow<u64>(&v0, v1);
            if (0x2::vec_map::contains<u64, NonceInfo>(&arg0.used_nonces, v2)) {
                if (0x2::clock::timestamp_ms(arg1) >= 0x2::vec_map::get<u64, NonceInfo>(&arg0.used_nonces, v2).timestamp + 604800000) {
                    let (_, _) = 0x2::vec_map::remove<u64, NonceInfo>(&mut arg0.used_nonces, v2);
                };
            };
            v1 = v1 + 1;
        };
    }

    fun create_withdrawal_message(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::string::into_bytes(0x1::u64::to_string(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        v0
    }

    public entry fun deactivate(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        assert!(!arg0.is_deactivated, 1);
        arg0.is_deactivated = true;
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), arg0.owner);
        };
        let v1 = FaucetEvent{
            event_type : 2,
            address    : arg0.owner,
            amount     : v0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<FaucetEvent>(v1);
    }

    public entry fun deposit(arg0: &mut Faucet, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_deactivated, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 9);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v1 = FaucetEvent{
            event_type : 1,
            address    : 0x2::tx_context::sender(arg2),
            amount     : v0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<FaucetEvent>(v1);
    }

    public fun get_balance(arg0: &Faucet) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_time_until_next_withdrawal(arg0: &Faucet, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.timeouts, arg2)) {
            return 0
        };
        let v0 = *0x2::table::borrow<address, u64>(&arg0.timeouts, arg2) + arg0.timeout_period;
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 >= v0) {
            0
        } else {
            v0 - v1
        }
    }

    public fun get_timeout_period(arg0: &Faucet) : u64 {
        arg0.timeout_period
    }

    public fun get_withdrawal_amount(arg0: &Faucet) : u64 {
        arg0.withdrawal_amount
    }

    public fun get_withdrawal_amount_pro(arg0: &Faucet) : u64 {
        arg0.withdrawal_amount_pro
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Faucet{
            id                    : 0x2::object::new(arg0),
            owner                 : 0x2::tx_context::sender(arg0),
            pubkey                : x"02df497ab7f7548c41e20eb81ea4bbcb0c0e2aad2635ba01b2cd8102bd408919bf",
            balance               : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            timeouts              : 0x2::table::new<address, u64>(arg0),
            used_nonces           : 0x2::vec_map::empty<u64, NonceInfo>(),
            withdrawal_amount     : 1000000000,
            timeout_period        : 86400000,
            withdrawal_amount_pro : 5000000000,
            is_paused             : false,
            is_deactivated        : false,
        };
        0x2::transfer::share_object<Faucet>(v0);
    }

    public fun is_deactivated(arg0: &Faucet) : bool {
        arg0.is_deactivated
    }

    public fun is_paused(arg0: &Faucet) : bool {
        arg0.is_paused
    }

    public entry fun pause(arg0: &mut Faucet, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        assert!(!arg0.is_deactivated, 1);
        arg0.is_paused = true;
        let v0 = FaucetEvent{
            event_type : 3,
            address    : arg0.owner,
            amount     : 0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<FaucetEvent>(v0);
    }

    public entry fun set_pubkey(arg0: &mut Faucet, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.pubkey = arg1;
    }

    public entry fun unpause(arg0: &mut Faucet, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        assert!(!arg0.is_deactivated, 1);
        arg0.is_paused = false;
        let v0 = FaucetEvent{
            event_type : 4,
            address    : arg0.owner,
            amount     : 0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<FaucetEvent>(v0);
    }

    public entry fun update_config(arg0: &mut Faucet, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 4);
        assert!(arg1 > 0, 9);
        assert!(arg2 > 0, 9);
        assert!(arg3 > 0, 9);
        arg0.withdrawal_amount = arg1;
        arg0.timeout_period = arg2;
        arg0.withdrawal_amount_pro = arg3;
        let v0 = ConfigUpdateEvent{
            withdrawal_amount : arg1,
            timeout_period    : arg2,
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public entry fun withdraw(arg0: &mut Faucet, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_deactivated, 1);
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg5, 8);
        assert!(!0x2::vec_map::contains<u64, NonceInfo>(&arg0.used_nonces, &arg2), 3);
        let v1 = create_withdrawal_message(arg2, arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg3, &arg0.pubkey, &v1, arg4), 7);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = if (arg6) {
            arg0.withdrawal_amount_pro
        } else {
            arg0.withdrawal_amount
        };
        if (0x2::table::contains<address, u64>(&arg0.timeouts, v2)) {
            assert!(v0 >= *0x2::table::borrow<address, u64>(&arg0.timeouts, v2) + arg0.timeout_period, 6);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.balance) >= v3, 5);
        let v4 = NonceInfo{
            nonce     : arg2,
            timestamp : v0,
        };
        0x2::vec_map::insert<u64, NonceInfo>(&mut arg0.used_nonces, arg2, v4);
        if (0x2::table::contains<address, u64>(&arg0.timeouts, v2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.timeouts, v2) = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.timeouts, v2, v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v3, arg7), v2);
        let v5 = FaucetEvent{
            event_type : 0,
            address    : v2,
            amount     : v3,
            timestamp  : v0,
        };
        0x2::event::emit<FaucetEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

