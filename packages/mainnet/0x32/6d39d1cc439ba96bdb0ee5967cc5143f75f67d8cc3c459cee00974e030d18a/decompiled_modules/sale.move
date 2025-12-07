module 0x326d39d1cc439ba96bdb0ee5967cc5143f75f67d8cc3c459cee00974e030d18a::sale {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenSale has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<address>,
        purchases_whitelist: 0x2::table::Table<address, u64>,
        purchases_public: 0x2::table::Table<address, u64>,
        price: u64,
        total_raised: u64,
        max_raise: u64,
        is_whitelist_phase: bool,
        treasury: address,
        whitelist_start_time: u64,
        whitelist_duration: u64,
    }

    struct PurchaseEvent has copy, drop {
        buyer: address,
        amount: u64,
        is_whitelist: bool,
        total_raised: u64,
    }

    struct PriceUpdateEvent has copy, drop {
        old_price: u64,
        new_price: u64,
    }

    struct PhaseUpdateEvent has copy, drop {
        is_whitelist_phase: bool,
    }

    struct WhitelistUpdateEvent has copy, drop {
        addresses_count: u64,
        added: bool,
    }

    struct WhitelistStartEvent has copy, drop {
        start_time: u64,
        end_time: u64,
        duration: u64,
    }

    public entry fun add_to_whitelist(arg0: &AdminCap, arg1: &mut TokenSale, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (!0x2::vec_set::contains<address>(&arg1.whitelist, &v2)) {
                0x2::vec_set::insert<address>(&mut arg1.whitelist, v2);
            };
            v1 = v1 + 1;
        };
        let v3 = WhitelistUpdateEvent{
            addresses_count : v0,
            added           : true,
        };
        0x2::event::emit<WhitelistUpdateEvent>(v3);
    }

    public fun get_max_raise(arg0: &TokenSale) : u64 {
        arg0.max_raise
    }

    public fun get_price(arg0: &TokenSale) : u64 {
        arg0.price
    }

    public fun get_public_purchase_amount(arg0: &TokenSale, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.purchases_public, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.purchases_public, arg1)
        } else {
            0
        }
    }

    public fun get_total_raised(arg0: &TokenSale) : u64 {
        arg0.total_raised
    }

    public fun get_treasury(arg0: &TokenSale) : address {
        arg0.treasury
    }

    public fun get_whitelist_duration(arg0: &TokenSale) : u64 {
        arg0.whitelist_duration
    }

    public fun get_whitelist_end_time(arg0: &TokenSale) : u64 {
        if (arg0.whitelist_start_time == 0) {
            0
        } else {
            arg0.whitelist_start_time + arg0.whitelist_duration
        }
    }

    public fun get_whitelist_purchase_amount(arg0: &TokenSale, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.purchases_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.purchases_whitelist, arg1)
        } else {
            0
        }
    }

    public fun get_whitelist_remaining_time(arg0: &TokenSale, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.whitelist_start_time == 0 || !arg0.is_whitelist_phase) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.whitelist_start_time + arg0.whitelist_duration;
        if (v0 >= v1) {
            0
        } else {
            v1 - v0
        }
    }

    public fun get_whitelist_size(arg0: &TokenSale) : u64 {
        0x2::vec_set::size<address>(&arg0.whitelist)
    }

    public fun get_whitelist_start_time(arg0: &TokenSale) : u64 {
        arg0.whitelist_start_time
    }

    public fun has_purchased_public(arg0: &TokenSale, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.purchases_public, arg1)
    }

    public fun has_purchased_whitelist(arg0: &TokenSale, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.purchases_whitelist, arg1)
    }

    public fun has_whitelist_started(arg0: &TokenSale) : bool {
        arg0.whitelist_start_time > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenSale{
            id                   : 0x2::object::new(arg0),
            whitelist            : 0x2::vec_set::empty<address>(),
            purchases_whitelist  : 0x2::table::new<address, u64>(arg0),
            purchases_public     : 0x2::table::new<address, u64>(arg0),
            price                : 1000000000,
            total_raised         : 0,
            max_raise            : 100000000000,
            is_whitelist_phase   : true,
            treasury             : 0x2::tx_context::sender(arg0),
            whitelist_start_time : 0,
            whitelist_duration   : 21600000,
        };
        0x2::transfer::share_object<TokenSale>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelist_active(arg0: &TokenSale, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_whitelist_phase || arg0.whitelist_start_time == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < arg0.whitelist_start_time + arg0.whitelist_duration
    }

    public fun is_whitelist_phase(arg0: &TokenSale) : bool {
        arg0.is_whitelist_phase
    }

    public fun is_whitelisted(arg0: &TokenSale, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public entry fun purchase(arg0: &mut TokenSale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 == arg0.price, 4);
        assert!(arg0.total_raised + v1 <= arg0.max_raise, 5);
        if (arg0.is_whitelist_phase) {
            assert!(arg0.whitelist_start_time > 0, 8);
            assert!(0x2::clock::timestamp_ms(arg2) < arg0.whitelist_start_time + arg0.whitelist_duration, 9);
            assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &v0), 1);
            assert!(!0x2::table::contains<address, u64>(&arg0.purchases_whitelist, v0), 2);
            0x2::table::add<address, u64>(&mut arg0.purchases_whitelist, v0, v1);
        } else {
            assert!(!0x2::table::contains<address, u64>(&arg0.purchases_public, v0), 3);
            0x2::table::add<address, u64>(&mut arg0.purchases_public, v0, v1);
        };
        arg0.total_raised = arg0.total_raised + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        let v2 = PurchaseEvent{
            buyer        : v0,
            amount       : v1,
            is_whitelist : arg0.is_whitelist_phase,
            total_raised : arg0.total_raised,
        };
        0x2::event::emit<PurchaseEvent>(v2);
    }

    public entry fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut TokenSale, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::vec_set::contains<address>(&arg1.whitelist, &v2)) {
                0x2::vec_set::remove<address>(&mut arg1.whitelist, &v2);
            };
            v1 = v1 + 1;
        };
        let v3 = WhitelistUpdateEvent{
            addresses_count : v0,
            added           : false,
        };
        0x2::event::emit<WhitelistUpdateEvent>(v3);
    }

    public entry fun start_whitelist_phase(arg0: &AdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(arg1.whitelist_start_time == 0, 10);
        assert!(arg1.is_whitelist_phase, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.whitelist_start_time = v0;
        let v1 = WhitelistStartEvent{
            start_time : v0,
            end_time   : v0 + arg1.whitelist_duration,
            duration   : arg1.whitelist_duration,
        };
        0x2::event::emit<WhitelistStartEvent>(v1);
    }

    public entry fun switch_to_public_sale(arg0: &AdminCap, arg1: &mut TokenSale) {
        assert!(arg1.is_whitelist_phase, 6);
        arg1.is_whitelist_phase = false;
        let v0 = PhaseUpdateEvent{is_whitelist_phase: false};
        0x2::event::emit<PhaseUpdateEvent>(v0);
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg2 > 0, 7);
        arg1.price = arg2;
        let v0 = PriceUpdateEvent{
            old_price : arg1.price,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdateEvent>(v0);
    }

    public entry fun update_treasury(arg0: &AdminCap, arg1: &mut TokenSale, arg2: address) {
        arg1.treasury = arg2;
    }

    public entry fun update_whitelist_duration(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg1.whitelist_start_time == 0, 10);
        arg1.whitelist_duration = arg2;
    }

    // decompiled from Move bytecode v6
}

