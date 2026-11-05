module 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<T0>,
        cards: 0x2::table::Table<address, Card>,
    }

    struct Card has store {
        label: 0x1::string::String,
        per_tx: u64,
        daily: u64,
        approve_above: u64,
        allowlist: vector<address>,
        expires_ms: u64,
        day_start_ms: u64,
        spent_today: u64,
        spent_total: u64,
        earned_total: u64,
        status: u8,
        ceiling: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PendingSpend<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        agent: address,
        to: address,
        amount: u64,
        memo: 0x1::string::String,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
    }

    struct CardIssued has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        label: 0x1::string::String,
    }

    struct CardStatus has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        status: u8,
    }

    struct Deposited has copy, drop {
        pool_id: 0x2::object::ID,
        from: address,
        amount: u64,
    }

    struct Spent has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        to: address,
        amount: u64,
        memo: 0x1::string::String,
        approved_by_owner: bool,
    }

    struct Earned has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        from: address,
        amount: u64,
    }

    struct ApprovalRequested has copy, drop {
        pool_id: 0x2::object::ID,
        pending_id: 0x2::object::ID,
        agent: address,
        to: address,
        amount: u64,
        memo: 0x1::string::String,
    }

    struct ApprovalDenied has copy, drop {
        pool_id: 0x2::object::ID,
        pending_id: 0x2::object::ID,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    fun take<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &mut Pool<T0>, arg2: address, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<Pool<T0>>(arg1);
        let v1 = 0x2::balance::value<T0>(&arg1.funds);
        assert!(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::is_active(arg0, arg1.owner, arg6), 13);
        let v2 = active_card<T0>(arg1, arg2, arg6);
        assert!(0x1::vector::is_empty<address>(&v2.allowlist) || 0x1::vector::contains<address>(&v2.allowlist, &arg3), 8);
        assert!(arg4 <= v2.per_tx, 5);
        assert!(v2.spent_today + arg4 <= v2.daily, 6);
        assert!(arg4 <= v2.approve_above, 7);
        assert!(v2.ceiling == 0 || v2.spent_total + arg4 <= v2.ceiling, 14);
        assert!(v1 >= arg4, 9);
        v2.spent_today = v2.spent_today + arg4;
        v2.spent_total = v2.spent_total + arg4;
        let v3 = Spent{
            pool_id           : v0,
            agent             : arg2,
            to                : arg3,
            amount            : arg4,
            memo              : arg5,
            approved_by_owner : false,
        };
        0x2::event::emit<Spent>(v3);
        0x2::coin::take<T0>(&mut arg1.funds, arg4, arg7)
    }

    public fun new<T0>(arg0: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (Pool<T0>, OwnerCap) {
        let v0 = Pool<T0>{
            id    : 0x2::object::new(arg2),
            owner : 0x2::tx_context::sender(arg2),
            funds : 0x2::balance::zero<T0>(),
            cards : 0x2::table::new<address, Card>(arg2),
        };
        let v1 = 0x2::object::id<Pool<T0>>(&v0);
        0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::start_trial(arg0, 0x2::tx_context::sender(arg2), arg1);
        let v2 = PoolCreated{
            pool_id : v1,
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PoolCreated>(v2);
        let v3 = OwnerCap{
            id      : 0x2::object::new(arg2),
            pool_id : v1,
        };
        (v0, v3)
    }

    fun active_card<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : &mut Card {
        let v0 = card_mut<T0>(arg0, arg1);
        assert!(v0.status != 2, 3);
        assert!(v0.status != 1, 11);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0.expires_ms == 0 || v1 < v0.expires_ms, 4);
        if (v1 >= v0.day_start_ms + 86400000) {
            v0.day_start_ms = v1;
            v0.spent_today = 0;
        };
        v0
    }

    public fun approve<T0>(arg0: &OwnerCap, arg1: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg2: &mut Pool<T0>, arg3: PendingSpend<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_cap<T0>(arg0, arg2);
        assert!(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::is_active(arg1, arg2.owner, arg4), 13);
        let PendingSpend {
            id      : v0,
            pool_id : v1,
            agent   : v2,
            to      : v3,
            amount  : v4,
            memo    : v5,
        } = arg3;
        assert!(v1 == 0x2::object::id<Pool<T0>>(arg2), 10);
        0x2::object::delete(v0);
        assert!(0x2::balance::value<T0>(&arg2.funds) >= v4, 9);
        let v6 = card_mut<T0>(arg2, v2);
        assert!(v6.status != 2, 3);
        assert!(v6.ceiling == 0 || v6.spent_total + v4 <= v6.ceiling, 14);
        let v7 = 0x2::clock::timestamp_ms(arg4);
        if (v7 >= v6.day_start_ms + 86400000) {
            v6.day_start_ms = v7;
            v6.spent_today = 0;
        };
        v6.spent_today = v6.spent_today + v4;
        v6.spent_total = v6.spent_total + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.funds, v4, arg5), v3);
        let v8 = Spent{
            pool_id           : v1,
            agent             : v2,
            to                : v3,
            amount            : v4,
            memo              : v5,
            approved_by_owner : true,
        };
        0x2::event::emit<Spent>(v8);
    }

    public fun balance_value<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun card_mut<T0>(arg0: &mut Pool<T0>, arg1: address) : &mut Card {
        assert!(0x2::table::contains<address, Card>(&arg0.cards, arg1), 1);
        0x2::table::borrow_mut<address, Card>(&mut arg0.cards, arg1)
    }

    public fun card_status<T0>(arg0: &Pool<T0>, arg1: address) : u8 {
        0x2::table::borrow<address, Card>(&arg0.cards, arg1).status
    }

    fun check_cap<T0>(arg0: &OwnerCap, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::id<Pool<T0>>(arg1), 2);
    }

    public fun create<T0>(arg0: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public(friend) fun credit_earning<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        assert!(0x2::table::contains<address, Card>(&arg0.cards, arg1), 1);
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.funds, arg2);
        let v1 = 0x2::table::borrow_mut<address, Card>(&mut arg0.cards, arg1);
        v1.earned_total = v1.earned_total + v0;
        let v2 = Earned{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            agent   : arg1,
            from    : arg3,
            amount  : v0,
        };
        0x2::event::emit<Earned>(v2);
    }

    public fun deny<T0>(arg0: &OwnerCap, arg1: &Pool<T0>, arg2: PendingSpend<T0>) {
        check_cap<T0>(arg0, arg1);
        let PendingSpend {
            id      : v0,
            pool_id : v1,
            agent   : _,
            to      : _,
            amount  : _,
            memo    : _,
        } = arg2;
        let v6 = v0;
        assert!(v1 == 0x2::object::id<Pool<T0>>(arg1), 10);
        0x2::object::delete(v6);
        let v7 = ApprovalDenied{
            pool_id    : v1,
            pending_id : 0x2::object::uid_to_inner(&v6),
        };
        0x2::event::emit<ApprovalDenied>(v7);
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Deposited{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            from    : 0x2::tx_context::sender(arg2),
            amount  : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun earned_total<T0>(arg0: &Pool<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Card>(&arg0.cards, arg1).earned_total
    }

    public fun has_card<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x2::table::contains<address, Card>(&arg0.cards, arg1)
    }

    public fun issue_card<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        check_cap<T0>(arg0, arg1);
        assert!(!0x2::table::contains<address, Card>(&arg1.cards, arg2), 12);
        let v0 = Card{
            label         : arg3,
            per_tx        : arg4,
            daily         : arg5,
            approve_above : arg6,
            allowlist     : vector[],
            expires_ms    : arg7,
            day_start_ms  : 0,
            spent_today   : 0,
            spent_total   : 0,
            earned_total  : 0,
            status        : 0,
            ceiling       : arg8,
        };
        0x2::table::add<address, Card>(&mut arg1.cards, arg2, v0);
        let v1 = CardIssued{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            agent   : arg2,
            label   : arg3,
        };
        0x2::event::emit<CardIssued>(v1);
    }

    public fun owner<T0>(arg0: &Pool<T0>) : address {
        arg0.owner
    }

    public fun pause_self<T0>(arg0: &mut Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::id<Pool<T0>>(arg0);
        let v2 = card_mut<T0>(arg0, v0);
        if (v2.status == 0) {
            v2.status = 1;
        };
        let v3 = CardStatus{
            pool_id : v1,
            agent   : v0,
            status  : v2.status,
        };
        0x2::event::emit<CardStatus>(v3);
    }

    public fun pay_agent<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &mut Pool<T0>, arg2: &mut Pool<T0>, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Pool<T0>>(arg1) != 0x2::object::id<Pool<T0>>(arg2), 15);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = take<T0>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7);
        credit_earning<T0>(arg2, arg3, 0x2::coin::into_balance<T0>(v1), 0x2::tx_context::sender(arg7));
    }

    public fun pay_agent_local<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &mut Pool<T0>, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = take<T0>(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6);
        credit_earning<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v1), 0x2::tx_context::sender(arg6));
    }

    public fun request_approval<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &mut Pool<T0>, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<Pool<T0>>(arg1);
        assert!(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::is_active(arg0, arg1.owner, arg5), 13);
        let v2 = active_card<T0>(arg1, v0, arg5);
        assert!(0x1::vector::is_empty<address>(&v2.allowlist) || 0x1::vector::contains<address>(&v2.allowlist, &arg2), 8);
        let v3 = PendingSpend<T0>{
            id      : 0x2::object::new(arg6),
            pool_id : v1,
            agent   : v0,
            to      : arg2,
            amount  : arg3,
            memo    : arg4,
        };
        let v4 = ApprovalRequested{
            pool_id    : v1,
            pending_id : 0x2::object::id<PendingSpend<T0>>(&v3),
            agent      : v0,
            to         : arg2,
            amount     : arg3,
            memo       : arg4,
        };
        0x2::event::emit<ApprovalRequested>(v4);
        0x2::transfer::share_object<PendingSpend<T0>>(v3);
    }

    public fun revoke<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: address) {
        check_cap<T0>(arg0, arg1);
        let v0 = card_mut<T0>(arg1, arg2);
        v0.status = 2;
        let v1 = CardStatus{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            agent   : arg2,
            status  : 2,
        };
        0x2::event::emit<CardStatus>(v1);
    }

    public fun set_allowlist<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: address, arg3: vector<address>) {
        check_cap<T0>(arg0, arg1);
        card_mut<T0>(arg1, arg2).allowlist = arg3;
    }

    public fun set_limits<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        check_cap<T0>(arg0, arg1);
        let v0 = card_mut<T0>(arg1, arg2);
        v0.per_tx = arg3;
        v0.daily = arg4;
        v0.approve_above = arg5;
        v0.expires_ms = arg6;
        v0.ceiling = arg7;
    }

    public fun set_paused<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: address, arg3: bool) {
        check_cap<T0>(arg0, arg1);
        let v0 = 0x2::object::id<Pool<T0>>(arg1);
        let v1 = card_mut<T0>(arg1, arg2);
        assert!(v1.status != 2, 3);
        let v2 = if (arg3) {
            1
        } else {
            0
        };
        v1.status = v2;
        let v3 = CardStatus{
            pool_id : v0,
            agent   : arg2,
            status  : v1.status,
        };
        0x2::event::emit<CardStatus>(v3);
    }

    public fun share<T0>(arg0: Pool<T0>) {
        0x2::transfer::share_object<Pool<T0>>(arg0);
    }

    public fun spend<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &mut Pool<T0>, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6), arg2);
    }

    public(friend) fun spend_coin<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: &mut Pool<T0>, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        take<T0>(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun spent_today<T0>(arg0: &Pool<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Card>(&arg0.cards, arg1).spent_today
    }

    public fun spent_total<T0>(arg0: &Pool<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Card>(&arg0.cards, arg1).spent_total
    }

    public fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_cap<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.funds, arg2, arg3), arg1.owner);
        let v0 = Withdrawn{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            amount  : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

