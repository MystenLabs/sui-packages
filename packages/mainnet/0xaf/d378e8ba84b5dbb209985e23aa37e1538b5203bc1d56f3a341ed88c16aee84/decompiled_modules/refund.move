module 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::refund {
    struct REFUND has drop {
        dummy_field: bool,
    }

    struct RefundPool has key {
        id: 0x2::object::UID,
        unclaimed: 0x2::table::Table<address, u64>,
        base_pool: 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::Pool,
        booster_pool: 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::Pool,
        accounting: 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::Accounting,
        phase: u8,
        timeout_ts: 0x1::option::Option<u64>,
    }

    public fun accounting(arg0: &RefundPool) : &0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::Accounting {
        &arg0.accounting
    }

    public fun current_liabilities(arg0: &RefundPool) : u64 {
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::current_liabilities(&arg0.accounting)
    }

    public(friend) fun accounting_mut(arg0: &mut RefundPool) : &mut 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::Accounting {
        &mut arg0.accounting
    }

    public entry fun add_addresses(arg0: &0x2::package::Publisher, arg1: &mut RefundPool, arg2: vector<address>, arg3: vector<u64>) {
        assert_address_addition_phase(arg1);
        assert_publisher(arg0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 2);
        let v0 = 0x1::vector::length<address>(&arg2);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v2 = 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_to_refund_mut(&mut arg1.accounting);
            *v2 = *v2 + v1;
            0x2::table::add<address, u64>(&mut arg1.unclaimed, 0x1::vector::pop_back<address>(&mut arg2), v1);
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun amount_to_claim(arg0: &RefundPool, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::table::contains<address, u64>(&arg0.unclaimed, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.unclaimed, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun amount_to_claim_boosted(arg0: &RefundPool, arg1: address) : 0x1::option::Option<u64> {
        if (0x2::table::contains<address, u64>(&arg0.unclaimed, arg1)) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.unclaimed, arg1);
            0x1::option::some<u64>(v1 + 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::math::div(v1, 2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun assert_address(arg0: &RefundPool, arg1: address) {
        assert!(0x2::table::contains<address, u64>(&arg0.unclaimed, arg1), 1);
    }

    fun assert_address_addition_phase(arg0: &RefundPool) {
        assert!(is_address_addition_phase(arg0), 10);
    }

    public(friend) fun assert_claim_phase(arg0: &RefundPool) {
        assert!(is_claim_phase(arg0), 12);
    }

    public(friend) fun assert_funding_phase(arg0: &RefundPool) {
        assert!(is_funding_phase(arg0), 11);
    }

    public fun assert_publisher(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<REFUND>(arg0), 0);
    }

    public(friend) fun assert_reclaim_phase(arg0: &RefundPool) {
        assert!(is_reclaim_phase(arg0), 13);
    }

    public fun base_funds(arg0: &RefundPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funds(&arg0.base_pool))
    }

    public fun base_pool(arg0: &RefundPool) : &0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::Pool {
        &arg0.base_pool
    }

    public fun booster_funds(arg0: &RefundPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funds(&arg0.booster_pool))
    }

    public fun booster_pool(arg0: &RefundPool) : &0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::Pool {
        &arg0.booster_pool
    }

    public(friend) fun booster_pool_mut(arg0: &mut RefundPool) : &mut 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::Pool {
        &mut arg0.base_pool
    }

    public entry fun claim_refund(arg0: &mut RefundPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_address(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(claim_refund_(arg0, v0, arg1), v0);
    }

    public(friend) fun claim_refund_(arg0: &mut RefundPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_claim_phase(arg0);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.unclaimed, arg1);
        let v1 = 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_refunded_mut(&mut arg0.accounting);
        *v1 = *v1 + v0;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funds_mut(&mut arg0.base_pool), v0), arg2)
    }

    public entry fun fund(arg0: &mut RefundPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_funding_phase(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::table::insert_or_add(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funders_mut(&mut arg0.base_pool), 0x2::tx_context::sender(arg2), v0);
        let v1 = 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_raised_mut(&mut arg0.accounting);
        assert!(!(*v1 + v0 > 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_to_refund(&arg0.accounting)), 0);
        *v1 = *v1 + v0;
        0x2::balance::join<0x2::sui::SUI>(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funds_mut(&mut arg0.base_pool), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_total_boosted(arg0: &RefundPool) : u64 {
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_boosted(&arg0.accounting)
    }

    public fun get_total_raised(arg0: &RefundPool) : u64 {
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_raised(&arg0.accounting)
    }

    public fun get_total_refunded(arg0: &RefundPool) : u64 {
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_refunded(&arg0.accounting)
    }

    public fun get_total_to_refund(arg0: &RefundPool) : u64 {
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_to_refund(&arg0.accounting)
    }

    fun init(arg0: REFUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RefundPool{
            id           : 0x2::object::new(arg1),
            unclaimed    : 0x2::table::new<address, u64>(arg1),
            base_pool    : 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::new(arg1),
            booster_pool : 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::new(arg1),
            accounting   : 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::new(),
            phase        : 1,
            timeout_ts   : 0x1::option::none<u64>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REFUND>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<RefundPool>(v0);
    }

    fun is_address_addition_phase(arg0: &RefundPool) : bool {
        arg0.phase == 1
    }

    fun is_claim_phase(arg0: &RefundPool) : bool {
        arg0.phase == 3
    }

    fun is_funding_phase(arg0: &RefundPool) : bool {
        arg0.phase == 2
    }

    fun is_reclaim_phase(arg0: &RefundPool) : bool {
        arg0.phase == 4
    }

    fun next_phase(arg0: &mut RefundPool) {
        arg0.phase = arg0.phase + 1;
    }

    public fun phase(arg0: &RefundPool) : u8 {
        arg0.phase
    }

    public entry fun reclaim_funds(arg0: &mut RefundPool, arg1: &mut 0x2::tx_context::TxContext) {
        assert_reclaim_phase(arg0);
        let v0 = &mut arg0.base_pool;
        reclaim_funds_(v0, 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_raised(&arg0.accounting), arg1);
    }

    public(friend) fun reclaim_funds_(arg0: &mut 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funders_mut(arg0);
        assert!(0x2::table::contains<address, u64>(v0, 0x2::tx_context::sender(arg2)), 7);
        let v1 = 0x2::table::is_empty<address, u64>(v0);
        let v2 = 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funds_mut(arg0);
        let v3 = if (v1) {
            0x2::balance::value<0x2::sui::SUI>(v2)
        } else {
            0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::math::div(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::math::mul(0x2::balance::value<0x2::sui::SUI>(v2), 0x2::table::remove<address, u64>(v0, 0x2::tx_context::sender(arg2))), arg1)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v2, v3), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun start_claim_phase(arg0: &mut RefundPool) {
        assert_funding_phase(arg0);
        assert!(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_to_refund(&arg0.accounting) == 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_raised(&arg0.accounting), 3);
        next_phase(arg0);
    }

    public entry fun start_funding_phase(arg0: &0x2::package::Publisher, arg1: &mut RefundPool, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_publisher(arg0);
        assert_address_addition_phase(arg1);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 4);
        0x1::option::fill<u64>(&mut arg1.timeout_ts, arg2);
        next_phase(arg1);
    }

    public entry fun start_reclaim_phase(arg0: &mut RefundPool, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.timeout_ts), 6);
        if (is_funding_phase(arg0)) {
            assert!(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_raised(&arg0.accounting) < 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_to_refund(&arg0.accounting), 0);
        } else {
            assert_claim_phase(arg0);
        };
        next_phase(arg0);
    }

    public fun timeout_ts(arg0: &RefundPool) : 0x1::option::Option<u64> {
        arg0.timeout_ts
    }

    public(friend) fun uid_mut(arg0: &mut RefundPool) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unclaimed(arg0: &RefundPool) : &0x2::table::Table<address, u64> {
        &arg0.unclaimed
    }

    public(friend) fun unclaimed_mut(arg0: &mut RefundPool) : &mut 0x2::table::Table<address, u64> {
        &mut arg0.unclaimed
    }

    public entry fun withdraw_funds(arg0: &mut RefundPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_funding_phase(arg0);
        0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::table::remove_or_subtract(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funders_mut(&mut arg0.base_pool), 0x2::tx_context::sender(arg2), arg1);
        let v0 = 0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::accounting::total_raised_mut(&mut arg0.accounting);
        *v0 = *v0 - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0xafd378e8ba84b5dbb209985e23aa37e1538b5203bc1d56f3a341ed88c16aee84::pool::funds_mut(&mut arg0.base_pool), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

