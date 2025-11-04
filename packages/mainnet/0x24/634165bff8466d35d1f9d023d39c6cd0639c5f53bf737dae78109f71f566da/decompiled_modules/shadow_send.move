module 0x24634165bff8466d35d1f9d023d39c6cd0639c5f53bf737dae78109f71f566da::shadow_send {
    struct Config has key {
        id: 0x2::object::UID,
        total_deposits: u64,
        total_claims: u64,
        total_refunds: u64,
    }

    struct Deposit has store, key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        secret_hash: vector<u8>,
        sender: address,
        expiry_ms: u64,
        claimed: bool,
        created_at: u64,
    }

    public entry fun claim(arg0: &mut Config, arg1: &mut Deposit, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.claimed, 101);
        arg1.claimed = true;
        arg0.total_claims = arg0.total_claims + 1;
        assert!(0x2::hash::blake2b256(&arg2) == arg1.secret_hash, 100);
        arg1.secret_hash = 0x1::vector::empty<u8>();
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.amount, 0x2::balance::value<0x2::sui::SUI>(&arg1.amount)), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_claim_link(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 106);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 10000000, 105);
        if (arg3 > 0) {
            assert!(arg3 <= 2592000000, 107);
        };
        let v1 = v0 * 1 / 100;
        let v2 = v1;
        if (v1 < 100000) {
            v2 = 100000;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg5), @0x71d783069c9f6545418cf23259dd791d5ed48ae22218d8d1539de31dec48e67a);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = if (arg3 == 0) {
            86400000
        } else {
            arg3
        };
        let v5 = Deposit{
            id          : 0x2::object::new(arg5),
            amount      : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            secret_hash : arg2,
            sender      : 0x2::tx_context::sender(arg5),
            expiry_ms   : v3 + v4,
            claimed     : false,
            created_at  : v3,
        };
        arg0.total_deposits = arg0.total_deposits + 1;
        0x2::transfer::share_object<Deposit>(v5);
    }

    public fun get_deposit_info(arg0: &Deposit) : (u64, address, u64, bool, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.amount), arg0.sender, arg0.expiry_ms, arg0.claimed, arg0.created_at)
    }

    public fun get_stats(arg0: &Config) : (u64, u64, u64) {
        (arg0.total_deposits, arg0.total_claims, arg0.total_refunds)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id             : 0x2::object::new(arg0),
            total_deposits : 0,
            total_claims   : 0,
            total_refunds  : 0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_expired(arg0: &Deposit, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms
    }

    public entry fun refund(arg0: &mut Config, arg1: &mut Deposit, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.claimed, 101);
        assert!(0x2::tx_context::sender(arg3) == arg1.sender, 103);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expiry_ms, 102);
        arg1.claimed = true;
        arg0.total_refunds = arg0.total_refunds + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.amount, 0x2::balance::value<0x2::sui::SUI>(&arg1.amount)), arg3), arg1.sender);
    }

    // decompiled from Move bytecode v6
}

