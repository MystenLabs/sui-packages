module 0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::mandate {
    struct Mandate<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        balance: 0x2::balance::Balance<T0>,
        max_per_payment: u64,
        max_per_period: u64,
        period_ms: u64,
        period_start_ms: u64,
        spent_in_period: u64,
        total_spent: u64,
        payments: u64,
        expires_ms: u64,
        paused: bool,
        any_recipient: bool,
        recipients: 0x2::vec_set::VecSet<address>,
        used_nonces: 0x2::table::Table<vector<u8>, bool>,
        label: 0x1::string::String,
    }

    struct MandateCreated has copy, drop {
        mandate: 0x2::object::ID,
        owner: address,
        agent: address,
        amount: u64,
        max_per_payment: u64,
        max_per_period: u64,
        period_ms: u64,
        expires_ms: u64,
        any_recipient: bool,
        recipients: vector<address>,
    }

    struct Paid<phantom T0> has copy, drop {
        mandate: 0x2::object::ID,
        receipt_no: u64,
        payer: address,
        agent: address,
        recipient: address,
        service: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
        nonce: vector<u8>,
        memo: 0x1::string::String,
        timestamp_ms: u64,
        spent_in_period: u64,
        balance_after: u64,
    }

    struct ToppedUp has copy, drop {
        mandate: 0x2::object::ID,
        from: address,
        amount: u64,
        balance_after: u64,
    }

    struct Withdrawn has copy, drop {
        mandate: 0x2::object::ID,
        amount: u64,
        balance_after: u64,
    }

    struct AgentChanged has copy, drop {
        mandate: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
    }

    struct LimitsChanged has copy, drop {
        mandate: 0x2::object::ID,
        max_per_payment: u64,
        max_per_period: u64,
        period_ms: u64,
    }

    struct ExpiryChanged has copy, drop {
        mandate: 0x2::object::ID,
        expires_ms: u64,
    }

    struct RecipientsChanged has copy, drop {
        mandate: 0x2::object::ID,
        any_recipient: bool,
        recipients: vector<address>,
    }

    struct PauseChanged has copy, drop {
        mandate: 0x2::object::ID,
        paused: bool,
    }

    struct MandateClosed has copy, drop {
        mandate: 0x2::object::ID,
        refunded: u64,
    }

    public fun balance<T0>(arg0: &Mandate<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun add_recipient<T0>(arg0: &mut Mandate<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        if (!0x2::vec_set::contains<address>(&arg0.recipients, &arg1)) {
            assert!(0x2::vec_set::length<address>(&arg0.recipients) < 32, 15);
            0x2::vec_set::insert<address>(&mut arg0.recipients, arg1);
        };
        emit_recipients<T0>(arg0);
    }

    public fun agent<T0>(arg0: &Mandate<T0>) : address {
        arg0.agent
    }

    fun assert_owner<T0>(arg0: &Mandate<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun can_pay<T0>(arg0: &Mandate<T0>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : bool {
        if (arg0.agent == @0x0 || arg0.paused) {
            return false
        };
        if (arg0.expires_ms != 0 && 0x2::clock::timestamp_ms(arg3) >= arg0.expires_ms) {
            return false
        };
        if (arg1 == 0 || arg1 > arg0.max_per_payment) {
            return false
        };
        if (!arg0.any_recipient && !0x2::vec_set::contains<address>(&arg0.recipients, &arg2)) {
            return false
        };
        arg1 <= remaining_in_period<T0>(arg0, arg3)
    }

    fun check_limits(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0 && arg1 > 0, 11);
        assert!(arg0 <= arg1, 11);
        assert!(arg2 >= 60000 && arg2 <= 31536000000, 12);
    }

    public fun close<T0>(arg0: Mandate<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(&arg0, arg1);
        let Mandate {
            id              : v0,
            owner           : v1,
            agent           : _,
            balance         : v3,
            max_per_payment : _,
            max_per_period  : _,
            period_ms       : _,
            period_start_ms : _,
            spent_in_period : _,
            total_spent     : _,
            payments        : _,
            expires_ms      : _,
            paused          : _,
            any_recipient   : _,
            recipients      : _,
            used_nonces     : v15,
            label           : _,
        } = arg0;
        let v17 = v3;
        let v18 = v0;
        let v19 = 0x2::balance::value<T0>(&v17);
        if (v19 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v17, arg1), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v17);
        };
        0x2::table::drop<vector<u8>, bool>(v15);
        let v20 = MandateClosed{
            mandate  : 0x2::object::uid_to_inner(&v18),
            refunded : v19,
        };
        0x2::event::emit<MandateClosed>(v20);
        0x2::object::delete(v18);
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<address>, arg7: bool, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        check_limits(arg2, arg3, arg4);
        assert!(arg5 == 0 || arg5 > v0, 13);
        assert!(0x1::vector::length<u8>(&arg8) <= 64, 16);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0x1::vector::length<address>(&arg6);
        assert!(v2 <= 32, 15);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<address>(&arg6, v3);
            if (!0x2::vec_set::contains<address>(&v1, &v4)) {
                0x2::vec_set::insert<address>(&mut v1, v4);
            };
            v3 = v3 + 1;
        };
        assert!(arg7 || !0x2::vec_set::is_empty<address>(&v1), 14);
        let v5 = 0x2::tx_context::sender(arg10);
        let v6 = Mandate<T0>{
            id              : 0x2::object::new(arg10),
            owner           : v5,
            agent           : arg1,
            balance         : 0x2::coin::into_balance<T0>(arg0),
            max_per_payment : arg2,
            max_per_period  : arg3,
            period_ms       : arg4,
            period_start_ms : v0,
            spent_in_period : 0,
            total_spent     : 0,
            payments        : 0,
            expires_ms      : arg5,
            paused          : false,
            any_recipient   : arg7,
            recipients      : v1,
            used_nonces     : 0x2::table::new<vector<u8>, bool>(arg10),
            label           : 0x1::string::utf8(arg8),
        };
        let v7 = MandateCreated{
            mandate         : 0x2::object::id<Mandate<T0>>(&v6),
            owner           : v5,
            agent           : arg1,
            amount          : 0x2::coin::value<T0>(&arg0),
            max_per_payment : arg2,
            max_per_period  : arg3,
            period_ms       : arg4,
            expires_ms      : arg5,
            any_recipient   : arg7,
            recipients      : *0x2::vec_set::keys<address>(&v6.recipients),
        };
        0x2::event::emit<MandateCreated>(v7);
        0x2::transfer::share_object<Mandate<T0>>(v6);
    }

    fun do_pay<T0>(arg0: &mut Mandate<T0>, arg1: u64, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x2::tx_context::sender(arg7) == arg0.agent && arg0.agent != @0x0, 1);
        assert!(!arg0.paused, 2);
        assert!(arg0.expires_ms == 0 || v0 < arg0.expires_ms, 3);
        assert!(arg1 > 0, 4);
        assert!(arg1 <= arg0.max_per_payment, 5);
        assert!(0x1::vector::length<u8>(&arg5) <= 128, 19);
        roll_period<T0>(arg0, v0);
        assert!(arg0.spent_in_period + arg1 <= arg0.max_per_period, 6);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            assert!(0x1::vector::length<u8>(&arg4) <= 64, 9);
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg4), 8);
            0x2::table::add<vector<u8>, bool>(&mut arg0.used_nonces, arg4, true);
        };
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 10);
        arg0.spent_in_period = arg0.spent_in_period + arg1;
        arg0.total_spent = arg0.total_spent + arg1;
        arg0.payments = arg0.payments + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg7), arg2);
        let v1 = Paid<T0>{
            mandate         : 0x2::object::id<Mandate<T0>>(arg0),
            receipt_no      : arg0.payments,
            payer           : arg0.owner,
            agent           : arg0.agent,
            recipient       : arg2,
            service         : arg3,
            amount          : arg1,
            nonce           : arg4,
            memo            : 0x1::string::utf8(arg5),
            timestamp_ms    : v0,
            spent_in_period : arg0.spent_in_period,
            balance_after   : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<Paid<T0>>(v1);
    }

    fun emit_recipients<T0>(arg0: &Mandate<T0>) {
        let v0 = RecipientsChanged{
            mandate       : 0x2::object::id<Mandate<T0>>(arg0),
            any_recipient : arg0.any_recipient,
            recipients    : *0x2::vec_set::keys<address>(&arg0.recipients),
        };
        0x2::event::emit<RecipientsChanged>(v0);
    }

    public fun is_paused<T0>(arg0: &Mandate<T0>) : bool {
        arg0.paused
    }

    public fun max_per_payment<T0>(arg0: &Mandate<T0>) : u64 {
        arg0.max_per_payment
    }

    public fun max_per_period<T0>(arg0: &Mandate<T0>) : u64 {
        arg0.max_per_period
    }

    public fun nonce_used<T0>(arg0: &Mandate<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg1)
    }

    public fun owner<T0>(arg0: &Mandate<T0>) : address {
        arg0.owner
    }

    public fun pause<T0>(arg0: &mut Mandate<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.paused = true;
        let v0 = PauseChanged{
            mandate : 0x2::object::id<Mandate<T0>>(arg0),
            paused  : true,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun pay<T0>(arg0: &mut Mandate<T0>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.any_recipient || 0x2::vec_set::contains<address>(&arg0.recipients, &arg2), 7);
        do_pay<T0>(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), arg3, arg4, arg5, arg6);
    }

    public fun pay_service<T0>(arg0: &mut Mandate<T0>, arg1: &0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service::Service<T0>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service::is_api<T0>(arg1), 20);
        assert!(0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service::is_active<T0>(arg1), 17);
        let v0 = 0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service::price<T0>(arg1);
        assert!(v0 <= arg2, 18);
        let v1 = 0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service::pay_to<T0>(arg1);
        let v2 = 0x2::object::id<0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service::Service<T0>>(arg1);
        let v3 = if (arg0.any_recipient) {
            true
        } else {
            let v4 = 0x2::object::id_to_address(&v2);
            if (0x2::vec_set::contains<address>(&arg0.recipients, &v4)) {
                true
            } else {
                0x2::vec_set::contains<address>(&arg0.recipients, &v1)
            }
        };
        assert!(v3, 7);
        do_pay<T0>(arg0, v0, v1, 0x1::option::some<0x2::object::ID>(v2), arg3, b"", arg4, arg5);
    }

    public fun payments<T0>(arg0: &Mandate<T0>) : u64 {
        arg0.payments
    }

    public fun remaining_in_period<T0>(arg0: &Mandate<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if (0x2::clock::timestamp_ms(arg1) >= arg0.period_start_ms + arg0.period_ms) {
            0
        } else {
            arg0.spent_in_period
        };
        let v1 = if (v0 >= arg0.max_per_period) {
            0
        } else {
            arg0.max_per_period - v0
        };
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        if (v1 < v2) {
            v1
        } else {
            v2
        }
    }

    public fun remove_recipient<T0>(arg0: &mut Mandate<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        if (0x2::vec_set::contains<address>(&arg0.recipients, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.recipients, &arg1);
        };
        emit_recipients<T0>(arg0);
    }

    public fun resume<T0>(arg0: &mut Mandate<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.paused = false;
        let v0 = PauseChanged{
            mandate : 0x2::object::id<Mandate<T0>>(arg0),
            paused  : false,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    fun roll_period<T0>(arg0: &mut Mandate<T0>, arg1: u64) {
        if (arg1 >= arg0.period_start_ms + arg0.period_ms) {
            arg0.period_start_ms = arg1;
            arg0.spent_in_period = 0;
        };
    }

    public fun set_agent<T0>(arg0: &mut Mandate<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        arg0.agent = arg1;
        let v0 = AgentChanged{
            mandate   : 0x2::object::id<Mandate<T0>>(arg0),
            old_agent : arg0.agent,
            new_agent : arg1,
        };
        0x2::event::emit<AgentChanged>(v0);
    }

    public fun set_any_recipient<T0>(arg0: &mut Mandate<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        arg0.any_recipient = arg1;
        emit_recipients<T0>(arg0);
    }

    public fun set_expiry<T0>(arg0: &mut Mandate<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(arg1 == 0 || arg1 > 0x2::clock::timestamp_ms(arg2), 13);
        arg0.expires_ms = arg1;
        let v0 = ExpiryChanged{
            mandate    : 0x2::object::id<Mandate<T0>>(arg0),
            expires_ms : arg1,
        };
        0x2::event::emit<ExpiryChanged>(v0);
    }

    public fun set_limits<T0>(arg0: &mut Mandate<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg4);
        check_limits(arg1, arg2, arg3);
        arg0.max_per_payment = arg1;
        arg0.max_per_period = arg2;
        arg0.period_ms = arg3;
        let v0 = LimitsChanged{
            mandate         : 0x2::object::id<Mandate<T0>>(arg0),
            max_per_payment : arg1,
            max_per_period  : arg2,
            period_ms       : arg3,
        };
        0x2::event::emit<LimitsChanged>(v0);
    }

    public fun top_up<T0>(arg0: &mut Mandate<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = ToppedUp{
            mandate       : 0x2::object::id<Mandate<T0>>(arg0),
            from          : 0x2::tx_context::sender(arg2),
            amount        : v0,
            balance_after : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<ToppedUp>(v1);
    }

    public fun total_spent<T0>(arg0: &Mandate<T0>) : u64 {
        arg0.total_spent
    }

    public fun withdraw<T0>(arg0: &mut Mandate<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), arg0.owner);
        let v0 = Withdrawn{
            mandate       : 0x2::object::id<Mandate<T0>>(arg0),
            amount        : arg1,
            balance_after : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    public fun withdraw_all<T0>(arg0: &mut Mandate<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg1), arg0.owner);
        let v1 = Withdrawn{
            mandate       : 0x2::object::id<Mandate<T0>>(arg0),
            amount        : v0,
            balance_after : 0,
        };
        0x2::event::emit<Withdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

