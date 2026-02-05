module 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        deposits: 0x2::table::Table<0x2::object::ID, Deposit>,
        total_balance: u64,
    }

    struct Deposit has store {
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        order_id: 0x2::object::ID,
    }

    struct ExecutorCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        reason: u8,
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Deposit{
            owner    : v1,
            balance  : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            order_id : arg1,
        };
        0x2::table::add<0x2::object::ID, Deposit>(&mut arg0.deposits, arg1, v2);
        arg0.total_balance = arg0.total_balance + v0;
        let v3 = DepositEvent{
            order_id : arg1,
            owner    : v1,
            amount   : v0,
        };
        0x2::event::emit<DepositEvent>(v3);
        v0
    }

    public fun get_deposit_amount(arg0: &Vault, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, Deposit>(&arg0.deposits, arg1)) {
            0x2::balance::value<0x2::sui::SUI>(&0x2::table::borrow<0x2::object::ID, Deposit>(&arg0.deposits, arg1).balance)
        } else {
            0
        }
    }

    public fun get_deposit_owner(arg0: &Vault, arg1: 0x2::object::ID) : address {
        0x2::table::borrow<0x2::object::ID, Deposit>(&arg0.deposits, arg1).owner
    }

    public fun has_deposit(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Deposit>(&arg0.deposits, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            deposits      : 0x2::table::new<0x2::object::ID, Deposit>(arg0),
            total_balance : 0,
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = ExecutorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ExecutorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun total_balance(arg0: &Vault) : u64 {
        arg0.total_balance
    }

    public fun withdraw_for_execution(arg0: &mut Vault, arg1: &ExecutorCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, address) {
        assert!(0x2::table::contains<0x2::object::ID, Deposit>(&arg0.deposits, arg2), 1);
        let Deposit {
            owner    : v0,
            balance  : v1,
            order_id : _,
        } = 0x2::table::remove<0x2::object::ID, Deposit>(&mut arg0.deposits, arg2);
        let v3 = v1;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        arg0.total_balance = arg0.total_balance - v4;
        let v5 = WithdrawEvent{
            order_id : arg2,
            owner    : v0,
            amount   : v4,
            reason   : 1,
        };
        0x2::event::emit<WithdrawEvent>(v5);
        (0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3), v0)
    }

    public fun withdraw_to_owner(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<0x2::object::ID, Deposit>(&arg0.deposits, arg1), 1);
        assert!(0x2::table::borrow<0x2::object::ID, Deposit>(&arg0.deposits, arg1).owner == 0x2::tx_context::sender(arg2), 0);
        let Deposit {
            owner    : v0,
            balance  : v1,
            order_id : _,
        } = 0x2::table::remove<0x2::object::ID, Deposit>(&mut arg0.deposits, arg1);
        let v3 = v1;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        arg0.total_balance = arg0.total_balance - v4;
        let v5 = WithdrawEvent{
            order_id : arg1,
            owner    : v0,
            amount   : v4,
            reason   : 0,
        };
        0x2::event::emit<WithdrawEvent>(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg2)
    }

    // decompiled from Move bytecode v6
}

