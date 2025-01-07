module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message {
    struct MessageSent has copy, drop {
        message: vector<u8>,
    }

    struct SendMessageTicket<T0: drop> {
        auth: T0,
        destination_domain: u32,
        recipient: address,
        message_body: vector<u8>,
    }

    struct SendMessageWithCallerTicket<T0: drop> {
        auth: T0,
        destination_domain: u32,
        recipient: address,
        destination_caller: address,
        message_body: vector<u8>,
    }

    struct ReplaceMessageTicket<T0: drop> {
        auth: T0,
        original_raw_message: vector<u8>,
        original_attestation: vector<u8>,
        new_message_body: 0x1::option::Option<vector<u8>>,
        new_destination_caller: 0x1::option::Option<address>,
    }

    public fun send_message<T0: drop>(arg0: SendMessageTicket<T0>, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message {
        let SendMessageTicket {
            auth               : v0,
            destination_domain : v1,
            recipient          : v2,
            message_body       : v3,
        } = arg0;
        send_message_impl<T0>(arg1, v0, v1, v2, v3, @0x0)
    }

    public fun create_replace_message_ticket<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<address>) : ReplaceMessageTicket<T0> {
        ReplaceMessageTicket<T0>{
            auth                   : arg0,
            original_raw_message   : arg1,
            original_attestation   : arg2,
            new_message_body       : arg3,
            new_destination_caller : arg4,
        }
    }

    public fun create_send_message_ticket<T0: drop>(arg0: T0, arg1: u32, arg2: address, arg3: vector<u8>) : SendMessageTicket<T0> {
        SendMessageTicket<T0>{
            auth               : arg0,
            destination_domain : arg1,
            recipient          : arg2,
            message_body       : arg3,
        }
    }

    public fun create_send_message_with_caller_ticket<T0: drop>(arg0: T0, arg1: u32, arg2: address, arg3: address, arg4: vector<u8>) : SendMessageWithCallerTicket<T0> {
        SendMessageWithCallerTicket<T0>{
            auth               : arg0,
            destination_domain : arg1,
            recipient          : arg2,
            destination_caller : arg3,
            message_body       : arg4,
        }
    }

    public fun replace_message<T0: drop>(arg0: ReplaceMessageTicket<T0>, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message {
        let ReplaceMessageTicket {
            auth                   : _,
            original_raw_message   : v1,
            original_attestation   : v2,
            new_message_body       : v3,
            new_destination_caller : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v3;
        let v7 = v1;
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg1));
        assert!(!0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::paused(arg1), 0);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::attestation::verify_attestation_signatures(v7, v2, arg1);
        let v8 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::from_bytes(&v7);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::sender(&v8) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T0>(), 4);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::source_domain(&v8) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 5);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::update_destination_caller(&mut v8, 0x1::option::get_with_default<address>(&v5, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_caller(&v8)));
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::update_message_body(&mut v8, 0x1::option::get_with_default<vector<u8>>(&v6, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body(&v8)));
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::update_version(&mut v8, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::message_version(arg1));
        serialize_message_and_emit_event(v8, arg1);
        v8
    }

    fun send_message_impl<T0: drop>(arg0: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg1: T0, arg2: u32, arg3: address, arg4: vector<u8>, arg5: address) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg0));
        assert!(!0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::paused(arg0), 0);
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::new(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::message_version(arg0), 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg0), arg2, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::reserve_and_increment_nonce(arg0), 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T0>(), arg3, arg5, arg4);
        serialize_message_and_emit_event(v0, arg0);
        v0
    }

    public fun send_message_with_caller<T0: drop>(arg0: SendMessageWithCallerTicket<T0>, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message {
        let SendMessageWithCallerTicket {
            auth               : v0,
            destination_domain : v1,
            recipient          : v2,
            destination_caller : v3,
            message_body       : v4,
        } = arg0;
        assert!(v3 != @0x0, 3);
        send_message_impl<T0>(arg1, v0, v1, v2, v4, v3)
    }

    fun serialize_message_and_emit_event(arg0: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body(&arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::max_message_body_size(arg1), 1);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::recipient(&arg0) != @0x0, 2);
        let v1 = MessageSent{message: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::serialize(&arg0)};
        0x2::event::emit<MessageSent>(v1);
    }

    // decompiled from Move bytecode v6
}

