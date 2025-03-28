module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::send_message {
    struct MessageSent has copy, drop {
        message: vector<u8>,
    }

    public fun send_message<T0: drop>(arg0: T0, arg1: u32, arg2: address, arg3: vector<u8>, arg4: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message {
        send_message_impl<T0>(arg4, arg0, arg1, arg2, arg3, @0x0)
    }

    public fun auth_caller_identifier<T0: drop>() : address {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 3);
        let v1 = 0x1::type_name::into_string(v0);
        0x2::address::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v1)))
    }

    public fun replace_message<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<address>, arg5: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg5));
        assert!(!0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::paused(arg5), 0);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::attestation::verify_attestation_signatures(arg1, arg2, arg5);
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::from_bytes(&arg1);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::sender(&v0) == auth_caller_identifier<T0>(), 5);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::source_domain(&v0) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg5), 6);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::update_destination_caller(&mut v0, 0x1::option::get_with_default<address>(&arg4, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::destination_caller(&v0)));
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::update_message_body(&mut v0, 0x1::option::get_with_default<vector<u8>>(&arg3, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::message_body(&v0)));
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::update_version(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::message_version(arg5));
        serialize_message_and_emit_event(v0, arg5);
        v0
    }

    fun send_message_impl<T0: drop>(arg0: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg1: T0, arg2: u32, arg3: address, arg4: vector<u8>, arg5: address) : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg0));
        assert!(!0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::paused(arg0), 0);
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::new(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::message_version(arg0), 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg0), arg2, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::reserve_and_increment_nonce(arg0), auth_caller_identifier<T0>(), arg3, arg5, arg4);
        serialize_message_and_emit_event(v0, arg0);
        v0
    }

    public fun send_message_with_caller<T0: drop>(arg0: T0, arg1: u32, arg2: address, arg3: address, arg4: vector<u8>, arg5: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message {
        assert!(arg3 != @0x0, 4);
        send_message_impl<T0>(arg5, arg0, arg1, arg2, arg4, arg3)
    }

    fun serialize_message_and_emit_event(arg0: 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) {
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::message_body(&arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::max_message_body_size(arg1), 1);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::recipient(&arg0) != @0x0, 2);
        let v1 = MessageSent{message: 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::serialize(&arg0)};
        0x2::event::emit<MessageSent>(v1);
    }

    // decompiled from Move bytecode v6
}

