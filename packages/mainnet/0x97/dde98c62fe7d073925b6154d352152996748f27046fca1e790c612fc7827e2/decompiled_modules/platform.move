module 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform {
    struct Platform has key {
        id: 0x2::object::UID,
        treasury: address,
        fee: u64,
        period_ms: u64,
        trial_ms: u64,
        paid_until: 0x2::table::Table<address, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TrialStarted has copy, drop {
        owner: address,
        until_ms: u64,
    }

    struct Subscribed has copy, drop {
        owner: address,
        payer: address,
        amount: u64,
        until_ms: u64,
    }

    struct TermsChanged has copy, drop {
        treasury: address,
        fee: u64,
        period_ms: u64,
        trial_ms: u64,
    }

    public fun fee(arg0: &Platform) : u64 {
        arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Platform{
            id         : 0x2::object::new(arg0),
            treasury   : 0x2::tx_context::sender(arg0),
            fee        : 10000000000,
            period_ms  : 30 * 86400000,
            trial_ms   : 30 * 86400000,
            paid_until : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Platform>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &Platform, arg1: address, arg2: &0x2::clock::Clock) : bool {
        0x2::table::contains<address, u64>(&arg0.paid_until, arg1) && 0x2::clock::timestamp_ms(arg2) <= *0x2::table::borrow<address, u64>(&arg0.paid_until, arg1)
    }

    public fun paid_until(arg0: &Platform, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.paid_until, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.paid_until, arg1)
        } else {
            0
        }
    }

    public fun set_terms(arg0: &AdminCap, arg1: &mut Platform, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg3 > 0 && arg4 > 0, 202);
        arg1.treasury = arg2;
        arg1.fee = arg3;
        arg1.period_ms = arg4;
        arg1.trial_ms = arg5;
        let v0 = TermsChanged{
            treasury  : arg2,
            fee       : arg3,
            period_ms : arg4,
            trial_ms  : arg5,
        };
        0x2::event::emit<TermsChanged>(v0);
    }

    public(friend) fun start_trial(arg0: &mut Platform, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::table::contains<address, u64>(&arg0.paid_until, arg1)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg0.trial_ms;
        0x2::table::add<address, u64>(&mut arg0.paid_until, arg1, v0);
        let v1 = TrialStarted{
            owner    : arg1,
            until_ms : v0,
        };
        0x2::event::emit<TrialStarted>(v1);
    }

    public fun subscribe(arg0: &mut Platform, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0 && v0 % arg0.fee == 0, 201);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.paid_until, arg1)) {
            let v3 = 0x2::table::remove<address, u64>(&mut arg0.paid_until, arg1);
            if (v3 > v1) {
                v3
            } else {
                v1
            }
        } else {
            v1
        };
        let v4 = v2 + v0 / arg0.fee * arg0.period_ms;
        0x2::table::add<address, u64>(&mut arg0.paid_until, arg1, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.treasury);
        let v5 = Subscribed{
            owner    : arg1,
            payer    : 0x2::tx_context::sender(arg4),
            amount   : v0,
            until_ms : v4,
        };
        0x2::event::emit<Subscribed>(v5);
    }

    public fun treasury(arg0: &Platform) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

