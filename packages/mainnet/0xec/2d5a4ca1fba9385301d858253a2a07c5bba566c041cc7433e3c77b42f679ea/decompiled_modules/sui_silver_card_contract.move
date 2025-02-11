module 0xec2d5a4ca1fba9385301d858253a2a07c5bba566c041cc7433e3c77b42f679ea::sui_silver_card_contract {
    struct CardConfigs has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        native_fee: u64,
        non_native_fee: u64,
        usdc_address: address,
        revenue_vault: address,
        card_vault: address,
        revenue_fee: u64,
        min_card_amount: u64,
        max_card_amount: u64,
        daily_card_buy_limit: u64,
    }

    struct PurchaseRecord has key {
        id: 0x2::object::UID,
        timestamp_in_record: u64,
        total_card_bought_per_day: u64,
    }

    struct FeeTier has drop, store {
        minAmount: u64,
        maxAmount: u64,
        fee: u64,
    }

    struct FeeTierList has store, key {
        id: 0x2::object::UID,
        version: u64,
        tiers: vector<FeeTier>,
    }

    struct SwapFee has drop, store {
        token_type: 0x1::ascii::String,
        fee: u64,
    }

    struct SwapFeeList has store, key {
        id: 0x2::object::UID,
        version: u64,
        swap_fees: vector<SwapFee>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Date has copy, drop, store {
        year: u64,
        month: u8,
        day: u8,
    }

    struct CardPurchased has copy, drop {
        from: address,
        amount: u64,
        src_token_type: 0x1::ascii::String,
        user_email: 0x1::ascii::String,
    }

    struct CurrentDate has copy, drop {
        date: Date,
    }

    public fun add_fee_tier(arg0: &AdminCap, arg1: &mut FeeTierList, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 3);
        let v0 = FeeTier{
            minAmount : arg2,
            maxAmount : arg3,
            fee       : arg4,
        };
        0x1::vector::push_back<FeeTier>(&mut arg1.tiers, v0);
    }

    public fun add_swap_fee(arg0: &AdminCap, arg1: &mut SwapFeeList, arg2: 0x1::ascii::String, arg3: u64) {
        assert!(arg1.version == 1, 3);
        let v0 = SwapFee{
            token_type : arg2,
            fee        : arg3,
        };
        0x1::vector::push_back<SwapFee>(&mut arg1.swap_fees, v0);
    }

    public fun buy_card_direct<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::ascii::String, arg2: u64, arg3: 0x1::ascii::String, arg4: &CardConfigs, arg5: &mut PurchaseRecord, arg6: &mut FeeTierList, arg7: &mut SwapFeeList, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 1, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::address::to_ascii_string(arg4.usdc_address) == 0x1::type_name::get_address(&v0), 6);
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 0);
        let v1 = arg2 * get_swap_fee_from_list(arg7, arg1) / 10000;
        if (v1 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v1, arg9), arg4.revenue_vault);
        };
        let v2 = arg2 - v1;
        assert!(v2 >= arg4.min_card_amount && v2 <= arg4.max_card_amount, 1);
        let v3 = v2 * get_fee_from_tiers(arg6, v2) / 10000;
        let v4 = 0x2::clock::timestamp_ms(arg8);
        let Date {
            year  : v5,
            month : v6,
            day   : v7,
        } = calculate_date(v4 / 1000);
        let Date {
            year  : v8,
            month : v9,
            day   : v10,
        } = calculate_date(arg5.timestamp_in_record / 1000);
        let v11 = if (v5 == v8) {
            if (v6 == v9) {
                v7 == v10
            } else {
                false
            }
        } else {
            false
        };
        if (v11) {
            arg5.total_card_bought_per_day = arg5.total_card_bought_per_day + v2;
        } else {
            arg5.timestamp_in_record = v4;
            arg5.total_card_bought_per_day = v2;
        };
        assert!(arg5.total_card_bought_per_day <= arg4.daily_card_buy_limit, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v3, arg9), arg4.revenue_vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v2 - v3, arg9), arg4.card_vault);
        let v12 = CardPurchased{
            from           : 0x2::tx_context::sender(arg9),
            amount         : v2,
            src_token_type : arg1,
            user_email     : arg3,
        };
        0x2::event::emit<CardPurchased>(v12);
    }

    fun calculate_date(arg0: u64) : Date {
        let v0 = arg0;
        let v1 = 1970;
        loop {
            let v2 = if (is_leap_year(v1)) {
                366 * 86400
            } else {
                365 * 86400
            };
            if (v0 >= v2) {
                let v3 = if (is_leap_year(v1)) {
                    366 * 86400
                } else {
                    365 * 86400
                };
                v0 = v0 - v3;
                v1 = v1 + 1;
            } else {
                break
            };
        };
        let v4 = x"1f1c1f1e1f1e1f1f1e1f1e1f";
        if (is_leap_year(v1)) {
            *0x1::vector::borrow_mut<u8>(&mut v4, 1) = 29;
        };
        let v5 = 0;
        while (v0 >= (*0x1::vector::borrow<u8>(&v4, v5) as u64) * 86400) {
            v0 = v0 - (*0x1::vector::borrow<u8>(&v4, v5) as u64) * 86400;
            v5 = v5 + 1;
        };
        Date{
            year  : v1,
            month : ((v5 + 1) as u8),
            day   : ((v0 / 86400) as u8) + 1,
        }
    }

    public fun create_purchase_profile(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<PurchaseRecord>(new_purchase_record(0, 0, arg1), arg0);
    }

    public fun get_current_date(arg0: &0x2::clock::Clock) : Date {
        let v0 = calculate_date(0x2::clock::timestamp_ms(arg0) / 1000);
        let v1 = CurrentDate{date: v0};
        0x2::event::emit<CurrentDate>(v1);
        v0
    }

    public fun get_fee_from_tiers(arg0: &mut FeeTierList, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<FeeTier>(&arg0.tiers)) {
            if (arg1 >= 0x1::vector::borrow<FeeTier>(&arg0.tiers, v0).minAmount && arg1 <= 0x1::vector::borrow<FeeTier>(&arg0.tiers, v0).maxAmount) {
                v1 = 0x1::vector::borrow<FeeTier>(&arg0.tiers, v0).fee;
                break
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_swap_fee_from_list(arg0: &mut SwapFeeList, arg1: 0x1::ascii::String) : u64 {
        let v0 = 0;
        let v1 = 500;
        while (v0 < 0x1::vector::length<SwapFee>(&arg0.swap_fees)) {
            if (0x1::vector::borrow<SwapFee>(&arg0.swap_fees, v0).token_type == arg1) {
                v1 = 0x1::vector::borrow<SwapFee>(&arg0.swap_fees, v0).fee;
                break
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = FeeTierList{
            id      : 0x2::object::new(arg0),
            version : 1,
            tiers   : 0x1::vector::empty<FeeTier>(),
        };
        0x2::transfer::share_object<FeeTierList>(v1);
        let v2 = SwapFeeList{
            id        : 0x2::object::new(arg0),
            version   : 1,
            swap_fees : 0x1::vector::empty<SwapFee>(),
        };
        0x2::transfer::share_object<SwapFeeList>(v2);
        let v3 = CardConfigs{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            admin                : 0x2::object::id<AdminCap>(&v0),
            native_fee           : 150,
            non_native_fee       : 500,
            usdc_address         : @0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7,
            revenue_vault        : @0xad542a101e08a2d61136727062802e5455f269d0c815350ef51ef80b5905f26,
            card_vault           : @0x7be464889d569825a2caa72118b6521361770de809f84eb433ce42bbf88d5c08,
            revenue_fee          : 200,
            min_card_amount      : 1000000,
            max_card_amount      : 1500000000,
            daily_card_buy_limit : 1500000000,
        };
        0x2::transfer::share_object<CardConfigs>(v3);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_leap_year(arg0: u64) : bool {
        arg0 % 4 == 0 && arg0 % 100 != 0 || arg0 % 400 == 0
    }

    entry fun migrate(arg0: &mut CardConfigs, arg1: &mut FeeTierList, arg2: &mut SwapFeeList, arg3: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg3), 2);
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
        arg1.version = 1;
        arg2.version = 1;
    }

    fun new_purchase_record(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PurchaseRecord {
        PurchaseRecord{
            id                        : 0x2::object::new(arg2),
            timestamp_in_record       : arg0,
            total_card_bought_per_day : arg1,
        }
    }

    public fun remove_fee_tier(arg0: &AdminCap, arg1: &mut FeeTierList, arg2: u64, arg3: u64) {
        assert!(arg1.version == 1, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeTier>(&arg1.tiers)) {
            if (0x1::vector::borrow<FeeTier>(&arg1.tiers, v1).minAmount == arg2 && 0x1::vector::borrow<FeeTier>(&arg1.tiers, v1).maxAmount == arg3) {
                v0 = true;
                0x1::vector::remove<FeeTier>(&mut arg1.tiers, v1);
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 7);
    }

    public fun remove_swap_fee(arg0: &AdminCap, arg1: &mut SwapFeeList, arg2: 0x1::ascii::String) {
        assert!(arg1.version == 1, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SwapFee>(&arg1.swap_fees)) {
            if (0x1::vector::borrow<SwapFee>(&arg1.swap_fees, v1).token_type == arg2) {
                v0 = true;
                0x1::vector::remove<SwapFee>(&mut arg1.swap_fees, v1);
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 7);
    }

    public fun set_card_vault(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: address) {
        assert!(arg1.version == 1, 3);
        arg1.card_vault = arg2;
    }

    public fun set_daily_limit(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.daily_card_buy_limit = arg2;
    }

    public fun set_max_card_amount(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.max_card_amount = arg2;
    }

    public fun set_min_card_amount(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.min_card_amount = arg2;
    }

    public fun set_native_fee(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.native_fee = arg2;
    }

    public fun set_non_native_fee(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.non_native_fee = arg2;
    }

    public fun set_revenue_fee(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.revenue_fee = arg2;
    }

    public fun set_revenue_vault(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: address) {
        assert!(arg1.version == 1, 3);
        arg1.revenue_vault = arg2;
    }

    public fun set_usdc_address(arg0: &AdminCap, arg1: &mut CardConfigs, arg2: address) {
        assert!(arg1.version == 1, 3);
        arg1.usdc_address = arg2;
    }

    public fun update_fee_tier(arg0: &AdminCap, arg1: &mut FeeTierList, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeTier>(&arg1.tiers)) {
            if (0x1::vector::borrow<FeeTier>(&arg1.tiers, v1).minAmount == arg2 && 0x1::vector::borrow<FeeTier>(&arg1.tiers, v1).maxAmount == arg3) {
                v0 = true;
                0x1::vector::borrow_mut<FeeTier>(&mut arg1.tiers, v1).fee = arg4;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 7);
    }

    public fun update_swap_fee(arg0: &AdminCap, arg1: &mut SwapFeeList, arg2: 0x1::ascii::String, arg3: u64) {
        assert!(arg1.version == 1, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SwapFee>(&arg1.swap_fees)) {
            if (0x1::vector::borrow<SwapFee>(&arg1.swap_fees, v1).token_type == arg2) {
                v0 = true;
                0x1::vector::borrow_mut<SwapFee>(&mut arg1.swap_fees, v1).fee = arg3;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 7);
    }

    // decompiled from Move bytecode v6
}

