module 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        is_alternative_payment: bool,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        deep_fee_vault: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        sponsored_pools: 0x2::table::Table<0x2::object::ID, bool>,
        package_version: u64,
    }

    struct SponsorFeeRecord has store, key {
        id: 0x2::object::UID,
        sponsor_fee_records: 0x2::table::Table<address, SponsorSpend>,
        epoch_sponsor_fee_limit: u64,
        uncapped_senders: 0x2::table::Table<address, bool>,
    }

    struct SponsorSpend has copy, drop, store {
        epoch: u64,
        spent: u64,
    }

    struct InitGlobalConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct BalanceCaps has store, key {
        id: 0x2::object::UID,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
    }

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct SetAlternativePaymentEvent has copy, drop {
        is_alternative_payment: bool,
    }

    struct WithdrawDeepFeeEvent has copy, drop {
        amount: u64,
    }

    struct SetSponsoredPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_sponsored: bool,
    }

    struct RemoveSponsoredPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct InitSponsorFeeRecordEvent has copy, drop {
        record_id: 0x2::object::ID,
        epoch_sponsor_fee_limit: u64,
    }

    struct SetSponsorFeeLimitEvent has copy, drop {
        new_limit: u64,
        old_limit: u64,
    }

    struct PruneSponsorRecordEvent has copy, drop {
        sender: address,
    }

    struct SetUncappedSenderEvent has copy, drop {
        sender: address,
        is_uncapped: bool,
    }

    struct SetReferralEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_set: bool,
    }

    struct MintBalanceCapsEvent has copy, drop {
        deposit_cap_id: 0x2::object::ID,
        withdraw_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    public(friend) fun add_sponsor_record(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x1::string::String, SponsorFeeRecord>(&arg0.id, 0x1::string::utf8(b"sponsor_fee_record"))) {
            return false
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record"));
        charge(v0, 0x2::tx_context::sender(arg2), 0x2::tx_context::epoch(arg2), arg1)
    }

    public fun add_uncapped_sender(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg1.id, 0x1::string::utf8(b"sponsor_fee_record"));
        if (!0x2::table::contains<address, bool>(&v0.uncapped_senders, arg2)) {
            0x2::table::add<address, bool>(&mut v0.uncapped_senders, arg2, true);
            let v1 = SetUncappedSenderEvent{
                sender      : arg2,
                is_uncapped : true,
            };
            0x2::event::emit<SetUncappedSenderEvent>(v1);
        };
    }

    public(friend) fun alternative_payment_deep(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        if (!is_alternative_payment(arg0)) {
            return arg1
        };
        if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_fee_vault) < arg2) {
            return arg1
        };
        let v0 = add_sponsor_record(arg0, arg2, arg3);
        if (!v0) {
            return arg1
        };
        let v1 = 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v1, 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, arg2));
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1, arg3)
    }

    public fun balance_manager_id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager)
    }

    fun charge(arg0: &mut SponsorFeeRecord, arg1: address, arg2: u64, arg3: u64) : bool {
        if (!0x2::table::contains<address, SponsorSpend>(&arg0.sponsor_fee_records, arg1)) {
            if (!0x2::table::contains<address, bool>(&arg0.uncapped_senders, arg1) && arg3 > arg0.epoch_sponsor_fee_limit) {
                return false
            };
            let v0 = SponsorSpend{
                epoch : arg2,
                spent : arg3,
            };
            0x2::table::add<address, SponsorSpend>(&mut arg0.sponsor_fee_records, arg1, v0);
            return true
        };
        let v1 = 0x2::table::borrow_mut<address, SponsorSpend>(&mut arg0.sponsor_fee_records, arg1);
        if (v1.epoch != arg2) {
            if (!0x2::table::contains<address, bool>(&arg0.uncapped_senders, arg1) && arg3 > arg0.epoch_sponsor_fee_limit) {
                return false
            };
            v1.epoch = arg2;
            v1.spent = arg3;
            return true
        };
        if (!0x2::table::contains<address, bool>(&arg0.uncapped_senders, arg1) && v1.spent + arg3 > arg0.epoch_sponsor_fee_limit) {
            return false
        };
        v1.spent = v1.spent + arg3;
        true
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 1);
    }

    fun credit(arg0: &mut SponsorFeeRecord, arg1: address, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<address, SponsorSpend>(&arg0.sponsor_fee_records, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, SponsorSpend>(&mut arg0.sponsor_fee_records, arg1);
        if (v0.epoch != arg2) {
            return
        };
        v0.spent = v0.spent - 0x1::u64::min(arg3, v0.spent);
    }

    public fun deep_fee_amount(arg0: &GlobalConfig) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_fee_vault)
    }

    public fun deposit_deep_fee(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public(friend) fun get_deposit_and_withdraw_caps(arg0: &BalanceCaps) : (&0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap) {
        (&arg0.deposit_cap, &arg0.withdraw_cap)
    }

    public(friend) fun get_mut_balance_manager_and_trade_cap(arg0: &mut GlobalConfig) : (&mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap) {
        (&mut arg0.balance_manager, &arg0.trade_cap)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg0);
        let v2 = GlobalConfig{
            id                     : 0x2::object::new(arg0),
            is_alternative_payment : true,
            trade_cap              : v1,
            balance_manager        : v0,
            deep_fee_vault         : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            sponsored_pools        : 0x2::table::new<0x2::object::ID, bool>(arg0),
            package_version        : 1,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v2);
        let v4 = InitGlobalConfigEvent{
            admin_cap_id       : 0x2::object::id<AdminCap>(&v3),
            trade_cap_id       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&v1),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&v0),
            global_config_id   : 0x2::object::id<GlobalConfig>(&v2),
        };
        0x2::event::emit<InitGlobalConfigEvent>(v4);
    }

    public fun init_sponsor_fee_record(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_with_type<0x1::string::String, SponsorFeeRecord>(&arg1.id, 0x1::string::utf8(b"sponsor_fee_record"))) {
            return
        };
        let v0 = SponsorFeeRecord{
            id                      : 0x2::object::new(arg2),
            sponsor_fee_records     : 0x2::table::new<address, SponsorSpend>(arg2),
            epoch_sponsor_fee_limit : 10000000000,
            uncapped_senders        : 0x2::table::new<address, bool>(arg2),
        };
        let v1 = InitSponsorFeeRecordEvent{
            record_id               : 0x2::object::id<SponsorFeeRecord>(&v0),
            epoch_sponsor_fee_limit : v0.epoch_sponsor_fee_limit,
        };
        0x2::event::emit<InitSponsorFeeRecordEvent>(v1);
        0x2::dynamic_object_field::add<0x1::string::String, SponsorFeeRecord>(&mut arg1.id, 0x1::string::utf8(b"sponsor_fee_record"), v0);
    }

    public fun is_alternative_payment(arg0: &GlobalConfig) : bool {
        arg0.is_alternative_payment
    }

    public fun is_sponsored_pool(arg0: &GlobalConfig, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.sponsored_pools, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.sponsored_pools, arg1)
    }

    public fun mint_balance_caps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"balance_caps");
        assert!(!0x2::dynamic_field::exists<0x1::string::String>(&arg1.id, v0), 3);
        let (v1, _) = get_mut_balance_manager_and_trade_cap(arg1);
        let v3 = BalanceCaps{
            id           : 0x2::object::new(arg2),
            deposit_cap  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(v1, arg2),
            withdraw_cap : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(v1, arg2),
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg1.id, v0, 0x2::object::id<BalanceCaps>(&v3));
        let v4 = MintBalanceCapsEvent{
            deposit_cap_id     : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&v3.deposit_cap),
            withdraw_cap_id    : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&v3.withdraw_cap),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg1.balance_manager),
        };
        0x2::event::emit<MintBalanceCapsEvent>(v4);
        0x2::transfer::share_object<BalanceCaps>(v3);
    }

    public fun prune_sponsor_record(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg1.id, 0x1::string::utf8(b"sponsor_fee_record"));
        if (0x2::table::contains<address, SponsorSpend>(&v0.sponsor_fee_records, arg2)) {
            0x2::table::remove<address, SponsorSpend>(&mut v0.sponsor_fee_records, arg2);
            let v1 = PruneSponsorRecordEvent{sender: arg2};
            0x2::event::emit<PruneSponsorRecordEvent>(v1);
        };
    }

    public(friend) fun refund_sponsor_deep(arg0: &mut GlobalConfig, arg1: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = sponsor_refund_amount(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1), arg2);
        if (v0 == 0) {
            return
        };
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v0, arg3)));
        if (!0x2::dynamic_object_field::exists_with_type<0x1::string::String, SponsorFeeRecord>(&arg0.id, 0x1::string::utf8(b"sponsor_fee_record"))) {
            return
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record"));
        credit(v1, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3), v0);
    }

    public fun remove_sponsored_pool(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.sponsored_pools, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.sponsored_pools, arg2);
        let v0 = RemoveSponsoredPoolEvent{pool_id: arg2};
        0x2::event::emit<RemoveSponsoredPoolEvent>(v0);
    }

    public fun remove_uncapped_sender(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg1.id, 0x1::string::utf8(b"sponsor_fee_record"));
        if (0x2::table::contains<address, bool>(&v0.uncapped_senders, arg2)) {
            0x2::table::remove<address, bool>(&mut v0.uncapped_senders, arg2);
            let v1 = SetUncappedSenderEvent{
                sender      : arg2,
                is_uncapped : false,
            };
            0x2::event::emit<SetUncappedSenderEvent>(v1);
        };
    }

    public fun set_is_alternative_payment(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.is_alternative_payment = arg2;
        let v0 = SetAlternativePaymentEvent{is_alternative_payment: arg2};
        0x2::event::emit<SetAlternativePaymentEvent>(v0);
    }

    public fun set_referral(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg3: 0x2::object::ID) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance_manager_referral_pool_id(arg2) == arg3, 4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::set_balance_manager_referral(&mut arg1.balance_manager, arg2, &arg1.trade_cap);
        let v0 = SetReferralEvent{
            pool_id : arg3,
            is_set  : true,
        };
        0x2::event::emit<SetReferralEvent>(v0);
    }

    public fun set_sponsored_pool(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x2::object::ID, arg3: bool) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.sponsored_pools, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.sponsored_pools, arg2) = arg3;
        } else {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.sponsored_pools, arg2, arg3);
        };
        let v0 = SetSponsoredPoolEvent{
            pool_id      : arg2,
            is_sponsored : arg3,
        };
        0x2::event::emit<SetSponsoredPoolEvent>(v0);
    }

    public(friend) fun sponsor_refund_amount(arg0: u64, arg1: u64) : u64 {
        0x1::u64::min(arg0, arg1)
    }

    public fun trade_cap_id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.trade_cap)
    }

    public fun unset_referral<T0, T1>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::unset_balance_manager_referral(&mut arg1.balance_manager, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), &arg1.trade_cap);
        let v0 = SetReferralEvent{
            pool_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2),
            is_set  : false,
        };
        0x2::event::emit<SetReferralEvent>(v0);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > arg1.package_version && arg2 <= 1, 2);
        arg1.package_version = arg2;
        let v0 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersionEvent>(v0);
    }

    public fun update_sponsor_fee_limit(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg1.id, 0x1::string::utf8(b"sponsor_fee_record"));
        v0.epoch_sponsor_fee_limit = arg2;
        let v1 = SetSponsorFeeLimitEvent{
            new_limit : arg2,
            old_limit : v0.epoch_sponsor_fee_limit,
        };
        0x2::event::emit<SetSponsorFeeLimitEvent>(v1);
    }

    public fun withdraw_deep_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(deep_fee_amount(arg1) >= arg2, 0);
        let v0 = WithdrawDeepFeeEvent{amount: arg2};
        0x2::event::emit<WithdrawDeepFeeEvent>(v0);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.deep_fee_vault, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

