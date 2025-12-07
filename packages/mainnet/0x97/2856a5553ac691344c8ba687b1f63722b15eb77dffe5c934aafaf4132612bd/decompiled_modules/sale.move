module 0x972856a5553ac691344c8ba687b1f63722b15eb77dffe5c934aafaf4132612bd::sale {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenSale has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<address>,
        purchases_wl1: 0x2::table::Table<address, u64>,
        purchases_wl1_count: 0x2::table::Table<address, u8>,
        purchases_wl2: 0x2::table::Table<address, u64>,
        purchases_public: 0x2::table::Table<address, u64>,
        price: u64,
        total_raised: u64,
        max_raise: u64,
        current_phase: u8,
        is_sold_out: bool,
        treasury: address,
        wl1_start_time: u64,
        wl1_duration: u64,
        wl2_start_time: u64,
        wl2_duration: u64,
        public_start_time: u64,
    }

    struct PurchaseEvent has copy, drop {
        buyer: address,
        amount: u64,
        phase: u8,
        purchase_number: u8,
        total_raised: u64,
    }

    struct PhaseChangedEvent has copy, drop {
        old_phase: u8,
        new_phase: u8,
        timestamp: u64,
    }

    struct PriceUpdateEvent has copy, drop {
        old_price: u64,
        new_price: u64,
    }

    struct WhitelistUpdateEvent has copy, drop {
        addresses_count: u64,
        added: bool,
    }

    struct WL1StartEvent has copy, drop {
        wl1_start_time: u64,
        wl1_end_time: u64,
        wl2_start_time: u64,
        wl2_end_time: u64,
        public_start_time: u64,
    }

    struct SoldOutEvent has copy, drop {
        total_raised: u64,
        max_raise: u64,
        timestamp: u64,
    }

    struct MaxRaiseIncreasedEvent has copy, drop {
        old_max_raise: u64,
        new_max_raise: u64,
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

    public entry fun force_switch_to_public(arg0: &AdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(arg1.current_phase == 0 || arg1.current_phase == 1, 13);
        arg1.current_phase = 2;
        let v0 = PhaseChangedEvent{
            old_phase : arg1.current_phase,
            new_phase : 2,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    public entry fun force_switch_to_wl2(arg0: &AdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(arg1.current_phase == 0, 13);
        arg1.current_phase = 1;
        let v0 = PhaseChangedEvent{
            old_phase : 0,
            new_phase : 1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    public fun get_current_phase(arg0: &TokenSale) : u8 {
        arg0.current_phase
    }

    public fun get_current_phase_remaining_time(arg0: &TokenSale, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.current_phase == 0 && arg0.wl1_start_time > 0) {
            let v2 = arg0.wl1_start_time + arg0.wl1_duration;
            if (v0 >= v2) {
                0
            } else {
                v2 - v0
            }
        } else if (arg0.current_phase == 1 && arg0.wl2_start_time > 0) {
            let v3 = arg0.wl2_start_time + arg0.wl2_duration;
            if (v0 >= v3) {
                0
            } else {
                v3 - v0
            }
        } else {
            0
        }
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

    public fun get_public_start_time(arg0: &TokenSale) : u64 {
        arg0.public_start_time
    }

    public fun get_total_raised(arg0: &TokenSale) : u64 {
        arg0.total_raised
    }

    public fun get_treasury(arg0: &TokenSale) : address {
        arg0.treasury
    }

    public fun get_whitelist_size(arg0: &TokenSale) : u64 {
        0x2::vec_set::size<address>(&arg0.whitelist)
    }

    public fun get_wl1_duration(arg0: &TokenSale) : u64 {
        arg0.wl1_duration
    }

    public fun get_wl1_end_time(arg0: &TokenSale) : u64 {
        if (arg0.wl1_start_time == 0) {
            0
        } else {
            arg0.wl1_start_time + arg0.wl1_duration
        }
    }

    public fun get_wl1_purchase_amount(arg0: &TokenSale, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.purchases_wl1, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.purchases_wl1, arg1)
        } else {
            0
        }
    }

    public fun get_wl1_purchase_count(arg0: &TokenSale, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.purchases_wl1_count, arg1)) {
            *0x2::table::borrow<address, u8>(&arg0.purchases_wl1_count, arg1)
        } else {
            0
        }
    }

    public fun get_wl1_start_time(arg0: &TokenSale) : u64 {
        arg0.wl1_start_time
    }

    public fun get_wl2_duration(arg0: &TokenSale) : u64 {
        arg0.wl2_duration
    }

    public fun get_wl2_end_time(arg0: &TokenSale) : u64 {
        if (arg0.wl2_start_time == 0) {
            0
        } else {
            arg0.wl2_start_time + arg0.wl2_duration
        }
    }

    public fun get_wl2_purchase_amount(arg0: &TokenSale, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.purchases_wl2, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.purchases_wl2, arg1)
        } else {
            0
        }
    }

    public fun get_wl2_start_time(arg0: &TokenSale) : u64 {
        arg0.wl2_start_time
    }

    public fun has_purchased_public(arg0: &TokenSale, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.purchases_public, arg1)
    }

    public fun has_purchased_wl1(arg0: &TokenSale, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.purchases_wl1, arg1)
    }

    public fun has_purchased_wl2(arg0: &TokenSale, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.purchases_wl2, arg1)
    }

    public fun has_wl1_started(arg0: &TokenSale) : bool {
        arg0.wl1_start_time > 0
    }

    public entry fun increase_max_raise(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg2 > arg1.max_raise, 15);
        arg1.max_raise = arg2;
        if (arg1.is_sold_out) {
            arg1.is_sold_out = false;
            if (arg1.current_phase == 3) {
                arg1.current_phase = 2;
            };
        };
        let v0 = MaxRaiseIncreasedEvent{
            old_max_raise : arg1.max_raise,
            new_max_raise : arg2,
        };
        0x2::event::emit<MaxRaiseIncreasedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenSale{
            id                  : 0x2::object::new(arg0),
            whitelist           : 0x2::vec_set::empty<address>(),
            purchases_wl1       : 0x2::table::new<address, u64>(arg0),
            purchases_wl1_count : 0x2::table::new<address, u8>(arg0),
            purchases_wl2       : 0x2::table::new<address, u64>(arg0),
            purchases_public    : 0x2::table::new<address, u64>(arg0),
            price               : 1000000000,
            total_raised        : 0,
            max_raise           : 100000000000,
            current_phase       : 0,
            is_sold_out         : false,
            treasury            : 0x2::tx_context::sender(arg0),
            wl1_start_time      : 0,
            wl1_duration        : 10800000,
            wl2_start_time      : 0,
            wl2_duration        : 10800000,
            public_start_time   : 0,
        };
        0x2::transfer::share_object<TokenSale>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_public_active(arg0: &TokenSale) : bool {
        arg0.current_phase == 2 && !arg0.is_sold_out
    }

    public fun is_sold_out(arg0: &TokenSale) : bool {
        arg0.is_sold_out
    }

    public fun is_whitelisted(arg0: &TokenSale, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun is_wl1_active(arg0: &TokenSale, arg1: &0x2::clock::Clock) : bool {
        if (arg0.current_phase != 0 || arg0.wl1_start_time == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < arg0.wl1_start_time + arg0.wl1_duration
    }

    public fun is_wl2_active(arg0: &TokenSale, arg1: &0x2::clock::Clock) : bool {
        if (arg0.current_phase != 1 || arg0.wl2_start_time == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < arg0.wl2_start_time + arg0.wl2_duration
    }

    public entry fun purchase(arg0: &mut TokenSale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(!arg0.is_sold_out, 12);
        assert!(v1 == arg0.price, 3);
        if (arg0.current_phase == 0 && arg0.wl1_start_time > 0) {
            if (v2 >= arg0.wl1_start_time + arg0.wl1_duration) {
                let v3 = PhaseChangedEvent{
                    old_phase : 0,
                    new_phase : 1,
                    timestamp : v2,
                };
                0x2::event::emit<PhaseChangedEvent>(v3);
                arg0.current_phase = 1;
            };
        };
        if (arg0.current_phase == 1 && arg0.wl2_start_time > 0) {
            if (v2 >= arg0.wl2_start_time + arg0.wl2_duration) {
                let v4 = PhaseChangedEvent{
                    old_phase : 1,
                    new_phase : 2,
                    timestamp : v2,
                };
                0x2::event::emit<PhaseChangedEvent>(v4);
                arg0.current_phase = 2;
            };
        };
        if (arg0.current_phase == 0) {
            assert!(arg0.wl1_start_time > 0, 6);
            assert!(v2 < arg0.wl1_start_time + arg0.wl1_duration, 7);
            assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &v0), 1);
            let v5 = if (0x2::table::contains<address, u8>(&arg0.purchases_wl1_count, v0)) {
                *0x2::table::borrow<address, u8>(&arg0.purchases_wl1_count, v0)
            } else {
                0
            };
            assert!(v5 < 2, 10);
            let v6 = v5 + 1;
            if (0x2::table::contains<address, u64>(&arg0.purchases_wl1, v0)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.purchases_wl1, v0);
                *v7 = *v7 + v1;
                *0x2::table::borrow_mut<address, u8>(&mut arg0.purchases_wl1_count, v0) = v6;
            } else {
                0x2::table::add<address, u64>(&mut arg0.purchases_wl1, v0, v1);
                0x2::table::add<address, u8>(&mut arg0.purchases_wl1_count, v0, v6);
            };
            let v8 = PurchaseEvent{
                buyer           : v0,
                amount          : v1,
                phase           : 0,
                purchase_number : v6,
                total_raised    : arg0.total_raised + v1,
            };
            0x2::event::emit<PurchaseEvent>(v8);
        } else if (arg0.current_phase == 1) {
            assert!(arg0.wl2_start_time > 0, 8);
            assert!(v2 < arg0.wl2_start_time + arg0.wl2_duration, 9);
            assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &v0), 1);
            assert!(!0x2::table::contains<address, u64>(&arg0.purchases_wl2, v0), 11);
            0x2::table::add<address, u64>(&mut arg0.purchases_wl2, v0, v1);
            let v9 = PurchaseEvent{
                buyer           : v0,
                amount          : v1,
                phase           : 1,
                purchase_number : 1,
                total_raised    : arg0.total_raised + v1,
            };
            0x2::event::emit<PurchaseEvent>(v9);
        } else {
            assert!(arg0.current_phase == 2, 13);
            assert!(!0x2::table::contains<address, u64>(&arg0.purchases_public, v0), 2);
            0x2::table::add<address, u64>(&mut arg0.purchases_public, v0, v1);
            let v10 = PurchaseEvent{
                buyer           : v0,
                amount          : v1,
                phase           : 2,
                purchase_number : 1,
                total_raised    : arg0.total_raised + v1,
            };
            0x2::event::emit<PurchaseEvent>(v10);
        };
        let v11 = arg0.total_raised + v1;
        if (v11 >= arg0.max_raise) {
            arg0.is_sold_out = true;
            arg0.current_phase = 3;
            let v12 = SoldOutEvent{
                total_raised : v11,
                max_raise    : arg0.max_raise,
                timestamp    : v2,
            };
            0x2::event::emit<SoldOutEvent>(v12);
        };
        assert!(v11 <= arg0.max_raise, 4);
        arg0.total_raised = v11;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
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

    public entry fun start_wl1_phase(arg0: &AdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(arg1.wl1_start_time == 0, 14);
        assert!(arg1.current_phase == 0, 13);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.wl1_start_time = v0;
        arg1.wl2_start_time = v0 + arg1.wl1_duration;
        arg1.public_start_time = arg1.wl2_start_time + arg1.wl2_duration;
        let v1 = WL1StartEvent{
            wl1_start_time    : arg1.wl1_start_time,
            wl1_end_time      : arg1.wl1_start_time + arg1.wl1_duration,
            wl2_start_time    : arg1.wl2_start_time,
            wl2_end_time      : arg1.wl2_start_time + arg1.wl2_duration,
            public_start_time : arg1.public_start_time,
        };
        0x2::event::emit<WL1StartEvent>(v1);
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg2 > 0, 5);
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

    public entry fun update_wl1_duration(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg1.wl1_start_time == 0, 14);
        assert!(arg2 > 0, 15);
        arg1.wl1_duration = arg2;
    }

    public entry fun update_wl2_duration(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg1.wl1_start_time == 0, 14);
        assert!(arg2 > 0, 15);
        arg1.wl2_duration = arg2;
    }

    // decompiled from Move bytecode v6
}

