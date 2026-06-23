module 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::hash_share_market {
    struct MarketFeePool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct BuyOrder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        buyer: address,
        price_per_unit_mist: u64,
        payment: 0x2::balance::Balance<T1>,
        expires_epoch: 0x1::option::Option<u64>,
    }

    struct SellOrder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        seller: address,
        price_per_unit_mist: u64,
        inventory: 0x2::balance::Balance<T0>,
        expires_epoch: 0x1::option::Option<u64>,
    }

    struct BuyOrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        buyer: address,
        price_per_unit_mist: u64,
        budget_mist: u64,
        expires_epoch: 0x1::option::Option<u64>,
    }

    struct SellOrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        seller: address,
        price_per_unit_mist: u64,
        inventory_units: u64,
        expires_epoch: 0x1::option::Option<u64>,
    }

    struct BuyOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        seller: address,
        units: u64,
        gross_mist: u64,
        fee_mist: u64,
        net_paid_mist: u64,
        budget_remaining_mist: u64,
    }

    struct SellOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        buyer: address,
        units: u64,
        gross_mist: u64,
        fee_mist: u64,
        inventory_remaining: u64,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        refund_amount: u64,
        side_is_buy: bool,
    }

    struct PriceUpdated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        old_price: u64,
        new_price: u64,
        side_is_buy: bool,
    }

    struct AdminProposed has copy, drop {
        fee_pool_id: 0x2::object::ID,
        current_admin: address,
        pending_admin: address,
    }

    struct AdminTransferred has copy, drop {
        fee_pool_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    public fun accept_admin<T0>(arg0: &mut MarketFeePool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 13906836429202522133);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg1) == v0, 13906836437792587799);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        let v1 = AdminTransferred{
            fee_pool_id : 0x2::object::uid_to_inner(&arg0.id),
            old_admin   : arg0.admin,
            new_admin   : v0,
        };
        0x2::event::emit<AdminTransferred>(v1);
    }

    public fun buy_budget<T0, T1>(arg0: &BuyOrder<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.payment)
    }

    public fun buy_buyer<T0, T1>(arg0: &BuyOrder<T0, T1>) : address {
        arg0.buyer
    }

    public fun buy_expires<T0, T1>(arg0: &BuyOrder<T0, T1>) : 0x1::option::Option<u64> {
        arg0.expires_epoch
    }

    public fun buy_price<T0, T1>(arg0: &BuyOrder<T0, T1>) : u64 {
        arg0.price_per_unit_mist
    }

    public fun cancel_buy_order<T0, T1>(arg0: BuyOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.buyer == 0x2::tx_context::sender(arg1), 13906835492898471939);
        let BuyOrder {
            id                  : v0,
            buyer               : v1,
            price_per_unit_mist : _,
            payment             : v3,
            expires_epoch       : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = 0x2::balance::value<T1>(&v5);
        let v8 = OrderCancelled{
            order_id      : 0x2::object::uid_to_inner(&v6),
            owner         : v1,
            refund_amount : v7,
            side_is_buy   : true,
        };
        0x2::event::emit<OrderCancelled>(v8);
        0x2::object::delete(v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg1), v1);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
    }

    public fun cancel_sell_order<T0, T1>(arg0: SellOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg1), 13906836145733632005);
        let SellOrder {
            id                  : v0,
            seller              : v1,
            price_per_unit_mist : _,
            inventory           : v3,
            expires_epoch       : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = OrderCancelled{
            order_id      : 0x2::object::uid_to_inner(&v6),
            owner         : v1,
            refund_amount : v7,
            side_is_buy   : false,
        };
        0x2::event::emit<OrderCancelled>(v8);
        0x2::object::delete(v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg1), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
    }

    public fun cleanup_expired_buy_order<T0, T1>(arg0: BuyOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<u64>(&arg0.expires_epoch), 13906835578798473229);
        assert!(0x2::tx_context::epoch(arg1) >= *0x1::option::borrow<u64>(&arg0.expires_epoch), 13906835591683375117);
        let BuyOrder {
            id                  : v0,
            buyer               : v1,
            price_per_unit_mist : _,
            payment             : v3,
            expires_epoch       : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = 0x2::balance::value<T1>(&v5);
        let v8 = OrderCancelled{
            order_id      : 0x2::object::uid_to_inner(&v6),
            owner         : v1,
            refund_amount : v7,
            side_is_buy   : true,
        };
        0x2::event::emit<OrderCancelled>(v8);
        0x2::object::delete(v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg1), v1);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
    }

    public fun cleanup_expired_sell_order<T0, T1>(arg0: SellOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<u64>(&arg0.expires_epoch), 13906836223043567629);
        assert!(0x2::tx_context::epoch(arg1) >= *0x1::option::borrow<u64>(&arg0.expires_epoch), 13906836235928469517);
        let SellOrder {
            id                  : v0,
            seller              : v1,
            price_per_unit_mist : _,
            inventory           : v3,
            expires_epoch       : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = OrderCancelled{
            order_id      : 0x2::object::uid_to_inner(&v6),
            owner         : v1,
            refund_amount : v7,
            side_is_buy   : false,
        };
        0x2::event::emit<OrderCancelled>(v8);
        0x2::object::delete(v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg1), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
    }

    public fun create_fee_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketFeePool<T0>{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            pending_admin : 0x1::option::none<address>(),
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<MarketFeePool<T0>>(v0);
    }

    public fun fee_pool_admin<T0>(arg0: &MarketFeePool<T0>) : address {
        arg0.admin
    }

    public fun fill_buy_order<T0, T1>(arg0: &mut BuyOrder<T0, T1>, arg1: &MarketFeePool<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg0.expires_epoch)) {
            assert!(0x2::tx_context::epoch(arg3) < *0x1::option::borrow<u64>(&arg0.expires_epoch), 13906835226611023883);
        };
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13906835243791155215);
        let v1 = 0x1::option::destroy_some<u64>(0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::u64::mul_div(v0, arg0.price_per_unit_mist, 1, 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::rounding::down()));
        assert!(0x2::balance::value<T1>(&arg0.payment) >= v1, 13906835256675532807);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x1::option::destroy_some<u64>(0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::u64::mul_div(v1, 200, 10000, 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::rounding::down()));
        let v4 = 0x2::balance::split<T1>(&mut arg0.payment, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::coin::into_balance<T0>(arg2), arg3), arg0.buyer);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg3), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v3), arg3), arg1.admin);
        let v5 = BuyOrderFilled{
            order_id              : 0x2::object::id<BuyOrder<T0, T1>>(arg0),
            seller                : v2,
            units                 : v0,
            gross_mist            : v1,
            fee_mist              : v3,
            net_paid_mist         : v1 - v3,
            budget_remaining_mist : 0x2::balance::value<T1>(&arg0.payment),
        };
        0x2::event::emit<BuyOrderFilled>(v5);
    }

    public fun fill_sell_order<T0, T1>(arg0: &mut SellOrder<T0, T1>, arg1: &MarketFeePool<T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg0.expires_epoch)) {
            assert!(0x2::tx_context::epoch(arg4) < *0x1::option::borrow<u64>(&arg0.expires_epoch), 13906835857971216395);
        };
        assert!(arg3 > 0, 13906835870856380431);
        assert!(0x2::balance::value<T0>(&arg0.inventory) >= arg3, 13906835875150954505);
        let v0 = 0x1::option::destroy_some<u64>(0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::u64::mul_div(arg3, arg0.price_per_unit_mist, 1, 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::rounding::down()));
        assert!(0x2::coin::value<T1>(&arg2) >= v0, 13906835888035725319);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::option::destroy_some<u64>(0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::u64::mul_div(v0, 200, 10000, 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::rounding::down()));
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        let v4 = 0x2::balance::split<T1>(&mut v3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.inventory, arg3), arg4), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg4), arg0.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v2), arg4), arg1.admin);
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), v1);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
        let v5 = SellOrderFilled{
            order_id            : 0x2::object::id<SellOrder<T0, T1>>(arg0),
            buyer               : v1,
            units               : arg3,
            gross_mist          : v0,
            fee_mist            : v2,
            inventory_remaining : 0x2::balance::value<T0>(&arg0.inventory),
        };
        0x2::event::emit<SellOrderFilled>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun place_buy_order<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 13906835080582660115);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg1)
        };
        let v2 = BuyOrder<T0, T1>{
            id                  : 0x2::object::new(arg3),
            buyer               : v0,
            price_per_unit_mist : arg0,
            payment             : 0x2::coin::into_balance<T1>(arg2),
            expires_epoch       : v1,
        };
        let v3 = BuyOrderPlaced{
            order_id            : 0x2::object::id<BuyOrder<T0, T1>>(&v2),
            buyer               : v0,
            price_per_unit_mist : arg0,
            budget_mist         : 0x2::coin::value<T1>(&arg2),
            expires_epoch       : v1,
        };
        0x2::event::emit<BuyOrderPlaced>(v3);
        0x2::transfer::share_object<BuyOrder<T0, T1>>(v2);
    }

    public fun place_sell_order<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 13906835703352918035);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13906835711942590479);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = if (arg1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg1)
        };
        let v3 = SellOrder<T0, T1>{
            id                  : 0x2::object::new(arg3),
            seller              : v1,
            price_per_unit_mist : arg0,
            inventory           : 0x2::coin::into_balance<T0>(arg2),
            expires_epoch       : v2,
        };
        let v4 = SellOrderPlaced{
            order_id            : 0x2::object::id<SellOrder<T0, T1>>(&v3),
            seller              : v1,
            price_per_unit_mist : arg0,
            inventory_units     : v0,
            expires_epoch       : v2,
        };
        0x2::event::emit<SellOrderPlaced>(v4);
        0x2::transfer::share_object<SellOrder<T0, T1>>(v3);
    }

    public fun propose_admin<T0>(arg0: &mut MarketFeePool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906836351892848657);
        let v0 = if (arg1 == @0x0) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(arg1)
        };
        arg0.pending_admin = v0;
        let v1 = AdminProposed{
            fee_pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            current_admin : arg0.admin,
            pending_admin : arg1,
        };
        0x2::event::emit<AdminProposed>(v1);
    }

    public fun sell_expires<T0, T1>(arg0: &SellOrder<T0, T1>) : 0x1::option::Option<u64> {
        arg0.expires_epoch
    }

    public fun sell_inventory<T0, T1>(arg0: &SellOrder<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.inventory)
    }

    public fun sell_price<T0, T1>(arg0: &SellOrder<T0, T1>) : u64 {
        arg0.price_per_unit_mist
    }

    public fun sell_seller<T0, T1>(arg0: &SellOrder<T0, T1>) : address {
        arg0.seller
    }

    public fun top_up_buy_order<T0, T1>(arg0: &mut BuyOrder<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.payment, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun top_up_sell_order<T0, T1>(arg0: &mut SellOrder<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.inventory, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun update_buy_order_price<T0, T1>(arg0: &mut BuyOrder<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.buyer == 0x2::tx_context::sender(arg2), 13906835432768929795);
        assert!(arg1 > 0, 13906835437064945683);
        arg0.price_per_unit_mist = arg1;
        let v0 = PriceUpdated{
            order_id    : 0x2::object::id<BuyOrder<T0, T1>>(arg0),
            owner       : arg0.buyer,
            old_price   : arg0.price_per_unit_mist,
            new_price   : arg1,
            side_is_buy : true,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public fun update_sell_order_price<T0, T1>(arg0: &mut SellOrder<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg2), 13906836055539318789);
        assert!(arg1 > 0, 13906836059835203603);
        arg0.price_per_unit_mist = arg1;
        let v0 = PriceUpdated{
            order_id    : 0x2::object::id<SellOrder<T0, T1>>(arg0),
            owner       : arg0.seller,
            old_price   : arg0.price_per_unit_mist,
            new_price   : arg1,
            side_is_buy : false,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

