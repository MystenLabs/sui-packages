module 0x6177004e9a67fcc415d1f5b7e3ac9270f14d77a8e53552289b3cdc7ccb694c8c::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    struct FaucetPool<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<T0>,
        claim_amount: u64,
        claim: 0x2::table::Table<address, u64>,
        admin: address,
        is_paused: bool,
        cooldown_period: u64,
    }

    struct ClaimEvent has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    public fun can_claim<T0>(arg0: &FaucetPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.claim, arg1)) {
            return true
        };
        0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<address, u64>(&arg0.claim, arg1) + 86400000
    }

    public entry fun claim_tokens<T0>(arg0: &mut FaucetPool<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 13906834535121158153);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, u64>(&arg0.claim, arg2)) {
            assert!(v0 >= *0x2::table::borrow<address, u64>(&arg0.claim, arg2) + 86400000, 13906834556595601411);
        };
        assert!(0x2::balance::value<T0>(&arg0.coin) >= arg0.claim_amount, 13906834573775601669);
        if (0x2::table::contains<address, u64>(&arg0.claim, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claim, arg2) = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claim, arg2, v0);
        };
        let v1 = ClaimEvent{
            recipient : arg2,
            amount    : arg0.claim_amount,
            timestamp : v0,
        };
        0x2::event::emit<ClaimEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin, arg0.claim_amount), arg3), arg2);
    }

    public entry fun create_faucet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13906834389092139015);
        let v0 = FaucetPool<T0>{
            id              : 0x2::object::new(arg2),
            coin            : 0x2::coin::into_balance<T0>(arg0),
            claim_amount    : arg1,
            claim           : 0x2::table::new<address, u64>(arg2),
            admin           : 0x2::tx_context::sender(arg2),
            is_paused       : false,
            cooldown_period : 86400000,
        };
        0x2::transfer::share_object<FaucetPool<T0>>(v0);
    }

    public entry fun deposit_token<T0>(arg0: &mut FaucetPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834483581026305);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906834487876386823);
        0x2::balance::join<T0>(&mut arg0.coin, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_claim_amount<T0>(arg0: &FaucetPool<T0>) : u64 {
        arg0.claim_amount
    }

    public fun get_faucet_admin<T0>(arg0: &FaucetPool<T0>) : address {
        arg0.admin
    }

    public fun get_faucet_balance<T0>(arg0: &FaucetPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.coin)
    }

    public fun get_faucet_info<T0>(arg0: &FaucetPool<T0>) : (u64, u64, address, bool, u64) {
        (0x2::balance::value<T0>(&arg0.coin), arg0.claim_amount, arg0.admin, arg0.is_paused, arg0.cooldown_period)
    }

    public fun get_faucet_stats<T0>(arg0: &FaucetPool<T0>) : (u64, u64, u64, bool, u64) {
        (0x2::balance::value<T0>(&arg0.coin), arg0.claim_amount, 0x2::table::length<address, u64>(&arg0.claim), arg0.is_paused, 0x2::balance::value<T0>(&arg0.coin) / arg0.claim_amount)
    }

    public fun get_last_claim_time<T0>(arg0: &FaucetPool<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::table::contains<address, u64>(&arg0.claim, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.claim, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun has_sufficient_balance<T0>(arg0: &FaucetPool<T0>) : bool {
        0x2::balance::value<T0>(&arg0.coin) >= arg0.claim_amount
    }

    public fun is_paused<T0>(arg0: &FaucetPool<T0>) : bool {
        arg0.is_paused
    }

    public entry fun pause_faucet<T0>(arg0: &mut FaucetPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13906834835768344577);
        arg0.is_paused = true;
    }

    public entry fun set_admin<T0>(arg0: &mut FaucetPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834809998540801);
        arg0.admin = arg1;
    }

    public entry fun set_claim_amount<T0>(arg0: &mut FaucetPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834719804227585);
        assert!(arg1 > 0, 13906834724099588103);
        arg0.claim_amount = arg1;
    }

    public entry fun unpause_faucet<T0>(arg0: &mut FaucetPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13906834861538148353);
        arg0.is_paused = false;
    }

    public entry fun withdraw<T0>(arg0: &mut FaucetPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834745574031361);
        assert!(arg1 > 0, 13906834754164359175);
        assert!(0x2::balance::value<T0>(&arg0.coin) >= arg1, 13906834762754162693);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

