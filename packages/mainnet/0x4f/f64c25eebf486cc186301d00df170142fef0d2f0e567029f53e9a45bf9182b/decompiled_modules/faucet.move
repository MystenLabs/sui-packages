module 0x4ff64c25eebf486cc186301d00df170142fef0d2f0e567029f53e9a45bf9182b::faucet {
    struct FaucetPool<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<T0>,
        claim_amount: u64,
        claim: 0x2::table::Table<address, u64>,
        admin: address,
        is_paused: bool,
        cooldown_period: u64,
        total_claims: u64,
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
        0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<address, u64>(&arg0.claim, arg1) + arg0.cooldown_period
    }

    public entry fun claim_tokens<T0>(arg0: &mut FaucetPool<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 13906834548005535745);
        assert!(!arg0.is_paused, 13906834552301027337);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, u64>(&arg0.claim, arg2)) {
            assert!(v0 >= *0x2::table::borrow<address, u64>(&arg0.claim, arg2) + arg0.cooldown_period, 13906834578070437891);
        };
        assert!(0x2::balance::value<T0>(&arg0.coin) >= arg0.claim_amount, 13906834599545405445);
        if (0x2::table::contains<address, u64>(&arg0.claim, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claim, arg2) = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claim, arg2, v0);
        };
        arg0.total_claims = arg0.total_claims + 1;
        let v1 = ClaimEvent{
            recipient : arg2,
            amount    : arg0.claim_amount,
            timestamp : v0,
        };
        0x2::event::emit<ClaimEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin, arg0.claim_amount), arg3), arg2);
    }

    public entry fun create_faucet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13906834397682073607);
        let v0 = FaucetPool<T0>{
            id              : 0x2::object::new(arg2),
            coin            : 0x2::coin::into_balance<T0>(arg0),
            claim_amount    : arg1,
            claim           : 0x2::table::new<address, u64>(arg2),
            admin           : 0x2::tx_context::sender(arg2),
            is_paused       : false,
            cooldown_period : 86400000,
            total_claims    : 0,
        };
        0x2::transfer::share_object<FaucetPool<T0>>(v0);
    }

    public entry fun deposit_token<T0>(arg0: &mut FaucetPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834496465928193);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906834500761288711);
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

    public fun get_faucet_stats<T0>(arg0: &FaucetPool<T0>) : (u64, u64, u64, bool, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin), arg0.claim_amount, 0x2::table::length<address, u64>(&arg0.claim), arg0.is_paused, 0x2::balance::value<T0>(&arg0.coin) / arg0.claim_amount, arg0.total_claims)
    }

    public fun get_last_claim_time<T0>(arg0: &FaucetPool<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::table::contains<address, u64>(&arg0.claim, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.claim, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_total_claims<T0>(arg0: &FaucetPool<T0>) : u64 {
        arg0.total_claims
    }

    public fun has_sufficient_balance<T0>(arg0: &FaucetPool<T0>) : bool {
        0x2::balance::value<T0>(&arg0.coin) >= arg0.claim_amount
    }

    public fun is_paused<T0>(arg0: &FaucetPool<T0>) : bool {
        arg0.is_paused
    }

    public entry fun pause_faucet<T0>(arg0: &mut FaucetPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13906834913077755905);
        arg0.is_paused = true;
    }

    public entry fun set_admin<T0>(arg0: &mut FaucetPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834887307952129);
        arg0.admin = arg1;
    }

    public entry fun set_claim_amount<T0>(arg0: &mut FaucetPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834758458933249);
        assert!(arg1 > 0, 13906834762754293767);
        arg0.claim_amount = arg1;
    }

    public entry fun set_cooldown_period<T0>(arg0: &mut FaucetPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834865833115649);
        arg0.cooldown_period = arg1;
    }

    public entry fun unpause_faucet<T0>(arg0: &mut FaucetPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13906834938847559681);
        arg0.is_paused = false;
    }

    public entry fun withdraw<T0>(arg0: &mut FaucetPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906834784228737025);
        assert!(arg1 > 0, 13906834792819064839);
        assert!(0x2::balance::value<T0>(&arg0.coin) >= arg1, 13906834801408868357);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

