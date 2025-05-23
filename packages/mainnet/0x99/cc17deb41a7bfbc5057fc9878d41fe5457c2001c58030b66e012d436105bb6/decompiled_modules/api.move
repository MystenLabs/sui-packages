module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::api {
    public fun create_conversation<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM, T0>(arg2, &v0, arg0);
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::create_conversation<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM>(arg2, &v0), arg3, arg4, arg5);
    }

    public fun create_conversation_message<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message {
        let v0 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM, T0>(arg2, &v0, arg0);
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::create_conversation_message(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM>(arg2, &v0), arg3, arg4, arg5, arg6)
    }

    public fun create_conversation_with_message<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: address, arg4: 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM, T0>(arg2, &v0, arg0);
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::create_conversation_with_message<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM>(arg2, &v0), arg3, arg4, arg5, arg6);
    }

    public fun create_profile<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM, T0>(arg2, &v0, arg1);
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::create_profile(arg0, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM>(arg2, &v0), arg3, arg4);
    }

    public fun send_message<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: &mut 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>, arg4: 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM, T0>(arg2, &v0, arg0);
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::send_message<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller::PIM>(arg2, &v0), arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

