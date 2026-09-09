module 0x54f7d3baa905daf3beb516a733c20a20df1897cde490231c3604f452b813e5d3::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        liquidity: 0x2::balance::Balance<T0>,
        executors: 0x2::vec_set::VecSet<address>,
        paused: bool,
        maximum_loss_bps: u64,
    }

    struct DepositReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct FlashLoanReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct ExecutorAuthorizationChanged has copy, drop {
        pool_id: 0x2::object::ID,
        executor: address,
        authorized: bool,
    }

    struct PauseChanged has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    struct WithdrawalEvent has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        pool_id: 0x2::object::ID,
        executor: address,
        amount: u64,
        available_after: u64,
    }

    struct RepayEvent has copy, drop {
        pool_id: 0x2::object::ID,
        executor: address,
        amount: u64,
        available_after: u64,
    }

    public fun borrow<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        check_version<T0>(arg0);
        assert!(!arg0.paused, 13835903468055363594);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.executors, &v0), 13835622001668456456);
        assert!(arg1 > 0, 13835059056009740292);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.liquidity), 13836466435188916238);
        let v1 = BorrowEvent{
            pool_id         : 0x2::object::id<Pool<T0>>(arg0),
            executor        : v0,
            amount          : arg1,
            available_after : 0x2::balance::value<T0>(&arg0.liquidity),
        };
        0x2::event::emit<BorrowEvent>(v1);
        let v2 = FlashLoanReceipt<T0>{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            amount  : arg1,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.liquidity, arg1), arg2), v2)
    }

    public fun authorize_executor<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address) {
        check_version<T0>(arg1);
        assert!(!0x2::vec_set::contains<address>(&arg1.executors, &arg2), 13837028947055935506);
        0x2::vec_set::insert<address>(&mut arg1.executors, arg2);
        let v0 = ExecutorAuthorizationChanged{
            pool_id    : 0x2::object::id<Pool<T0>>(arg1),
            executor   : arg2,
            authorized : true,
        };
        0x2::event::emit<ExecutorAuthorizationChanged>(v0);
    }

    public fun available<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity)
    }

    fun check_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 13836185252269850636);
    }

    entry fun create_and_share_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool<T0>>(new_pool<T0>(arg0, arg1));
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : DepositReceipt<T0> {
        check_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13835058785426800644);
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositReceipt<T0>{
            id      : 0x2::object::new(arg2),
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            amount  : v0,
        };
        let v2 = DepositEvent{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            depositor : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<DepositEvent>(v2);
        v1
    }

    public fun deposit_amount<T0>(arg0: &DepositReceipt<T0>) : u64 {
        arg0.amount
    }

    entry fun deposit_and_transfer<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<DepositReceipt<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_executor<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.executors, &arg1)
    }

    public fun is_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.paused
    }

    public fun merge_deposit_receipts<T0>(arg0: &mut DepositReceipt<T0>, arg1: DepositReceipt<T0>) {
        let DepositReceipt {
            id      : v0,
            pool_id : v1,
            amount  : v2,
        } = arg1;
        assert!(arg0.pool_id == v1, 13835340436497301510);
        0x2::object::delete(v0);
        arg0.amount = arg0.amount + v2;
    }

    public fun new_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        let v0 = Pool<T0>{
            id               : 0x2::object::new(arg1),
            version          : 1,
            liquidity        : 0x2::balance::zero<T0>(),
            executors        : 0x2::vec_set::empty<address>(),
            paused           : false,
            maximum_loss_bps : 30,
        };
        let v1 = PoolCreated{pool_id: 0x2::object::id<Pool<T0>>(&v0)};
        0x2::event::emit<PoolCreated>(v1);
        v0
    }

    public fun repay<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0>(arg0);
        let FlashLoanReceipt {
            pool_id : v0,
            amount  : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<Pool<T0>>(arg0), 13835340668425535494);
        if (0x2::coin::value<T0>(&arg1) < v1) {
            assert!(((v1 - 0x2::coin::value<T0>(&arg1)) as u128) * 10000 <= (0x2::coin::value<T0>(&arg1) as u128) * (arg0.maximum_loss_bps as u128), 13836748077669482512);
        };
        let v2 = RepayEvent{
            pool_id         : v0,
            executor        : 0x2::tx_context::sender(arg3),
            amount          : v1,
            available_after : 0x2::balance::value<T0>(&arg0.liquidity),
        };
        0x2::event::emit<RepayEvent>(v2);
        arg1
    }

    public fun repay_flashloan<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0>(arg0);
        let FlashLoanReceipt {
            pool_id : v0,
            amount  : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<Pool<T0>>(arg0), 13835340599706058758);
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 13836747978885234704);
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg3)));
        let v2 = RepayEvent{
            pool_id         : v0,
            executor        : 0x2::tx_context::sender(arg3),
            amount          : v1,
            available_after : 0x2::balance::value<T0>(&arg0.liquidity),
        };
        0x2::event::emit<RepayEvent>(v2);
        arg1
    }

    public fun revoke_executor<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address) {
        check_version<T0>(arg1);
        assert!(0x2::vec_set::contains<address>(&arg1.executors, &arg2), 13837310473572384788);
        0x2::vec_set::remove<address>(&mut arg1.executors, &arg2);
        let v0 = ExecutorAuthorizationChanged{
            pool_id    : 0x2::object::id<Pool<T0>>(arg1),
            executor   : arg2,
            authorized : false,
        };
        0x2::event::emit<ExecutorAuthorizationChanged>(v0);
    }

    public fun set_maximum_loss_bps<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        check_version<T0>(arg1);
        arg1.maximum_loss_bps = arg2;
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: bool) {
        check_version<T0>(arg1);
        arg1.paused = arg2;
        let v0 = PauseChanged{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            paused  : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun split_deposit_receipt<T0>(arg0: &mut DepositReceipt<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DepositReceipt<T0> {
        assert!(arg1 > 0 && arg1 < arg0.amount, 13835058991585230852);
        arg0.amount = arg0.amount - arg1;
        DepositReceipt<T0>{
            id      : 0x2::object::new(arg2),
            pool_id : arg0.pool_id,
            amount  : arg1,
        }
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: DepositReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0>(arg0);
        let DepositReceipt {
            id      : v0,
            pool_id : v1,
            amount  : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Pool<T0>>(arg0), 13835340359187890182);
        0x2::object::delete(v0);
        let v3 = WithdrawalEvent{
            pool_id   : v1,
            recipient : 0x2::tx_context::sender(arg2),
            amount    : v2,
        };
        0x2::event::emit<WithdrawalEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.liquidity, v2), arg2)
    }

    entry fun withdraw_and_transfer<T0>(arg0: &mut Pool<T0>, arg1: DepositReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

