module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point {
    struct PointConfig has key {
        id: 0x2::object::UID,
        expiration_days: u64,
        point_value_usd_micro: u64,
        max_usage_rate_bp: u64,
        payback_rate_bp: u64,
        min_usage_points: u64,
    }

    struct PointWallet has key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::vec_map::VecMap<u64, u64>,
        total_balance: u64,
    }

    struct PointVoucher has store, key {
        id: 0x2::object::UID,
        amount: u64,
        recipient: address,
        expiry_month: u64,
    }

    struct PointReceipt {
        points: u64,
        discount_token: u64,
        payback_points: u64,
        product_price_token: u64,
        coin_type: 0x1::type_name::TypeName,
        spender: address,
        token_price_usd_micro: u64,
        decimals: u64,
    }

    struct PointConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
    }

    struct WalletCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        owner: address,
    }

    struct PointMinted has copy, drop {
        wallet_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        expiry_month: u64,
    }

    struct PointSpent has copy, drop {
        wallet_id: 0x2::object::ID,
        owner: address,
        points: u64,
        discount_token: u64,
        coin_type: 0x1::ascii::String,
    }

    struct PointPayback has copy, drop {
        wallet_id: 0x2::object::ID,
        owner: address,
        coin_paid: u64,
        payback_points: u64,
    }

    struct PointVoucherIssued has copy, drop {
        voucher_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        expiry_month: u64,
    }

    struct PointVoucherClaimed has copy, drop {
        wallet_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        expiry_month: u64,
    }

    struct PointConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        expiration_days: u64,
        point_value_usd_micro: u64,
        max_usage_rate_bp: u64,
        payback_rate_bp: u64,
        min_usage_points: u64,
    }

    fun add_months(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 % 100 - 1 + arg1;
        (arg0 / 100 + v0 / 12) * 100 + v0 % 12 + 1
    }

    fun calc_available_balance(arg0: &PointWallet, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u64, u64>(&arg0.balances)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.balances, v1);
            if (*v2 > arg1) {
                v0 = v0 + *v3;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_max_points_for_purchase(arg0: u64, arg1: u8, arg2: u64, arg3: &PointConfig) : u64 {
        assert!(arg2 > 0, 5);
        arg0 * arg3.max_usage_rate_bp / 10000 * arg2 / pow10((arg1 as u64)) / arg3.point_value_usd_micro
    }

    public fun calculate_points_needed(arg0: u64, arg1: u8, arg2: u64, arg3: &PointConfig) : u64 {
        assert!(arg2 > 0, 5);
        let v0 = arg3.point_value_usd_micro * pow10((arg1 as u64));
        (arg0 * arg2 + v0 - 1) / v0
    }

    public fun claim_points_voucher(arg0: &mut PointWallet, arg1: PointVoucher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 0);
        let PointVoucher {
            id           : v1,
            amount       : v2,
            recipient    : v3,
            expiry_month : v4,
        } = arg1;
        assert!(v3 == v0, 8);
        assert!(v4 > ms_to_year_month(0x2::clock::timestamp_ms(arg2)), 7);
        0x2::object::delete(v1);
        credit_points_with_expiry(arg0, v2, v4);
    }

    public fun config_expiration_days(arg0: &PointConfig) : u64 {
        arg0.expiration_days
    }

    public fun config_max_usage_rate(arg0: &PointConfig) : u64 {
        arg0.max_usage_rate_bp
    }

    public fun config_min_usage_points(arg0: &PointConfig) : u64 {
        arg0.min_usage_points
    }

    public fun config_payback_rate(arg0: &PointConfig) : u64 {
        arg0.payback_rate_bp
    }

    public fun config_point_value(arg0: &PointConfig) : u64 {
        arg0.point_value_usd_micro
    }

    public fun create_config(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg1), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        let v0 = PointConfig{
            id                    : 0x2::object::new(arg1),
            expiration_days       : 90,
            point_value_usd_micro : 10000,
            max_usage_rate_bp     : 3000,
            payback_rate_bp       : 500,
            min_usage_points      : 100,
        };
        let v1 = PointConfigCreated{config_id: 0x2::object::id<PointConfig>(&v0)};
        0x2::event::emit<PointConfigCreated>(v1);
        0x2::transfer::share_object<PointConfig>(v0);
    }

    public fun create_wallet(arg0: &mut 0x2::tx_context::TxContext) : PointWallet {
        let v0 = PointWallet{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            balances      : 0x2::vec_map::empty<u64, u64>(),
            total_balance : 0,
        };
        let v1 = WalletCreated{
            wallet_id : 0x2::object::id<PointWallet>(&v0),
            owner     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<WalletCreated>(v1);
        v0
    }

    fun credit_points_with_expiry(arg0: &mut PointWallet, arg1: u64, arg2: u64) {
        if (0x2::vec_map::contains<u64, u64>(&arg0.balances, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.balances, &arg2);
            *v0 = *v0 + arg1;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.balances, arg2, arg1);
        };
        arg0.total_balance = arg0.total_balance + arg1;
        let v1 = PointVoucherClaimed{
            wallet_id    : 0x2::object::id<PointWallet>(arg0),
            owner        : arg0.owner,
            amount       : arg1,
            expiry_month : arg2,
        };
        0x2::event::emit<PointVoucherClaimed>(v1);
    }

    fun days_in_month(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 2) {
            if (is_leap_year(arg0)) {
                return 29
            };
            return 28
        };
        let v0 = if (arg1 == 4) {
            true
        } else if (arg1 == 6) {
            true
        } else if (arg1 == 9) {
            true
        } else {
            arg1 == 11
        };
        if (v0) {
            return 30
        };
        31
    }

    fun deduct_points_fifo(arg0: &mut PointWallet, arg1: u64, arg2: u64) {
        let v0 = arg1;
        while (v0 > 0 && 0x2::vec_map::length<u64, u64>(&arg0.balances) > 0) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.balances, find_min_valid_month_idx(&arg0.balances, arg2));
            let v3 = *v1;
            let v4 = *v2;
            if (v4 <= v0) {
                v0 = v0 - v4;
                let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.balances, &v3);
                continue
            };
            let v7 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.balances, &v3);
            *v7 = *v7 - v0;
            v0 = 0;
        };
        arg0.total_balance = arg0.total_balance - arg1;
    }

    fun emit_config_updated(arg0: &PointConfig) {
        let v0 = PointConfigUpdated{
            config_id             : 0x2::object::id<PointConfig>(arg0),
            expiration_days       : arg0.expiration_days,
            point_value_usd_micro : arg0.point_value_usd_micro,
            max_usage_rate_bp     : arg0.max_usage_rate_bp,
            payback_rate_bp       : arg0.payback_rate_bp,
            min_usage_points      : arg0.min_usage_points,
        };
        0x2::event::emit<PointConfigUpdated>(v0);
    }

    public(friend) fun finalize_receipt(arg0: &mut PointWallet, arg1: PointReceipt, arg2: &PointConfig, arg3: &0x2::clock::Clock) {
        let PointReceipt {
            points                : _,
            discount_token        : v1,
            payback_points        : v2,
            product_price_token   : v3,
            coin_type             : _,
            spender               : _,
            token_price_usd_micro : _,
            decimals              : _,
        } = arg1;
        if (v2 > 0) {
            mint_to_wallet(arg0, v2, arg2, arg3);
            let v8 = 0;
            if (v3 > v1) {
                v8 = v3 - v1;
            };
            let v9 = PointPayback{
                wallet_id      : 0x2::object::id<PointWallet>(arg0),
                owner          : arg0.owner,
                coin_paid      : v8,
                payback_points : v2,
            };
            0x2::event::emit<PointPayback>(v9);
        };
    }

    fun find_min_valid_month_idx(arg0: &0x2::vec_map::VecMap<u64, u64>, arg1: u64) : u64 {
        let v0 = 18446744073709551615;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u64, u64>(arg0)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<u64, u64>(arg0, v1);
            if (*v2 > arg1 && *v2 < v0) {
                v0 = *v2;
            };
            v1 = v1 + 1;
        };
        0
    }

    fun is_leap_year(arg0: u64) : bool {
        arg0 % 4 == 0 && arg0 % 100 != 0 || arg0 % 400 == 0
    }

    public fun is_voucher_claimable(arg0: &PointVoucher, arg1: &0x2::clock::Clock) : bool {
        arg0.expiry_month > ms_to_year_month(0x2::clock::timestamp_ms(arg1))
    }

    public fun make_point_receipt<T0>(arg0: &mut PointWallet, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: &PointConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : PointReceipt {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.owner == v0, 0);
        assert!(arg4 > 0, 5);
        let v1 = pow10((arg3 as u64));
        let v2 = 0;
        if (arg1 > 0) {
            assert!(arg1 >= arg5.min_usage_points, 9);
            let v3 = ms_to_year_month(0x2::clock::timestamp_ms(arg6));
            assert!(calc_available_balance(arg0, v3) >= arg1, 1);
            let v4 = arg1 * arg5.point_value_usd_micro * v1 / arg4;
            v2 = v4;
            if (v4 > arg2) {
                v2 = arg2;
            };
            assert!(v2 <= arg2 * arg5.max_usage_rate_bp / 10000, 6);
            deduct_points_fifo(arg0, arg1, v3);
            let v5 = PointSpent{
                wallet_id      : 0x2::object::id<PointWallet>(arg0),
                owner          : v0,
                points         : arg1,
                discount_token : v2,
                coin_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            };
            0x2::event::emit<PointSpent>(v5);
        };
        let v6 = 0;
        if (arg2 > v2) {
            v6 = arg2 - v2;
        };
        let v7 = 0;
        if (v6 > 0 && arg5.payback_rate_bp > 0) {
            v7 = v6 * arg4 / v1 * arg5.payback_rate_bp / 10000 * arg5.point_value_usd_micro;
        };
        PointReceipt{
            points                : arg1,
            discount_token        : v2,
            payback_points        : v7,
            product_price_token   : arg2,
            coin_type             : 0x1::type_name::with_defining_ids<T0>(),
            spender               : v0,
            token_price_usd_micro : arg4,
            decimals              : (arg3 as u64),
        }
    }

    public fun make_points_voucher(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: u64, arg2: address, arg3: &PointConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg5), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        assert!(arg1 > 0, 2);
        let v0 = add_months(ms_to_year_month(0x2::clock::timestamp_ms(arg4)), arg3.expiration_days / 30);
        let v1 = PointVoucher{
            id           : 0x2::object::new(arg5),
            amount       : arg1,
            recipient    : arg2,
            expiry_month : v0,
        };
        let v2 = PointVoucherIssued{
            voucher_id   : 0x2::object::id<PointVoucher>(&v1),
            recipient    : arg2,
            amount       : arg1,
            expiry_month : v0,
        };
        0x2::event::emit<PointVoucherIssued>(v2);
        0x2::transfer::public_transfer<PointVoucher>(v1, arg2);
    }

    fun mint_to_wallet(arg0: &mut PointWallet, arg1: u64, arg2: &PointConfig, arg3: &0x2::clock::Clock) {
        let v0 = add_months(ms_to_year_month(0x2::clock::timestamp_ms(arg3)), arg2.expiration_days / 30);
        if (0x2::vec_map::contains<u64, u64>(&arg0.balances, &v0)) {
            let v1 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.balances, &v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.balances, v0, arg1);
        };
        arg0.total_balance = arg0.total_balance + arg1;
        let v2 = PointMinted{
            wallet_id    : 0x2::object::id<PointWallet>(arg0),
            owner        : arg0.owner,
            amount       : arg1,
            expiry_month : v0,
        };
        0x2::event::emit<PointMinted>(v2);
    }

    fun ms_to_year_month(arg0: u64) : u64 {
        let v0 = arg0 / 86400000;
        let v1 = 1970;
        loop {
            let v2 = 365;
            if (is_leap_year(v1)) {
                v2 = 366;
            };
            if (v0 < v2) {
                break
            };
            v0 = v0 - v2;
            v1 = v1 + 1;
        };
        let v3 = 1;
        while (v3 <= 12) {
            let v4 = days_in_month(v1, v3);
            if (v0 < v4) {
                break
            };
            v0 = v0 - v4;
            v3 = v3 + 1;
        };
        v1 * 100 + v3
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun receipt_coin_type(arg0: &PointReceipt) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun receipt_discount_token(arg0: &PointReceipt) : u64 {
        arg0.discount_token
    }

    public(friend) fun receipt_payback_points(arg0: &PointReceipt) : u64 {
        arg0.payback_points
    }

    public(friend) fun receipt_points(arg0: &PointReceipt) : u64 {
        arg0.points
    }

    public(friend) fun receipt_product_price(arg0: &PointReceipt) : u64 {
        arg0.product_price_token
    }

    public fun store_wallet(arg0: PointWallet) {
        0x2::transfer::transfer<PointWallet>(arg0, arg0.owner);
    }

    public fun update_expiration_days(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut PointConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        assert!(arg2 > 0, 2);
        arg1.expiration_days = arg2;
        emit_config_updated(arg1);
    }

    public fun update_max_usage_rate(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut PointConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        assert!(arg2 <= 10000, 2);
        arg1.max_usage_rate_bp = arg2;
        emit_config_updated(arg1);
    }

    public fun update_min_usage_points(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut PointConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        arg1.min_usage_points = arg2;
        emit_config_updated(arg1);
    }

    public fun update_payback_rate(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut PointConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        assert!(arg2 <= 10000, 2);
        arg1.payback_rate_bp = arg2;
        emit_config_updated(arg1);
    }

    public fun update_point_value(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut PointConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 4);
        assert!(arg2 > 0, 2);
        arg1.point_value_usd_micro = arg2;
        emit_config_updated(arg1);
    }

    public fun voucher_amount(arg0: &PointVoucher) : u64 {
        arg0.amount
    }

    public fun voucher_expiry_month(arg0: &PointVoucher) : u64 {
        arg0.expiry_month
    }

    public fun voucher_recipient(arg0: &PointVoucher) : address {
        arg0.recipient
    }

    public fun wallet_available_balance(arg0: &PointWallet, arg1: &0x2::clock::Clock) : u64 {
        calc_available_balance(arg0, ms_to_year_month(0x2::clock::timestamp_ms(arg1)))
    }

    public fun wallet_balance_at(arg0: &PointWallet, arg1: u64) : u64 {
        if (0x2::vec_map::contains<u64, u64>(&arg0.balances, &arg1)) {
            *0x2::vec_map::get<u64, u64>(&arg0.balances, &arg1)
        } else {
            0
        }
    }

    public fun wallet_expiring_balance(arg0: &PointWallet, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = ms_to_year_month(0x2::clock::timestamp_ms(arg2));
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<u64, u64>(&arg0.balances)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.balances, v2);
            if (*v3 > v0 && *v3 < add_months(v0, arg1)) {
                v1 = v1 + *v4;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun wallet_owner(arg0: &PointWallet) : address {
        arg0.owner
    }

    public fun wallet_slot_count(arg0: &PointWallet) : u64 {
        0x2::vec_map::length<u64, u64>(&arg0.balances)
    }

    public fun wallet_total_balance(arg0: &PointWallet) : u64 {
        arg0.total_balance
    }

    // decompiled from Move bytecode v7
}

