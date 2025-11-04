module 0x8a614f5f933e7c0a3f5759da1993160cb83e4d4ccba3bcd916347fef2e61a95::shadow_send {
    struct Config has key {
        id: 0x2::object::UID,
        total_deposits: u64,
        total_claims: u64,
        total_refunds: u64,
        total_early_refunds: u64,
    }

    struct Deposit<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<T0>,
        secret_hash: vector<u8>,
        sender: address,
        expiry_ms: u64,
        claimed: bool,
        created_at: u64,
    }

    struct DepositCreated has copy, drop {
        deposit_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        expiry_ms: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct Claimed has copy, drop {
        deposit_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct Refunded has copy, drop {
        deposit_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct EarlyRefunded has copy, drop {
        deposit_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public entry fun claim<T0>(arg0: &mut Config, arg1: &mut Deposit<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.claimed, 101);
        arg1.claimed = true;
        arg0.total_claims = arg0.total_claims + 1;
        assert!(0x2::hash::blake2b256(&arg2) == arg1.secret_hash, 100);
        arg1.secret_hash = 0x1::vector::empty<u8>();
        let v0 = 0x2::balance::value<T0>(&arg1.amount);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Claimed{
            deposit_id : 0x2::object::uid_to_inner(&arg1.id),
            recipient  : v1,
            amount     : v0,
            coin_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Claimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, v0), arg3), v1);
    }

    public entry fun create_claim_link<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 106);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 108);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000, 105);
        let v1 = v0 * 1 / 100;
        let v2 = v1;
        if (v1 < 100) {
            v2 = 100;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg4), @0x71d783069c9f6545418cf23259dd791d5ed48ae22218d8d1539de31dec48e67a);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = v3 + 604800000;
        let v5 = Deposit<T0>{
            id          : 0x2::object::new(arg4),
            amount      : 0x2::coin::into_balance<T0>(arg1),
            secret_hash : arg2,
            sender      : 0x2::tx_context::sender(arg4),
            expiry_ms   : v4,
            claimed     : false,
            created_at  : v3,
        };
        arg0.total_deposits = arg0.total_deposits + 1;
        let v6 = DepositCreated{
            deposit_id : 0x2::object::uid_to_inner(&v5.id),
            sender     : 0x2::tx_context::sender(arg4),
            amount     : 0x2::balance::value<T0>(&v5.amount),
            expiry_ms  : v4,
            coin_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositCreated>(v6);
        0x2::transfer::share_object<Deposit<T0>>(v5);
    }

    public entry fun early_refund<T0>(arg0: &mut Config, arg1: &mut Deposit<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.claimed, 101);
        assert!(0x2::tx_context::sender(arg2) == arg1.sender, 103);
        arg1.claimed = true;
        arg0.total_early_refunds = arg0.total_early_refunds + 1;
        let v0 = 0x2::balance::value<T0>(&arg1.amount);
        let v1 = EarlyRefunded{
            deposit_id : 0x2::object::uid_to_inner(&arg1.id),
            sender     : arg1.sender,
            amount     : v0,
            coin_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EarlyRefunded>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, v0), arg2), arg1.sender);
    }

    public fun get_deposit_info<T0>(arg0: &Deposit<T0>) : (u64, address, u64, bool, u64) {
        (0x2::balance::value<T0>(&arg0.amount), arg0.sender, arg0.expiry_ms, arg0.claimed, arg0.created_at)
    }

    public fun get_stats(arg0: &Config) : (u64, u64, u64, u64) {
        (arg0.total_deposits, arg0.total_claims, arg0.total_refunds, arg0.total_early_refunds)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            total_deposits      : 0,
            total_claims        : 0,
            total_refunds       : 0,
            total_early_refunds : 0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_expired<T0>(arg0: &Deposit<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms
    }

    public entry fun refund<T0>(arg0: &mut Config, arg1: &mut Deposit<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.claimed, 101);
        assert!(0x2::tx_context::sender(arg3) == arg1.sender, 103);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expiry_ms, 102);
        arg1.claimed = true;
        arg0.total_refunds = arg0.total_refunds + 1;
        let v0 = 0x2::balance::value<T0>(&arg1.amount);
        let v1 = Refunded{
            deposit_id : 0x2::object::uid_to_inner(&arg1.id),
            sender     : arg1.sender,
            amount     : v0,
            coin_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Refunded>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, v0), arg3), arg1.sender);
    }

    // decompiled from Move bytecode v6
}

