module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_composer {
    struct ComposerRegistry has store {
        composers: 0x2::table::Table<address, ComposerInfo>,
    }

    struct ComposerInfo has store {
        compose_queue: address,
        lz_compose_info: vector<u8>,
    }

    struct ComposeQueue has key {
        id: 0x2::object::UID,
        composer: address,
        messages: 0x2::table::Table<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>,
    }

    struct MessageKey has copy, drop, store {
        from: address,
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        index: u16,
    }

    struct ComposeSentEvent has copy, drop {
        from: address,
        to: address,
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        index: u16,
        message: vector<u8>,
    }

    struct ComposeDeliveredEvent has copy, drop {
        from: address,
        to: address,
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        index: u16,
    }

    struct LzComposeAlertEvent has copy, drop {
        from: address,
        to: address,
        executor: address,
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        index: u16,
        gas: u64,
        value: u64,
        message: vector<u8>,
        extra_data: vector<u8>,
        reason: 0x1::ascii::String,
    }

    struct ComposerRegisteredEvent has copy, drop {
        composer: address,
        compose_queue: address,
        lz_compose_info: vector<u8>,
    }

    struct LzComposeInfoSetEvent has copy, drop {
        composer: address,
        lz_compose_info: vector<u8>,
    }

    public(friend) fun clear_compose(arg0: &mut ComposeQueue, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16, arg4: vector<u8>) {
        let v0 = MessageKey{
            from  : arg1,
            guid  : arg2,
            index : arg3,
        };
        assert!(0x2::table::contains<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(&arg0.messages, v0), 3);
        let v1 = 0x2::table::borrow_mut<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(&mut arg0.messages, v0);
        assert!(*v1 == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(&arg4)), 2);
        *v1 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::ff_bytes32();
        let v2 = ComposeDeliveredEvent{
            from  : arg1,
            to    : arg0.composer,
            guid  : arg2,
            index : arg3,
        };
        0x2::event::emit<ComposeDeliveredEvent>(v2);
    }

    public(friend) fun composer(arg0: &ComposeQueue) : address {
        arg0.composer
    }

    public(friend) fun get_compose_message_hash(arg0: &ComposeQueue, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = &arg0.messages;
        let v1 = MessageKey{
            from  : arg1,
            guid  : arg2,
            index : arg3,
        };
        assert!(0x2::table::contains<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(v0, v1), 3);
        let v2 = MessageKey{
            from  : arg1,
            guid  : arg2,
            index : arg3,
        };
        *0x2::table::borrow<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(v0, v2)
    }

    public(friend) fun get_compose_queue(arg0: &ComposerRegistry, arg1: address) : address {
        let v0 = &arg0.composers;
        assert!(0x2::table::contains<address, ComposerInfo>(v0, arg1), 4);
        0x2::table::borrow<address, ComposerInfo>(v0, arg1).compose_queue
    }

    public(friend) fun get_lz_compose_info(arg0: &ComposerRegistry, arg1: address) : &vector<u8> {
        let v0 = &arg0.composers;
        assert!(0x2::table::contains<address, ComposerInfo>(v0, arg1), 4);
        &0x2::table::borrow<address, ComposerInfo>(v0, arg1).lz_compose_info
    }

    public(friend) fun has_compose_message_hash(arg0: &ComposeQueue, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16) : bool {
        let v0 = MessageKey{
            from  : arg1,
            guid  : arg2,
            index : arg3,
        };
        0x2::table::contains<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(&arg0.messages, v0)
    }

    public(friend) fun is_registered(arg0: &ComposerRegistry, arg1: address) : bool {
        0x2::table::contains<address, ComposerInfo>(&arg0.composers, arg1)
    }

    public(friend) fun lz_compose_alert(arg0: address, arg1: address, arg2: address, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg4: u16, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::ascii::String) {
        let v0 = LzComposeAlertEvent{
            from       : arg1,
            to         : arg2,
            executor   : arg0,
            guid       : arg3,
            index      : arg4,
            gas        : arg5,
            value      : arg6,
            message    : arg7,
            extra_data : arg8,
            reason     : arg9,
        };
        0x2::event::emit<LzComposeAlertEvent>(v0);
    }

    public(friend) fun new_composer_registry(arg0: &mut 0x2::tx_context::TxContext) : ComposerRegistry {
        ComposerRegistry{composers: 0x2::table::new<address, ComposerInfo>(arg0)}
    }

    public(friend) fun register_composer(arg0: &mut ComposerRegistry, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_registered(arg0, arg1), 5);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 6);
        let v0 = ComposeQueue{
            id       : 0x2::object::new(arg3),
            composer : arg1,
            messages : 0x2::table::new<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(arg3),
        };
        let v1 = 0x2::object::id_address<ComposeQueue>(&v0);
        let v2 = ComposerInfo{
            compose_queue   : v1,
            lz_compose_info : arg2,
        };
        0x2::table::add<address, ComposerInfo>(&mut arg0.composers, arg1, v2);
        0x2::transfer::share_object<ComposeQueue>(v0);
        let v3 = ComposerRegisteredEvent{
            composer        : arg1,
            compose_queue   : v1,
            lz_compose_info : arg2,
        };
        0x2::event::emit<ComposerRegisteredEvent>(v3);
    }

    public(friend) fun send_compose(arg0: &mut ComposeQueue, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u16, arg4: vector<u8>) {
        let v0 = MessageKey{
            from  : arg1,
            guid  : arg2,
            index : arg3,
        };
        assert!(!0x2::table::contains<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(&arg0.messages, v0), 1);
        0x2::table::add<MessageKey, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(&mut arg0.messages, v0, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(&arg4)));
        let v1 = ComposeSentEvent{
            from    : arg1,
            to      : arg0.composer,
            guid    : arg2,
            index   : arg3,
            message : arg4,
        };
        0x2::event::emit<ComposeSentEvent>(v1);
    }

    public(friend) fun set_lz_compose_info(arg0: &mut ComposerRegistry, arg1: address, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 6);
        let v0 = &mut arg0.composers;
        assert!(0x2::table::contains<address, ComposerInfo>(v0, arg1), 4);
        0x2::table::borrow_mut<address, ComposerInfo>(v0, arg1).lz_compose_info = arg2;
        let v1 = LzComposeInfoSetEvent{
            composer        : arg1,
            lz_compose_info : arg2,
        };
        0x2::event::emit<LzComposeInfoSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

