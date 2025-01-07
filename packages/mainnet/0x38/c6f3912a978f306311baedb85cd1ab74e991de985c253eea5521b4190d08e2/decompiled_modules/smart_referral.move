module 0x38c6f3912a978f306311baedb85cd1ab74e991de985c253eea5521b4190d08e2::smart_referral {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReferrerBalanceKey<phantom T0> has copy, drop, store {
        referrer_address: address,
    }

    struct ReferrerBalanceValue<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct ReferralPoolValue<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ReferralBank has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        percentage_edge_config: 0x2::table::Table<0x1::string::String, vector<u64>>,
    }

    struct AddReferrerBalanceEvent<phantom T0> has copy, drop, store {
        referrer_address: address,
        amount: u64,
    }

    struct ClaimReferrerBalanceEvent<phantom T0> has copy, drop, store {
        referrer_address: address,
        amount: u64,
    }

    public fun add_referrer_balance<T0>(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        if (!referrer_balance_exists<T0>(arg1, arg2)) {
            let v0 = ReferrerBalanceKey<T0>{referrer_address: arg2};
            let v1 = ReferrerBalanceValue<T0>{
                id     : 0x2::object::new(arg4),
                amount : 0,
            };
            0x2::dynamic_object_field::add<ReferrerBalanceKey<T0>, ReferrerBalanceValue<T0>>(&mut arg1.id, v0, v1);
        };
        let v2 = borrow_referrer_balance_mut<T0>(arg1, arg2);
        v2.amount = v2.amount + arg3;
        let v3 = AddReferrerBalanceEvent<T0>{
            referrer_address : arg2,
            amount           : arg3,
        };
        0x2::event::emit<AddReferrerBalanceEvent<T0>>(v3);
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_valid_version(arg0: &ReferralBank) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 2);
    }

    fun borrow_referral_bank_pool_mut<T0>(arg0: &mut ReferralBank) : &mut ReferralPoolValue<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, ReferralPoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    fun borrow_referrer_balance_mut<T0>(arg0: &mut ReferralBank, arg1: address) : &mut ReferrerBalanceValue<T0> {
        let v0 = ReferrerBalanceKey<T0>{referrer_address: arg1};
        0x2::dynamic_object_field::borrow_mut<ReferrerBalanceKey<T0>, ReferrerBalanceValue<T0>>(&mut arg0.id, v0)
    }

    public fun claim<T0>(arg0: &mut ReferralBank, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_valid_version(arg0);
        assert!(referrer_balance_exists<T0>(arg0, v0), 1);
        let v1 = borrow_referrer_balance_mut<T0>(arg0, v0);
        let v2 = v1.amount;
        assert!(v2 > 0, 3);
        v1.amount = 0;
        assert!(referral_bank_pool_exists<T0>(arg0), 4);
        let v3 = borrow_referral_bank_pool_mut<T0>(arg0);
        assert!(0x2::balance::value<T0>(&v3.balance) >= v2, 5);
        let v4 = ClaimReferrerBalanceEvent<T0>{
            referrer_address : v0,
            amount           : v2,
        };
        0x2::event::emit<ClaimReferrerBalanceEvent<T0>>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3.balance, v2), arg1)
    }

    public fun delete_percentage_edge(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: 0x1::string::String) {
        assert_valid_version(arg1);
        0x2::table::remove<0x1::string::String, vector<u64>>(&mut arg1.percentage_edge_config, arg2);
    }

    public fun deposit_into_pool<T0>(arg0: &mut ReferralBank, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        if (!referral_bank_pool_exists<T0>(arg0)) {
            let v0 = ReferralPoolValue<T0>{
                id      : 0x2::object::new(arg2),
                balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, ReferralPoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v0);
        };
        0x2::balance::join<T0>(&mut borrow_referral_bank_pool_mut<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ReferralBank{
            id                     : 0x2::object::new(arg0),
            version_set            : 0x2::vec_set::singleton<u64>(1),
            percentage_edge_config : 0x2::table::new<0x1::string::String, vector<u64>>(arg0),
        };
        let v2 = &mut v1;
        new_percentage_edge(&v0, v2, 0x1::string::utf8(b"blackjack"), 100000000, 5000000);
        let v3 = &mut v1;
        new_percentage_edge(&v0, v3, 0x1::string::utf8(b"limbo"), 100000000, 10000000);
        let v4 = &mut v1;
        new_percentage_edge(&v0, v4, 0x1::string::utf8(b"live"), 100000000, 10000000);
        let v5 = &mut v1;
        new_percentage_edge(&v0, v5, 0x1::string::utf8(b"slots"), 100000000, 20000000);
        let v6 = &mut v1;
        new_percentage_edge(&v0, v6, 0x1::string::utf8(b"coinflip"), 100000000, 10000000);
        let v7 = &mut v1;
        new_percentage_edge(&v0, v7, 0x1::string::utf8(b"rps"), 100000000, 10000000);
        let v8 = &mut v1;
        new_percentage_edge(&v0, v8, 0x1::string::utf8(b"range"), 100000000, 10000000);
        let v9 = &mut v1;
        new_percentage_edge(&v0, v9, 0x1::string::utf8(b"plinko"), 100000000, 30000000);
        let v10 = &mut v1;
        new_percentage_edge(&v0, v10, 0x1::string::utf8(b"raffle"), 100000000, 1);
        let v11 = &mut v1;
        new_percentage_edge(&v0, v11, 0x1::string::utf8(b"lottery"), 100000000, 250000000);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ReferralBank>(v1);
    }

    public fun new_percentage_edge(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        assert_valid_version(arg1);
        0x2::table::add<0x1::string::String, vector<u64>>(&mut arg1.percentage_edge_config, arg2, 0x1::vector::empty<u64>());
        let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<u64>>(&mut arg1.percentage_edge_config, arg2);
        0x1::vector::push_back<u64>(v0, arg3);
        0x1::vector::push_back<u64>(v0, arg4);
    }

    public fun package_version() : u64 {
        1
    }

    fun referral_bank_pool_exists<T0>(arg0: &ReferralBank) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun referrer_balance_exists<T0>(arg0: &ReferralBank, arg1: address) : bool {
        let v0 = ReferrerBalanceKey<T0>{referrer_address: arg1};
        0x2::dynamic_object_field::exists_<ReferrerBalanceKey<T0>>(&arg0.id, v0)
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun update_edge(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: 0x1::string::String, arg3: u64) {
        assert_valid_version(arg1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<u64>>(&mut arg1.percentage_edge_config, arg2);
        0x1::vector::remove<u64>(v0, 1);
        0x1::vector::insert<u64>(v0, arg3, 1);
    }

    public fun update_percentage(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: 0x1::string::String, arg3: u64) {
        assert_valid_version(arg1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<u64>>(&mut arg1.percentage_edge_config, arg2);
        0x1::vector::remove<u64>(v0, 0);
        0x1::vector::insert<u64>(v0, arg3, 0);
    }

    public fun withdraw_from_pool<T0>(arg0: &AdminCap, arg1: &mut ReferralBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut borrow_referral_bank_pool_mut<T0>(arg1).balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

