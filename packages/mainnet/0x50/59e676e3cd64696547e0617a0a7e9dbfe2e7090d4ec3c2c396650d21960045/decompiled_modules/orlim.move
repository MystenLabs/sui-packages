module 0x5059e676e3cd64696547e0617a0a7e9dbfe2e7090d4ec3c2c396650d21960045::orlim {
    struct OrderType has copy, drop, store {
        value: u8,
    }

    struct TimeInForce has copy, drop, store {
        value: u8,
    }

    struct OrderPlacedEvent has copy, drop {
        order_id: u64,
        pool_id: vector<u8>,
        user: address,
        price: u64,
        quantity: u64,
        is_bid: bool,
        created_at: u64,
    }

    struct OrderCancelledEvent has copy, drop {
        order_id: u64,
        user: address,
        cancelled_at: u64,
    }

    struct OrderModifiedEvent has copy, drop {
        order_id: u64,
        old_price: u64,
        new_price: u64,
        old_quantity: u64,
        new_quantity: u64,
        modified_at: u64,
    }

    struct ContractPausedEvent has copy, drop {
        paused: bool,
        paused_at: u64,
        admin: address,
    }

    struct OCOOrderPlacedEvent has copy, drop {
        oco_group_id: u64,
        order_id_1: u64,
        order_id_2: u64,
        user: address,
        created_at: u64,
    }

    struct OCOOrderFilledEvent has copy, drop {
        oco_group_id: u64,
        filled_order_id: u64,
        cancelled_order_id: u64,
        user: address,
        filled_at: u64,
    }

    struct OCOOrderCancelledEvent has copy, drop {
        oco_group_id: u64,
        cancelled_order_id: u64,
        user: address,
        cancelled_at: u64,
    }

    struct TIFOrderPlacedEvent has copy, drop {
        order_id: u64,
        tif_type: u8,
        user: address,
        created_at: u64,
    }

    struct OrderPartialFilledEvent has copy, drop {
        order_id: u64,
        filled_quantity: u64,
        remaining_quantity: u64,
        user: address,
        filled_at: u64,
    }

    struct OrderExpiredEvent has copy, drop {
        order_id: u64,
        user: address,
        expired_at: u64,
    }

    struct OrderOwnershipTransferredEvent has copy, drop {
        order_id: u64,
        from: address,
        to: address,
        transferred_at: u64,
    }

    struct OrderCancelledByOwnerEvent has copy, drop {
        order_id: u64,
        owner: address,
        cancelled_at: u64,
    }

    struct OrderReceiptData has copy, drop, store {
        order_id: u64,
        deepbook_order_id: u64,
        pool_id: vector<u8>,
        price: u64,
        quantity: u64,
        original_quantity: u64,
        is_bid: bool,
        order_type: OrderType,
        time_in_force: TimeInForce,
        created_at: u64,
        is_active: bool,
        is_fully_filled: bool,
        cancelled_at: 0x1::option::Option<u64>,
        oco_group_id: 0x1::option::Option<u64>,
        expires_at: 0x1::option::Option<u64>,
    }

    struct OCOGroup has store, key {
        id: 0x2::object::UID,
        group_id: u64,
        order1_id: u64,
        order2_id: u64,
        created_at: u64,
        is_active: bool,
    }

    struct OrderReceipt has store, key {
        id: 0x2::object::UID,
        order_data: OrderReceiptData,
        owner: address,
    }

    struct OrderManager has store, key {
        id: 0x2::object::UID,
        owner: address,
        active_orders: vector<u64>,
        total_orders_created: u64,
        receipts: 0x2::table::Table<u64, OrderReceiptData>,
        oco_groups: 0x2::table::Table<u64, OCOGroup>,
        is_paused: bool,
        created_at: u64,
        deepbook_pools: 0x2::table::Table<vector<u8>, 0x2::object::UID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun cancel_limit_order(arg0: &mut OrderManager, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(0x1::vector::contains<u64>(&arg0.active_orders, &arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::table::remove<u64, OrderReceiptData>(&mut arg0.receipts, arg1);
        assert!(v1.is_active, 6);
        assert!(v0 > v1.created_at, 5);
        let v2 = v1.oco_group_id;
        if (0x1::option::is_some<u64>(&v2)) {
            let v3 = *0x1::option::borrow<u64>(&v2);
            if (0x2::table::contains<u64, OCOGroup>(&arg0.oco_groups, v3)) {
                let v4 = 0x2::table::remove<u64, OCOGroup>(&mut arg0.oco_groups, v3);
                let v5 = if (v4.order1_id == arg1) {
                    v4.order2_id
                } else {
                    v4.order1_id
                };
                v4.is_active = false;
                0x2::table::add<u64, OCOGroup>(&mut arg0.oco_groups, v3, v4);
                let v6 = v5;
                if (0x2::table::contains<u64, OrderReceiptData>(&arg0.receipts, v6)) {
                    let v7 = 0x2::table::remove<u64, OrderReceiptData>(&mut arg0.receipts, v6);
                    if (v7.is_active && 0x1::vector::contains<u64>(&arg0.active_orders, &v6)) {
                        v7.is_active = false;
                        v7.cancelled_at = 0x1::option::some<u64>(v0);
                        let v8 = 0;
                        while (v8 < 0x1::vector::length<u64>(&arg0.active_orders)) {
                            if (*0x1::vector::borrow<u64>(&arg0.active_orders, v8) == v6) {
                                0x1::vector::remove<u64>(&mut arg0.active_orders, v8);
                                break
                            };
                            v8 = v8 + 1;
                        };
                        let v9 = OCOOrderCancelledEvent{
                            oco_group_id       : v3,
                            cancelled_order_id : v6,
                            user               : arg0.owner,
                            cancelled_at       : v0,
                        };
                        0x2::event::emit<OCOOrderCancelledEvent>(v9);
                    };
                    0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v6, v7);
                };
            };
        };
        v1.is_active = false;
        v1.cancelled_at = 0x1::option::some<u64>(v0);
        0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, arg1, v1);
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&arg0.active_orders)) {
            if (*0x1::vector::borrow<u64>(&arg0.active_orders, v10) == arg1) {
                0x1::vector::remove<u64>(&mut arg0.active_orders, v10);
                break
            };
            v10 = v10 + 1;
        };
        let v11 = OrderCancelledEvent{
            order_id     : arg1,
            user         : arg0.owner,
            cancelled_at : v0,
        };
        0x2::event::emit<OrderCancelledEvent>(v11);
    }

    public entry fun cancel_limit_order_entry(arg0: &mut OrderManager, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_limit_order(arg0, arg1, arg2, arg3);
    }

    public entry fun cancel_multiple_orders_entry(arg0: &mut OrderManager, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_multiple_orders_safe(arg0, arg1, arg2, arg3);
    }

    public fun cancel_multiple_orders_safe(arg0: &mut OrderManager, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v0);
            if (0x1::vector::contains<u64>(&arg0.active_orders, &v2)) {
                if (0x2::table::borrow<u64, OrderReceiptData>(&arg0.receipts, v2).is_active) {
                    cancel_limit_order(arg0, v2, arg2, arg3);
                    0x1::vector::push_back<u64>(&mut v1, v2);
                };
            };
            v0 = v0 + 1;
        };
        while (0x1::vector::length<u64>(&arg1) > 0) {
            0x1::vector::pop_back<u64>(&mut arg1);
        };
        0x1::vector::destroy_empty<u64>(arg1);
        while (0x1::vector::length<u64>(&v1) > 0) {
            0x1::vector::pop_back<u64>(&mut v1);
        };
        0x1::vector::destroy_empty<u64>(v1);
    }

    public fun cancel_order_by_object(arg0: &mut OrderManager, arg1: OrderReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<u64>, 0x2::coin::Coin<u64>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(arg1.owner == arg0.owner, 3);
        let v0 = arg1.order_data.order_id;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = arg1.order_data;
        v2.is_active = false;
        v2.cancelled_at = 0x1::option::some<u64>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg0.active_orders)) {
            if (*0x1::vector::borrow<u64>(&arg0.active_orders, v3) == v0) {
                0x1::vector::remove<u64>(&mut arg0.active_orders, v3);
                break
            };
            v3 = v3 + 1;
        };
        if (0x1::option::is_some<u64>(&v2.oco_group_id)) {
            let v4 = *0x1::option::borrow<u64>(&v2.oco_group_id);
            if (0x2::table::contains<u64, OCOGroup>(&arg0.oco_groups, v4)) {
                let v5 = 0x2::table::borrow_mut<u64, OCOGroup>(&mut arg0.oco_groups, v4);
                if (v5.is_active) {
                    let v6 = if (v5.order1_id == v0) {
                        v5.order2_id
                    } else {
                        v5.order1_id
                    };
                    if (0x2::table::contains<u64, OrderReceiptData>(&arg0.receipts, v6)) {
                        let v7 = 0x2::table::remove<u64, OrderReceiptData>(&mut arg0.receipts, v6);
                        if (v7.is_active) {
                            v7.is_active = false;
                            v7.cancelled_at = 0x1::option::some<u64>(v1);
                            let v8 = 0;
                            while (v8 < 0x1::vector::length<u64>(&arg0.active_orders)) {
                                if (*0x1::vector::borrow<u64>(&arg0.active_orders, v8) == v6) {
                                    0x1::vector::remove<u64>(&mut arg0.active_orders, v8);
                                    break
                                };
                                v8 = v8 + 1;
                            };
                            let v9 = OCOOrderCancelledEvent{
                                oco_group_id       : v4,
                                cancelled_order_id : v6,
                                user               : arg0.owner,
                                cancelled_at       : v1,
                            };
                            0x2::event::emit<OCOOrderCancelledEvent>(v9);
                        };
                        0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v6, v7);
                    };
                };
                let v10 = 0x2::table::remove<u64, OCOGroup>(&mut arg0.oco_groups, v4);
                v10.is_active = false;
                0x2::table::add<u64, OCOGroup>(&mut arg0.oco_groups, v4, v10);
            };
        };
        0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v0, v2);
        let v11 = OrderCancelledByOwnerEvent{
            order_id     : v0,
            owner        : arg0.owner,
            cancelled_at : v1,
        };
        0x2::event::emit<OrderCancelledByOwnerEvent>(v11);
        let OrderReceipt {
            id         : v12,
            order_data : _,
            owner      : _,
        } = arg1;
        0x2::object::delete(v12);
        (0x2::coin::zero<u64>(arg3), 0x2::coin::zero<u64>(arg3))
    }

    public entry fun cancel_order_by_object_entry(arg0: &mut OrderManager, arg1: OrderReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = cancel_order_by_object(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<u64>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(v3, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<u64>(v3);
        };
        if (0x2::coin::value<u64>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(v2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<u64>(v2);
        };
    }

    public fun create_order_manager(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderManager{
            id                   : 0x2::object::new(arg1),
            owner                : 0x2::tx_context::sender(arg1),
            active_orders        : 0x1::vector::empty<u64>(),
            total_orders_created : 0,
            receipts             : 0x2::table::new<u64, OrderReceiptData>(arg1),
            oco_groups           : 0x2::table::new<u64, OCOGroup>(arg1),
            is_paused            : false,
            created_at           : 0x2::clock::timestamp_ms(arg0),
            deepbook_pools       : 0x2::table::new<vector<u8>, 0x2::object::UID>(arg1),
        };
        0x2::transfer::public_transfer<OrderManager>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_order_manager_entry(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        create_order_manager(arg0, arg1);
    }

    public fun create_order_receipt(arg0: &mut OrderManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(0x2::table::contains<u64, OrderReceiptData>(&arg0.receipts, arg1), 0);
        let v0 = OrderReceipt{
            id         : 0x2::object::new(arg2),
            order_data : 0x2::table::remove<u64, OrderReceiptData>(&mut arg0.receipts, arg1),
            owner      : arg0.owner,
        };
        0x2::transfer::public_transfer<OrderReceipt>(v0, arg0.owner);
    }

    public entry fun create_order_receipt_entry(arg0: &mut OrderManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        create_order_receipt(arg0, arg1, arg2);
    }

    public fun get_manager_owner(arg0: &OrderManager) : address {
        arg0.owner
    }

    public fun get_receipt_details(arg0: &OrderManager, arg1: u64) : &OrderReceiptData {
        0x2::table::borrow<u64, OrderReceiptData>(&arg0.receipts, arg1)
    }

    public fun get_total_orders_created(arg0: &OrderManager) : u64 {
        arg0.total_orders_created
    }

    public fun get_user_orders(arg0: &OrderManager) : &vector<u64> {
        &arg0.active_orders
    }

    public fun handle_oco_fill(arg0: &mut OrderManager, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(0x2::table::contains<u64, OrderReceiptData>(&arg0.receipts, arg1), 0);
        let v0 = 0x2::table::borrow<u64, OrderReceiptData>(&arg0.receipts, arg1);
        assert!(v0.is_active, 8);
        if (0x1::option::is_some<u64>(&v0.oco_group_id)) {
            let v1 = *0x1::option::borrow<u64>(&v0.oco_group_id);
            assert!(0x2::table::contains<u64, OCOGroup>(&arg0.oco_groups, v1), 7);
            let v2 = 0x2::table::remove<u64, OCOGroup>(&mut arg0.oco_groups, v1);
            let v3 = if (v2.order1_id == arg1) {
                v2.order2_id
            } else {
                v2.order1_id
            };
            v2.is_active = false;
            0x2::table::add<u64, OCOGroup>(&mut arg0.oco_groups, v1, v2);
            let v4 = 0x2::clock::timestamp_ms(arg2);
            if (0x2::table::contains<u64, OrderReceiptData>(&arg0.receipts, v3)) {
                let v5 = 0x2::table::remove<u64, OrderReceiptData>(&mut arg0.receipts, v3);
                if (v5.is_active) {
                    v5.is_active = false;
                    v5.cancelled_at = 0x1::option::some<u64>(v4);
                    let v6 = 0;
                    while (v6 < 0x1::vector::length<u64>(&arg0.active_orders)) {
                        if (*0x1::vector::borrow<u64>(&arg0.active_orders, v6) == v3) {
                            0x1::vector::remove<u64>(&mut arg0.active_orders, v6);
                            break
                        };
                        v6 = v6 + 1;
                    };
                };
                0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v3, v5);
            };
            let v7 = 0x2::table::remove<u64, OrderReceiptData>(&mut arg0.receipts, arg1);
            v7.is_active = false;
            v7.is_fully_filled = true;
            0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, arg1, v7);
            let v8 = 0;
            while (v8 < 0x1::vector::length<u64>(&arg0.active_orders)) {
                if (*0x1::vector::borrow<u64>(&arg0.active_orders, v8) == arg1) {
                    0x1::vector::remove<u64>(&mut arg0.active_orders, v8);
                    break
                };
                v8 = v8 + 1;
            };
            let v9 = OCOOrderFilledEvent{
                oco_group_id       : v1,
                filled_order_id    : arg1,
                cancelled_order_id : v3,
                user               : arg0.owner,
                filled_at          : v4,
            };
            0x2::event::emit<OCOOrderFilledEvent>(v9);
        };
    }

    public entry fun handle_oco_fill_entry(arg0: &mut OrderManager, arg1: OrderReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        handle_oco_fill(arg0, arg1.order_data.order_id, arg2, arg3);
        let OrderReceipt {
            id         : v0,
            order_data : _,
            owner      : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_contract_paused(arg0: &OrderManager) : bool {
        arg0.is_paused
    }

    public fun is_order_active(arg0: &OrderManager, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.active_orders, &arg1)
    }

    public fun modify_order(arg0: &mut OrderManager, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(0x1::vector::contains<u64>(&arg0.active_orders, &arg1), 0);
        let v0 = 0x2::table::borrow_mut<u64, OrderReceiptData>(&mut arg0.receipts, arg1);
        assert!(v0.is_active, 6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 > v0.created_at, 5);
        if (0x1::option::is_some<u64>(&arg2)) {
            let v2 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v2 > 0, 1);
            v0.price = v2;
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            let v3 = 0x1::option::destroy_some<u64>(arg3);
            assert!(v3 > 0, 2);
            v0.quantity = v3;
        };
        let v4 = OrderModifiedEvent{
            order_id     : arg1,
            old_price    : v0.price,
            new_price    : v0.price,
            old_quantity : v0.quantity,
            new_quantity : v0.quantity,
            modified_at  : v1,
        };
        0x2::event::emit<OrderModifiedEvent>(v4);
    }

    public entry fun modify_order_entry(arg0: &mut OrderManager, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        modify_order(arg0, arg1, 0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg3), arg4, arg5);
    }

    public fun place_limit_order(arg0: &mut OrderManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > arg0.created_at, 5);
        let v1 = v0 + arg0.total_orders_created;
        0x1::vector::push_back<u64>(&mut arg0.active_orders, v1);
        arg0.total_orders_created = arg0.total_orders_created + 1;
        let v2 = OrderType{value: 0};
        let v3 = TimeInForce{value: 0};
        let v4 = OrderReceiptData{
            order_id          : v1,
            deepbook_order_id : v1,
            pool_id           : arg1,
            price             : arg2,
            quantity          : arg3,
            original_quantity : arg3,
            is_bid            : arg4,
            order_type        : v2,
            time_in_force     : v3,
            created_at        : v0,
            is_active         : true,
            is_fully_filled   : false,
            cancelled_at      : 0x1::option::none<u64>(),
            oco_group_id      : 0x1::option::none<u64>(),
            expires_at        : 0x1::option::none<u64>(),
        };
        0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v1, v4);
        let v5 = OrderPlacedEvent{
            order_id   : v1,
            pool_id    : arg1,
            user       : arg0.owner,
            price      : arg2,
            quantity   : arg3,
            is_bid     : arg4,
            created_at : v0,
        };
        0x2::event::emit<OrderPlacedEvent>(v5);
        v1
    }

    public entry fun place_limit_order_entry(arg0: &mut OrderManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        place_limit_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun place_limit_order_oco(arg0: &mut OrderManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(arg2 > 0 && arg5 > 0, 1);
        assert!(arg3 > 0 && arg6 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 > arg0.created_at, 5);
        let v1 = v0 + arg0.total_orders_created;
        let v2 = v1 + 1000000;
        0x1::vector::push_back<u64>(&mut arg0.active_orders, v1);
        0x1::vector::push_back<u64>(&mut arg0.active_orders, v2);
        arg0.total_orders_created = arg0.total_orders_created + 2;
        let v3 = OCOGroup{
            id         : 0x2::object::new(arg9),
            group_id   : v1,
            order1_id  : v1,
            order2_id  : v2,
            created_at : v0,
            is_active  : true,
        };
        0x2::table::add<u64, OCOGroup>(&mut arg0.oco_groups, v1, v3);
        let v4 = OrderType{value: 1};
        let v5 = TimeInForce{value: 0};
        let v6 = OrderReceiptData{
            order_id          : v1,
            deepbook_order_id : v1,
            pool_id           : arg1,
            price             : arg2,
            quantity          : arg3,
            original_quantity : arg3,
            is_bid            : arg4,
            order_type        : v4,
            time_in_force     : v5,
            created_at        : v0,
            is_active         : true,
            is_fully_filled   : false,
            cancelled_at      : 0x1::option::none<u64>(),
            oco_group_id      : 0x1::option::some<u64>(v1),
            expires_at        : 0x1::option::none<u64>(),
        };
        0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v1, v6);
        let v7 = OrderType{value: 1};
        let v8 = TimeInForce{value: 0};
        let v9 = OrderReceiptData{
            order_id          : v2,
            deepbook_order_id : v2,
            pool_id           : 0x1::vector::empty<u8>(),
            price             : arg5,
            quantity          : arg6,
            original_quantity : arg6,
            is_bid            : arg7,
            order_type        : v7,
            time_in_force     : v8,
            created_at        : v0,
            is_active         : true,
            is_fully_filled   : false,
            cancelled_at      : 0x1::option::none<u64>(),
            oco_group_id      : 0x1::option::some<u64>(v1),
            expires_at        : 0x1::option::none<u64>(),
        };
        0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v2, v9);
        let v10 = OCOOrderPlacedEvent{
            oco_group_id : v1,
            order_id_1   : v1,
            order_id_2   : v2,
            user         : arg0.owner,
            created_at   : v0,
        };
        0x2::event::emit<OCOOrderPlacedEvent>(v10);
        let v11 = OrderPlacedEvent{
            order_id   : v1,
            pool_id    : 0x1::vector::empty<u8>(),
            user       : arg0.owner,
            price      : arg2,
            quantity   : arg3,
            is_bid     : arg4,
            created_at : v0,
        };
        0x2::event::emit<OrderPlacedEvent>(v11);
        let v12 = OrderPlacedEvent{
            order_id   : v2,
            pool_id    : 0x1::vector::empty<u8>(),
            user       : arg0.owner,
            price      : arg5,
            quantity   : arg6,
            is_bid     : arg7,
            created_at : v0,
        };
        0x2::event::emit<OrderPlacedEvent>(v12);
        (v1, v2)
    }

    public entry fun place_limit_order_oco_entry(arg0: &mut OrderManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _) = place_limit_order_oco(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_limit_order_tif(arg0: &mut OrderManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: u8, arg6: 0x2::coin::Coin<u64>, arg7: 0x2::coin::Coin<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0x2::coin::Coin<u64>>, 0x1::option::Option<0x2::coin::Coin<u64>>) {
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 3);
        assert!(!arg0.is_paused, 4);
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        assert!(arg5 == 1 || arg5 == 2, 9);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 > arg0.created_at, 5);
        let v1 = v0 + arg0.total_orders_created;
        let v2 = 0;
        let v3 = true;
        let v4 = false;
        let v5 = 0x1::option::none<0x2::coin::Coin<u64>>();
        let v6 = 0x1::option::none<0x2::coin::Coin<u64>>();
        if (arg5 == 1) {
            if (arg3 > 0) {
                v3 = false;
                if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v5)) {
                    0x2::coin::destroy_zero<u64>(0x1::option::extract<0x2::coin::Coin<u64>>(&mut v5));
                };
                if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v6)) {
                    0x2::coin::destroy_zero<u64>(0x1::option::extract<0x2::coin::Coin<u64>>(&mut v6));
                };
                0x1::option::fill<0x2::coin::Coin<u64>>(&mut v5, 0x2::coin::split<u64>(&mut arg6, (((arg3 as u128) * (0x2::coin::value<u64>(&arg6) as u128) / (arg3 as u128)) as u64), arg9));
                0x1::option::fill<0x2::coin::Coin<u64>>(&mut v6, 0x2::coin::zero<u64>(arg9));
                let v7 = OrderPartialFilledEvent{
                    order_id           : v1,
                    filled_quantity    : v2,
                    remaining_quantity : arg3,
                    user               : arg0.owner,
                    filled_at          : v0,
                };
                0x2::event::emit<OrderPartialFilledEvent>(v7);
            } else {
                v4 = true;
                v3 = false;
            };
        } else if (arg5 == 2) {
            if (arg3 > 0) {
                if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v5)) {
                    0x2::coin::destroy_zero<u64>(0x1::option::extract<0x2::coin::Coin<u64>>(&mut v5));
                };
                if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v6)) {
                    0x2::coin::destroy_zero<u64>(0x1::option::extract<0x2::coin::Coin<u64>>(&mut v6));
                };
                0x1::option::fill<0x2::coin::Coin<u64>>(&mut v5, 0x2::coin::split<u64>(&mut arg6, 0x2::coin::value<u64>(&arg6), arg9));
                0x1::option::fill<0x2::coin::Coin<u64>>(&mut v6, 0x2::coin::zero<u64>(arg9));
                let v8 = OrderExpiredEvent{
                    order_id   : v1,
                    user       : arg0.owner,
                    expired_at : v0,
                };
                0x2::event::emit<OrderExpiredEvent>(v8);
                if (0x2::coin::value<u64>(&arg6) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg6, 0x2::tx_context::sender(arg9));
                } else {
                    0x2::coin::destroy_zero<u64>(arg6);
                };
                if (0x2::coin::value<u64>(&arg7) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg7, 0x2::tx_context::sender(arg9));
                } else {
                    0x2::coin::destroy_zero<u64>(arg7);
                };
                return (v1, v5, v6)
            };
            v4 = true;
            v3 = false;
        };
        if (v3 || arg5 == 1 && v2 > 0) {
            0x1::vector::push_back<u64>(&mut arg0.active_orders, v1);
            arg0.total_orders_created = arg0.total_orders_created + 1;
            let v9 = TimeInForce{value: arg5};
            let v10 = if (v3) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>(v0)
            };
            let v11 = OrderType{value: 2};
            let v12 = OrderReceiptData{
                order_id          : v1,
                deepbook_order_id : v1,
                pool_id           : arg1,
                price             : arg2,
                quantity          : arg3,
                original_quantity : arg3,
                is_bid            : arg4,
                order_type        : v11,
                time_in_force     : v9,
                created_at        : v0,
                is_active         : v3,
                is_fully_filled   : v4,
                cancelled_at      : v10,
                oco_group_id      : 0x1::option::none<u64>(),
                expires_at        : 0x1::option::none<u64>(),
            };
            0x2::table::add<u64, OrderReceiptData>(&mut arg0.receipts, v1, v12);
            let v13 = TIFOrderPlacedEvent{
                order_id   : v1,
                tif_type   : arg5,
                user       : arg0.owner,
                created_at : v0,
            };
            0x2::event::emit<TIFOrderPlacedEvent>(v13);
            let v14 = OrderPlacedEvent{
                order_id   : v1,
                pool_id    : arg1,
                user       : arg0.owner,
                price      : arg2,
                quantity   : arg3,
                is_bid     : arg4,
                created_at : v0,
            };
            0x2::event::emit<OrderPlacedEvent>(v14);
        };
        if (0x2::coin::value<u64>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg6, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<u64>(arg6);
        };
        if (0x2::coin::value<u64>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg7, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<u64>(arg7);
        };
        (v1, v5, v6)
    }

    public entry fun place_limit_order_tif_entry(arg0: &mut OrderManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: u8, arg6: 0x2::coin::Coin<u64>, arg7: 0x2::coin::Coin<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2) = place_limit_order_tif(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(0x1::option::extract<0x2::coin::Coin<u64>>(&mut v4), 0x2::tx_context::sender(arg9));
        };
        if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(0x1::option::extract<0x2::coin::Coin<u64>>(&mut v3), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<0x2::coin::Coin<u64>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<u64>>(v3);
    }

    public fun toggle_pause(arg0: &AdminCap, arg1: &mut OrderManager, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = arg2;
        let v0 = ContractPausedEvent{
            paused    : arg2,
            paused_at : 0x2::clock::timestamp_ms(arg3),
            admin     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ContractPausedEvent>(v0);
    }

    public fun transfer_manager(arg0: OrderManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<OrderManager>(arg0, arg1);
    }

    public entry fun transfer_manager_entry(arg0: OrderManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == get_manager_owner(&arg0), 3);
        transfer_manager(arg0, arg1, arg2);
    }

    public fun transfer_order_ownership(arg0: OrderReceipt, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        0x2::transfer::public_transfer<OrderReceipt>(arg0, arg1);
        let v0 = OrderOwnershipTransferredEvent{
            order_id       : arg0.order_data.order_id,
            from           : 0x2::tx_context::sender(arg2),
            to             : arg1,
            transferred_at : 0,
        };
        0x2::event::emit<OrderOwnershipTransferredEvent>(v0);
    }

    public entry fun transfer_order_ownership_entry(arg0: OrderReceipt, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_order_ownership(arg0, arg1, arg2);
    }

    public fun update_order_status(arg0: &mut OrderManager, arg1: u64, arg2: bool) {
        if (0x2::table::contains<u64, OrderReceiptData>(&arg0.receipts, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, OrderReceiptData>(&mut arg0.receipts, arg1);
            v0.is_active = arg2;
            if (!arg2 && v0.is_active) {
                let v1 = 0;
                while (v1 < 0x1::vector::length<u64>(&arg0.active_orders)) {
                    if (*0x1::vector::borrow<u64>(&arg0.active_orders, v1) == arg1) {
                        0x1::vector::remove<u64>(&mut arg0.active_orders, v1);
                        break
                    };
                    v1 = v1 + 1;
                };
            };
        };
    }

    // decompiled from Move bytecode v6
}

