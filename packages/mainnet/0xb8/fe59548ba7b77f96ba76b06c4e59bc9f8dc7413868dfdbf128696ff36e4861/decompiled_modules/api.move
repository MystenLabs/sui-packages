module 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::api {
    public fun create_feed<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::PIX, T0>(arg2, &v0, arg0);
        0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::create_feed<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::Post>(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::PIX>(arg2, &v0), arg3, arg4);
    }

    public fun new_post<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: vector<u8>, arg4: u8, arg5: 0x1::option::Option<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::PostLink>, arg6: &mut 0x2::tx_context::TxContext) : 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::Post {
        let v0 = 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::PIX, T0>(arg2, &v0, arg0);
        0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::new_post(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::PIX>(arg2, &v0), arg3, arg4, arg5, arg6)
    }

    public fun post_message<T0: drop>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: &mut 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::Stream<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::Post>, arg4: 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::Post, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::PIX, T0>(arg2, &v0, arg0);
        0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::post_message<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed::Post>(arg1, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller::PIX>(arg2, &v0), arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

