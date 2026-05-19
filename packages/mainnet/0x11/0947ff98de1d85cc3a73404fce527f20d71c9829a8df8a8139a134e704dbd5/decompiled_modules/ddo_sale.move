module 0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::ddo_sale {
    struct SwapConfig<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        admins: vector<address>,
        ddo_price: u64,
        lb_buy_ratio: u64,
        ddo_payment_receiver: address,
        ddo_balance: 0x2::balance::Balance<T1>,
        lb_sale_config_id: 0x2::object::ID,
        is_paused: bool,
        total_usdc_received: u64,
        total_ddo_given: u64,
        total_lb_usdc: u64,
        total_ddo_fee_usdc: u64,
        user_records: 0x2::table::Table<address, UserSwapRecords>,
    }

    struct UserSwapRecords has store {
        records: vector<SwapRecord>,
        total_usdc_spent: u64,
        total_ddo_received: u64,
        total_lb_received: u64,
        swap_count: u64,
    }

    struct SwapRecord has copy, drop, store {
        usdc_amount: u64,
        ddo_amount: u64,
        lb_amount: u64,
        lb_usdc: u64,
        ddo_fee_usdc: u64,
        ddo_price_at_swap: u64,
        lb_price_at_swap: u64,
        timestamp: u64,
    }

    struct SwapConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        creator: address,
        ddo_price: u64,
        lb_buy_ratio: u64,
        ddo_payment_receiver: address,
        lb_sale_config_id: 0x2::object::ID,
    }

    struct TokensSwapped has copy, drop {
        buyer: address,
        usdc_amount: u64,
        ddo_amount: u64,
        lb_amount: u64,
        lb_usdc: u64,
        ddo_fee_usdc: u64,
        ddo_price: u64,
        lb_price: u64,
        timestamp: u64,
        total_swaps: u64,
    }

    struct DDODeposited has copy, drop {
        amount: u64,
        deposited_by: address,
        total_balance: u64,
    }

    struct DDOWithdrawn has copy, drop {
        amount: u64,
        withdrawn_by: address,
        recipient: address,
        remaining_balance: u64,
    }

    struct DDOPriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct LBBuyRatioUpdated has copy, drop {
        old_ratio: u64,
        new_ratio: u64,
        updated_by: address,
    }

    struct DDOPaymentReceiverUpdated has copy, drop {
        old_receiver: address,
        new_receiver: address,
        updated_by: address,
    }

    struct SwapPaused has copy, drop {
        paused: bool,
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

    public entry fun add_admin<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        assert!(!is_admin<T0, T1, T2>(arg0, arg2), 5);
        assert!(0x1::vector::length<address>(&arg0.admins) < 10, 9);
        0x1::vector::push_back<address>(&mut arg0.admins, arg2);
        let v1 = AdminAdded{
            new_admin : arg2,
            added_by  : v0,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    fun add_record(arg0: &mut UserSwapRecords, arg1: SwapRecord) {
        if (0x1::vector::length<SwapRecord>(&arg0.records) >= 20) {
            0x1::vector::remove<SwapRecord>(&mut arg0.records, 0);
        };
        0x1::vector::push_back<SwapRecord>(&mut arg0.records, arg1);
    }

    public entry fun admin_update_ddo_price<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        assert!(arg2 > 0, 4);
        arg0.ddo_price = arg2;
        let v1 = DDOPriceUpdated{
            old_price  : arg0.ddo_price,
            new_price  : arg2,
            updated_by : v0,
        };
        0x2::event::emit<DDOPriceUpdated>(v1);
    }

    fun assert_admin<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: address) {
        assert!(is_admin<T0, T1, T2>(arg0, arg1), 1);
    }

    public entry fun buy<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &mut 0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::SaleConfig<T0, T2>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        assert!(0x2::object::id<0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::SaleConfig<T0, T2>>(arg1) == arg0.lb_sale_config_id, 13);
        assert!(!0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::is_paused<T0, T2>(arg1), 14);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = 0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::get_price<T0, T2>(arg1);
        assert!(v2 > 0, 4);
        let v3 = calculate_ddo_amount(v1, arg0.ddo_price);
        assert!(v3 > 0, 3);
        assert!(0x2::balance::value<T1>(&arg0.ddo_balance) >= v3, 2);
        let v4 = (((v1 as u128) * (arg0.lb_buy_ratio as u128) / (10000 as u128)) as u64);
        let v5 = v1 - v4;
        assert!(v4 > 0, 3);
        let v6 = calculate_lb_amount(v4, v2);
        0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::buy_lb<T0, T2>(arg1, 0x2::coin::split<T0>(&mut arg2, v4, arg4), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.ddo_payment_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.ddo_balance, v3), arg4), v0);
        arg0.total_usdc_received = arg0.total_usdc_received + v1;
        arg0.total_ddo_given = arg0.total_ddo_given + v3;
        arg0.total_lb_usdc = arg0.total_lb_usdc + v4;
        arg0.total_ddo_fee_usdc = arg0.total_ddo_fee_usdc + v5;
        let v7 = 0x2::clock::timestamp_ms(arg3);
        let v8 = SwapRecord{
            usdc_amount       : v1,
            ddo_amount        : v3,
            lb_amount         : v6,
            lb_usdc           : v4,
            ddo_fee_usdc      : v5,
            ddo_price_at_swap : arg0.ddo_price,
            lb_price_at_swap  : v2,
            timestamp         : v7,
        };
        let v9 = if (0x2::table::contains<address, UserSwapRecords>(&arg0.user_records, v0)) {
            let v10 = 0x2::table::borrow_mut<address, UserSwapRecords>(&mut arg0.user_records, v0);
            add_record(v10, v8);
            v10.total_usdc_spent = v10.total_usdc_spent + v1;
            v10.total_ddo_received = v10.total_ddo_received + v3;
            v10.total_lb_received = v10.total_lb_received + v6;
            v10.swap_count = v10.swap_count + 1;
            v10.swap_count
        } else {
            let v11 = 0x1::vector::empty<SwapRecord>();
            0x1::vector::push_back<SwapRecord>(&mut v11, v8);
            let v12 = UserSwapRecords{
                records            : v11,
                total_usdc_spent   : v1,
                total_ddo_received : v3,
                total_lb_received  : v6,
                swap_count         : 1,
            };
            0x2::table::add<address, UserSwapRecords>(&mut arg0.user_records, v0, v12);
            1
        };
        let v13 = TokensSwapped{
            buyer        : v0,
            usdc_amount  : v1,
            ddo_amount   : v3,
            lb_amount    : v6,
            lb_usdc      : v4,
            ddo_fee_usdc : v5,
            ddo_price    : arg0.ddo_price,
            lb_price     : v2,
            timestamp    : v7,
            total_swaps  : v9,
        };
        0x2::event::emit<TokensSwapped>(v13);
    }

    fun calculate_ddo_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 1000000000000000, 10);
        let v0 = (arg0 as u128) * (1000000 as u128) / (arg1 as u128) * (100 as u128);
        assert!(v0 <= 18446744073709551615, 11);
        (v0 as u64)
    }

    fun calculate_lb_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 1000000000000000, 10);
        let v0 = (arg0 as u128) * (1000 as u128) * (1000000 as u128) / (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 11);
        (v0 as u64)
    }

    public entry fun create_swap_config<T0, T1, T2>(arg0: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg1: u64, arg2: u64, arg3: address, arg4: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::SaleConfig<T0, T2>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(arg2 > 0 && arg2 < 10000, 12);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::SaleConfig<T0, T2>>(arg4);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = SwapConfig<T0, T1, T2>{
            id                   : 0x2::object::new(arg5),
            admins               : v2,
            ddo_price            : arg1,
            lb_buy_ratio         : arg2,
            ddo_payment_receiver : arg3,
            ddo_balance          : 0x2::balance::zero<T1>(),
            lb_sale_config_id    : v1,
            is_paused            : false,
            total_usdc_received  : 0,
            total_ddo_given      : 0,
            total_lb_usdc        : 0,
            total_ddo_fee_usdc   : 0,
            user_records         : 0x2::table::new<address, UserSwapRecords>(arg5),
        };
        let v4 = SwapConfigCreated{
            config_id            : 0x2::object::id<SwapConfig<T0, T1, T2>>(&v3),
            creator              : v0,
            ddo_price            : arg1,
            lb_buy_ratio         : arg2,
            ddo_payment_receiver : arg3,
            lb_sale_config_id    : v1,
        };
        0x2::event::emit<SwapConfigCreated>(v4);
        0x2::transfer::share_object<SwapConfig<T0, T1, T2>>(v3);
    }

    public entry fun deposit_ddo<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.ddo_balance, 0x2::coin::into_balance<T1>(arg1));
        let v0 = DDODeposited{
            amount        : 0x2::coin::value<T1>(&arg1),
            deposited_by  : 0x2::tx_context::sender(arg2),
            total_balance : 0x2::balance::value<T1>(&arg0.ddo_balance),
        };
        0x2::event::emit<DDODeposited>(v0);
    }

    public fun estimate_swap<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::SaleConfig<T0, T2>, arg2: u64) : (u64, u64, u64, u64) {
        let v0 = 0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::get_price<T0, T2>(arg1);
        let v1 = (((arg2 as u128) * (arg0.lb_buy_ratio as u128) / (10000 as u128)) as u64);
        let v2 = if (v0 > 0 && v1 > 0) {
            calculate_lb_amount(v1, v0)
        } else {
            0
        };
        (calculate_ddo_amount(arg2, arg0.ddo_price), v2, v1, arg2 - v1)
    }

    fun find_admin_index<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_ddo_balance<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.ddo_balance)
    }

    public fun get_ddo_payment_receiver<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>) : address {
        arg0.ddo_payment_receiver
    }

    public fun get_ddo_price<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>) : u64 {
        arg0.ddo_price
    }

    public fun get_lb_buy_ratio<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>) : u64 {
        arg0.lb_buy_ratio
    }

    public fun get_swap_info<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>) : (u64, u64, u64, address, bool, u64, u64, u64, u64) {
        (arg0.ddo_price, arg0.lb_buy_ratio, 0x2::balance::value<T1>(&arg0.ddo_balance), arg0.ddo_payment_receiver, arg0.is_paused, arg0.total_usdc_received, arg0.total_ddo_given, arg0.total_lb_usdc, arg0.total_ddo_fee_usdc)
    }

    public fun get_user_records<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: address) : &vector<SwapRecord> {
        &0x2::table::borrow<address, UserSwapRecords>(&arg0.user_records, arg1).records
    }

    public fun get_user_stats<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: address) : (u64, u64, u64, u64) {
        if (0x2::table::contains<address, UserSwapRecords>(&arg0.user_records, arg1)) {
            let v4 = 0x2::table::borrow<address, UserSwapRecords>(&arg0.user_records, arg1);
            (v4.total_usdc_spent, v4.total_ddo_received, v4.total_lb_received, v4.swap_count)
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun has_user_records<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: address) : bool {
        0x2::table::contains<address, UserSwapRecords>(&arg0.user_records, arg1)
    }

    fun is_admin<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_paused<T0, T1, T2>(arg0: &SwapConfig<T0, T1, T2>) : bool {
        arg0.is_paused
    }

    public fun record_ddo_amount(arg0: &SwapRecord) : u64 {
        arg0.ddo_amount
    }

    public fun record_ddo_fee_usdc(arg0: &SwapRecord) : u64 {
        arg0.ddo_fee_usdc
    }

    public fun record_ddo_price(arg0: &SwapRecord) : u64 {
        arg0.ddo_price_at_swap
    }

    public fun record_lb_amount(arg0: &SwapRecord) : u64 {
        arg0.lb_amount
    }

    public fun record_lb_price(arg0: &SwapRecord) : u64 {
        arg0.lb_price_at_swap
    }

    public fun record_lb_usdc(arg0: &SwapRecord) : u64 {
        arg0.lb_usdc
    }

    public fun record_timestamp(arg0: &SwapRecord) : u64 {
        arg0.timestamp
    }

    public fun record_usdc_amount(arg0: &SwapRecord) : u64 {
        arg0.usdc_amount
    }

    public entry fun remove_admin<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 7);
        let (v1, v2) = find_admin_index<T0, T1, T2>(arg0, arg2);
        assert!(v1, 6);
        0x1::vector::remove<address>(&mut arg0.admins, v2);
        let v3 = AdminRemoved{
            removed_admin : arg2,
            removed_by    : v0,
        };
        0x2::event::emit<AdminRemoved>(v3);
    }

    public entry fun set_paused<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        arg0.is_paused = arg2;
        let v1 = SwapPaused{
            paused     : arg2,
            updated_by : v0,
        };
        0x2::event::emit<SwapPaused>(v1);
    }

    public entry fun update_ddo_payment_receiver<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        arg0.ddo_payment_receiver = arg2;
        let v1 = DDOPaymentReceiverUpdated{
            old_receiver : arg0.ddo_payment_receiver,
            new_receiver : arg2,
            updated_by   : v0,
        };
        0x2::event::emit<DDOPaymentReceiverUpdated>(v1);
    }

    public entry fun update_ddo_price<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        assert!(arg2 > 0, 4);
        arg0.ddo_price = arg2;
        let v1 = DDOPriceUpdated{
            old_price  : arg0.ddo_price,
            new_price  : arg2,
            updated_by : v0,
        };
        0x2::event::emit<DDOPriceUpdated>(v1);
    }

    public entry fun update_lb_buy_ratio<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        assert!(arg2 > 0 && arg2 < 10000, 12);
        arg0.lb_buy_ratio = arg2;
        let v1 = LBBuyRatioUpdated{
            old_ratio  : arg0.lb_buy_ratio,
            new_ratio  : arg2,
            updated_by : v0,
        };
        0x2::event::emit<LBBuyRatioUpdated>(v1);
    }

    public entry fun withdraw_all_ddo<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin<T0, T1, T2>(arg0, v0);
        let v1 = 0x2::balance::value<T1>(&arg0.ddo_balance);
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.ddo_balance), arg3), arg2);
        let v2 = DDOWithdrawn{
            amount            : v1,
            withdrawn_by      : v0,
            recipient         : arg2,
            remaining_balance : 0,
        };
        0x2::event::emit<DDOWithdrawn>(v2);
    }

    public entry fun withdraw_ddo<T0, T1, T2>(arg0: &mut SwapConfig<T0, T1, T2>, arg1: &0x1654c207d5032d4147510a10de53bfbc2703bfc96353b0b4547435a9f6ca5583::lb_sale::AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_admin<T0, T1, T2>(arg0, v0);
        assert!(0x2::balance::value<T1>(&arg0.ddo_balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.ddo_balance, arg2), arg4), arg3);
        let v1 = DDOWithdrawn{
            amount            : arg2,
            withdrawn_by      : v0,
            recipient         : arg3,
            remaining_balance : 0x2::balance::value<T1>(&arg0.ddo_balance),
        };
        0x2::event::emit<DDOWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

