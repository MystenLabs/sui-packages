module 0xd2ae1b3bef7929691ab3987903ffe61fe4e38f9fb3f25cbd63028b4c4e945f2d::trading_post {
    struct Ext has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        allowed: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        fee_type: 0x1::type_name::TypeName,
        fee: u64,
        fee_recipient: address,
        min_ttl_ms: u64,
        max_ttl_ms: u64,
    }

    struct ItemKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct CapKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct CoinKey has copy, drop, store {
        t: 0x1::type_name::TypeName,
    }

    struct FeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Trade has key {
        id: 0x2::object::UID,
        maker: address,
        taker: address,
        escrow: 0x2::bag::Bag,
        escrow_count: u64,
        give_items: vector<0x2::object::ID>,
        give_caps: vector<0x2::object::ID>,
        give_coins: vector<0x1::type_name::TypeName>,
        want_items: vector<0x2::object::ID>,
        want_caps: vector<0x2::object::ID>,
        want_coins: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fee: u64,
        fee_type: 0x1::type_name::TypeName,
        fee_recipient: address,
        created_ms: u64,
        expires_ms: u64,
        status: u8,
    }

    struct Settlement {
        trade_id: 0x2::object::ID,
        want_items: 0x2::vec_set::VecSet<0x2::object::ID>,
        want_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        want_coins: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Unwind {
        trade_id: 0x2::object::ID,
        status: u8,
        by: address,
    }

    struct Proposed has copy, drop {
        trade_id: 0x2::object::ID,
        maker: address,
        taker: address,
        give_items: vector<0x2::object::ID>,
        give_item_types: vector<0x1::type_name::TypeName>,
        give_caps: vector<0x2::object::ID>,
        give_cap_types: vector<0x1::type_name::TypeName>,
        give_coin_types: vector<0x1::type_name::TypeName>,
        give_coin_amounts: vector<u64>,
        want_items: vector<0x2::object::ID>,
        want_item_types: vector<0x1::type_name::TypeName>,
        want_caps: vector<0x2::object::ID>,
        want_cap_types: vector<0x1::type_name::TypeName>,
        want_coin_types: vector<0x1::type_name::TypeName>,
        want_coin_amounts: vector<u64>,
        fee: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct Accepted has copy, drop {
        trade_id: 0x2::object::ID,
        maker: address,
        taker: address,
        fee: u64,
    }

    struct Closed has copy, drop {
        trade_id: 0x2::object::ID,
        maker: address,
        taker: address,
        status: u8,
        by: address,
    }

    struct DraftTypes has drop, store {
        give_item_types: vector<0x1::type_name::TypeName>,
        give_cap_types: vector<0x1::type_name::TypeName>,
        give_coin_amounts: vector<u64>,
        want_item_types: vector<0x1::type_name::TypeName>,
        want_cap_types: vector<0x1::type_name::TypeName>,
    }

    struct DraftKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: &Registry, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Trade {
        assert!(arg1 != 0x2::tx_context::sender(arg5), 15);
        assert!(0x1::type_name::get<T0>() == arg0.fee_type && 0x2::coin::value<T0>(&arg2) == arg0.fee, 7);
        assert!(arg3 >= arg0.min_ttl_ms && arg3 <= arg0.max_ttl_ms, 14);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::bag::new(arg5);
        let v2 = FeeKey{dummy_field: false};
        0x2::bag::add<FeeKey, 0x2::balance::Balance<T0>>(&mut v1, v2, 0x2::coin::into_balance<T0>(arg2));
        let v3 = Trade{
            id            : 0x2::object::new(arg5),
            maker         : 0x2::tx_context::sender(arg5),
            taker         : arg1,
            escrow        : v1,
            escrow_count  : 0,
            give_items    : 0x1::vector::empty<0x2::object::ID>(),
            give_caps     : 0x1::vector::empty<0x2::object::ID>(),
            give_coins    : 0x1::vector::empty<0x1::type_name::TypeName>(),
            want_items    : 0x1::vector::empty<0x2::object::ID>(),
            want_caps     : 0x1::vector::empty<0x2::object::ID>(),
            want_coins    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            fee           : arg0.fee,
            fee_type      : arg0.fee_type,
            fee_recipient : arg0.fee_recipient,
            created_ms    : v0,
            expires_ms    : v0 + arg3,
            status        : 0,
        };
        let v4 = DraftKey{dummy_field: false};
        let v5 = DraftTypes{
            give_item_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            give_cap_types    : 0x1::vector::empty<0x1::type_name::TypeName>(),
            give_coin_amounts : vector[],
            want_item_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            want_cap_types    : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<DraftKey, DraftTypes>(&mut v3.id, v4, v5);
        v3
    }

    public fun is_installed(arg0: &0x2::kiosk::Kiosk) : bool {
        0x2::kiosk_extension::is_installed<Ext>(arg0) && 0x2::kiosk_extension::is_enabled<Ext>(arg0)
    }

    public fun accept_begin(arg0: &mut Trade, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Settlement {
        assert!(arg0.status == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.taker, 2);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_ms, 5);
        let v0 = 0x2::vec_set::empty<0x2::object::ID>();
        let v1 = &arg0.want_items;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(v1, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::vec_set::empty<0x2::object::ID>();
        let v4 = &arg0.want_caps;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v3, *0x1::vector::borrow<0x2::object::ID>(v4, v5));
            v5 = v5 + 1;
        };
        Settlement{
            trade_id   : 0x2::object::id<Trade>(arg0),
            want_items : v0,
            want_caps  : v3,
            want_coins : arg0.want_coins,
        }
    }

    public fun accept_finish<T0>(arg0: &mut Trade, arg1: Settlement, arg2: &mut 0x2::tx_context::TxContext) {
        check(arg0, &arg1);
        let Settlement {
            trade_id   : _,
            want_items : v1,
            want_caps  : v2,
            want_coins : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (0x2::vec_set::is_empty<0x2::object::ID>(&v6)) {
            if (0x2::vec_set::is_empty<0x2::object::ID>(&v5)) {
                0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&v4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 10);
        assert!(arg0.escrow_count == 0, 11);
        assert!(0x1::type_name::get<T0>() == arg0.fee_type, 7);
        let v8 = FeeKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<FeeKey, 0x2::balance::Balance<T0>>(&mut arg0.escrow, v8), arg2), arg0.fee_recipient);
        arg0.status = 1;
        let v9 = Accepted{
            trade_id : 0x2::object::id<Trade>(arg0),
            maker    : arg0.maker,
            taker    : arg0.taker,
            fee      : arg0.fee,
        };
        0x2::event::emit<Accepted>(v9);
    }

    public fun allow<T0>(arg0: &AdminCap, arg1: &mut Registry) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.allowed, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.allowed, v0);
        };
    }

    public fun cancel_begin(arg0: &Trade, arg1: &0x2::tx_context::TxContext) : Unwind {
        assert!(arg0.status == 0, 4);
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 3);
        Unwind{
            trade_id : 0x2::object::id<Trade>(arg0),
            status   : 3,
            by       : 0x2::tx_context::sender(arg1),
        }
    }

    fun check(arg0: &Trade, arg1: &Settlement) {
        assert!(0x2::object::id<Trade>(arg0) == arg1.trade_id, 4);
    }

    public fun decline_begin(arg0: &Trade, arg1: &0x2::tx_context::TxContext) : Unwind {
        assert!(arg0.status == 0, 4);
        assert!(0x2::tx_context::sender(arg1) == arg0.taker, 2);
        Unwind{
            trade_id : 0x2::object::id<Trade>(arg0),
            status   : 2,
            by       : 0x2::tx_context::sender(arg1),
        }
    }

    public fun deliver_coin<T0>(arg0: &Trade, arg1: &mut Settlement, arg2: 0x2::coin::Coin<T0>) {
        check(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.want_coins, &v0), 8);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.want_coins, &v0);
        assert!(0x2::coin::value<T0>(&arg2) >= v2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.maker);
    }

    public fun deliver_item<T0: store + key>(arg0: &Trade, arg1: &mut Settlement, arg2: T0) {
        check(arg0, arg1);
        let v0 = 0x2::object::id<T0>(&arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.want_items, &v0), 8);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.want_items, &v0);
        0x2::transfer::public_transfer<T0>(arg2, arg0.maker);
    }

    public fun deliver_locked<T0: store + key>(arg0: &Trade, arg1: &mut Settlement, arg2: &mut 0x2::kiosk::Kiosk, arg3: T0, arg4: &0x2::transfer_policy::TransferPolicy<T0>) {
        check(arg0, arg1);
        assert!(0x2::kiosk::owner(arg2) == arg0.maker, 12);
        let v0 = 0x2::object::id<T0>(&arg3);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.want_caps, &v0), 8);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.want_caps, &v0);
        let v1 = Ext{dummy_field: false};
        0x2::kiosk_extension::lock<Ext, T0>(v1, arg2, arg3, arg4);
    }

    public fun disallow<T0>(arg0: &AdminCap, arg1: &mut Registry) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.allowed, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.allowed, &v0);
        };
    }

    fun draft(arg0: &mut Trade) : &mut DraftTypes {
        let v0 = DraftKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DraftKey, DraftTypes>(&mut arg0.id, v0)
    }

    public fun escrow_count(arg0: &Trade) : u64 {
        arg0.escrow_count
    }

    public fun expire_begin(arg0: &Trade, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Unwind {
        assert!(arg0.status == 0, 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 6);
        Unwind{
            trade_id : 0x2::object::id<Trade>(arg0),
            status   : 4,
            by       : 0x2::tx_context::sender(arg2),
        }
    }

    public fun expires_ms(arg0: &Trade) : u64 {
        arg0.expires_ms
    }

    public fun fee(arg0: &Registry) : u64 {
        arg0.fee
    }

    public fun fee_recipient(arg0: &Registry) : address {
        arg0.fee_recipient
    }

    public fun give_cap<T0: store + key>(arg0: &Registry, arg1: &mut Trade, arg2: 0x2::kiosk::PurchaseCap<T0>) {
        assert!(is_allowed<T0>(arg0), 1);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg2) == 0, 13);
        let v0 = 0x2::kiosk::purchase_cap_item<T0>(&arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.give_caps, &v0), 17);
        let v1 = CapKey{id: v0};
        0x2::bag::add<CapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.escrow, v1, arg2);
        arg1.escrow_count = arg1.escrow_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.give_caps, v0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut draft(arg1).give_cap_types, 0x1::type_name::get<T0>());
    }

    public fun give_coin<T0>(arg0: &Registry, arg1: &mut Trade, arg2: 0x2::coin::Coin<T0>) {
        assert!(is_allowed<T0>(arg0), 1);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 16);
        let v0 = CoinKey{t: 0x1::type_name::get<T0>()};
        if (0x2::bag::contains<CoinKey>(&arg1.escrow, v0)) {
            let v1 = 0x2::bag::borrow_mut<CoinKey, 0x2::balance::Balance<T0>>(&mut arg1.escrow, v0);
            0x2::balance::join<T0>(v1, 0x2::coin::into_balance<T0>(arg2));
            let v2 = 0x2::balance::value<T0>(v1);
            let (v3, v4) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.give_coins, &v0.t);
            assert!(v3, 18);
            *0x1::vector::borrow_mut<u64>(&mut draft(arg1).give_coin_amounts, v4) = v2;
        } else {
            0x2::bag::add<CoinKey, 0x2::balance::Balance<T0>>(&mut arg1.escrow, v0, 0x2::coin::into_balance<T0>(arg2));
            arg1.escrow_count = arg1.escrow_count + 1;
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.give_coins, v0.t);
            0x1::vector::push_back<u64>(&mut draft(arg1).give_coin_amounts, 0x2::coin::value<T0>(&arg2));
        };
    }

    public fun give_item<T0: store + key>(arg0: &Registry, arg1: &mut Trade, arg2: T0) {
        assert!(is_allowed<T0>(arg0), 1);
        let v0 = 0x2::object::id<T0>(&arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.give_items, &v0), 17);
        let v1 = ItemKey{id: v0};
        0x2::bag::add<ItemKey, T0>(&mut arg1.escrow, v1, arg2);
        arg1.escrow_count = arg1.escrow_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.give_items, v0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut draft(arg1).give_item_types, 0x1::type_name::get<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id            : 0x2::object::new(arg0),
            allowed       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            fee_type      : 0x1::type_name::get<0x2::sui::SUI>(),
            fee           : 0,
            fee_recipient : 0x2::tx_context::sender(arg0),
            min_ttl_ms    : 3600000,
            max_ttl_ms    : 2592000000,
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun install(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Ext{dummy_field: false};
        0x2::kiosk_extension::add<Ext>(v0, arg0, arg1, 2, arg2);
    }

    public fun is_allowed<T0>(arg0: &Registry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed, &v0)
    }

    public fun maker(arg0: &Trade) : address {
        arg0.maker
    }

    public fun publish(arg0: Trade, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.maker == 0x2::tx_context::sender(arg1), 3);
        assert!(arg0.escrow_count > 0, 16);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.want_items) + 0x1::vector::length<0x2::object::ID>(&arg0.want_caps) + 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&arg0.want_coins) > 0, 16);
        let v0 = DraftKey{dummy_field: false};
        let DraftTypes {
            give_item_types   : v1,
            give_cap_types    : v2,
            give_coin_amounts : v3,
            want_item_types   : v4,
            want_cap_types    : v5,
        } = 0x2::dynamic_field::remove<DraftKey, DraftTypes>(&mut arg0.id, v0);
        let (v6, v7) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, u64>(arg0.want_coins);
        let v8 = Proposed{
            trade_id          : 0x2::object::id<Trade>(&arg0),
            maker             : arg0.maker,
            taker             : arg0.taker,
            give_items        : arg0.give_items,
            give_item_types   : v1,
            give_caps         : arg0.give_caps,
            give_cap_types    : v2,
            give_coin_types   : arg0.give_coins,
            give_coin_amounts : v3,
            want_items        : arg0.want_items,
            want_item_types   : v4,
            want_caps         : arg0.want_caps,
            want_cap_types    : v5,
            want_coin_types   : v6,
            want_coin_amounts : v7,
            fee               : arg0.fee,
            created_ms        : arg0.created_ms,
            expires_ms        : arg0.expires_ms,
        };
        0x2::event::emit<Proposed>(v8);
        0x2::transfer::share_object<Trade>(arg0);
    }

    public fun refund_cap<T0: store + key>(arg0: &mut Trade, arg1: &Unwind, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk) {
        ucheck(arg0, arg1);
        let v0 = CapKey{id: arg2};
        assert!(0x2::bag::contains<CapKey>(&arg0.escrow, v0), 18);
        arg0.escrow_count = arg0.escrow_count - 1;
        let v1 = CapKey{id: arg2};
        0x2::kiosk::return_purchase_cap<T0>(arg3, 0x2::bag::remove<CapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.escrow, v1));
    }

    public fun refund_coin<T0>(arg0: &mut Trade, arg1: &Unwind, arg2: &mut 0x2::tx_context::TxContext) {
        ucheck(arg0, arg1);
        let v0 = CoinKey{t: 0x1::type_name::get<T0>()};
        assert!(0x2::bag::contains<CoinKey>(&arg0.escrow, v0), 18);
        arg0.escrow_count = arg0.escrow_count - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<CoinKey, 0x2::balance::Balance<T0>>(&mut arg0.escrow, v0), arg2), arg0.maker);
    }

    public fun refund_item<T0: store + key>(arg0: &mut Trade, arg1: &Unwind, arg2: 0x2::object::ID) {
        ucheck(arg0, arg1);
        let v0 = ItemKey{id: arg2};
        assert!(0x2::bag::contains<ItemKey>(&arg0.escrow, v0), 18);
        arg0.escrow_count = arg0.escrow_count - 1;
        let v1 = ItemKey{id: arg2};
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<ItemKey, T0>(&mut arg0.escrow, v1), arg0.maker);
    }

    public fun set_fee<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: address) {
        arg1.fee_type = 0x1::type_name::get<T0>();
        arg1.fee = arg2;
        arg1.fee_recipient = arg3;
    }

    public fun set_ttl(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 14);
        arg1.min_ttl_ms = arg2;
        arg1.max_ttl_ms = arg3;
    }

    public fun status(arg0: &Trade) : u8 {
        arg0.status
    }

    public fun take_cap<T0: store + key>(arg0: &mut Trade, arg1: &Settlement, arg2: 0x2::object::ID) : 0x2::kiosk::PurchaseCap<T0> {
        check(arg0, arg1);
        let v0 = CapKey{id: arg2};
        assert!(0x2::bag::contains<CapKey>(&arg0.escrow, v0), 18);
        arg0.escrow_count = arg0.escrow_count - 1;
        let v1 = CapKey{id: arg2};
        0x2::bag::remove<CapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.escrow, v1)
    }

    public fun take_coin<T0>(arg0: &mut Trade, arg1: &Settlement, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check(arg0, arg1);
        let v0 = CoinKey{t: 0x1::type_name::get<T0>()};
        assert!(0x2::bag::contains<CoinKey>(&arg0.escrow, v0), 18);
        arg0.escrow_count = arg0.escrow_count - 1;
        0x2::coin::from_balance<T0>(0x2::bag::remove<CoinKey, 0x2::balance::Balance<T0>>(&mut arg0.escrow, v0), arg2)
    }

    public fun take_item<T0: store + key>(arg0: &mut Trade, arg1: &Settlement, arg2: 0x2::object::ID) : T0 {
        check(arg0, arg1);
        let v0 = ItemKey{id: arg2};
        assert!(0x2::bag::contains<ItemKey>(&arg0.escrow, v0), 18);
        arg0.escrow_count = arg0.escrow_count - 1;
        let v1 = ItemKey{id: arg2};
        0x2::bag::remove<ItemKey, T0>(&mut arg0.escrow, v1)
    }

    public fun taker(arg0: &Trade) : address {
        arg0.taker
    }

    fun ucheck(arg0: &Trade, arg1: &Unwind) {
        assert!(0x2::object::id<Trade>(arg0) == arg1.trade_id, 4);
    }

    public fun unwind_finish<T0>(arg0: &mut Trade, arg1: Unwind, arg2: &mut 0x2::tx_context::TxContext) {
        ucheck(arg0, &arg1);
        let Unwind {
            trade_id : _,
            status   : v1,
            by       : v2,
        } = arg1;
        assert!(arg0.escrow_count == 0, 11);
        assert!(0x1::type_name::get<T0>() == arg0.fee_type, 7);
        let v3 = FeeKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<FeeKey, 0x2::balance::Balance<T0>>(&mut arg0.escrow, v3), arg2), arg0.maker);
        arg0.status = v1;
        let v4 = Closed{
            trade_id : 0x2::object::id<Trade>(arg0),
            maker    : arg0.maker,
            taker    : arg0.taker,
            status   : v1,
            by       : v2,
        };
        0x2::event::emit<Closed>(v4);
    }

    public fun want_cap<T0>(arg0: &Registry, arg1: &mut Trade, arg2: 0x2::object::ID) {
        assert!(is_allowed<T0>(arg0), 1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.want_items, &arg2) && !0x1::vector::contains<0x2::object::ID>(&arg1.want_caps, &arg2), 17);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.want_caps, arg2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut draft(arg1).want_cap_types, 0x1::type_name::get<T0>());
    }

    public fun want_coin<T0>(arg0: &Registry, arg1: &mut Trade, arg2: u64) {
        assert!(is_allowed<T0>(arg0), 1);
        assert!(arg2 > 0, 16);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.want_coins, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.want_coins, &v0);
            *v1 = *v1 + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.want_coins, v0, arg2);
        };
    }

    public fun want_item<T0>(arg0: &Registry, arg1: &mut Trade, arg2: 0x2::object::ID) {
        assert!(is_allowed<T0>(arg0), 1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.want_items, &arg2) && !0x1::vector::contains<0x2::object::ID>(&arg1.want_caps, &arg2), 17);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.want_items, arg2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut draft(arg1).want_item_types, 0x1::type_name::get<T0>());
    }

    // decompiled from Move bytecode v7
}

