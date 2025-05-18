module 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet {
    struct WithdrawEvent has copy, drop {
        withdraw_id: u256,
        token: 0x1::type_name::TypeName,
        reduced: u64,
        to_addr: address,
    }

    struct QuickWithdrawEvent has copy, drop {
        withdraw_id: u256,
        token: 0x1::type_name::TypeName,
        reduced: u64,
        to_addr: address,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        operator: address,
        token: 0x1::type_name::TypeName,
        reduced: u64,
        to_addr: address,
    }

    struct DepositEvent has copy, drop {
        deposit_id: u256,
        account_id: u256,
        token: 0x1::type_name::TypeName,
        amount: u64,
        checksum: vector<u8>,
    }

    public fun deposit<T0>(arg0: &0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::balance::Balance<T0>, arg3: u256, arg4: u256, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::when_not_paused(arg0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_allow_version(arg0);
        let v0 = DepositEvent{
            deposit_id : arg3,
            account_id : arg4,
            token      : 0x1::type_name::get<T0>(),
            amount     : 0x2::balance::value<T0>(&arg2),
            checksum   : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::deposit<T0>(arg1, arg2, arg6);
    }

    public fun emergency_withdraw<T0>(arg0: &0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletTokenHolder, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_operator(arg0, arg3);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::when_emergency_withdraw_to_not_null(arg0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_allow_version(arg0);
        let v0 = 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::emergency_withdraw_to(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::withdraw<T0>(arg1, arg2), arg3), v0);
        let v1 = EmergencyWithdrawEvent{
            operator : 0x2::tx_context::sender(arg3),
            token    : 0x1::type_name::get<T0>(),
            reduced  : arg2,
            to_addr  : v0,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v1);
    }

    public(friend) fun get_withdraw_sign_msg<T0>(arg0: 0x1::string::String, arg1: u256, arg2: u64, arg3: address, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(2)));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b"withdraw");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg1)));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg2 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg4 as u256))));
        v0
    }

    public fun quick_withdraw<T0>(arg0: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletTokenHolder, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext, arg4: u256, arg5: u64, arg6: address, arg7: u64) {
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_quick_withdrawer(arg0, arg3);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::when_not_paused(arg0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_allow_version(arg0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::when_not_expired(arg2, arg7);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::check_quick_withdraw_id_used(arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::withdraw<T0>(arg1, arg5), arg3), arg6);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::mark_quick_withdraw_id_used(arg0, arg4);
        let v0 = QuickWithdrawEvent{
            withdraw_id : arg4,
            token       : 0x1::type_name::get<T0>(),
            reduced     : arg5,
            to_addr     : arg6,
        };
        0x2::event::emit<QuickWithdrawEvent>(v0);
    }

    public fun set_withdraw_allow_list<T0>(arg0: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletTokenHolder, arg1: &0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_admin(arg1, arg3);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::set_withdraw_allow_list<T0>(arg0, arg2);
    }

    public fun withdraw<T0>(arg0: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::CloudWalletTokenHolder, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u256, arg5: address, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_trusted_bot(arg0, arg9);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::when_not_paused(arg0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::when_not_expired(arg2, arg7);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::only_allow_version(arg0);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::check_withdraw_whitelist<T0>(arg1, arg5);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::check_withdraw_id_used(arg0, arg4);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::check_signer(0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::utils::ecrecover(arg8, 0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::utils::keccak_message(get_withdraw_sign_msg<T0>(arg3, arg4, arg6, arg5, arg7))), arg0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::withdraw<T0>(arg1, arg6), arg9), arg5);
        0x5ab6fd42bfc38655015e47c913afe577487a2774f09d9b3cf31fada5f069fd30::cloud_wallet_config::mark_withdraw_id_used(arg0, arg4);
        let v0 = WithdrawEvent{
            withdraw_id : arg4,
            token       : 0x1::type_name::get<T0>(),
            reduced     : arg6,
            to_addr     : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

