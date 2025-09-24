module 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet {
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

    struct MMCreditEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CreditEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct MMWithdrawEvent has copy, drop {
        withdraw_id: u256,
        token: 0x1::type_name::TypeName,
        amount: u64,
        to: address,
    }

    struct LPBWithdrawEvent has copy, drop {
        withdraw_id: u256,
        token: 0x1::type_name::TypeName,
        reduced: u64,
        to_addr: address,
    }

    struct CloudWalletSwapping {
        id: 0x2::object::ID,
        swap_id: u256,
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
    }

    struct LPBSwapEvent has copy, drop {
        swap_id: u256,
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        to_amount: u64,
    }

    struct LPBCreditEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct UserDepositEvent has copy, drop {
        deposit_id: u256,
        account_id: u256,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun credit_coin<T0>(arg0: &0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_operator(arg0, arg3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        let v0 = CreditEvent{
            token  : 0x1::type_name::get<T0>(),
            amount : 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::credit_coin<T0>(arg1, arg2, arg3),
        };
        0x2::event::emit<CreditEvent>(v0);
    }

    public fun deposit<T0>(arg0: &0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::balance::Balance<T0>, arg3: u256, arg4: u256, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        let v0 = DepositEvent{
            deposit_id : arg3,
            account_id : arg4,
            token      : 0x1::type_name::get<T0>(),
            amount     : 0x2::balance::value<T0>(&arg2),
            checksum   : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::deposit<T0>(arg1, arg2, arg6);
    }

    public fun emergency_withdraw<T0>(arg0: &0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_operator(arg0, arg4);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_emergency_withdraw_to_not_null(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_emergency_withdraw_to_match(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::withdraw<T0>(arg1, arg2), arg4), arg3);
        let v0 = EmergencyWithdrawEvent{
            operator : 0x2::tx_context::sender(arg4),
            token    : 0x1::type_name::get<T0>(),
            reduced  : arg2,
            to_addr  : arg3,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v0);
    }

    public(friend) fun get_lpb_swap_sign_msg<T0, T1>(arg0: address, arg1: u256, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(2)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b"lpb_swap");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg1)));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg2 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg3 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg4 as u256))));
        v0
    }

    public(friend) fun get_lpb_withdraw_sign_msg<T0>(arg0: address, arg1: u256, arg2: u64, arg3: address, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(2)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b"lpb_withdraw");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg1)));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg2 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg4 as u256))));
        v0
    }

    public(friend) fun get_mm_withdraw_sign_msg<T0>(arg0: address, arg1: u256, arg2: u64, arg3: address, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(2)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b"mm_withdraw");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg1)));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg2 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg4 as u256))));
        v0
    }

    public(friend) fun get_user_deposit_sign_msg<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(2)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b"user_deposit");
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg1)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg2)));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg3 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg4 as u256))));
        v0
    }

    public fun lpb_after_swap<T0>(arg0: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg1: 0x2::coin::Coin<T0>, arg2: 0x93394866c757b9688d8cb8180733880bc82e0204c50c96948952af22786fb4ed::swap::Swapping, arg3: CloudWalletSwapping, arg4: &mut 0x2::tx_context::TxContext) {
        let CloudWalletSwapping {
            id                : v0,
            swap_id           : v1,
            from_coin_type    : v2,
            total_from_amount : v3,
        } = arg3;
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_swapping_id_match(v0, &arg2);
        let v4 = 0x93394866c757b9688d8cb8180733880bc82e0204c50c96948952af22786fb4ed::swap::after_swap<T0>(arg1, arg2);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::deposit<T0>(arg0, 0x2::coin::into_balance<T0>(v4), arg4);
        let v5 = LPBSwapEvent{
            swap_id           : v1,
            from_coin_type    : v2,
            total_from_amount : v3,
            to_coin_type      : 0x1::type_name::get<T0>(),
            to_amount         : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<LPBSwapEvent>(v5);
    }

    public fun lpb_before_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg2: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg3: u256, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x93394866c757b9688d8cb8180733880bc82e0204c50c96948952af22786fb4ed::swap::Swapping, CloudWalletSwapping) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_lpb_trusted_bot(arg1, arg8);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg1);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_expired(arg0, arg6);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg1);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_lpb_swap_id_used(arg1, arg3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::mark_lpb_swap_id_used(arg1, arg3);
        let v0 = 0x2::object::id<0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder>(arg2);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_signer(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::utils::ecrecover(arg7, get_lpb_swap_sign_msg<T0, T1>(0x2::object::id_to_address(&v0), arg3, arg4, arg5, arg6)), arg1, 1);
        let v1 = 0x93394866c757b9688d8cb8180733880bc82e0204c50c96948952af22786fb4ed::swap::before_swap<T0, T1>(arg4, arg5, arg8);
        let v2 = CloudWalletSwapping{
            id                : 0x93394866c757b9688d8cb8180733880bc82e0204c50c96948952af22786fb4ed::swap::get_swapping_id(&v1),
            swap_id           : arg3,
            from_coin_type    : 0x1::type_name::get<T0>(),
            total_from_amount : arg4,
        };
        (0x2::coin::from_balance<T0>(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::withdraw<T0>(arg2, arg4), arg8), v1, v2)
    }

    public fun lpb_credit<T0>(arg0: &0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_lpb_trusted_bot(arg0, arg3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        let v0 = LPBCreditEvent{
            token  : 0x1::type_name::get<T0>(),
            amount : 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::credit_coin<T0>(arg1, arg2, arg3),
        };
        0x2::event::emit<LPBCreditEvent>(v0);
    }

    public fun lpb_withdraw<T0>(arg0: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: &0x2::clock::Clock, arg3: u256, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_lpb_trusted_bot(arg0, arg8);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_expired(arg2, arg6);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_withdraw_whitelist<T0>(arg1, arg4);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_withdraw_id_used(arg0, arg3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::mark_withdraw_id_used(arg0, arg3);
        let v0 = 0x2::object::id<0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder>(arg1);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_signer(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::utils::ecrecover(arg7, get_lpb_withdraw_sign_msg<T0>(0x2::object::id_to_address(&v0), arg3, arg5, arg4, arg6)), arg0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::withdraw<T0>(arg1, arg5), arg8), arg4);
        let v1 = LPBWithdrawEvent{
            withdraw_id : arg3,
            token       : 0x1::type_name::get<T0>(),
            reduced     : arg5,
            to_addr     : arg4,
        };
        0x2::event::emit<LPBWithdrawEvent>(v1);
    }

    public fun mm_credit<T0>(arg0: &0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        let v0 = MMCreditEvent{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<MMCreditEvent>(v0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::deposit<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    public fun mm_withdraw<T0>(arg0: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: &0x2::clock::Clock, arg3: u256, arg4: u64, arg5: address, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_mm_trusted_bot(arg0, arg8);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_expired(arg2, arg6);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_mm_withdraw_id_used(arg0, arg3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_signer(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::utils::ecrecover(arg7, get_mm_withdraw_sign_msg<T0>(0x2::object::id_address<0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder>(arg1), arg3, arg4, arg5, arg6)), arg0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::withdraw<T0>(arg1, arg4), arg8), arg5);
        let v0 = MMWithdrawEvent{
            withdraw_id : arg3,
            token       : 0x1::type_name::get<T0>(),
            amount      : arg4,
            to          : arg5,
        };
        0x2::event::emit<MMWithdrawEvent>(v0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::mark_mm_withdraw_id_used(arg0, arg3);
    }

    public fun quick_withdraw<T0>(arg0: &0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::QuickWithdrawCap, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg2: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg3: &0x2::clock::Clock, arg4: u256, arg5: u64, arg6: u64) : 0x2::balance::Balance<T0> {
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_latest_withdraw_cap(arg1, arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg1);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg1);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_expired(arg3, arg6);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_quick_withdraw_id_used(arg1, arg4);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::mark_quick_withdraw_id_used(arg1, arg4);
        let v0 = QuickWithdrawEvent{
            withdraw_id : arg4,
            token       : 0x1::type_name::get<T0>(),
            reduced     : arg5,
            to_addr     : 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::vault_token_holder_address(arg1),
        };
        0x2::event::emit<QuickWithdrawEvent>(v0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::withdraw<T0>(arg2, arg5)
    }

    public fun user_deposit<T0>(arg0: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::balance::Balance<T0>, arg3: u256, arg4: u256, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != 0, 60001);
        assert!(arg4 != 0, 60002);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x2::sui::SUI>(), 60003);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::when_not_paused(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::only_allow_version(arg0);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_user_deposit_id_used(arg0, arg3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::mark_user_deposit_id_used(arg0, arg3, arg7);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::object::id<0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::CloudWalletTokenHolder>(arg1);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::check_signer(0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::utils::ecrecover(arg5, get_user_deposit_sign_msg<T0>(0x2::object::id_to_address(&v1), arg3, arg4, v0, arg6)), arg0, 3);
        0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::cloud_wallet_config::deposit<T0>(arg1, arg2, arg7);
        let v2 = UserDepositEvent{
            deposit_id : arg3,
            account_id : arg4,
            token      : 0x1::type_name::get<T0>(),
            amount     : v0,
        };
        0x2::event::emit<UserDepositEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

