module 0xead97611255de5030505526706313431a9567b46d7559b199a4fadf4e76428f3::sui_dummy_adapter {
    struct DummyPool has store, key {
        id: 0x2::object::UID,
        total_deposited: u64,
        total_borrowed: u64,
        borrowers: vector<address>,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
        time: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        amount: u64,
        time: u64,
    }

    struct BorrowEvent has copy, drop, store {
        user: address,
        amount: u64,
        time: u64,
    }

    struct RepayEvent has copy, drop, store {
        user: address,
        amount: u64,
        time: u64,
    }

    public entry fun borrow(arg0: &mut DummyPool, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg0.total_deposited, 1);
        arg0.total_borrowed = arg0.total_borrowed + arg2;
        if (!0x1::vector::contains<address>(&arg0.borrowers, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.borrowers, arg1);
        };
        let v0 = BorrowEvent{
            user   : arg1,
            amount : arg2,
            time   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public entry fun create_dummy_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DummyPool{
            id              : 0x2::object::new(arg0),
            total_deposited : 0,
            total_borrowed  : 0,
            borrowers       : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<DummyPool>(v0);
    }

    public entry fun deposit(arg0: &mut DummyPool, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg0.total_deposited = arg0.total_deposited + v0;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        let v1 = DepositEvent{
            user   : arg1,
            amount : v0,
            time   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun is_borrower(arg0: &DummyPool, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.borrowers, &arg1)
    }

    public entry fun repay(arg0: &mut DummyPool, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 <= arg0.total_borrowed, 2);
        arg0.total_borrowed = arg0.total_borrowed - v0;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        let v1 = RepayEvent{
            user   : arg1,
            amount : v0,
            time   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<RepayEvent>(v1);
    }

    public entry fun withdraw(arg0: &mut DummyPool, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg0.total_deposited, 0);
        arg0.total_deposited = arg0.total_deposited - arg2;
        let v0 = WithdrawEvent{
            user   : arg1,
            amount : arg2,
            time   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

