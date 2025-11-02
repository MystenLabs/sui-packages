module 0xbabe0ac23d319493b1618c9821980f6da1a4b39369f199f7bdd6cd82c4fcf516::lottery_personal {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        user_deposits: 0x2::table::Table<address, u64>,
        suilend_obligations: 0x2::table::Table<address, vector<u8>>,
        whitelist: 0x2::vec_set::VecSet<address>,
        paused: bool,
        version: u64,
        created_at: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        deposit_time: u64,
        pool_id: address,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        ticket_id: address,
        total_pool: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        ticket_id: address,
        total_pool: u64,
        timestamp: u64,
    }

    struct WhitelistEvent has copy, drop {
        address: address,
        added: bool,
        timestamp: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    public fun add_to_whitelist<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: address, arg3: &0x2::clock::Clock) {
        0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
        let v0 = WhitelistEvent{
            address   : arg2,
            added     : true,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WhitelistEvent>(v0);
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, arg1);
        0x2::vec_set::insert<address>(&mut v0, arg2);
        let v1 = LotteryPool<T0>{
            id                  : 0x2::object::new(arg4),
            balance             : 0x2::balance::zero<T0>(),
            total_deposited     : 0,
            user_deposits       : 0x2::table::new<address, u64>(arg4),
            suilend_obligations : 0x2::table::new<address, vector<u8>>(arg4),
            whitelist           : v0,
            paused              : false,
            version             : 1,
            created_at          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<LotteryPool<T0>>(v1);
    }

    public fun deposit<T0>(arg0: &mut LotteryPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Ticket {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &v0), 0);
        assert!(!arg0.paused, 2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_deposits, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, v0)
        } else {
            0
        };
        let v3 = v2 + v1;
        assert!(v3 <= 100000000, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + v1;
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v0) = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_deposits, v0, v1);
        };
        let v4 = Ticket{
            id           : 0x2::object::new(arg3),
            owner        : v0,
            amount       : v1,
            deposit_time : 0x2::clock::timestamp_ms(arg2),
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
        };
        let v5 = DepositEvent{
            user       : v0,
            amount     : v1,
            ticket_id  : 0x2::object::uid_to_address(&v4.id),
            total_pool : arg0.total_deposited,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositEvent>(v5);
        v4
    }

    public fun get_pool_stats<T0>(arg0: &LotteryPool<T0>) : (u64, u64, u64, bool) {
        (arg0.total_deposited, 0x2::balance::value<T0>(&arg0.balance), 0x2::vec_set::size<address>(&arg0.whitelist), arg0.paused)
    }

    public fun get_suilend_obligation<T0>(arg0: &LotteryPool<T0>, arg1: address) : vector<u8> {
        if (0x2::table::contains<address, vector<u8>>(&arg0.suilend_obligations, arg1)) {
            *0x2::table::borrow<address, vector<u8>>(&arg0.suilend_obligations, arg1)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_ticket_info(arg0: &Ticket) : (address, u64, u64) {
        (arg0.owner, arg0.amount, arg0.deposit_time)
    }

    public fun get_user_deposit<T0>(arg0: &LotteryPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted<T0>(arg0: &LotteryPool<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun pause<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: &0x2::clock::Clock) {
        arg1.paused = true;
        let v0 = PauseEvent{
            paused    : true,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun remove_from_whitelist<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: address, arg3: &0x2::clock::Clock) {
        0x2::vec_set::remove<address>(&mut arg1.whitelist, &arg2);
        let v0 = WhitelistEvent{
            address   : arg2,
            added     : false,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WhitelistEvent>(v0);
    }

    public fun set_suilend_obligation<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: address, arg3: vector<u8>) {
        if (0x2::table::contains<address, vector<u8>>(&arg1.suilend_obligations, arg2)) {
            0x2::table::remove<address, vector<u8>>(&mut arg1.suilend_obligations, arg2);
        };
        0x2::table::add<address, vector<u8>>(&mut arg1.suilend_obligations, arg2, arg3);
    }

    public fun unpause<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: &0x2::clock::Clock) {
        arg1.paused = false;
        let v0 = PauseEvent{
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &mut LotteryPool<T0>, arg1: Ticket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Ticket {
            id           : v0,
            owner        : v1,
            amount       : v2,
            deposit_time : _,
            pool_id      : v4,
        } = arg1;
        let v5 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg3), 4);
        assert!(v4 == 0x2::object::uid_to_address(&arg0.id), 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v2, 5);
        arg0.total_deposited = arg0.total_deposited - v2;
        let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v1);
        *v6 = *v6 - v2;
        if (*v6 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.user_deposits, v1);
        };
        let v7 = WithdrawEvent{
            user       : v1,
            amount     : v2,
            ticket_id  : 0x2::object::uid_to_address(&v5),
            total_pool : arg0.total_deposited,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v7);
        0x2::object::delete(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg3)
    }

    // decompiled from Move bytecode v6
}

