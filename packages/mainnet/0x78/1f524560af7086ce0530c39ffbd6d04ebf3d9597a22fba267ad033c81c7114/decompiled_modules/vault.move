module 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, Account>,
    }

    struct Account has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        on: bool,
        strategy: u8,
        per_round: u64,
        rounds_left: u64,
        keep: u64,
        target: u64,
        last_ms: u64,
        deposited: u64,
        withdrawn: u64,
        spent: u64,
        returned: u64,
        rounds: u64,
    }

    struct PullCap has store, key {
        id: 0x2::object::UID,
    }

    struct Deposited has copy, drop {
        player: address,
        amount: u64,
        balance: u64,
    }

    struct Withdrawn has copy, drop {
        player: address,
        amount: u64,
        balance: u64,
    }

    struct PlanSet has copy, drop {
        player: address,
        strategy: u8,
        per_round: u64,
        rounds: u64,
        keep: u64,
        target: u64,
    }

    struct Stopped has copy, drop {
        player: address,
        reason: u8,
    }

    struct Pulled has copy, drop {
        player: address,
        amount: u64,
        balance: u64,
        rounds_left: u64,
    }

    struct Credited has copy, drop {
        player: address,
        amount: u64,
        balance: u64,
    }

    fun account_mut(arg0: &mut Vault, arg1: address) : &mut Account {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            let v0 = Account{
                balance     : 0x2::balance::zero<0x2::sui::SUI>(),
                on          : false,
                strategy    : 0,
                per_round   : 0,
                rounds_left : 0,
                keep        : 0,
                target      : 0,
                last_ms     : 0,
                deposited   : 0,
                withdrawn   : 0,
                spent       : 0,
                returned    : 0,
                rounds      : 0,
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1, v0);
        };
        0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1)
    }

    public fun balance_of(arg0: &Vault, arg1: address) : u64 {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            return 0
        };
        0x2::balance::value<0x2::sui::SUI>(&0x2::table::borrow<address, Account>(&arg0.accounts, arg1).balance)
    }

    public fun credit(arg0: &mut Vault, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = account_mut(arg0, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.balance, arg2);
        v1.returned = v1.returned + v0;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.balance);
        let v3 = Credited{
            player  : arg1,
            amount  : v0,
            balance : v2,
        };
        0x2::event::emit<Credited>(v3);
        let v4 = if (v1.on) {
            if (v1.target > 0) {
                v2 >= v1.target
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            v1.on = false;
            let v5 = Stopped{
                player : arg1,
                reason : 2,
            };
            0x2::event::emit<Stopped>(v5);
        };
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = account_mut(arg0, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        v2.deposited = v2.deposited + v0;
        let v3 = Deposited{
            player  : v1,
            amount  : v0,
            balance : 0x2::balance::value<0x2::sui::SUI>(&v2.balance),
        };
        0x2::event::emit<Deposited>(v3);
    }

    public fun has_account(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, Account>(&arg0.accounts, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            accounts : 0x2::table::new<address, Account>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = PullCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PullCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_on(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, Account>(&arg0.accounts, arg1) && 0x2::table::borrow<address, Account>(&arg0.accounts, arg1).on
    }

    public fun min_gap_ms() : u64 {
        20000
    }

    public fun plan_of(arg0: &Vault, arg1: address) : (bool, u8, u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            return (false, 0, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        (v0.on, v0.strategy, v0.per_round, v0.rounds_left, v0.keep, v0.target, v0.last_ms)
    }

    public fun pull(arg0: &mut Vault, arg1: &PullCap, arg2: address, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(ready(arg0, arg2, arg3), 4);
        let v0 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg2);
        let v1 = v0.per_round;
        v0.rounds_left = v0.rounds_left - 1;
        v0.last_ms = 0x2::clock::timestamp_ms(arg3);
        v0.spent = v0.spent + v1;
        v0.rounds = v0.rounds + 1;
        let v2 = Pulled{
            player      : arg2,
            amount      : v1,
            balance     : 0x2::balance::value<0x2::sui::SUI>(&v0.balance),
            rounds_left : v0.rounds_left,
        };
        0x2::event::emit<Pulled>(v2);
        if (v0.rounds_left == 0) {
            v0.on = false;
            let v3 = Stopped{
                player : arg2,
                reason : 1,
            };
            0x2::event::emit<Stopped>(v3);
        };
        0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v1)
    }

    public fun ready(arg0: &Vault, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.balance);
        if (v0.on) {
            if (v0.rounds_left > 0) {
                if (v0.per_round > 0) {
                    if (v1 >= v0.per_round) {
                        if (v1 - v0.per_round >= v0.keep) {
                            if (v0.target == 0 || v1 < v0.target) {
                                0x2::clock::timestamp_ms(arg2) >= v0.last_ms + 20000
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun start(arg0: &mut Vault, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg3 > 0, 3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = account_mut(arg0, v0);
        v1.on = true;
        v1.strategy = arg1;
        v1.per_round = arg2;
        v1.rounds_left = arg3;
        v1.keep = arg4;
        v1.target = arg5;
        let v2 = PlanSet{
            player    : v0,
            strategy  : arg1,
            per_round : arg2,
            rounds    : arg3,
            keep      : arg4,
            target    : arg5,
        };
        0x2::event::emit<PlanSet>(v2);
    }

    public fun stop(arg0: &mut Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        if (v1.on) {
            v1.on = false;
            let v2 = Stopped{
                player : v0,
                reason : 0,
            };
            0x2::event::emit<Stopped>(v2);
        };
    }

    public fun totals_of(arg0: &Vault, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            return (0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        (v0.deposited, v0.withdrawn, v0.spent, v0.returned, v0.rounds)
    }

    public fun withdraw(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        assert!(arg1 > 0, 5);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&v1.balance), 2);
        v1.withdrawn = v1.withdrawn + arg1;
        let v2 = Withdrawn{
            player  : v0,
            amount  : arg1,
            balance : 0x2::balance::value<0x2::sui::SUI>(&v1.balance),
        };
        0x2::event::emit<Withdrawn>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, arg1), arg2)
    }

    public fun withdraw_all(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&0x2::table::borrow<address, Account>(&arg0.accounts, v0).balance);
        withdraw(arg0, v1, arg1)
    }

    // decompiled from Move bytecode v7
}

