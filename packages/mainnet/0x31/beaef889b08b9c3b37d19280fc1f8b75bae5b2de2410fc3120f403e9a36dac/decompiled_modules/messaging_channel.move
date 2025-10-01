module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel {
    struct MessagingChannel has key {
        id: 0x2::object::UID,
        oapp: address,
        channels: 0x2::table::Table<ChannelKey, Channel>,
        is_sending: bool,
    }

    struct ChannelKey has copy, drop, store {
        remote_eid: u32,
        remote_oapp: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct Channel has store {
        outbound_nonce: u64,
        lazy_inbound_nonce: u64,
        inbound_payload_hashes: 0x2::table::Table<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>,
    }

    struct ChannelInitializedEvent has copy, drop {
        local_oapp: address,
        remote_eid: u32,
        remote_oapp: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct PacketSentEvent has copy, drop {
        encoded_packet: vector<u8>,
        options: vector<u8>,
        send_library: address,
    }

    struct PacketVerifiedEvent has copy, drop {
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        nonce: u64,
        receiver: address,
        payload_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct PacketDeliveredEvent has copy, drop {
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        receiver: address,
        nonce: u64,
    }

    struct InboundNonceSkippedEvent has copy, drop {
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        receiver: address,
        nonce: u64,
    }

    struct PacketNilifiedEvent has copy, drop {
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        receiver: address,
        nonce: u64,
        payload_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct PacketBurntEvent has copy, drop {
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        receiver: address,
        nonce: u64,
        payload_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct LzReceiveAlertEvent has copy, drop {
        receiver: address,
        executor: address,
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        nonce: u64,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        gas: u64,
        value: u64,
        message: vector<u8>,
        extra_data: vector<u8>,
        reason: 0x1::ascii::String,
    }

    public(friend) fun assert_ownership(arg0: &MessagingChannel, arg1: address) {
        assert!(arg0.oapp == arg1, 5);
    }

    public(friend) fun burn(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) {
        let v0 = channel_mut(arg0, arg1, arg2);
        assert!(arg3 <= v0.lazy_inbound_nonce && 0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&v0.inbound_payload_hashes, arg3), 4);
        assert!(arg4 == 0x2::table::remove<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&mut v0.inbound_payload_hashes, arg3), 9);
        let v1 = PacketBurntEvent{
            src_eid      : arg1,
            sender       : arg2,
            receiver     : arg0.oapp,
            nonce        : arg3,
            payload_hash : arg4,
        };
        0x2::event::emit<PacketBurntEvent>(v1);
    }

    fun channel(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : &Channel {
        let v0 = ChannelKey{
            remote_eid  : arg1,
            remote_oapp : arg2,
        };
        let v1 = &arg0.channels;
        assert!(0x2::table::contains<ChannelKey, Channel>(v1, v0), 11);
        0x2::table::borrow<ChannelKey, Channel>(v1, v0)
    }

    fun channel_mut(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : &mut Channel {
        let v0 = ChannelKey{
            remote_eid  : arg1,
            remote_oapp : arg2,
        };
        let v1 = &mut arg0.channels;
        assert!(0x2::table::contains<ChannelKey, Channel>(v1, v0), 11);
        0x2::table::borrow_mut<ChannelKey, Channel>(v1, v0)
    }

    public(friend) fun clear_payload(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: vector<u8>) {
        let v0 = channel_mut(arg0, arg1, arg2);
        let v1 = v0.lazy_inbound_nonce;
        if (arg3 > v1) {
            let v2 = v1 + 1;
            while (v2 <= arg3) {
                assert!(0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&v0.inbound_payload_hashes, v2), 4);
                v2 = v2 + 1;
            };
            v0.lazy_inbound_nonce = arg3;
        };
        let v3 = &mut v0.inbound_payload_hashes;
        let v4 = if (0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v3, arg3)) {
            0x1::option::some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(0x2::table::remove<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v3, arg3))
        } else {
            0x1::option::none<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()
        };
        assert!(0x1::option::some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg4))) == v4, 9);
        let v5 = PacketDeliveredEvent{
            src_eid  : arg1,
            sender   : arg2,
            receiver : arg0.oapp,
            nonce    : arg3,
        };
        0x2::event::emit<PacketDeliveredEvent>(v5);
    }

    public(friend) fun confirm_send(arg0: &mut MessagingChannel, arg1: address, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, arg3: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, arg4: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult, arg5: &mut 0x2::tx_context::TxContext) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>) {
        assert!(arg0.is_sending, 7);
        arg0.is_sending = false;
        let v0 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::packet(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::base(&arg3));
        let v1 = channel_mut(arg0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(v0), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::receiver(v0));
        v1.outbound_nonce = v1.outbound_nonce + 1;
        assert!(v1.outbound_nonce == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::nonce(v0), 4);
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::fee(&arg4);
        let (v3, v4) = split_fee(arg2, v2, arg5);
        let v5 = PacketSentEvent{
            encoded_packet : *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::encoded_packet(&arg4),
            options        : *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::options(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::base(&arg3)),
            send_library   : arg1,
        };
        0x2::event::emit<PacketSentEvent>(v5);
        (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::create(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::guid(v0), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::nonce(v0), *v2), v3, v4)
    }

    public(friend) fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = MessagingChannel{
            id         : 0x2::object::new(arg1),
            oapp       : arg0,
            channels   : 0x2::table::new<ChannelKey, Channel>(arg1),
            is_sending : false,
        };
        0x2::transfer::share_object<MessagingChannel>(v0);
        0x2::object::id_address<MessagingChannel>(&v0)
    }

    public(friend) fun get_payload_hash(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = &channel(arg0, arg1, arg2).inbound_payload_hashes;
        assert!(0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v0, arg3), 9);
        *0x2::table::borrow<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v0, arg3)
    }

    public(friend) fun has_payload_hash(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64) : bool {
        0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&channel(arg0, arg1, arg2).inbound_payload_hashes, arg3)
    }

    public(friend) fun inbound_nonce(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : u64 {
        let v0 = channel(arg0, arg1, arg2);
        let v1 = v0.lazy_inbound_nonce;
        while (0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&v0.inbound_payload_hashes, v1 + 1)) {
            v1 = v1 + 1;
        };
        v1
    }

    public(friend) fun init_channel(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_channel_inited(arg0, arg1, arg2), 1);
        let v0 = ChannelKey{
            remote_eid  : arg1,
            remote_oapp : arg2,
        };
        let v1 = Channel{
            outbound_nonce         : 0,
            lazy_inbound_nonce     : 0,
            inbound_payload_hashes : 0x2::table::new<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(arg3),
        };
        0x2::table::add<ChannelKey, Channel>(&mut arg0.channels, v0, v1);
        let v2 = ChannelInitializedEvent{
            local_oapp  : arg0.oapp,
            remote_eid  : arg1,
            remote_oapp : arg2,
        };
        0x2::event::emit<ChannelInitializedEvent>(v2);
    }

    public(friend) fun is_channel_inited(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : bool {
        let v0 = ChannelKey{
            remote_eid  : arg1,
            remote_oapp : arg2,
        };
        0x2::table::contains<ChannelKey, Channel>(&arg0.channels, v0)
    }

    public(friend) fun is_sending(arg0: &MessagingChannel) : bool {
        arg0.is_sending
    }

    public(friend) fun lazy_inbound_nonce(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : u64 {
        channel(arg0, arg1, arg2).lazy_inbound_nonce
    }

    public(friend) fun lz_receive_alert(arg0: address, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: address, arg5: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::ascii::String) {
        let v0 = LzReceiveAlertEvent{
            receiver   : arg4,
            executor   : arg0,
            src_eid    : arg1,
            sender     : arg2,
            nonce      : arg3,
            guid       : arg5,
            gas        : arg6,
            value      : arg7,
            message    : arg8,
            extra_data : arg9,
            reason     : arg10,
        };
        0x2::event::emit<LzReceiveAlertEvent>(v0);
    }

    public(friend) fun next_guid(arg0: &MessagingChannel, arg1: u32, arg2: u32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::compute_guid(outbound_nonce(arg0, arg2, arg3) + 1, arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_address(arg0.oapp), arg2, arg3)
    }

    public(friend) fun nilify(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) {
        let v0 = channel_mut(arg0, arg1, arg2);
        let v1 = &v0.inbound_payload_hashes;
        let v2 = if (0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v1, arg3)) {
            0x2::table::borrow<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v1, arg3)
        } else {
            let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32();
            &v3
        };
        assert!(arg4 == *v2, 9);
        assert!(arg3 > v0.lazy_inbound_nonce || !0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(v2), 4);
        let v4 = &mut v0.inbound_payload_hashes;
        if (0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v4, arg3)) {
            *0x2::table::borrow_mut<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v4, arg3) = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::ff_bytes32();
        } else {
            0x2::table::add<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v4, arg3, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::ff_bytes32());
        };
        let v5 = PacketNilifiedEvent{
            src_eid      : arg1,
            sender       : arg2,
            receiver     : arg0.oapp,
            nonce        : arg3,
            payload_hash : arg4,
        };
        0x2::event::emit<PacketNilifiedEvent>(v5);
    }

    public(friend) fun oapp(arg0: &MessagingChannel) : address {
        arg0.oapp
    }

    public(friend) fun outbound_nonce(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : u64 {
        channel(arg0, arg1, arg2).outbound_nonce
    }

    public(friend) fun quote(arg0: &MessagingChannel, arg1: u32, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam) : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam {
        let v0 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::dst_eid(arg2);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::receiver(arg2);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::create_param(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::create(channel(arg0, v0, v1).outbound_nonce + 1, arg1, arg0.oapp, v0, v1, *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::message(arg2)), *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::options(arg2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::pay_in_zro(arg2))
    }

    public(friend) fun send(arg0: &mut MessagingChannel, arg1: u32, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam) : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam {
        assert!(!arg0.is_sending, 10);
        arg0.is_sending = true;
        let v0 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::dst_eid(arg2);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::receiver(arg2);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::create_param(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::create_param(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::create(channel(arg0, v0, v1).outbound_nonce + 1, arg1, arg0.oapp, v0, v1, *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::message(arg2)), *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::options(arg2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::pay_in_zro(arg2)))
    }

    public(friend) fun skip(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64) {
        assert!(arg3 == inbound_nonce(arg0, arg1, arg2) + 1, 4);
        let v0 = channel_mut(arg0, arg1, arg2);
        v0.lazy_inbound_nonce = arg3;
        let v1 = InboundNonceSkippedEvent{
            src_eid  : arg1,
            sender   : arg2,
            receiver : arg0.oapp,
            nonce    : arg3,
        };
        0x2::event::emit<InboundNonceSkippedEvent>(v1);
    }

    fun split_fee(arg0: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>) {
        let v0 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::native_token_mut(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(v0) >= 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::native_fee(arg1), 2);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(v0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::native_fee(arg1), arg2);
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::zro_token_mut(arg0);
        let v3 = if (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::zro_fee(arg1) > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v2) && 0x2::coin::value<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>(0x1::option::borrow<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v2)) >= 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::zro_fee(arg1), 3);
            0x2::coin::split<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>(0x1::option::borrow_mut<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::zro_fee(arg1), arg2)
        } else {
            0x2::coin::zero<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>(arg2)
        };
        (v1, v3)
    }

    public(friend) fun verifiable(arg0: &MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64) : bool {
        arg3 > lazy_inbound_nonce(arg0, arg1, arg2) || has_payload_hash(arg0, arg1, arg2, arg3)
    }

    public(friend) fun verify(arg0: &mut MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) {
        assert!(verifiable(arg0, arg1, arg2, arg3), 8);
        assert!(!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&arg4), 6);
        let v0 = channel_mut(arg0, arg1, arg2);
        let v1 = &mut v0.inbound_payload_hashes;
        if (0x2::table::contains<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v1, arg3)) {
            *0x2::table::borrow_mut<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v1, arg3) = arg4;
        } else {
            0x2::table::add<u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v1, arg3, arg4);
        };
        let v2 = PacketVerifiedEvent{
            src_eid      : arg1,
            sender       : arg2,
            nonce        : arg3,
            receiver     : arg0.oapp,
            payload_hash : arg4,
        };
        0x2::event::emit<PacketVerifiedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

