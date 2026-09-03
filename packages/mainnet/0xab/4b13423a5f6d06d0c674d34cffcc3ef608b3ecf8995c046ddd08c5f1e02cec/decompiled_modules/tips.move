module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::tips {
    struct TipSent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        fee: u64,
        post_id: 0x1::option::Option<u64>,
    }

    fun send<T0>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfig, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg1, 1);
        let v1 = TipSent{
            from    : v0,
            to      : arg1,
            amount  : arg2,
            fee     : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::collect<T0>(arg0, arg4, arg2, arg1, arg5),
            post_id : arg3,
        };
        0x2::event::emit<TipSent>(v1);
    }

    public fun tip<T0>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfig, arg1: address, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        send<T0>(arg0, arg1, arg2, 0x1::option::none<u64>(), arg3, arg4);
    }

    public fun tip_post<T0>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfig, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::Feed, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_exists(arg1, arg2), 2);
        let v0 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post(arg1, arg2);
        send<T0>(arg0, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_author(&v0), arg3, 0x1::option::some<u64>(arg2), arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

