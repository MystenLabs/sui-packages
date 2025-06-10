module 0xaca9b417a1b46447ad02a736d4dcd71f0688af1d2f4c01ae57f187e0083b052a::attention_board {
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
        messages: 0x2::table::Table<0x2::object::ID, Message<T0>>,
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

    public fun bid_message<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.minimum_bid, 1);
        0x2::balance::join<T0>(&mut arg0.bids, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Message<T0>{
            id          : 0x2::object::new(arg4),
            user        : 0x2::tx_context::sender(arg4),
            message     : arg2,
            timestamp_s : ((0x2::clock::timestamp_ms(arg3) / 1000) as u32),
            bid         : 0x2::coin::value<T0>(&arg1),
        };
        0x2::table::add<0x2::object::ID, Message<T0>>(&mut arg0.messages, 0x2::object::uid_to_inner(&v0.id), v0);
    }

    public fun bump_message_bid<T0>(arg0: &mut AttentionBoard<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg1), 5);
        0x2::balance::join<T0>(&mut arg0.bids, 0x2::coin::into_balance<T0>(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Message<T0>>(&mut arg0.messages, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.user, 3);
        v0.bid = v0.bid + 0x2::coin::value<T0>(&arg2);
    }

    fun cancel_message<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg2), 5);
        let Message {
            id          : v0,
            user        : _,
            message     : _,
            timestamp_s : _,
            bid         : v4,
        } = 0x2::table::remove<0x2::object::ID, Message<T0>>(&mut arg0.messages, arg2);
        0x2::object::delete(v0);
        let v5 = 0x2::balance::split<T0>(&mut arg0.bids, v4);
        0x2::balance::join<T0>(&mut arg0.refund_fees, 0x2::balance::split<T0>(&mut v5, (((arg1.refund_fee_bps as u128) * (v4 as u128) / 10000) as u64)));
        0x2::coin::from_balance<T0>(v5, arg3)
    }

    public fun cancel_message_as_admin<T0>(arg0: &GlobalAdmin, arg1: &mut AttentionBoard<T0>, arg2: &GlobalConfig, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        cancel_message<T0>(arg1, arg2, arg3, arg4)
    }

    public fun cancel_message_as_kol<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.kol, 2);
        cancel_message<T0>(arg0, arg1, arg2, arg3)
    }

    public fun cancel_message_as_user<T0>(arg0: &mut AttentionBoard<T0>, arg1: &GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == 0x2::table::borrow<0x2::object::ID, Message<T0>>(&arg0.messages, arg2).user, 3);
        cancel_message<T0>(arg0, arg1, arg2, arg3)
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

    public fun create_attention_board_as_admin<T0>(arg0: &GlobalAdmin, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        let v0 = AttentionBoard<T0>{
            id           : 0x2::object::new(arg3),
            kol          : arg1,
            messages     : 0x2::table::new<0x2::object::ID, Message<T0>>(arg3),
            minimum_bid  : arg2,
            bids         : 0x2::balance::zero<T0>(),
            success_fees : 0x2::balance::zero<T0>(),
            refund_fees  : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<AttentionBoard<T0>>(v0);
    }

    public fun create_attention_board_as_kol<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 6);
        let v0 = AttentionBoard<T0>{
            id           : 0x2::object::new(arg1),
            kol          : 0x2::tx_context::sender(arg1),
            messages     : 0x2::table::new<0x2::object::ID, Message<T0>>(arg1),
            minimum_bid  : arg0,
            bids         : 0x2::balance::zero<T0>(),
            success_fees : 0x2::balance::zero<T0>(),
            refund_fees  : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<AttentionBoard<T0>>(v0);
    }

    public fun get_message_user<T0>(arg0: &AttentionBoard<T0>, arg1: 0x2::object::ID) : address {
        assert!(0x2::table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg1), 5);
        0x2::table::borrow<0x2::object::ID, Message<T0>>(&arg0.messages, arg1).user
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalAdmin{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id                            : 0x2::object::new(arg0),
            admin_cap                     : 0x2::object::uid_to_inner(&v0.id),
            receiver                      : 0x2::tx_context::sender(arg0),
            refund_fee_bps                : 500,
            protocol_share_of_refund_fee  : 10000,
            protocol_share_of_success_fee : 5000,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
        0x2::transfer::public_transfer<GlobalAdmin>(v0, 0x2::tx_context::sender(arg0));
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
        assert!(0x2::table::contains<0x2::object::ID, Message<T0>>(&arg0.messages, arg1), 5);
        let Message {
            id          : v0,
            user        : _,
            message     : _,
            timestamp_s : _,
            bid         : v4,
        } = 0x2::table::remove<0x2::object::ID, Message<T0>>(&mut arg0.messages, arg1);
        0x2::balance::join<T0>(&mut arg0.success_fees, 0x2::balance::split<T0>(&mut arg0.bids, v4));
        0x2::object::delete(v0);
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

