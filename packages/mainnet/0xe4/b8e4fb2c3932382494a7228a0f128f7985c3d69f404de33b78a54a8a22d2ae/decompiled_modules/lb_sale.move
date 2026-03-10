module 0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale {
    struct LBSALE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SaleConfig<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admins: vector<address>,
        price: u64,
        payment_receiver: address,
        lb_balance: 0x2::balance::Balance<T1>,
        is_paused: bool,
        total_sold: u64,
        total_revenue: u64,
        user_records: 0x2::table::Table<address, UserRecords>,
    }

    struct UserRecords has store {
        records: vector<PurchaseRecord>,
        total_usdc_spent: u64,
        total_lb_received: u64,
        purchase_count: u64,
    }

    struct PurchaseRecord has copy, drop, store {
        usdc_amount: u64,
        lb_amount: u64,
        price_at_purchase: u64,
        timestamp: u64,
    }

    struct SaleConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        creator: address,
        initial_price: u64,
        payment_receiver: address,
    }

    struct TokenPurchased has copy, drop {
        buyer: address,
        usdc_amount: u64,
        lb_amount: u64,
        price: u64,
        timestamp: u64,
        total_purchases: u64,
    }

    struct PriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct AdminAdded has copy, drop {
        new_admin: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        removed_admin: address,
        removed_by: address,
    }

    struct PaymentReceiverUpdated has copy, drop {
        old_receiver: address,
        new_receiver: address,
        updated_by: address,
    }

    struct LBDeposited has copy, drop {
        amount: u64,
        deposited_by: address,
        total_balance: u64,
    }

    struct LBWithdrawn has copy, drop {
        amount: u64,
        withdrawn_by: address,
        recipient: address,
        remaining_balance: u64,
    }

    struct SalePaused has copy, drop {
        paused: bool,
        updated_by: address,
    }

    public entry fun add_admin<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1>(arg0, v0);
        assert!(!is_admin<T0, T1>(arg0, arg2), 5);
        assert!(0x1::vector::length<address>(&arg0.admins) < 10, 9);
        0x1::vector::push_back<address>(&mut arg0.admins, arg2);
        let v1 = AdminAdded{
            new_admin : arg2,
            added_by  : v0,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    fun add_record(arg0: &mut UserRecords, arg1: PurchaseRecord) {
        if (0x1::vector::length<PurchaseRecord>(&arg0.records) >= 10) {
            0x1::vector::remove<PurchaseRecord>(&mut arg0.records, 0);
        };
        0x1::vector::push_back<PurchaseRecord>(&mut arg0.records, arg1);
    }

    fun assert_admin<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) {
        assert!(is_admin<T0, T1>(arg0, arg1), 1);
    }

    public entry fun buy_exact_lb<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<T1>(&arg0.lb_balance) >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = calculate_usdc_for_lb(arg2, arg0.price);
        assert!(0x2::coin::value<T0>(arg1) >= v1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v1, arg3), arg0.payment_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.lb_balance, arg2), arg3), v0);
        arg0.total_sold = arg0.total_sold + arg2;
        arg0.total_revenue = arg0.total_revenue + v1;
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v3 = PurchaseRecord{
            usdc_amount       : v1,
            lb_amount         : arg2,
            price_at_purchase : arg0.price,
            timestamp         : v2,
        };
        let v4 = if (0x2::table::contains<address, UserRecords>(&arg0.user_records, v0)) {
            let v5 = 0x2::table::borrow_mut<address, UserRecords>(&mut arg0.user_records, v0);
            add_record(v5, v3);
            v5.total_usdc_spent = v5.total_usdc_spent + v1;
            v5.total_lb_received = v5.total_lb_received + arg2;
            v5.purchase_count = v5.purchase_count + 1;
            v5.purchase_count
        } else {
            let v6 = 0x1::vector::empty<PurchaseRecord>();
            0x1::vector::push_back<PurchaseRecord>(&mut v6, v3);
            let v7 = UserRecords{
                records           : v6,
                total_usdc_spent  : v1,
                total_lb_received : arg2,
                purchase_count    : 1,
            };
            0x2::table::add<address, UserRecords>(&mut arg0.user_records, v0, v7);
            1
        };
        let v8 = TokenPurchased{
            buyer           : v0,
            usdc_amount     : v1,
            lb_amount       : arg2,
            price           : arg0.price,
            timestamp       : v2,
            total_purchases : v4,
        };
        0x2::event::emit<TokenPurchased>(v8);
    }

    public entry fun buy_lb<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 3);
        let v2 = calculate_lb_amount(v1, arg0.price);
        assert!(v2 > 0, 3);
        assert!(0x2::balance::value<T1>(&arg0.lb_balance) >= v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.payment_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.lb_balance, v2), arg2), v0);
        arg0.total_sold = arg0.total_sold + v2;
        arg0.total_revenue = arg0.total_revenue + v1;
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v4 = PurchaseRecord{
            usdc_amount       : v1,
            lb_amount         : v2,
            price_at_purchase : arg0.price,
            timestamp         : v3,
        };
        let v5 = if (0x2::table::contains<address, UserRecords>(&arg0.user_records, v0)) {
            let v6 = 0x2::table::borrow_mut<address, UserRecords>(&mut arg0.user_records, v0);
            add_record(v6, v4);
            v6.total_usdc_spent = v6.total_usdc_spent + v1;
            v6.total_lb_received = v6.total_lb_received + v2;
            v6.purchase_count = v6.purchase_count + 1;
            v6.purchase_count
        } else {
            let v7 = 0x1::vector::empty<PurchaseRecord>();
            0x1::vector::push_back<PurchaseRecord>(&mut v7, v4);
            let v8 = UserRecords{
                records           : v7,
                total_usdc_spent  : v1,
                total_lb_received : v2,
                purchase_count    : 1,
            };
            0x2::table::add<address, UserRecords>(&mut arg0.user_records, v0, v8);
            1
        };
        let v9 = TokenPurchased{
            buyer           : v0,
            usdc_amount     : v1,
            lb_amount       : v2,
            price           : arg0.price,
            timestamp       : v3,
            total_purchases : v5,
        };
        0x2::event::emit<TokenPurchased>(v9);
    }

    fun calculate_lb_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000 as u128) * (1000000 as u128) / (arg1 as u128)) as u64)
    }

    fun calculate_usdc_for_lb(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (1000 as u128) * (1000000 as u128);
        if (v0 % v1 > 0) {
            ((v0 / v1 + 1) as u64)
        } else {
            ((v0 / v1) as u64)
        }
    }

    public fun check_is_admin<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : bool {
        is_admin<T0, T1>(arg0, arg1)
    }

    public entry fun create_sale_config<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = SaleConfig<T0, T1>{
            id               : 0x2::object::new(arg3),
            admins           : v1,
            price            : arg1,
            payment_receiver : arg2,
            lb_balance       : 0x2::balance::zero<T1>(),
            is_paused        : false,
            total_sold       : 0,
            total_revenue    : 0,
            user_records     : 0x2::table::new<address, UserRecords>(arg3),
        };
        let v3 = SaleConfigCreated{
            config_id        : 0x2::object::id<SaleConfig<T0, T1>>(&v2),
            creator          : v0,
            initial_price    : arg1,
            payment_receiver : arg2,
        };
        0x2::event::emit<SaleConfigCreated>(v3);
        0x2::transfer::share_object<SaleConfig<T0, T1>>(v2);
    }

    public entry fun deposit_lb<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.lb_balance, 0x2::coin::into_balance<T1>(arg1));
        let v0 = LBDeposited{
            amount        : 0x2::coin::value<T1>(&arg1),
            deposited_by  : 0x2::tx_context::sender(arg2),
            total_balance : 0x2::balance::value<T1>(&arg0.lb_balance),
        };
        0x2::event::emit<LBDeposited>(v0);
    }

    public fun estimate_lb_output<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: u64) : u64 {
        calculate_lb_amount(arg1, arg0.price)
    }

    public fun estimate_usdc_needed<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: u64) : u64 {
        calculate_usdc_for_lb(arg1, arg0.price)
    }

    fun find_admin_index<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_admins<T0, T1>(arg0: &SaleConfig<T0, T1>) : &vector<address> {
        &arg0.admins
    }

    public fun get_lb_balance<T0, T1>(arg0: &SaleConfig<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.lb_balance)
    }

    public fun get_payment_receiver<T0, T1>(arg0: &SaleConfig<T0, T1>) : address {
        arg0.payment_receiver
    }

    public fun get_price<T0, T1>(arg0: &SaleConfig<T0, T1>) : u64 {
        arg0.price
    }

    public fun get_sale_info<T0, T1>(arg0: &SaleConfig<T0, T1>) : (u64, u64, address, bool, u64, u64) {
        (arg0.price, 0x2::balance::value<T1>(&arg0.lb_balance), arg0.payment_receiver, arg0.is_paused, arg0.total_sold, arg0.total_revenue)
    }

    public fun get_total_revenue<T0, T1>(arg0: &SaleConfig<T0, T1>) : u64 {
        arg0.total_revenue
    }

    public fun get_total_sold<T0, T1>(arg0: &SaleConfig<T0, T1>) : u64 {
        arg0.total_sold
    }

    public fun get_user_purchase_count<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserRecords>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserRecords>(&arg0.user_records, arg1).purchase_count
        } else {
            0
        }
    }

    public fun get_user_records<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : &vector<PurchaseRecord> {
        &0x2::table::borrow<address, UserRecords>(&arg0.user_records, arg1).records
    }

    public fun get_user_stats<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : (u64, u64, u64, u64) {
        if (0x2::table::contains<address, UserRecords>(&arg0.user_records, arg1)) {
            let v4 = 0x2::table::borrow<address, UserRecords>(&arg0.user_records, arg1);
            (v4.total_usdc_spent, v4.total_lb_received, v4.purchase_count, 0x1::vector::length<PurchaseRecord>(&v4.records))
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun get_user_total_lb_received<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserRecords>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserRecords>(&arg0.user_records, arg1).total_lb_received
        } else {
            0
        }
    }

    public fun get_user_total_usdc_spent<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserRecords>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserRecords>(&arg0.user_records, arg1).total_usdc_spent
        } else {
            0
        }
    }

    public fun has_user_records<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, UserRecords>(&arg0.user_records, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_admin<T0, T1>(arg0: &SaleConfig<T0, T1>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_paused<T0, T1>(arg0: &SaleConfig<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun record_lb_amount(arg0: &PurchaseRecord) : u64 {
        arg0.lb_amount
    }

    public fun record_price(arg0: &PurchaseRecord) : u64 {
        arg0.price_at_purchase
    }

    public fun record_timestamp(arg0: &PurchaseRecord) : u64 {
        arg0.timestamp
    }

    public fun record_usdc_amount(arg0: &PurchaseRecord) : u64 {
        arg0.usdc_amount
    }

    public entry fun remove_admin<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1>(arg0, v0);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 7);
        let (v1, v2) = find_admin_index<T0, T1>(arg0, arg2);
        assert!(v1, 6);
        0x1::vector::remove<address>(&mut arg0.admins, v2);
        let v3 = AdminRemoved{
            removed_admin : arg2,
            removed_by    : v0,
        };
        0x2::event::emit<AdminRemoved>(v3);
    }

    public entry fun set_paused<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1>(arg0, v0);
        arg0.is_paused = arg2;
        let v1 = SalePaused{
            paused     : arg2,
            updated_by : v0,
        };
        0x2::event::emit<SalePaused>(v1);
    }

    public entry fun update_payment_receiver<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1>(arg0, v0);
        arg0.payment_receiver = arg2;
        let v1 = PaymentReceiverUpdated{
            old_receiver : arg0.payment_receiver,
            new_receiver : arg2,
            updated_by   : v0,
        };
        0x2::event::emit<PaymentReceiverUpdated>(v1);
    }

    public entry fun update_price<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1>(arg0, v0);
        assert!(arg2 > 0, 4);
        arg0.price = arg2;
        let v1 = PriceUpdated{
            old_price  : arg0.price,
            new_price  : arg2,
            updated_by : v0,
        };
        0x2::event::emit<PriceUpdated>(v1);
    }

    public entry fun withdraw_all_lb<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1>(arg0, v0);
        let v1 = 0x2::balance::value<T1>(&arg0.lb_balance);
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.lb_balance), arg3), arg2);
        let v2 = LBWithdrawn{
            amount            : v1,
            withdrawn_by      : v0,
            recipient         : arg2,
            remaining_balance : 0,
        };
        0x2::event::emit<LBWithdrawn>(v2);
    }

    public entry fun withdraw_lb<T0, T1>(arg0: &mut SaleConfig<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_admin<T0, T1>(arg0, v0);
        assert!(0x2::balance::value<T1>(&arg0.lb_balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.lb_balance, arg2), arg4), arg3);
        let v1 = LBWithdrawn{
            amount            : arg2,
            withdrawn_by      : v0,
            recipient         : arg3,
            remaining_balance : 0x2::balance::value<T1>(&arg0.lb_balance),
        };
        0x2::event::emit<LBWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

