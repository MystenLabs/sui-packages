module 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        ika: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun deposit_ika(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
    }

    public fun deposit_sui(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun drain(arg0: &mut Treasury, arg1: &0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::acl::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui), arg2))
    }

    fun give_back(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun ika_value(arg0: &Treasury) : u64 {
        0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.ika)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id  : 0x2::object::new(arg0),
            ika : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun pay_dkg_zero_trust(arg0: &mut Treasury, arg1: &0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::acl::OperatorCap, arg2: &mut 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::Account, arg3: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg4: 0x2::object::ID, arg5: u32, arg6: vector<u8>, arg7: vector<u8>, arg8: address, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = take(arg0, arg12);
        let v2 = v1;
        let v3 = v0;
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::dkg::request_dkg_zero_trust(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, &mut v3, &mut v2, arg12);
        give_back(arg0, v3, v2);
    }

    public fun pay_presign(arg0: &mut Treasury, arg1: &0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::acl::OperatorCap, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: u32, arg5: u32, arg6: vector<u8>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = take(arg0, arg8);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg2, arg3, arg4, arg5, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, arg6, arg8), &mut v3, &mut v2, arg8), arg7);
        give_back(arg0, v3, v2);
    }

    public fun pay_register_and_dkg_zero_trust(arg0: &mut Treasury, arg1: &0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::acl::OperatorCap, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: u32, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = take(arg0, arg11);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::register_account(arg1, arg11);
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::dkg::request_dkg_zero_trust(arg1, &mut v4, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &mut v3, &mut v2, arg11);
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::share_account(v4);
        give_back(arg0, v3, v2);
    }

    public fun pay_sign_zero_trust(arg0: &mut Treasury, arg1: &0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::acl::OperatorCap, arg2: &mut 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::Account, arg3: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg4: 0x2::object::ID, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg6: u32, arg7: u32, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = take(arg0, arg11);
        let v2 = v1;
        let v3 = v0;
        give_back(arg0, v3, v2);
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::sign::request_sign_zero_trust(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &mut v3, &mut v2, arg11)
    }

    public fun sui_value(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    fun take(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui), arg1))
    }

    // decompiled from Move bytecode v6
}

