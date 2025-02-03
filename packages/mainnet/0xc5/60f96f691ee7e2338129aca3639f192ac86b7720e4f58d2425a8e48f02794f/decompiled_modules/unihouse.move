module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse {
    struct UniHouse has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        referral_table: 0x2::table::Table<address, address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VoucherConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VoucherConfig has store, key {
        id: 0x2::object::UID,
        rules: vector<u64>,
    }

    struct VoucherReceipt<phantom T0> {
        redemption_amount: u64,
    }

    public fun add_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::add_game_config<T0, T1>(borrow_house_mut<T0>(arg1), arg2, arg3, arg4, arg5, arg6);
    }

    public fun add_volume<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = referrer(arg1, v0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::add_volume<T0, T1>(borrow_house_mut<T0>(arg1), v0, v1, arg2);
    }

    public fun claim_rebate<T0>(arg0: &mut UniHouse, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::claim_rebate<T0>(borrow_house_mut<T0>(arg0), arg1)
    }

    public fun join<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: 0x2::balance::Balance<T0>) {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_inflow<T0, T1>(0x2::balance::value<T0>(&arg2));
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::join<T0>(borrow_house_mut<T0>(arg1), arg2);
    }

    public fun remove_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut UniHouse) {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::remove_game_config<T0, T1>(borrow_house_mut<T0>(arg1));
    }

    public fun split<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: u64) : 0x2::balance::Balance<T0> {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_outflow<T0, T1>(arg2);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::split<T0, T1>(borrow_house_mut<T0>(arg1), arg2)
    }

    public fun update_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>) {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::update_game_config<T0, T1>(borrow_house_mut<T0>(arg1), arg2, arg3, arg4, arg5, arg6);
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64) : 0x2::balance::Balance<T0> {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_withdraw<T0>(arg2);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::withdraw<T0>(borrow_house_mut<T0>(arg1), arg2)
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    public fun assert_valid_bet_size<T0, T1: drop>(arg0: &UniHouse, arg1: u64) {
        let (v0, v1) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::bet_size_range<T0, T1>(borrow_house<T0>(arg0));
        assert!(arg1 >= v0 && arg1 <= v1, 3);
    }

    fun assert_valid_version(arg0: &UniHouse) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 0);
    }

    fun assert_valid_voucher_value<T0>(arg0: &UniHouse, arg1: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher::UniVoucher<T0>) {
        let v0 = voucher_max_value<T0>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        assert!(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher::value<T0>(arg1) <= 0x1::option::destroy_some<u64>(v0), 7);
    }

    public fun assert_within_risk<T0, T1: drop>(arg0: &UniHouse, arg1: u64) {
        assert!(arg1 <= 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::max_risk<T0, T1>(borrow_house<T0>(arg0)), 4);
    }

    public fun borrow_house<T0>(arg0: &UniHouse) : &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::House<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::House<T0>>(&arg0.id, v0)
    }

    fun borrow_house_mut<T0>(arg0: &mut UniHouse) : &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::House<T0> {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::House<T0>>(&mut arg0.id, v0)
    }

    public fun buy_voucher<T0>(arg0: &mut UniHouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher::UniVoucher<T0> {
        deposit<T0>(arg0, arg1);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher::mint<T0>(0x2::coin::value<T0>(&arg1), 7776000000, arg2)
    }

    public fun claim_rebate_to<T0>(arg0: &mut UniHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rebate<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public fun create_house<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_deposit<T0>(0x2::balance::value<T0>(&v1));
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::House<T0>>(&mut arg1.id, v0, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::new<T0>(v1, arg3));
    }

    public fun deposit<T0>(arg0: &mut UniHouse, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_deposit<T0>(0x2::balance::value<T0>(&v0));
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::join<T0>(borrow_house_mut<T0>(arg0), v0);
    }

    public fun house_exists<T0>(arg0: &UniHouse) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = UniHouse{
            id             : 0x2::object::new(arg0),
            version_set    : 0x2::vec_set::singleton<u64>(3),
            referral_table : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<UniHouse>(v1);
    }

    public fun new_game_receipt<T0, T1: drop>(arg0: T1, arg1: &UniHouse, arg2: u64) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, T1> {
        assert!(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::game_config_exists<T0, T1>(borrow_house<T0>(arg1)), 5);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::new_receipt<T0, T1>(arg2)
    }

    public fun package_version() : u64 {
        3
    }

    public fun prove_voucher_is_used<T0, T1: drop>(arg0: VoucherReceipt<T0>, arg1: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, T1>) {
        let VoucherReceipt { redemption_amount: v0 } = arg0;
        let (v1, _) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::consume_receipt_and_return<T0, T1>(arg1);
        assert!(v1 >= v0, 6);
    }

    public fun prove_voucher_is_used_and_record_leaderboard<T0, T1: drop>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::leaderboard::Leaderboard, arg1: VoucherReceipt<T0>, arg2: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, T1>, arg3: address) {
        let VoucherReceipt { redemption_amount: v0 } = arg1;
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::leaderboard::add_score<T0, T1>(arg0, &arg2, arg3);
        let (v1, _) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::consume_receipt_and_return<T0, T1>(arg2);
        assert!(v1 >= v0, 6);
    }

    public fun put<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: 0x2::coin::Coin<T0>) {
        join<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun record_leaderboard<T0, T1: drop>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::leaderboard::Leaderboard, arg1: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, T1>, arg2: address) {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::leaderboard::add_score<T0, T1>(arg0, &arg1, arg2);
        let (_, _) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::consume_receipt_and_return<T0, T1>(arg1);
    }

    public fun redeem_voucher<T0>(arg0: &mut UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher::UniVoucher<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, VoucherReceipt<T0>) {
        assert_valid_voucher_value<T0>(arg0, arg1);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher::deduct<T0>(arg1, arg2, arg3);
        let v0 = VoucherReceipt<T0>{redemption_amount: arg3};
        (0x2::coin::from_balance<T0>(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::split_for_voucher<T0>(borrow_house_mut<T0>(arg0), arg3), arg4), v0)
    }

    public fun referrer(arg0: &UniHouse, arg1: address) : 0x1::option::Option<address> {
        let v0 = &arg0.referral_table;
        if (0x2::table::contains<address, address>(v0, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(v0, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun set_referrer(arg0: &mut UniHouse, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg1) {
            return
        };
        let v1 = &mut arg0.referral_table;
        if (0x2::table::contains<address, address>(v1, v0)) {
            return
        };
        0x2::table::add<address, address>(v1, v0, arg1);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_set_referrer(v0, arg1);
    }

    public fun set_voucher_config<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherConfigKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VoucherConfigKey<T0>, VoucherConfig>(&arg1.id, v0)) {
            0x2::dynamic_object_field::borrow_mut<VoucherConfigKey<T0>, VoucherConfig>(&mut arg1.id, v0).rules = arg2;
        } else {
            let v1 = VoucherConfig{
                id    : 0x2::object::new(arg3),
                rules : arg2,
            };
            0x2::dynamic_object_field::add<VoucherConfigKey<T0>, VoucherConfig>(&mut arg1.id, v0, v1);
        };
    }

    public fun take<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(split<T0, T1>(arg0, arg1, arg2), arg3)
    }

    public fun version_set(arg0: &UniHouse) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    public fun voucher_max_value<T0>(arg0: &UniHouse) : 0x1::option::Option<u64> {
        let v0 = VoucherConfigKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VoucherConfigKey<T0>, VoucherConfig>(&arg0.id, v0)) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&0x2::dynamic_object_field::borrow<VoucherConfigKey<T0>, VoucherConfig>(&arg0.id, v0).rules, 0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun voucher_redemption_amount<T0>(arg0: &VoucherReceipt<T0>) : u64 {
        arg0.redemption_amount
    }

    public fun withdraw_to<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw<T0>(arg0, arg1, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

