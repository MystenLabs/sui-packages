module 0x199d6e2c12a1a3d2242d798ea49a2ca29539708e342c56c10be5499087bb15b5::deposit {
    struct Order has copy, drop, store {
        order_no: u64,
        from: address,
        to: address,
        amount: u64,
        is_node: bool,
        block_number: u64,
        timestamp: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        vaults: vector<address>,
        order_id: u64,
    }

    struct Orders has store, key {
        id: 0x2::object::UID,
        item: 0x2::table::Table<u64, Order>,
    }

    struct DEPOSIT has drop {
        dummy_field: bool,
    }

    struct DepositToken has copy, drop {
        from: address,
        to: address,
        order_no: u64,
        amount: u64,
    }

    public fun deposit(arg0: &mut Config, arg1: &mut Orders, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        assert!(0x1::vector::length<address>(&arg0.vaults) > 0, 2);
        let v1 = *0x1::vector::borrow<address>(&arg0.vaults, arg0.order_id % 0x1::vector::length<address>(&arg0.vaults));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        let v2 = Order{
            order_no     : arg0.order_id,
            from         : 0x2::tx_context::sender(arg4),
            to           : v1,
            amount       : v0,
            is_node      : arg3,
            block_number : 0x2::tx_context::epoch(arg4),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        save_order(arg1, v2);
        arg0.order_id = arg0.order_id + 1;
    }

    fun init(arg0: DEPOSIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            vaults   : 0x1::vector::empty<address>(),
            order_id : 1,
        };
        let v1 = Orders{
            id   : 0x2::object::new(arg1),
            item : 0x2::table::new<u64, Order>(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::share_object<Orders>(v1);
    }

    fun save_order(arg0: &mut Orders, arg1: Order) {
        assert!(!0x2::table::contains<u64, Order>(&arg0.item, arg1.order_no), 3);
        0x2::table::add<u64, Order>(&mut arg0.item, arg1.order_no, arg1);
        let v0 = DepositToken{
            from     : arg1.from,
            to       : arg1.to,
            order_no : arg1.order_no,
            amount   : arg1.amount,
        };
        0x2::event::emit<DepositToken>(v0);
    }

    public fun transfer_ownership(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
    }

    public fun update_vault(arg0: &mut Config, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.vaults = arg1;
    }

    // decompiled from Move bytecode v6
}

