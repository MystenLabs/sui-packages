module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::market {
    struct Item has copy, drop, store {
        base: u64,
        target: u64,
        max: u64,
    }

    struct Market has key {
        id: 0x2::object::UID,
        version: u64,
        shed: 0x2::object::ID,
        open: bool,
        fee: u64,
        payee: address,
        bid_bps: u64,
        items: vector<Item>,
        scrap: u64,
        cash: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MarketKey has copy, drop, store {
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
    }

    struct Stocked has copy, drop {
        kind: u8,
        units: u64,
        sui: u64,
        by: address,
        out: bool,
    }

    struct MarketConfigured has copy, drop {
        market: 0x2::object::ID,
        open: bool,
        fee: u64,
        payee: address,
        bid_bps: u64,
        items: vector<Item>,
    }

    fun ask(arg0: &Market, arg1: u8, arg2: u64, arg3: u64) : u64 {
        assert!(arg0.open, 563);
        assert!(arg3 >= 1 && arg3 <= 1000, 567);
        assert!(arg2 >= arg3, 565);
        let v0 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg3) {
            let v3 = arg2 - v2;
            let v4 = if (v3 >= v0.target) {
                v0.base
            } else {
                (v0.base * v0.target + v3 - 1) / v3
            };
            v1 = v1 + v4;
            v2 = v2 + 1;
        };
        v1
    }

    fun bid(arg0: &Market, arg1: u8, arg2: u64, arg3: u64) : u64 {
        assert!(arg0.open, 563);
        assert!(arg3 >= 1 && arg3 <= 1000, 567);
        let v0 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        assert!(arg2 + arg3 <= v0.max, 566);
        arg3 * v0.base * arg0.bid_bps / 10000
    }

    public fun buy_elixir(arg0: &mut Market, arg1: &mut Trade, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir {
        let v0 = arg0;
        let v1 = VialKey{kind: 3};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&v0.id, v1))
        } else {
            0
        };
        note(arg1, arg0, 3, arg2, ask(arg0, 3, v2, arg2), true, v2 - arg2);
        let v3 = VialKey{kind: 3};
        assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg0.id, v3), 565);
        let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg0.id, v3);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(v4) >= arg2, 565);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_elixir(v4, arg2, arg3)
    }

    public fun buy_poison(arg0: &mut Market, arg1: &mut Trade, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison {
        let v0 = arg0;
        let v1 = VialKey{kind: 1};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&v0.id, v1))
        } else {
            0
        };
        note(arg1, arg0, 1, arg2, ask(arg0, 1, v2, arg2), true, v2 - arg2);
        let v3 = VialKey{kind: 1};
        assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg0.id, v3), 565);
        let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg0.id, v3);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(v4) >= arg2, 565);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_poison(v4, arg2, arg3)
    }

    public fun buy_remedy(arg0: &mut Market, arg1: &mut Trade, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy {
        let v0 = arg0;
        let v1 = VialKey{kind: 2};
        let v2 = if (0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v0.id, v1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(0x2::dynamic_object_field::borrow<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&v0.id, v1))
        } else {
            0
        };
        note(arg1, arg0, 2, arg2, ask(arg0, 2, v2, arg2), true, v2 - arg2);
        let v3 = VialKey{kind: 2};
        assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg0.id, v3), 565);
        let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg0.id, v3);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(v4) >= arg2, 565);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_remedy(v4, arg2, arg3)
    }

    public fun buy_scrap(arg0: &mut Market, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut Trade, arg3: u64) {
        arg0.scrap = arg0.scrap - arg3;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg1, arg2.trader, arg3);
        note(arg2, arg0, 0, arg3, ask(arg0, 0, arg0.scrap, arg3), true, arg0.scrap);
    }

    fun check_admin(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &Market) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == arg1.shed, 561);
        assert!(arg1.version == 1, 560);
    }

    public fun close_trade(arg0: &mut Market, arg1: Trade, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, _, _) = settle(arg0, arg1, arg2, arg3);
        v0
    }

    public fun close_trade_bounded(arg0: &mut Market, arg1: Trade, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2) = settle(arg0, arg1, arg2, arg5);
        assert!(v1 <= arg3 && v2 >= arg4, 569);
        v0
    }

    fun configured(arg0: &Market) {
        let v0 = MarketConfigured{
            market  : 0x2::object::id<Market>(arg0),
            open    : arg0.open,
            fee     : arg0.fee,
            payee   : arg0.payee,
            bid_bps : arg0.bid_bps,
            items   : arg0.items,
        };
        0x2::event::emit<MarketConfigured>(v0);
    }

    fun count(arg0: u8) : u64 {
        let v0 = 0;
        while (arg0 > 0) {
            v0 = v0 + ((arg0 & 1) as u64);
            arg0 = arg0 >> 1;
        };
        v0
    }

    public fun deposit_elixir(arg0: &mut Market, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir, arg2: &0x2::tx_context::TxContext) {
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

    public fun deposit_poison(arg0: &mut Market, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg2: &0x2::tx_context::TxContext) {
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

    public fun deposit_remedy(arg0: &mut Market, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg2: &0x2::tx_context::TxContext) {
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

    public fun deposit_scrap(arg0: &mut Market, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
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

    public fun deposit_sui(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
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

    public fun holdings(arg0: &Market) : (bool, u64, u64, u64, u64, u64) {
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

    public fun market_id(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg0);
        let v1 = MarketKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MarketKey>(v0, v1)) {
            let v3 = MarketKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<MarketKey, 0x2::object::ID>(v0, v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun note(arg0: &mut Trade, arg1: &Market, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        assert!(arg0.market == 0x2::object::id<Market>(arg1), 564);
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

    entry fun open_market(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 561);
        let v0 = MarketKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MarketKey>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg1), v0), 562);
        let v1 = Item{
            base   : 10000000,
            target : 200,
            max    : 5000,
        };
        let v2 = Item{
            base   : 100000000,
            target : 100,
            max    : 2000,
        };
        let v3 = Item{
            base   : 50000000,
            target : 100,
            max    : 2000,
        };
        let v4 = Item{
            base   : 15000000000,
            target : 10,
            max    : 20,
        };
        let v5 = 0x1::vector::empty<Item>();
        let v6 = &mut v5;
        0x1::vector::push_back<Item>(v6, v1);
        0x1::vector::push_back<Item>(v6, v2);
        0x1::vector::push_back<Item>(v6, v3);
        0x1::vector::push_back<Item>(v6, v4);
        let v7 = Market{
            id      : 0x2::object::new(arg3),
            version : 1,
            shed    : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1),
            open    : false,
            fee     : 50000000,
            payee   : arg2,
            bid_bps : 4500,
            items   : v5,
            scrap   : 0,
            cash    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v8 = MarketKey{dummy_field: false};
        0x2::dynamic_field::add<MarketKey, 0x2::object::ID>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid_mut(arg1), v8, 0x2::object::id<Market>(&v7));
        configured(&v7);
        0x2::transfer::share_object<Market>(v7);
    }

    public fun open_trade(arg0: &Market, arg1: &0x2::tx_context::TxContext) : Trade {
        assert!(arg0.version == 1, 560);
        assert!(arg0.open, 563);
        Trade{
            market : 0x2::object::id<Market>(arg0),
            trader : 0x2::tx_context::sender(arg1),
            owed   : 0,
            due    : 0,
            bought : 0,
            sold   : 0,
        }
    }

    public fun quote(arg0: &Market, arg1: u8, arg2: u64) : (u64, u64) {
        let v0 = if (arg1 == 0) {
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
        };
        let v4 = 0x1::vector::borrow<Item>(&arg0.items, (arg1 as u64));
        let v5 = if (arg2 >= 1) {
            if (arg2 <= 1000) {
                v0 >= arg2
            } else {
                false
            }
        } else {
            false
        };
        let v6 = if (v5) {
            let v7 = 0;
            let v8 = 0;
            while (v8 < arg2) {
                let v9 = v0 - v8;
                let v10 = if (v9 >= v4.target) {
                    v4.base
                } else {
                    (v4.base * v4.target + v9 - 1) / v9
                };
                v7 = v7 + v10;
                v8 = v8 + 1;
            };
            v7
        } else {
            0
        };
        let v11 = if (arg2 >= 1) {
            if (arg2 <= 1000) {
                v0 + arg2 <= v4.max
            } else {
                false
            }
        } else {
            false
        };
        let v12 = if (v11) {
            arg2 * v4.base * arg0.bid_bps / 10000
        } else {
            0
        };
        (v6, v12)
    }

    public fun sell_elixir(arg0: &mut Market, arg1: &mut Trade, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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

    public fun sell_poison(arg0: &mut Market, arg1: &mut Trade, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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

    public fun sell_remedy(arg0: &mut Market, arg1: &mut Trade, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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

    public fun sell_scrap(arg0: &mut Market, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut Trade, arg3: u64) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::spend_scrap(arg1, arg2.trader, arg3);
        arg0.scrap = arg0.scrap + arg3;
        note(arg2, arg0, 0, arg3, bid(arg0, 0, arg0.scrap, arg3), false, arg0.scrap);
    }

    entry fun set_item(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        check_admin(arg0, arg1);
        let v0 = if (arg2 <= 3) {
            if (arg3 > 0) {
                if (arg3 <= 100000000000) {
                    if (arg4 >= 1) {
                        if (arg4 <= arg5) {
                            arg5 <= 100000
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
        assert!(v0, 571);
        let v1 = Item{
            base   : arg3,
            target : arg4,
            max    : arg5,
        };
        *0x1::vector::borrow_mut<Item>(&mut arg1.items, (arg2 as u64)) = v1;
        configured(arg1);
    }

    entry fun set_open(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.open = arg2;
        configured(arg1);
    }

    entry fun set_terms(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market, arg2: u64, arg3: u64, arg4: address) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 500000000 && arg3 <= 5000, 571);
        arg1.fee = arg2;
        arg1.bid_bps = arg3;
        arg1.payee = arg4;
        configured(arg1);
    }

    fun settle(arg0: &mut Market, arg1: Trade, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64, u64) {
        let Trade {
            market : v0,
            trader : v1,
            owed   : v2,
            due    : v3,
            bought : v4,
            sold   : v5,
        } = arg1;
        assert!(v0 == 0x2::object::id<Market>(arg0) && v1 == 0x2::tx_context::sender(arg3), 564);
        let v6 = max(max(count(v4), count(v5)), 0);
        assert!(v6 > 0, 568);
        let v7 = arg0.fee * v6;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.cash) + v2 >= v3, 570);
        let v8 = v2 + v7;
        let (v9, v10) = if (v8 >= v3) {
            (v8 - v3, 0)
        } else {
            (0, v3 - v8)
        };
        if (v9 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v9, 569);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.cash, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v9, arg3)));
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.cash, v7), arg3), arg0.payee);
        };
        let v11 = Traded{
            trader   : v1,
            owed     : v2,
            due      : v3,
            fee      : v7,
            paid_in  : v9,
            paid_out : v10,
        };
        0x2::event::emit<Traded>(v11);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.cash, v10), arg3), v9, v10)
    }

    entry fun withdraw(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Market, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg1);
        let v0 = arg1.payee;
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.cash, arg3), arg8), v0);
        };
        if (arg4 > 0) {
            assert!(arg1.scrap >= arg4, 565);
            arg1.scrap = arg1.scrap - arg4;
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg2, v0, arg4);
        };
        if (arg5 > 0) {
            let v1 = VialKey{kind: 1};
            assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&arg1.id, v1), 565);
            let v2 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(&mut arg1.id, v1);
            assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(v2) >= arg5, 565);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_poison(v2, arg5, arg8), v0);
        };
        if (arg6 > 0) {
            let v3 = VialKey{kind: 2};
            assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&arg1.id, v3), 565);
            let v4 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(&mut arg1.id, v3);
            assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(v4) >= arg6, 565);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::split_remedy(v4, arg6, arg8), v0);
        };
        if (arg7 > 0) {
            let v5 = VialKey{kind: 3};
            assert!(0x2::dynamic_object_field::exists_with_type<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&arg1.id, v5), 565);
            let v6 = 0x2::dynamic_object_field::borrow_mut<VialKey, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(&mut arg1.id, v5);
            assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::elixir_doses(v6) >= arg7, 565);
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

