module 0x2026cf5a5c3376840841018471b2a14013b7f6a7e37028fc975379d6a5af9428::protocol {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DiscountConfig has store {
        threshold_base: u64,
        fee_bps: u64,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        inbox_prices: 0x2::table::Table<address, u64>,
        treasury: address,
        fee_bps: u64,
        discount_coins: 0x2::table::Table<0x1::ascii::String, DiscountConfig>,
        paused: bool,
    }

    struct MessageRecordV2 has store {
        sender: address,
        recipient: address,
        blob_id: vector<u8>,
        allowlist_id: address,
        timestamp: u64,
        payment: u64,
        treasury_fee: u64,
    }

    struct MessageRegistryV2 has key {
        id: 0x2::object::UID,
        messages: 0x2::table::Table<u64, MessageRecordV2>,
        next_id: u64,
    }

    struct MessageSentV2 has copy, drop {
        message_id: u64,
        sender: address,
        recipient: address,
        blob_id: vector<u8>,
        allowlist_id: address,
        timestamp: u64,
        payment: u64,
        treasury_fee: u64,
        recipient_received: u64,
    }

    struct MessageDeleted has copy, drop {
        message_id: u64,
        deleted_by: address,
        timestamp: u64,
    }

    struct TreasuryUpdated has copy, drop {
        new_treasury: address,
    }

    struct FeeRateUpdated has copy, drop {
        fee_bps: u64,
    }

    struct PausedStateChanged has copy, drop {
        paused: bool,
    }

    struct InboxPriceSet has copy, drop {
        owner: address,
        min_payment: u64,
    }

    struct InboxPriceCleared has copy, drop {
        owner: address,
    }

    struct DiscountCoinRegistered has copy, drop {
        coin_type: 0x1::ascii::String,
        threshold_base: u64,
        fee_bps: u64,
    }

    public entry fun clear_inbox_price(arg0: &mut ProtocolConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, u64>(&arg0.inbox_prices, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.inbox_prices, v0);
            let v1 = InboxPriceCleared{owner: v0};
            0x2::event::emit<InboxPriceCleared>(v1);
        };
    }

    public entry fun delete_message_v2(arg0: &mut MessageRegistryV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<u64, MessageRecordV2>(&arg0.messages, arg1), 9);
        let v1 = 0x2::table::borrow<u64, MessageRecordV2>(&arg0.messages, arg1);
        assert!(v1.sender == v0 || v1.recipient == v0, 8);
        let MessageRecordV2 {
            sender       : _,
            recipient    : _,
            blob_id      : _,
            allowlist_id : _,
            timestamp    : _,
            payment      : _,
            treasury_fee : _,
        } = 0x2::table::remove<u64, MessageRecordV2>(&mut arg0.messages, arg1);
        let v9 = MessageDeleted{
            message_id : arg1,
            deleted_by : v0,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<MessageDeleted>(v9);
    }

    public fun fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.fee_bps
    }

    public fun get_inbox_price(arg0: &ProtocolConfig, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.inbox_prices, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.inbox_prices, arg1)
        } else {
            0
        }
    }

    public fun has_inbox_price(arg0: &ProtocolConfig, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.inbox_prices, arg1)
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        assert!(v0 == @0xce4be8bcc98ee6a8ffdf3da5b7ae9d6ab14f77f112a9df81e966903c19b4295f, 10);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = ProtocolConfig{
            id             : 0x2::object::new(arg0),
            inbox_prices   : 0x2::table::new<address, u64>(arg0),
            treasury       : v0,
            fee_bps        : 500,
            discount_coins : 0x2::table::new<0x1::ascii::String, DiscountConfig>(arg0),
            paused         : false,
        };
        let v3 = DiscountConfig{
            threshold_base : 50000000000000,
            fee_bps        : 150,
        };
        0x2::table::add<0x1::ascii::String, DiscountConfig>(&mut v2.discount_coins, 0x1::ascii::string(b"0x7a321bdf6cd445cfe5f5cad61e7668d001eee2ac2f054175b37913b6e8f1cc84::AOOA::AOOA"), v3);
        0x2::transfer::share_object<ProtocolConfig>(v2);
        let v4 = MessageRegistryV2{
            id       : 0x2::object::new(arg0),
            messages : 0x2::table::new<u64, MessageRecordV2>(arg0),
            next_id  : 0,
        };
        0x2::transfer::share_object<MessageRegistryV2>(v4);
    }

    public fun is_paused(arg0: &ProtocolConfig) : bool {
        arg0.paused
    }

    public fun min_inbox_price() : u64 {
        1000000
    }

    public entry fun register_discount_coin(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(arg2);
        assert!(!0x2::table::contains<0x1::ascii::String, DiscountConfig>(&arg1.discount_coins, v0), 3);
        let v1 = DiscountConfig{
            threshold_base : arg3,
            fee_bps        : arg4,
        };
        0x2::table::add<0x1::ascii::String, DiscountConfig>(&mut arg1.discount_coins, v0, v1);
        let v2 = DiscountCoinRegistered{
            coin_type      : v0,
            threshold_base : arg3,
            fee_bps        : arg4,
        };
        0x2::event::emit<DiscountCoinRegistered>(v2);
    }

    public entry fun send_message(arg0: &mut MessageRegistryV2, arg1: &ProtocolConfig, arg2: address, arg3: vector<u8>, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        send_message_at_timestamp(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    fun send_message_at_timestamp(arg0: &mut MessageRegistryV2, arg1: &ProtocolConfig, arg2: address, arg3: vector<u8>, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 4);
        assert!(arg2 != @0x0, 5);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 7);
        assert!(0x2::table::contains<address, u64>(&arg1.inbox_prices, arg2), 2);
        let v0 = *0x2::table::borrow<address, u64>(&arg1.inbox_prices, arg2);
        assert!(v0 >= 1000000, 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v1 >= v0, 1);
        let v2 = v1 * arg1.fee_bps / 10000;
        let v3 = if (v2 < 1000) {
            1000
        } else {
            v2
        };
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v3), arg7), arg1.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg7), arg2);
        let v5 = 0x2::tx_context::sender(arg7);
        let v6 = arg0.next_id;
        let v7 = MessageRecordV2{
            sender       : v5,
            recipient    : arg2,
            blob_id      : arg3,
            allowlist_id : arg4,
            timestamp    : arg6,
            payment      : v1,
            treasury_fee : v3,
        };
        0x2::table::add<u64, MessageRecordV2>(&mut arg0.messages, v6, v7);
        arg0.next_id = v6 + 1;
        let v8 = MessageSentV2{
            message_id         : v6,
            sender             : v5,
            recipient          : arg2,
            blob_id            : arg3,
            allowlist_id       : arg4,
            timestamp          : arg6,
            payment            : v1,
            treasury_fee       : v3,
            recipient_received : v1 - v3,
        };
        0x2::event::emit<MessageSentV2>(v8);
    }

    public entry fun send_message_ms(arg0: &mut MessageRegistryV2, arg1: &ProtocolConfig, arg2: address, arg3: vector<u8>, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        send_message_at_timestamp(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6), arg7);
    }

    public entry fun set_fee_bps(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 0);
        arg1.fee_bps = arg2;
        let v0 = FeeRateUpdated{fee_bps: arg2};
        0x2::event::emit<FeeRateUpdated>(v0);
    }

    public entry fun set_inbox_price(arg0: &mut ProtocolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg1 >= 1000000, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.inbox_prices, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.inbox_prices, v0) = arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.inbox_prices, v0, arg1);
        };
        let v1 = InboxPriceSet{
            owner       : v0,
            min_payment : arg1,
        };
        0x2::event::emit<InboxPriceSet>(v1);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = PausedStateChanged{paused: arg2};
        0x2::event::emit<PausedStateChanged>(v0);
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{new_treasury: arg2};
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun total_messages(arg0: &MessageRegistryV2) : u64 {
        arg0.next_id
    }

    public fun treasury(arg0: &ProtocolConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

