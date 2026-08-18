module 0xcee0ed623cdc47f539286d0c6bdad4ae7b5a61fbc4b04f2972f67b9e4ce577d3::retention_cashback {
    struct RetentionCashback has drop {
        dummy_field: bool,
    }

    struct CashbackKey has copy, drop, store {
        key: vector<u8>,
    }

    struct RetentionCashbackGrantedEvent has copy, drop {
        player: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        key: vector<u8>,
    }

    public fun admin_grant_cashback<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        grant_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    fun grant_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13906834500760895489);
        let v0 = CashbackKey{key: arg3};
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::df_exists<CashbackKey>(arg0, v0), 13906834517940895747);
        let v1 = RetentionCashback{dummy_field: false};
        let v2 = CashbackKey{key: arg3};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_df<RetentionCashback, CashbackKey, u64>(arg0, v1, v2, arg2);
        let v3 = RetentionCashback{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, RetentionCashback>(arg0, v3, arg2), arg4), arg1);
        let v4 = RetentionCashbackGrantedEvent{
            player    : arg1,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg2,
            key       : arg3,
        };
        0x2::event::emit<RetentionCashbackGrantedEvent>(v4);
    }

    public fun manager_grant_cashback<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<RetentionCashback>(arg1, 0x2::tx_context::sender(arg5));
        grant_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

