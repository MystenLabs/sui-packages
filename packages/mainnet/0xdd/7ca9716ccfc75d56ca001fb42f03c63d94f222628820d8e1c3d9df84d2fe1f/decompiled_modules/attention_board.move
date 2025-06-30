module 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board {
    struct ATTENTION_BOARD has drop {
        dummy_field: bool,
    }

    struct GlobalAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        admin_cap: 0x2::object::ID,
        receiver: address,
        refund_fee_bps: u16,
        protocol_share_of_refund_fee: u16,
        protocol_share_of_success_fee: u16,
    }

    struct AttentionBoard<phantom T0> has store, key {
        id: 0x2::object::UID,
        kol: address,
        messages: 0x2::object_table::ObjectTable<0x2::object::ID, Message<T0>>,
        minimum_bid: u64,
        bids: 0x2::balance::Balance<T0>,
        success_fees: 0x2::balance::Balance<T0>,
        refund_fees: 0x2::balance::Balance<T0>,
    }

    struct Message<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        message: 0x1::string::String,
        timestamp_s: u32,
        bid: u64,
    }

    struct NewAttentionBoardEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        kol: address,
    }

    struct NewMessageBidEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
        user: address,
        bid: u64,
    }

    struct BumpMessageBidEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
        user: address,
        bump: u64,
    }

    struct MessageSubmittedEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
    }

    struct MessageCancelledEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
    }

    public fun bid_message<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.minimum_bid, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.bids, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Message<T0>{
            id          : 0x2::object::new(arg4),
            user        : 0x2::tx_context::sender(arg4),
            message     : arg2,
            timestamp_s : ((0x2::clock::timestamp_ms(arg3) / 1000) as u32),
            bid         : v0,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x2::object_table::add<0x2::object::ID, Message<T0>>(&mut arg0.messages, v2, v1);
        let v3 = NewMessageBidEvent<T0>{
            board_id   : 0x2::object::uid_to_inner(&arg0.id),
            message_id : v2,
            user       : 0x2::tx_context::sender(arg4),
            bid        : v0,
        };
        0x2::event::emit<NewMessageBidEvent<T0>>(v3);
    }

    fun bid_message_test<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.minimum_bid, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.bids, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Message<T0>{
            id          : 0x2::object::new(arg3),
            user        : 0x2::tx_context::sender(arg3),
            message     : arg2,
            timestamp_s : 0,
            bid         : v0,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x2::object_table::add<0x2::object::ID, Message<T0>>(&mut arg0.messages, v2, v1);
        let v3 = NewMessageBidEvent<T0>{
            board_id   : 0x2::object::uid_to_inner(&arg0.id),
            message_id : v2,
            user       : 0x2::tx_context::sender(arg3),
            bid        : v0,
        };
        0x2::event::emit<NewMessageBidEvent<T0>>(v3);
        v2
    }

    public fun bump_message_bid<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg1), 5);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.bids, 0x2::coin::into_balance<T0>(arg2));
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Message<T0>>(&mut arg0.messages, arg1);
        v1.bid = v1.bid + v0;
        let v2 = BumpMessageBidEvent<T0>{
            board_id   : 0x2::object::uid_to_inner(&arg0.id),
            message_id : arg1,
            user       : 0x2::tx_context::sender(arg3),
            bump       : v0,
        };
        0x2::event::emit<BumpMessageBidEvent<T0>>(v2);
    }

    fun cancel_message<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object_table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg2), 5);
        let Message {
            id          : v0,
            user        : _,
            message     : _,
            timestamp_s : _,
            bid         : v4,
        } = 0x2::object_table::remove<0x2::object::ID, Message<T0>>(&mut arg0.messages, arg2);
        let v5 = v0;
        let v6 = 0x2::balance::split<T0>(&mut arg0.bids, v4);
        0x2::balance::join<T0>(&mut arg0.refund_fees, 0x2::balance::split<T0>(&mut v6, (((arg1.refund_fee_bps as u128) * (v4 as u128) / 10000) as u64)));
        let v7 = MessageCancelledEvent<T0>{
            board_id   : 0x2::object::uid_to_inner(&arg0.id),
            message_id : 0x2::object::uid_to_inner(&v5),
        };
        0x2::event::emit<MessageCancelledEvent<T0>>(v7);
        0x2::object::delete(v5);
        0x2::coin::from_balance<T0>(v6, arg3)
    }

    public fun cancel_message_as_admin<T0>(arg0: &GlobalAdmin, arg1: &mut AttentionBoard<T0>, arg2: &GlobalConfig, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        cancel_message<T0>(arg1, arg2, arg3, arg4)
    }

    public fun cancel_message_as_kol<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.kol, 2);
        cancel_message<T0>(arg0, arg1, arg2, arg3)
    }

    public fun cancel_message_as_user<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    fun collect_fees<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::balance::split<T0>(&mut arg0.success_fees, (((0x2::balance::value<T0>(&arg0.success_fees) as u128) * (arg1.protocol_share_of_success_fee as u128) / 10000) as u64));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.success_fees);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::withdraw_all<T0>(&mut arg0.refund_fees));
        0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg0.refund_fees, (((0x2::balance::value<T0>(&arg0.refund_fees) as u128) * (arg1.protocol_share_of_refund_fee as u128) / 10000) as u64)));
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::coin::from_balance<T0>(v1, arg2))
    }

    public fun collect_fees_as_admin<T0>(arg0: &GlobalAdmin, arg1: &mut AttentionBoard<T0>, arg2: &GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = collect_fees<T0>(arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2.receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1.kol);
    }

    public fun collect_fees_as_kol<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.kol, 2);
        let (v0, v1) = collect_fees<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1.receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg0.kol);
    }

    fun create_attention_board<T0>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : AttentionBoard<T0> {
        let v0 = AttentionBoard<T0>{
            id           : 0x2::object::new(arg2),
            kol          : arg1,
            messages     : 0x2::object_table::new<0x2::object::ID, Message<T0>>(arg2),
            minimum_bid  : arg0,
            bids         : 0x2::balance::zero<T0>(),
            success_fees : 0x2::balance::zero<T0>(),
            refund_fees  : 0x2::balance::zero<T0>(),
        };
        let v1 = NewAttentionBoardEvent<T0>{
            board_id : 0x2::object::uid_to_inner(&v0.id),
            kol      : arg1,
        };
        0x2::event::emit<NewAttentionBoardEvent<T0>>(v1);
        v0
    }

    public fun create_attention_board_as_admin<T0>(arg0: &GlobalAdmin, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AttentionBoard<T0>{
            id           : 0x2::object::new(arg3),
            kol          : arg1,
            messages     : 0x2::object_table::new<0x2::object::ID, Message<T0>>(arg3),
            minimum_bid  : arg2,
            bids         : 0x2::balance::zero<T0>(),
            success_fees : 0x2::balance::zero<T0>(),
            refund_fees  : 0x2::balance::zero<T0>(),
        };
        let v1 = NewAttentionBoardEvent<T0>{
            board_id : 0x2::object::uid_to_inner(&v0.id),
            kol      : arg1,
        };
        0x2::event::emit<NewAttentionBoardEvent<T0>>(v1);
        0x2::transfer::share_object<AttentionBoard<T0>>(v0);
    }

    public fun create_attention_board_as_kol<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AttentionBoard<T0>{
            id           : 0x2::object::new(arg1),
            kol          : 0x2::tx_context::sender(arg1),
            messages     : 0x2::object_table::new<0x2::object::ID, Message<T0>>(arg1),
            minimum_bid  : arg0,
            bids         : 0x2::balance::zero<T0>(),
            success_fees : 0x2::balance::zero<T0>(),
            refund_fees  : 0x2::balance::zero<T0>(),
        };
        let v1 = NewAttentionBoardEvent<T0>{
            board_id : 0x2::object::uid_to_inner(&v0.id),
            kol      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NewAttentionBoardEvent<T0>>(v1);
        0x2::transfer::share_object<AttentionBoard<T0>>(v0);
    }

    public fun get_message_user<T0>(arg0: &AttentionBoard<T0>, arg1: 0x2::object::ID) : address {
        assert!(0x2::object_table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg1), 5);
        0x2::object_table::borrow<0x2::object::ID, Message<T0>>(&arg0.messages, arg1).user
    }

    fun init(arg0: ATTENTION_BOARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalAdmin{id: 0x2::object::new(arg1)};
        let v1 = GlobalConfig{
            id                            : 0x2::object::new(arg1),
            admin_cap                     : 0x2::object::uid_to_inner(&v0.id),
            receiver                      : 0x2::tx_context::sender(arg1),
            refund_fee_bps                : 500,
            protocol_share_of_refund_fee  : 10000,
            protocol_share_of_success_fee : 5000,
        };
        let (v2, v3) = 0x2::coin::create_currency<ATTENTION_BOARD>(arg0, 9, b"TEST_ATTN", b"TEST_ATTN", b"TEST_ATTN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        let v5 = 0x2::tx_context::sender(arg1);
        let v6 = create_attention_board<ATTENTION_BOARD>(1, v5, arg1);
        let v7 = &mut v6;
        let v8 = 0x2::coin::mint<ATTENTION_BOARD>(&mut v4, 1000000000, arg1);
        let v9 = bid_message_test<ATTENTION_BOARD>(v7, v8, 0x1::string::utf8(b"test message 1"), arg1);
        let v10 = &mut v6;
        let v11 = 0x2::coin::mint<ATTENTION_BOARD>(&mut v4, 1500000000, arg1);
        bid_message_test<ATTENTION_BOARD>(v10, v11, 0x1::string::utf8(b"test message 2"), arg1);
        let v12 = &mut v6;
        let v13 = 0x2::coin::mint<ATTENTION_BOARD>(&mut v4, 700000000, arg1);
        bid_message_test<ATTENTION_BOARD>(v12, v13, 0x1::string::utf8(b"test message 3"), arg1);
        let v14 = &mut v6;
        let v15 = 0x2::coin::mint<ATTENTION_BOARD>(&mut v4, 100000000, arg1);
        let v16 = bid_message_test<ATTENTION_BOARD>(v14, v15, 0x1::string::utf8(b"message to submit"), arg1);
        let v17 = &mut v6;
        let v18 = 0x2::coin::mint<ATTENTION_BOARD>(&mut v4, 300000000, arg1);
        let v19 = bid_message_test<ATTENTION_BOARD>(v17, v18, 0x1::string::utf8(b"message to cancel"), arg1);
        let v20 = &mut v6;
        let v21 = 0x2::coin::mint<ATTENTION_BOARD>(&mut v4, 1000000000, arg1);
        bump_message_bid<ATTENTION_BOARD>(v20, v9, v21, arg1);
        let v22 = &mut v6;
        submit_message<ATTENTION_BOARD>(v22, v16);
        let v23 = &mut v6;
        let v24 = cancel_message<ATTENTION_BOARD>(v23, &v1, v19, arg1);
        0x2::coin::burn<ATTENTION_BOARD>(&mut v4, v24);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATTENTION_BOARD>>(v3);
        0x2::transfer::share_object<AttentionBoard<ATTENTION_BOARD>>(v6);
        0x2::transfer::share_object<GlobalConfig>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTENTION_BOARD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<GlobalAdmin>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun set_minimum_bid_as_admin<T0>(arg0: &GlobalAdmin, arg1: &mut AttentionBoard<T0>, arg2: u64) {
        arg1.minimum_bid = arg2;
    }

    public fun set_minimum_bid_as_kol<T0>(arg0: &mut AttentionBoard<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.kol, 2);
        arg0.minimum_bid = arg1;
    }

    public fun set_protocol_share_of_refund_fee(arg0: &GlobalAdmin, arg1: &mut GlobalConfig, arg2: u16) {
        assert!(arg2 <= 10000, 4);
        arg1.protocol_share_of_refund_fee = arg2;
    }

    public fun set_protocol_share_of_success_fee(arg0: &GlobalAdmin, arg1: &mut GlobalConfig, arg2: u16) {
        assert!(arg2 <= 10000, 4);
        arg1.protocol_share_of_success_fee = arg2;
    }

    public fun set_receiver_wallet(arg0: &GlobalAdmin, arg1: &mut GlobalConfig, arg2: address) {
        arg1.receiver = arg2;
    }

    public fun set_refund_fee_bps(arg0: &GlobalAdmin, arg1: &mut GlobalConfig, arg2: u16) {
        assert!(arg2 <= 10000, 4);
        arg1.refund_fee_bps = arg2;
    }

    fun submit_message<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg1), 5);
        let Message {
            id          : v0,
            user        : _,
            message     : _,
            timestamp_s : _,
            bid         : v4,
        } = 0x2::object_table::remove<0x2::object::ID, Message<T0>>(&mut arg0.messages, arg1);
        let v5 = v0;
        0x2::balance::join<T0>(&mut arg0.success_fees, 0x2::balance::split<T0>(&mut arg0.bids, v4));
        let v6 = MessageSubmittedEvent<T0>{
            board_id   : 0x2::object::uid_to_inner(&arg0.id),
            message_id : 0x2::object::uid_to_inner(&v5),
        };
        0x2::event::emit<MessageSubmittedEvent<T0>>(v6);
        0x2::object::delete(v5);
    }

    public fun submit_message_as_admin<T0>(arg0: &GlobalAdmin, arg1: &mut AttentionBoard<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        submit_message<T0>(arg1, arg2);
    }

    public fun submit_message_as_kol<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.kol, 2);
        submit_message<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

