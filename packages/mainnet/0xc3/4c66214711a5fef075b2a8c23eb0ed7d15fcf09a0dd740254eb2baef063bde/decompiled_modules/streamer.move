module 0xc34c66214711a5fef075b2a8c23eb0ed7d15fcf09a0dd740254eb2baef063bde::streamer {
    struct StreamHub has key {
        id: 0x2::object::UID,
        messages: 0x2::table::Table<0x1::ascii::String, ChannelConfig>,
        version: u8,
    }

    struct ChannelConfig has store {
        owner: address,
        publisher: address,
        status: u8,
        subscriber_a: address,
        subscriber_b: address,
        fanout_ratio: u8,
        messages: 0x2::table::Table<0x2::object::ID, MessageMeta>,
    }

    struct MessageMeta has copy, drop, store {
        message_type: 0x1::ascii::String,
        sequence: u64,
        delivered: bool,
    }

    struct ChannelCreated has copy, drop {
        channel_id: 0x1::ascii::String,
        owner: address,
    }

    struct MessagePublished has copy, drop {
        channel_id: 0x1::ascii::String,
        message_id: 0x2::object::ID,
        message_type: 0x1::ascii::String,
        sequence: u64,
    }

    struct DeliveryCompleted has copy, drop {
        channel_id: 0x1::ascii::String,
        message_id: 0x2::object::ID,
        result_sequence: u64,
    }

    public fun archive_message(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut StreamHub, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg1.messages, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, ChannelConfig>(&mut arg1.messages, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.publisher, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, MessageMeta>(&v0.messages, arg3);
            !v3.delivered && v3.sequence > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, MessageMeta>(&mut v0.messages, arg3).delivered = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.fanout_ratio as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.subscriber_b);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.subscriber_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.subscriber_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.subscriber_b);
        };
        let v7 = DeliveryCompleted{
            channel_id      : arg2,
            message_id      : arg3,
            result_sequence : v5,
        };
        0x2::event::emit<DeliveryCompleted>(v7);
    }

    public entry fun create_channel(arg0: &mut StreamHub, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = ChannelConfig{
            owner        : 0x2::tx_context::sender(arg6),
            publisher    : arg2,
            status       : 0,
            subscriber_a : arg3,
            subscriber_b : arg4,
            fanout_ratio : arg5,
            messages     : 0x2::table::new<0x2::object::ID, MessageMeta>(arg6),
        };
        0x2::table::add<0x1::ascii::String, ChannelConfig>(&mut arg0.messages, arg1, v0);
        let v1 = ChannelCreated{
            channel_id : arg1,
            owner      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ChannelCreated>(v1);
    }

    public fun deliver_batch<T0>(arg0: &mut StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, ChannelConfig>(&mut arg0.messages, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.publisher, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, MessageMeta>(&mut v0.messages, arg2).delivered = true;
        };
        let v3 = v2 * (v0.fanout_ratio as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.subscriber_b);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.subscriber_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.subscriber_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.subscriber_b);
        };
        let v4 = DeliveryCompleted{
            channel_id      : arg1,
            message_id      : arg2,
            result_sequence : v2,
        };
        0x2::event::emit<DeliveryCompleted>(v4);
    }

    public fun forward_message<T0: store + key>(arg0: &mut StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, ChannelConfig>(&mut arg0.messages, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.publisher, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, MessageMeta>(&v0.messages, arg2);
            !v3.delivered && v3.sequence > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, MessageMeta>(&mut v0.messages, arg2).delivered = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.subscriber_b);
        let v4 = DeliveryCompleted{
            channel_id      : arg1,
            message_id      : arg2,
            result_sequence : 1,
        };
        0x2::event::emit<DeliveryCompleted>(v4);
    }

    public fun get_channel_info(arg0: &StreamHub, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1);
        (v0.owner, v0.publisher, v0.status & 1 != 0, v0.subscriber_a, v0.subscriber_b, v0.fanout_ratio)
    }

    public fun get_message_info(arg0: &StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1);
        assert!(0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, MessageMeta>(&v0.messages, arg2);
        (v1.message_type, v1.sequence, v1.delivered)
    }

    public fun get_message_sequence(arg0: &StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, MessageMeta>(&v0.messages, arg2);
        if (v1.delivered) {
            return 0
        };
        v1.sequence
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamHub{
            id       : 0x2::object::new(arg0),
            messages : 0x2::table::new<0x1::ascii::String, ChannelConfig>(arg0),
            version  : 1,
        };
        0x2::transfer::share_object<StreamHub>(v0);
    }

    public entry fun open_channel(arg0: &mut StreamHub, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, ChannelConfig>(&mut arg0.messages, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public entry fun publish_message(arg0: &mut StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, ChannelConfig>(&mut arg0.messages, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.publisher, 100);
        let v2 = MessageMeta{
            message_type : arg3,
            sequence     : arg4,
            delivered    : false,
        };
        if (0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, MessageMeta>(&mut v0.messages, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, MessageMeta>(&mut v0.messages, arg2, v2);
        };
        let v3 = MessagePublished{
            channel_id   : arg1,
            message_id   : arg2,
            message_type : arg3,
            sequence     : arg4,
        };
        0x2::event::emit<MessagePublished>(v3);
    }

    public fun should_deliver(arg0: &StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_message_sequence(arg0, arg1, arg2) > 0
    }

    public entry fun update_sequence(arg0: &mut StreamHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, ChannelConfig>(&arg0.messages, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, ChannelConfig>(&mut arg0.messages, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.publisher, 100);
        assert!(0x2::table::contains<0x2::object::ID, MessageMeta>(&v0.messages, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, MessageMeta>(&mut v0.messages, arg2).sequence = arg3;
    }

    // decompiled from Move bytecode v6
}

