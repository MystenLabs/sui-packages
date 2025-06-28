module 0xb86527a5685e9465208975d5aaaee9ab488b855e97285d266b0208a2031dda4b::payment_splitter {
    struct PaymentSplitter has key {
        id: 0x2::object::UID,
        owner: address,
        project_owner: address,
        payment_amount: u64,
        total_payments_received: u64,
        total_investor_payouts: u64,
        total_project_owner_payouts: u64,
        user_payments: 0x2::table::Table<address, vector<PaymentInfo>>,
        paused: bool,
    }

    struct PaymentInfo has copy, drop, store {
        amount: u64,
        investor_share: u64,
        project_owner_share: u64,
        timestamp: u64,
        epoch: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentReceived has copy, drop {
        payer: address,
        investor: address,
        project_owner: address,
        amount: u64,
        investor_share: u64,
        project_owner_share: u64,
        timestamp: u64,
    }

    struct InvestorPayout has copy, drop {
        investor: address,
        amount: u64,
        timestamp: u64,
    }

    struct ProjectOwnerPayout has copy, drop {
        project_owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct ProjectOwnerUpdated has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct PaymentAmountUpdated has copy, drop {
        old_amount: u64,
        new_amount: u64,
    }

    struct ContractPaused has copy, drop {
        paused: bool,
    }

    public fun calculate_split(arg0: &PaymentSplitter) : (u64, u64) {
        let v0 = arg0.payment_amount;
        let v1 = v0 * 10 / 100;
        (v1, v0 - v1)
    }

    public fun calculate_split_for_amount(arg0: u64) : (u64, u64) {
        let v0 = arg0 * 10 / 100;
        (v0, arg0 - v0)
    }

    public fun get_owner(arg0: &PaymentSplitter) : address {
        arg0.owner
    }

    public fun get_payment_amount(arg0: &PaymentSplitter) : u64 {
        arg0.payment_amount
    }

    public fun get_payment_info(arg0: &PaymentSplitter, arg1: address, arg2: u64) : PaymentInfo {
        *0x1::vector::borrow<PaymentInfo>(0x2::table::borrow<address, vector<PaymentInfo>>(&arg0.user_payments, arg1), arg2)
    }

    public fun get_project_owner(arg0: &PaymentSplitter) : address {
        arg0.project_owner
    }

    public fun get_statistics(arg0: &PaymentSplitter) : (u64, u64, u64) {
        (arg0.total_payments_received, arg0.total_investor_payouts, arg0.total_project_owner_payouts)
    }

    public fun get_user_payment_count(arg0: &PaymentSplitter, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<PaymentInfo>>(&arg0.user_payments, arg1)) {
            0x1::vector::length<PaymentInfo>(0x2::table::borrow<address, vector<PaymentInfo>>(&arg0.user_payments, arg1))
        } else {
            0
        }
    }

    public fun get_user_payments(arg0: &PaymentSplitter, arg1: address) : vector<PaymentInfo> {
        if (0x2::table::contains<address, vector<PaymentInfo>>(&arg0.user_payments, arg1)) {
            *0x2::table::borrow<address, vector<PaymentInfo>>(&arg0.user_payments, arg1)
        } else {
            0x1::vector::empty<PaymentInfo>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PaymentSplitter{
            id                          : 0x2::object::new(arg0),
            owner                       : 0x2::tx_context::sender(arg0),
            project_owner               : 0x2::tx_context::sender(arg0),
            payment_amount              : 10000,
            total_payments_received     : 0,
            total_investor_payouts      : 0,
            total_project_owner_payouts : 0,
            user_payments               : 0x2::table::new<address, vector<PaymentInfo>>(arg0),
            paused                      : false,
        };
        0x2::transfer::share_object<PaymentSplitter>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &PaymentSplitter) : bool {
        arg0.paused
    }

    public fun payment_info_amount(arg0: &PaymentInfo) : u64 {
        arg0.amount
    }

    public fun payment_info_epoch(arg0: &PaymentInfo) : u64 {
        arg0.epoch
    }

    public fun payment_info_investor_share(arg0: &PaymentInfo) : u64 {
        arg0.investor_share
    }

    public fun payment_info_project_owner_share(arg0: &PaymentInfo) : u64 {
        arg0.project_owner_share
    }

    public fun payment_info_timestamp(arg0: &PaymentInfo) : u64 {
        arg0.timestamp
    }

    public entry fun process_payment(arg0: &mut PaymentSplitter, arg1: 0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg2 != @0x0, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&arg1) >= arg0.payment_amount, 3);
        let v1 = arg0.payment_amount;
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v1 * 10 / 100;
        let v4 = v1 - v3;
        let v5 = 0x2::coin::into_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(arg1);
        if (0x2::balance::value<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(v5, arg4), v0);
        } else {
            0x2::balance::destroy_zero<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(v5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(0x2::balance::split<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut v5, v3), arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(0x2::balance::split<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut v5, v4), arg4), arg0.project_owner);
        arg0.total_payments_received = arg0.total_payments_received + v1;
        arg0.total_investor_payouts = arg0.total_investor_payouts + v3;
        arg0.total_project_owner_payouts = arg0.total_project_owner_payouts + v4;
        let v6 = PaymentInfo{
            amount              : v1,
            investor_share      : v3,
            project_owner_share : v4,
            timestamp           : v2,
            epoch               : 0x2::tx_context::epoch(arg4),
        };
        if (0x2::table::contains<address, vector<PaymentInfo>>(&arg0.user_payments, v0)) {
            0x1::vector::push_back<PaymentInfo>(0x2::table::borrow_mut<address, vector<PaymentInfo>>(&mut arg0.user_payments, v0), v6);
        } else {
            let v7 = 0x1::vector::empty<PaymentInfo>();
            0x1::vector::push_back<PaymentInfo>(&mut v7, v6);
            0x2::table::add<address, vector<PaymentInfo>>(&mut arg0.user_payments, v0, v7);
        };
        let v8 = PaymentReceived{
            payer               : v0,
            investor            : arg2,
            project_owner       : arg0.project_owner,
            amount              : v1,
            investor_share      : v3,
            project_owner_share : v4,
            timestamp           : v2,
        };
        0x2::event::emit<PaymentReceived>(v8);
        let v9 = InvestorPayout{
            investor  : arg2,
            amount    : v3,
            timestamp : v2,
        };
        0x2::event::emit<InvestorPayout>(v9);
        let v10 = ProjectOwnerPayout{
            project_owner : arg0.project_owner,
            amount        : v4,
            timestamp     : v2,
        };
        0x2::event::emit<ProjectOwnerPayout>(v10);
    }

    public fun set_paused(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
        let v0 = ContractPaused{paused: arg2};
        0x2::event::emit<ContractPaused>(v0);
    }

    public fun update_payment_amount(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        arg0.payment_amount = arg2;
        let v0 = PaymentAmountUpdated{
            old_amount : arg0.payment_amount,
            new_amount : arg2,
        };
        0x2::event::emit<PaymentAmountUpdated>(v0);
    }

    public fun update_project_owner(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 1);
        arg0.project_owner = arg2;
        let v0 = ProjectOwnerUpdated{
            old_owner : arg0.project_owner,
            new_owner : arg2,
        };
        0x2::event::emit<ProjectOwnerUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

