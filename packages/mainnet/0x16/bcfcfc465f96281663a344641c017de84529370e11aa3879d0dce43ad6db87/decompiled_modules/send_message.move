module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::send_message {
    struct MessageSent has copy, drop {
        message: vector<u8>,
    }

    struct SendMessageTicket<T0: drop> {
        auth: T0,
        destination_domain: u32,
        recipient: address,
        destination_caller: address,
        min_finality_threshold: u32,
        message_body: vector<u8>,
    }

    public fun send_message<T0: drop>(arg0: SendMessageTicket<T0>, arg1: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::Message {
        let SendMessageTicket {
            auth                   : v0,
            destination_domain     : v1,
            recipient              : v2,
            destination_caller     : v3,
            min_finality_threshold : v4,
            message_body           : v5,
        } = arg0;
        send_message_impl<T0>(arg1, v0, v1, v2, v5, v3, v4)
    }

    public fun create_send_message_ticket<T0: drop>(arg0: T0, arg1: u32, arg2: address, arg3: address, arg4: u32, arg5: vector<u8>) : SendMessageTicket<T0> {
        SendMessageTicket<T0>{
            auth                   : arg0,
            destination_domain     : arg1,
            recipient              : arg2,
            destination_caller     : arg3,
            min_finality_threshold : arg4,
            message_body           : arg5,
        }
    }

    fun send_message_impl<T0: drop>(arg0: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg1: T0, arg2: u32, arg3: address, arg4: vector<u8>, arg5: address, arg6: u32) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::Message {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg0));
        assert!(!0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::paused(arg0), 0);
        assert!(arg2 != 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::local_domain(arg0), 3);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::new(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::message_version(arg0), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::local_domain(arg0), arg2, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<T0>(), arg3, arg5, arg6, arg4);
        serialize_message_and_emit_event(v0, arg0);
        v0
    }

    fun serialize_message_and_emit_event(arg0: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::Message, arg1: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State) {
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::message_body(&arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::max_message_body_size(arg1), 1);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::recipient(&arg0) != @0x0, 2);
        let v1 = MessageSent{message: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::serialize(&arg0)};
        0x2::event::emit<MessageSent>(v1);
    }

    // decompiled from Move bytecode v7
}

