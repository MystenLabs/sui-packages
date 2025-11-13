module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet {
    public fun check_balance(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0) == 0x2::tx_context::sender(arg1), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        let v0 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet>(arg0);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_balance_checked(0x2::object::id_to_address(&v0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0), 0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance(arg0)));
    }

    public fun create_wallet(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_wallet(v0, 0x2::balance::zero<0x2::sui::SUI>(), arg0);
        let v2 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet>(&v1);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_wallet_created(0x2::object::id_to_address(&v2), v0);
        0x2::transfer::public_transfer<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet>(v1, v0);
    }

    public fun get_balance(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance(arg0))
    }

    public fun get_owner(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0)
    }

    public fun get_wallet_id_address(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet) : address {
        let v0 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun receive(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0) == 0x2::tx_context::sender(arg2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        let v0 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet>(arg0);
        0x2::balance::join<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_receive_address(0x2::object::id_to_address(&v0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0), 0x2::coin::value<0x2::sui::SUI>(&arg1), 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun send(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        assert!(arg1 > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0) == 0x2::tx_context::sender(arg3), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        assert!(0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance(arg0)) >= arg1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        let v0 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance_mut(arg0), arg1, arg3), arg2);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_funds_transferred(0x2::object::id_to_address(&v0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg0), arg2, arg1, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v6
}

