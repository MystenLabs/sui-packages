module 0x5e1864d020a9e437d10c4e3013f903b476ee0015eb31eaec7e14fa2789cdf812::private_bank {
    struct PRIVATE_BANK has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        available: 0x2::balance::Balance<0x2::sui::SUI>,
        issued_commitments: 0x2::table::Table<vector<u8>, bool>,
        paused: bool,
        outstanding_balance: u64,
        total_deposited: u64,
        total_admin_withdrawn: u64,
        total_issued: u64,
        total_claimed: u64,
        total_cancelled: u64,
        orders_issued: u64,
        orders_claimed: u64,
        orders_cancelled: u64,
    }

    struct PrivatePaymentOrder has key {
        id: 0x2::object::UID,
        bank_id: 0x2::object::ID,
        commitment: vector<u8>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Deposited has copy, drop {
        bank_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        available_balance: u64,
    }

    struct PrivatePaymentOrderCreated has copy, drop {
        bank_id: 0x2::object::ID,
        order_id: 0x2::object::ID,
        issuer: address,
        amount: u64,
    }

    struct PrivatePaymentOrderClaimed has copy, drop {
        bank_id: 0x2::object::ID,
        order_id: 0x2::object::ID,
        claimant: address,
        amount: u64,
    }

    struct PrivatePaymentOrderCancelled has copy, drop {
        bank_id: 0x2::object::ID,
        order_id: 0x2::object::ID,
        admin: address,
        amount: u64,
    }

    struct AdminWithdrawal has copy, drop {
        bank_id: 0x2::object::ID,
        admin: address,
        amount: u64,
        available_balance: u64,
    }

    struct PauseChanged has copy, drop {
        bank_id: 0x2::object::ID,
        admin: address,
        paused: bool,
    }

    fun assert_accounting(arg0: &Bank) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.available) + arg0.outstanding_balance == arg0.total_deposited - arg0.total_admin_withdrawn - arg0.total_claimed, 8);
        assert!(arg0.orders_claimed + arg0.orders_cancelled <= arg0.orders_issued, 8);
    }

    fun assert_not_paused(arg0: &Bank) {
        assert!(!arg0.paused, 7);
    }

    public fun available_balance(arg0: &Bank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.available)
    }

    public fun bank_id(arg0: &Bank) : 0x2::object::ID {
        0x2::object::id<Bank>(arg0)
    }

    public fun cancel_private_payment_order(arg0: &AdminCap, arg1: &mut Bank, arg2: PrivatePaymentOrder, arg3: &mut 0x2::tx_context::TxContext) {
        let PrivatePaymentOrder {
            id         : v0,
            bank_id    : v1,
            commitment : _,
            funds      : v3,
        } = arg2;
        let v4 = v3;
        let v5 = v0;
        assert!(v1 == 0x2::object::id<Bank>(arg1), 6);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        assert!(v6 <= arg1.outstanding_balance, 8);
        arg1.outstanding_balance = arg1.outstanding_balance - v6;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.available, v4);
        arg1.total_cancelled = arg1.total_cancelled + v6;
        arg1.orders_cancelled = arg1.orders_cancelled + 1;
        0x2::object::delete(v5);
        assert_accounting(arg1);
        let v7 = PrivatePaymentOrderCancelled{
            bank_id  : v1,
            order_id : 0x2::object::uid_to_inner(&v5),
            admin    : 0x2::tx_context::sender(arg3),
            amount   : v6,
        };
        0x2::event::emit<PrivatePaymentOrderCancelled>(v7);
    }

    public fun claim_private_payment_order(arg0: &mut Bank, arg1: PrivatePaymentOrder, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_private_payment_order(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_private_payment_order(arg0: &AdminCap, arg1: &mut Bank, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_not_paused(arg1);
        assert!(arg3 > 0, 0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.issued_commitments, arg2), 4);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.available), 1);
        0x2::table::add<vector<u8>, bool>(&mut arg1.issued_commitments, arg2, true);
        let v0 = PrivatePaymentOrder{
            id         : 0x2::object::new(arg4),
            bank_id    : 0x2::object::id<Bank>(arg1),
            commitment : arg2,
            funds      : 0x2::balance::split<0x2::sui::SUI>(&mut arg1.available, arg3),
        };
        let v1 = 0x2::object::id<PrivatePaymentOrder>(&v0);
        arg1.outstanding_balance = arg1.outstanding_balance + arg3;
        arg1.total_issued = arg1.total_issued + arg3;
        arg1.orders_issued = arg1.orders_issued + 1;
        assert_accounting(arg1);
        let v2 = PrivatePaymentOrderCreated{
            bank_id  : 0x2::object::id<Bank>(arg1),
            order_id : v1,
            issuer   : 0x2::tx_context::sender(arg4),
            amount   : arg3,
        };
        0x2::event::emit<PrivatePaymentOrderCreated>(v2);
        0x2::transfer::share_object<PrivatePaymentOrder>(v0);
        v1
    }

    public fun deposit(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        assert_accounting(arg0);
        let v1 = Deposited{
            bank_id           : 0x2::object::id<Bank>(arg0),
            depositor         : 0x2::tx_context::sender(arg2),
            amount            : v0,
            available_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.available),
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun init(arg0: PRIVATE_BANK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Bank>(new_bank(arg1));
    }

    public fun is_paused(arg0: &Bank) : bool {
        arg0.paused
    }

    fun new_bank(arg0: &mut 0x2::tx_context::TxContext) : Bank {
        Bank{
            id                    : 0x2::object::new(arg0),
            available             : 0x2::balance::zero<0x2::sui::SUI>(),
            issued_commitments    : 0x2::table::new<vector<u8>, bool>(arg0),
            paused                : false,
            outstanding_balance   : 0,
            total_deposited       : 0,
            total_admin_withdrawn : 0,
            total_issued          : 0,
            total_claimed         : 0,
            total_cancelled       : 0,
            orders_issued         : 0,
            orders_claimed        : 0,
            orders_cancelled      : 0,
        }
    }

    public fun order_amount(arg0: &PrivatePaymentOrder) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun order_bank_id(arg0: &PrivatePaymentOrder) : 0x2::object::ID {
        arg0.bank_id
    }

    public fun order_commitment(arg0: &PrivatePaymentOrder) : &vector<u8> {
        &arg0.commitment
    }

    public fun order_id(arg0: &PrivatePaymentOrder) : 0x2::object::ID {
        0x2::object::id<PrivatePaymentOrder>(arg0)
    }

    public fun orders_cancelled(arg0: &Bank) : u64 {
        arg0.orders_cancelled
    }

    public fun orders_claimed(arg0: &Bank) : u64 {
        arg0.orders_claimed
    }

    public fun orders_issued(arg0: &Bank) : u64 {
        arg0.orders_issued
    }

    public fun outstanding_balance(arg0: &Bank) : u64 {
        arg0.outstanding_balance
    }

    public fun payment_commitment(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        let v0 = b"ALIEN_PRIVATE_PAYMENT_BANK_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x2::hash::blake2b256(&v0)
    }

    public fun redeem_private_payment_order(arg0: &mut Bank, arg1: PrivatePaymentOrder, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_not_paused(arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        let PrivatePaymentOrder {
            id         : v0,
            bank_id    : v1,
            commitment : v2,
            funds      : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v0;
        assert!(v1 == 0x2::object::id<Bank>(arg0), 6);
        let v6 = 0x2::tx_context::sender(arg3);
        assert!(payment_commitment(v1, v6, arg2) == v2, 5);
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        assert!(v7 <= arg0.outstanding_balance, 8);
        arg0.outstanding_balance = arg0.outstanding_balance - v7;
        arg0.total_claimed = arg0.total_claimed + v7;
        arg0.orders_claimed = arg0.orders_claimed + 1;
        0x2::object::delete(v5);
        assert_accounting(arg0);
        let v8 = PrivatePaymentOrderClaimed{
            bank_id  : v1,
            order_id : 0x2::object::uid_to_inner(&v5),
            claimant : v6,
            amount   : v7,
        };
        0x2::event::emit<PrivatePaymentOrderClaimed>(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg3)
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Bank, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = PauseChanged{
            bank_id : 0x2::object::id<Bank>(arg1),
            admin   : 0x2::tx_context::sender(arg3),
            paused  : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun total_admin_withdrawn(arg0: &Bank) : u64 {
        arg0.total_admin_withdrawn
    }

    public fun total_assets(arg0: &Bank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.available) + arg0.outstanding_balance
    }

    public fun total_cancelled(arg0: &Bank) : u64 {
        arg0.total_cancelled
    }

    public fun total_claimed(arg0: &Bank) : u64 {
        arg0.total_claimed
    }

    public fun total_deposited(arg0: &Bank) : u64 {
        arg0.total_deposited
    }

    public fun total_issued(arg0: &Bank) : u64 {
        arg0.total_issued
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw_available(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_not_paused(arg1);
        assert!(arg2 > 0, 0);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.available), 1);
        arg1.total_admin_withdrawn = arg1.total_admin_withdrawn + arg2;
        assert_accounting(arg1);
        let v0 = AdminWithdrawal{
            bank_id           : 0x2::object::id<Bank>(arg1),
            admin             : 0x2::tx_context::sender(arg3),
            amount            : arg2,
            available_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.available),
        };
        0x2::event::emit<AdminWithdrawal>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.available, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

