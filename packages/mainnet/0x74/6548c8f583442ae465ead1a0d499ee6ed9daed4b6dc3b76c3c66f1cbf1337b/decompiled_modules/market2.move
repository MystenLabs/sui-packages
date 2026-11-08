module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::market2 {
    struct Item has copy, drop, store {
        base: u64,
        target: u64,
        max: u64,
        bid_bps: u64,
        ceil_bps: u64,
    }

    struct Market2 has key {
        id: 0x2::object::UID,
        version: u64,
        shed: 0x2::object::ID,
        open: bool,
        payee: address,
        items: vector<Item>,
        fee_bps: u64,
        fee_min: u64,
        floor_bps: u64,
        budget_base: u64,
        budget_bps: u64,
        wallet_cap: u64,
        reserve: u64,
        sweep_above: u64,
        scrap: u64,
        cash: 0x2::balance::Balance<0x2::sui::SUI>,
        day: u64,
        sold_today: u64,
        sold_yesterday: u64,
        paid_today: u64,
        wallets: 0x2::table::Table<address, Spent>,
    }

    struct Spent has drop, store {
        day: u64,
        paid: u64,
    }

    struct Market2Key has copy, drop, store {
        dummy_field: bool,
    }

    struct VialKey has copy, drop, store {
        kind: u8,
    }

    struct Trade {
        market: 0x2::object::ID,
        trader: address,
        owed: u64,
        due: u64,
        bought: u8,
        sold: u8,
    }

    struct Moved has copy, drop {
        trader: address,
        kind: u8,
        units: u64,
        price: u64,
        bought: bool,
        stock: u64,
    }

    struct Traded has copy, drop {
        trader: address,
        owed: u64,
        due: u64,
        fee: u64,
        paid_in: u64,
        paid_out: u64,
        day: u64,
    }

    struct Stocked has copy, drop {
        kind: u8,
        units: u64,
        sui: u64,
        by: address,
        out: bool,
    }

    struct Adopted has copy, drop {
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        sui: u64,
        scrap: u64,
        poison: u64,
        remedy: u64,
        elixir: u64,
    }

    struct Swept has copy, drop {
        sui: u64,
        to: address,
        left: u64,
    }

    struct Configured has copy, drop {
        market: 0x2::object::ID,
        open: bool,
        payee: address,
        items: vector<Item>,
        fee_bps: u64,
        fee_min: u64,
        floor_bps: u64,
        budget_base: u64,
        budget_bps: u64,
        wallet_cap: u64,
        reserve: u64,
        sweep_above: u64,
    }

    entry fun adopt(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::market::Market, arg2: &mut Market2, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::market::shed_of(arg1) == arg2.shed, 595);
        let (v0, v1, v2, v3, v4) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::market::drain(arg1, arg3);
        let v5 = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.cash, v5);
        arg2.scrap = arg2.scrap + v1;
        let v6 = v2;
        let v7 = if (0x1::option::is_none<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v6)) {
            0x1::option::destroy_none<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(v6);
            0
        } else {
            let v8 = 0x1::option::destroy_some<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(v6);
            let v9 = VialKey{kind: 1};
            if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg2.id, v9)) {
                0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_poison(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg2.id, v9), v8);
            } else {
                0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg2.id, v9, v8);
            };
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(&v8)
        };
        let v10 = v3;
        let v11 = if (0x1::option::is_none<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v10)) {
            0x1::option::destroy_none<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(v10);
            0
        } else {
            let v12 = 0x1::option::destroy_some<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(v10);
            let v13 = VialKey{kind: 2};
            if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg2.id, v13)) {
                0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_remedy(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg2.id, v13), v12);
            } else {
                0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg2.id, v13, v12);
            };
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(&v12)
        };
        let v14 = v4;
        let v15 = if (0x1::option::is_none<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v14)) {
            0x1::option::destroy_none<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(v14);
            0
        } else {
            let v16 = 0x1::option::destroy_some<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(v14);
            let v17 = VialKey{kind: 3};
            if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg2.id, v17)) {
                0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_elixir(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg2.id, v17), v16);
            } else {
                0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg2.id, v17, v16);
            };
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(&v16)
        };
        let v18 = Adopted{
            from   : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::market::Market>(arg1),
            to     : 0x2::object::id<Market2>(arg2),
            sui    : 0x2::balance::value<0x2::sui::SUI>(&v5),
            scrap  : v1,
            poison : v7,
            remedy : v11,
            elixir : v15,
        };
        0x2::event::emit<Adopted>(v18);
    }

    fun ask(arg0: &Market2, arg1: u8, arg2: u64, arg3: u64) : u64 {
        check_version(arg0);
        assert!(arg0.open, 583);
        assert!(arg3 >= 1 && arg3 <= 1000, 587);
        assert!(arg2 >= arg3, 585);
        ask_total(0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64)), arg2, arg3)
    }

    fun ask_total(arg0: &Item, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg2) {
            v0 = v0 + unit_ask(arg0, arg1 - v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun bid(arg0: &Market2, arg1: u8, arg2: u64, arg3: u64) : u64 {
        check_version(arg0);
        assert!(arg0.open, 583);
        assert!(arg3 >= 1 && arg3 <= 1000, 587);
        let v0 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        assert!(v0.bid_bps > 0, 596);
        assert!(arg2 + arg3 <= v0.max, 586);
        let v1 = bid_total(v0, arg0.floor_bps, arg2, arg3);
        assert!(v1 > 0, 596);
        v1
    }

    fun bid_total(arg0: &Item, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg3) {
            v0 = v0 + unit_bid(arg0, arg1, arg2 + v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun budget_left(arg0: &Market2, arg1: u64) : u64 {
        let (_, _, _, v3, v4) = day_books(arg0, arg1);
        if (v4 > v3) {
            v4 - v3
        } else {
            0
        }
    }

    fun budget_of(arg0: &Market2) : u64 {
        arg0.budget_base + mul_div(arg0.sold_yesterday, arg0.budget_bps, 10000)
    }

    public fun buy_elixir(arg0: &mut Market2, arg1: &mut Trade, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir {
        let v0 = arg0;
        let v1 = VialKey{kind: 3};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v0.id, v1))
        } else {
            0
        };
        note(arg1, arg0, 3, arg2, ask(arg0, 3, v2, arg2), true, v2 - arg2);
        let v3 = VialKey{kind: 3};
        assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v3), 585);
        let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg0.id, v3);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(v4) >= arg2, 585);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_elixir(v4, arg2, arg3)
    }

    public fun buy_poison(arg0: &mut Market2, arg1: &mut Trade, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison {
        let v0 = arg0;
        let v1 = VialKey{kind: 1};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v0.id, v1))
        } else {
            0
        };
        note(arg1, arg0, 1, arg2, ask(arg0, 1, v2, arg2), true, v2 - arg2);
        let v3 = VialKey{kind: 1};
        assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v3), 585);
        let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg0.id, v3);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(v4) >= arg2, 585);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_poison(v4, arg2, arg3)
    }

    public fun buy_remedy(arg0: &mut Market2, arg1: &mut Trade, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy {
        let v0 = arg0;
        let v1 = VialKey{kind: 2};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v0.id, v1))
        } else {
            0
        };
        note(arg1, arg0, 2, arg2, ask(arg0, 2, v2, arg2), true, v2 - arg2);
        let v3 = VialKey{kind: 2};
        assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v3), 585);
        let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg0.id, v3);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(v4) >= arg2, 585);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_remedy(v4, arg2, arg3)
    }

    public fun buy_scrap(arg0: &mut Market2, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut Trade, arg3: u64) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg1);
        arg0.scrap = arg0.scrap - arg3;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg1, arg2.trader, arg3);
        note(arg2, arg0, 0, arg3, ask(arg0, 0, arg0.scrap, arg3), true, arg0.scrap);
    }

    fun check_admin(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &Market2) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == arg1.shed, 581);
        check_version(arg1);
    }

    fun check_version(arg0: &Market2) {
        assert!(arg0.version == 1, 580);
    }

    public fun close_trade(arg0: &mut Market2, arg1: Trade, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, _, _) = settle(arg0, arg1, arg2, arg3);
        v0
    }

    public fun close_trade_bounded(arg0: &mut Market2, arg1: Trade, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2) = settle(arg0, arg1, arg2, arg5);
        assert!(v1 <= arg3 && v2 >= arg4, 589);
        v0
    }

    fun configured(arg0: &Market2) {
        let v0 = Configured{
            market      : 0x2::object::id<Market2>(arg0),
            open        : arg0.open,
            payee       : arg0.payee,
            items       : arg0.items,
            fee_bps     : arg0.fee_bps,
            fee_min     : arg0.fee_min,
            floor_bps   : arg0.floor_bps,
            budget_base : arg0.budget_base,
            budget_bps  : arg0.budget_bps,
            wallet_cap  : arg0.wallet_cap,
            reserve     : arg0.reserve,
            sweep_above : arg0.sweep_above,
        };
        0x2::event::emit<Configured>(v0);
    }

    public fun day_books(arg0: &Market2, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = arg1 / 86400000;
        if (v0 == arg0.day) {
            return (v0, arg0.sold_today, arg0.sold_yesterday, arg0.paid_today, budget_of(arg0))
        };
        let v1 = if (v0 == arg0.day + 1) {
            arg0.sold_today
        } else {
            0
        };
        (v0, 0, v1, 0, arg0.budget_base + mul_div(v1, arg0.budget_bps, 10000))
    }

    public fun deposit_elixir(arg0: &mut Market2, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = VialKey{kind: 3};
        if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v0)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_elixir(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg0.id, v0, arg1);
        };
        let v1 = Stocked{
            kind  : 3,
            units : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(&arg1),
            sui   : 0,
            by    : 0x2::tx_context::sender(arg2),
            out   : false,
        };
        0x2::event::emit<Stocked>(v1);
    }

    public fun deposit_poison(arg0: &mut Market2, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = VialKey{kind: 1};
        if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v0)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_poison(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg0.id, v0, arg1);
        };
        let v1 = Stocked{
            kind  : 1,
            units : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(&arg1),
            sui   : 0,
            by    : 0x2::tx_context::sender(arg2),
            out   : false,
        };
        0x2::event::emit<Stocked>(v1);
    }

    public fun deposit_remedy(arg0: &mut Market2, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = VialKey{kind: 2};
        if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v0)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_remedy(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg0.id, v0, arg1);
        };
        let v1 = Stocked{
            kind  : 2,
            units : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(&arg1),
            sui   : 0,
            by    : 0x2::tx_context::sender(arg2),
            out   : false,
        };
        0x2::event::emit<Stocked>(v1);
    }

    public fun deposit_scrap(arg0: &mut Market2, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg1);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::spend_scrap(arg1, 0x2::tx_context::sender(arg3), arg2);
        arg0.scrap = arg0.scrap + arg2;
        let v0 = Stocked{
            kind  : 0,
            units : arg2,
            sui   : 0,
            by    : 0x2::tx_context::sender(arg3),
            out   : false,
        };
        0x2::event::emit<Stocked>(v0);
    }

    public fun deposit_sui(arg0: &mut Market2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.cash, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = Stocked{
            kind  : 255,
            units : 0,
            sui   : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            by    : 0x2::tx_context::sender(arg2),
            out   : false,
        };
        0x2::event::emit<Stocked>(v0);
    }

    public fun holdings(arg0: &Market2) : (bool, u64, u64, u64, u64, u64) {
        let v0 = VialKey{kind: 1};
        let v1 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v0)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v0))
        } else {
            0
        };
        let v2 = VialKey{kind: 2};
        let v3 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v2)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v2))
        } else {
            0
        };
        let v4 = VialKey{kind: 3};
        let v5 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v4)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v4))
        } else {
            0
        };
        (arg0.open, 0x2::balance::value<0x2::sui::SUI>(&arg0.cash), arg0.scrap, v1, v3, v5)
    }

    public fun item(arg0: &Market2, arg1: u8) : (u64, u64, u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        (v0.base, v0.target, v0.max, v0.bid_bps, v0.ceil_bps)
    }

    public fun market2_id(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg0);
        let v1 = Market2Key{dummy_field: false};
        if (0x2::dynamic_field::exists<Market2Key>(v0, v1)) {
            let v3 = Market2Key{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<Market2Key, 0x2::object::ID>(v0, v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun note(arg0: &mut Trade, arg1: &Market2, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        assert!(arg0.market == 0x2::object::id<Market2>(arg1), 584);
        if (arg5) {
            arg0.owed = arg0.owed + arg4;
            arg0.bought = arg0.bought | 1 << arg2;
        } else {
            arg0.due = arg0.due + arg4;
            arg0.sold = arg0.sold | 1 << arg2;
        };
        let v0 = Moved{
            trader : arg0.trader,
            kind   : arg2,
            units  : arg3,
            price  : arg4,
            bought : arg5,
            stock  : arg6,
        };
        0x2::event::emit<Moved>(v0);
    }

    fun note_bids(arg0: &Market2, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::note_market_bids(arg1, top_bid(arg0, 1), top_bid(arg0, 2));
    }

    entry fun open_market2(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 581);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::shed_of(arg2) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 595);
        let v0 = Market2Key{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<Market2Key>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg1), v0), 582);
        let v1 = Item{
            base     : 10000000,
            target   : 200,
            max      : 5000,
            bid_bps  : 4500,
            ceil_bps : 0,
        };
        let v2 = Item{
            base     : 8000000,
            target   : 100,
            max      : 300,
            bid_bps  : 4500,
            ceil_bps : 30000,
        };
        let v3 = Item{
            base     : 3000000,
            target   : 100,
            max      : 300,
            bid_bps  : 4500,
            ceil_bps : 30000,
        };
        let v4 = Item{
            base     : 15 * 1000000000,
            target   : 10,
            max      : 10,
            bid_bps  : 0,
            ceil_bps : 20000,
        };
        let v5 = 0x1::vector::empty<Item>();
        let v6 = &mut v5;
        0x1::vector::push_back<Item>(v6, v1);
        0x1::vector::push_back<Item>(v6, v2);
        0x1::vector::push_back<Item>(v6, v3);
        0x1::vector::push_back<Item>(v6, v4);
        let v7 = Market2{
            id             : 0x2::object::new(arg4),
            version        : 1,
            shed           : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1),
            open           : false,
            payee          : arg3,
            items          : v5,
            fee_bps        : 300,
            fee_min        : 10000000,
            floor_bps      : 1000,
            budget_base    : 500000000,
            budget_bps     : 5000,
            wallet_cap     : 100000000,
            reserve        : 10 * 1000000000,
            sweep_above    : 40 * 1000000000,
            scrap          : 0,
            cash           : 0x2::balance::zero<0x2::sui::SUI>(),
            day            : 0,
            sold_today     : 0,
            sold_yesterday : 0,
            paid_today     : 0,
            wallets        : 0x2::table::new<address, Spent>(arg4),
        };
        note_bids(&v7, arg2);
        let v8 = Market2Key{dummy_field: false};
        0x2::dynamic_field::add<Market2Key, 0x2::object::ID>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid_mut(arg1), v8, 0x2::object::id<Market2>(&v7));
        configured(&v7);
        0x2::transfer::share_object<Market2>(v7);
    }

    public fun open_trade(arg0: &mut Market2, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Trade {
        check_version(arg0);
        assert!(arg0.open, 583);
        roll(arg0, 0x2::clock::timestamp_ms(arg1) / 86400000);
        Trade{
            market : 0x2::object::id<Market2>(arg0),
            trader : 0x2::tx_context::sender(arg2),
            owed   : 0,
            due    : 0,
            bought : 0,
            sold   : 0,
        }
    }

    public fun quote(arg0: &Market2, arg1: u8, arg2: u64) : (u64, u64) {
        let v0 = stock_of(arg0, arg1);
        let v1 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        let v2 = if (arg2 >= 1) {
            if (arg2 <= 1000) {
                v0 >= arg2
            } else {
                false
            }
        } else {
            false
        };
        let v3 = if (v2) {
            ask_total(v1, v0, arg2)
        } else {
            0
        };
        let v4 = if (arg2 >= 1) {
            if (arg2 <= 1000) {
                v0 + arg2 <= v1.max
            } else {
                false
            }
        } else {
            false
        };
        let v5 = if (v4) {
            bid_total(v1, arg0.floor_bps, v0, arg2)
        } else {
            0
        };
        (v3, v5)
    }

    fun roll(arg0: &mut Market2, arg1: u64) {
        if (arg0.day == arg1) {
            return
        };
        let v0 = if (arg1 == arg0.day + 1) {
            arg0.sold_today
        } else {
            0
        };
        arg0.sold_yesterday = v0;
        arg0.sold_today = 0;
        arg0.paid_today = 0;
        arg0.day = arg1;
    }

    public fun sell_elixir(arg0: &mut Market2, arg1: &mut Trade, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0;
        let v1 = VialKey{kind: 3};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v0.id, v1))
        } else {
            0
        };
        let v3 = VialKey{kind: 3};
        if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v3)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_elixir(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg0.id, v3), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_elixir(arg2, arg3, arg4));
        } else {
            0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg0.id, v3, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_elixir(arg2, arg3, arg4));
        };
        note(arg1, arg0, 3, arg3, bid(arg0, 3, v2, arg3), false, v2 + arg3);
    }

    public fun sell_poison(arg0: &mut Market2, arg1: &mut Trade, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0;
        let v1 = VialKey{kind: 1};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v0.id, v1))
        } else {
            0
        };
        let v3 = VialKey{kind: 1};
        if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v3)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_poison(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg0.id, v3), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_poison(arg2, arg3, arg4));
        } else {
            0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg0.id, v3, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_poison(arg2, arg3, arg4));
        };
        note(arg1, arg0, 1, arg3, bid(arg0, 1, v2, arg3), false, v2 + arg3);
    }

    public fun sell_remedy(arg0: &mut Market2, arg1: &mut Trade, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0;
        let v1 = VialKey{kind: 2};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v0.id, v1))
        } else {
            0
        };
        let v3 = VialKey{kind: 2};
        if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v3)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::join_remedy(0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg0.id, v3), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_remedy(arg2, arg3, arg4));
        } else {
            0x2::dynamic_object_field::add<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg0.id, v3, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_remedy(arg2, arg3, arg4));
        };
        note(arg1, arg0, 2, arg3, bid(arg0, 2, v2, arg3), false, v2 + arg3);
    }

    public fun sell_scrap(arg0: &mut Market2, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut Trade, arg3: u64) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg1);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::spend_scrap(arg1, arg2.trader, arg3);
        arg0.scrap = arg0.scrap + arg3;
        note(arg2, arg0, 0, arg3, bid(arg0, 0, arg0.scrap, arg3), false, arg0.scrap);
    }

    entry fun set_budget(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: u64, arg3: u64, arg4: u64) {
        check_admin(arg0, arg1);
        let v0 = if (arg2 <= 10000000000) {
            if (arg3 <= 10000) {
                arg4 <= 10000000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 594);
        arg1.budget_base = arg2;
        arg1.budget_bps = arg3;
        arg1.wallet_cap = arg4;
        configured(arg1);
    }

    entry fun set_cash_lines(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: u64, arg3: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 <= arg3 && arg3 <= 10000000000000, 594);
        arg1.reserve = arg2;
        arg1.sweep_above = arg3;
        configured(arg1);
    }

    entry fun set_fee(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: u64, arg3: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 1000 && arg3 <= 100000000, 594);
        arg1.fee_bps = arg2;
        arg1.fee_min = arg3;
        configured(arg1);
    }

    entry fun set_floor(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 10000, 594);
        arg1.floor_bps = arg2;
        configured(arg1);
    }

    entry fun set_item(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        check_admin(arg0, arg1);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::shed_of(arg2) == arg1.shed, 595);
        let v0 = if (arg3 <= 3) {
            if (arg4 >= 1) {
                if (arg4 <= 100000000000) {
                    if (arg5 >= 1) {
                        if (arg5 <= arg6) {
                            arg6 <= 100000
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 593);
        assert!(arg7 <= 5000 && (arg8 == 0 || arg8 >= 10000 && arg8 <= 1000000), 593);
        let v1 = Item{
            base     : arg4,
            target   : arg5,
            max      : arg6,
            bid_bps  : arg7,
            ceil_bps : arg8,
        };
        *0x1::vector::borrow_mut<Item>(&mut arg1.items, (arg3 as u64)) = v1;
        note_bids(arg1, arg2);
        configured(arg1);
    }

    entry fun set_open(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.open = arg2;
        configured(arg1);
    }

    entry fun set_payee(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: address) {
        check_admin(arg0, arg1);
        arg1.payee = arg2;
        configured(arg1);
    }

    fun settle(arg0: &mut Market2, arg1: Trade, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64, u64) {
        check_version(arg0);
        let Trade {
            market : v0,
            trader : v1,
            owed   : v2,
            due    : v3,
            bought : v4,
            sold   : v5,
        } = arg1;
        assert!(v0 == 0x2::object::id<Market2>(arg0) && v1 == 0x2::tx_context::sender(arg3), 584);
        assert!(v4 | v5 != 0, 588);
        let v6 = mul_div(v2 + v3, arg0.fee_bps, 10000);
        let v7 = if (v6 > arg0.fee_min) {
            v6
        } else {
            arg0.fee_min
        };
        let v8 = v2 + v7;
        let (v9, v10) = if (v8 >= v3) {
            (v8 - v3, 0)
        } else {
            (0, v3 - v8)
        };
        if (v3 > 0) {
            assert!(arg0.paid_today + v3 <= budget_of(arg0), 591);
            let v11 = arg0.day;
            if (!0x2::table::contains<address, Spent>(&arg0.wallets, v1)) {
                let v12 = Spent{
                    day  : v11,
                    paid : 0,
                };
                0x2::table::add<address, Spent>(&mut arg0.wallets, v1, v12);
            };
            let v13 = 0x2::table::borrow_mut<address, Spent>(&mut arg0.wallets, v1);
            if (v13.day != v11) {
                v13.day = v11;
                v13.paid = 0;
            };
            assert!(v13.paid + v3 <= arg0.wallet_cap, 592);
            v13.paid = v13.paid + v3;
            arg0.paid_today = arg0.paid_today + v3;
        };
        if (v10 > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.cash) >= v10 + arg0.reserve, 590);
        };
        if (v2 > v3) {
            arg0.sold_today = arg0.sold_today + v2 - v3;
        };
        if (v9 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v9, 589);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.cash, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v9, arg3)));
        };
        let v14 = Traded{
            trader   : v1,
            owed     : v2,
            due      : v3,
            fee      : v7,
            paid_in  : v9,
            paid_out : v10,
            day      : arg0.day,
        };
        0x2::event::emit<Traded>(v14);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.cash, v10), arg3), v9, v10)
    }

    fun stock_of(arg0: &Market2, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.scrap
        } else if (arg1 == 1) {
            let v1 = VialKey{kind: 1};
            if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v1)) {
                0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v1))
            } else {
                0
            }
        } else if (arg1 == 2) {
            let v2 = VialKey{kind: 2};
            if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v2)) {
                0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v2))
            } else {
                0
            }
        } else {
            let v3 = VialKey{kind: 3};
            if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v3)) {
                0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v3))
            } else {
                0
            }
        }
    }

    entry fun sweep(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.cash);
        if (v0 <= arg1.sweep_above) {
            return
        };
        let v1 = v0 - arg1.sweep_above;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.cash, v1), arg2), arg1.payee);
        let v2 = Swept{
            sui  : v1,
            to   : arg1.payee,
            left : 0x2::balance::value<0x2::sui::SUI>(&arg1.cash),
        };
        0x2::event::emit<Swept>(v2);
    }

    public fun terms(arg0: &Market2) : (bool, address, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.open, arg0.payee, arg0.fee_bps, arg0.fee_min, arg0.floor_bps, arg0.budget_base, arg0.budget_bps, arg0.wallet_cap, arg0.reserve, arg0.sweep_above)
    }

    fun top_bid(arg0: &Market2, arg1: u8) : u64 {
        let v0 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        v0.base * v0.bid_bps / 10000
    }

    fun unit_ask(arg0: &Item, arg1: u64) : u64 {
        if (arg1 >= arg0.target) {
            return arg0.base
        };
        let v0 = (arg0.base * arg0.target + arg1 - 1) / arg1;
        if (arg0.ceil_bps == 0) {
            return v0
        };
        let v1 = arg0.base * arg0.ceil_bps / 10000;
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    fun unit_bid(arg0: &Item, arg1: u64, arg2: u64) : u64 {
        if (arg2 < arg0.target || arg0.max <= arg0.target) {
            return arg0.base * arg0.bid_bps / 10000
        };
        let v0 = (arg0.max - arg2) * 10000 / (arg0.max - arg0.target);
        let v1 = if (v0 > arg1) {
            v0
        } else {
            arg1
        };
        arg0.base * arg0.bid_bps / 10000 * v1 / 10000
    }

    public fun wallet_left(arg0: &Market2, arg1: address, arg2: u64) : u64 {
        let v0 = if (0x2::table::contains<address, Spent>(&arg0.wallets, arg1)) {
            let v1 = 0x2::table::borrow<address, Spent>(&arg0.wallets, arg1);
            if (v1.day == arg2 / 86400000) {
                v1.paid
            } else {
                0
            }
        } else {
            0
        };
        if (arg0.wallet_cap > v0) {
            arg0.wallet_cap - v0
        } else {
            0
        }
    }

    entry fun withdraw(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market2, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg1);
        let v0 = arg1.payee;
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.cash, arg3), arg8), v0);
        };
        if (arg4 > 0) {
            assert!(arg1.scrap >= arg4, 585);
            arg1.scrap = arg1.scrap - arg4;
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg2, v0, arg4);
        };
        if (arg5 > 0) {
            let v1 = VialKey{kind: 1};
            assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg1.id, v1), 585);
            let v2 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg1.id, v1);
            assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(v2) >= arg5, 585);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_poison(v2, arg5, arg8), v0);
        };
        if (arg6 > 0) {
            let v3 = VialKey{kind: 2};
            assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg1.id, v3), 585);
            let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg1.id, v3);
            assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(v4) >= arg6, 585);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_remedy(v4, arg6, arg8), v0);
        };
        if (arg7 > 0) {
            let v5 = VialKey{kind: 3};
            assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg1.id, v5), 585);
            let v6 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg1.id, v5);
            assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(v6) >= arg7, 585);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_elixir(v6, arg7, arg8), v0);
        };
        let v7 = Stocked{
            kind  : 255,
            units : arg4 + arg5 + arg6 + arg7,
            sui   : arg3,
            by    : v0,
            out   : true,
        };
        0x2::event::emit<Stocked>(v7);
    }

    // decompiled from Move bytecode v7
}

