module 0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LiteAccount has store {
        sqd1_cap_id: 0x1::option::Option<0x2::object::ID>,
        sqd2_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LitePaymentPool has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ika_balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        paused: bool,
        lite_accounts: 0x2::table::Table<address, LiteAccount>,
        registrar_public_key: vector<u8>,
    }

    public(friend) fun assert_dwallet_creation_allowed(arg0: &LitePaymentPool, arg1: address, arg2: u32) {
        assert_pool_active(arg0);
        assert_supported_lite_curve(arg2);
        assert!(0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, arg1), 2);
        if (arg2 == 0) {
            assert!(0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<address, LiteAccount>(&arg0.lite_accounts, arg1).sqd1_cap_id), 3);
        } else {
            assert!(0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<address, LiteAccount>(&arg0.lite_accounts, arg1).sqd2_cap_id), 3);
        };
    }

    public(friend) fun assert_pool_active(arg0: &LitePaymentPool) {
        assert!(!arg0.paused, 0);
    }

    public(friend) fun assert_presign_mint_allowed(arg0: &LitePaymentPool, arg1: address, arg2: u32) {
        assert_pool_active(arg0);
        assert_supported_lite_curve(arg2);
        assert!(0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, arg1), 2);
        if (arg2 == 0) {
            assert!(!0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<address, LiteAccount>(&arg0.lite_accounts, arg1).sqd1_cap_id), 2);
        } else {
            assert!(!0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<address, LiteAccount>(&arg0.lite_accounts, arg1).sqd2_cap_id), 2);
        };
    }

    public(friend) fun assert_sign_cap_allowed(arg0: &LitePaymentPool, arg1: address, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap) {
        assert_pool_active(arg0);
        assert!(0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, arg1), 2);
        let v0 = 0x2::table::borrow<address, LiteAccount>(&arg0.lite_accounts, arg1);
        let v1 = 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg2);
        let v2 = 0x1::option::is_some<0x2::object::ID>(&v0.sqd1_cap_id) && *0x1::option::borrow<0x2::object::ID>(&v0.sqd1_cap_id) == v1;
        let v3 = 0x1::option::is_some<0x2::object::ID>(&v0.sqd2_cap_id) && *0x1::option::borrow<0x2::object::ID>(&v0.sqd2_cap_id) == v1;
        assert!(v2 || v3, 4);
    }

    public(friend) fun assert_supported_lite_curve(arg0: u32) {
        assert!(arg0 == 0 || arg0 == 2, 1);
    }

    public(friend) fun bind_dwallet_cap(arg0: &mut LitePaymentPool, arg1: address, arg2: u32, arg3: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap) {
        assert_supported_lite_curve(arg2);
        assert!(0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, arg1), 2);
        let v0 = 0x2::table::borrow_mut<address, LiteAccount>(&mut arg0.lite_accounts, arg1);
        if (arg2 == 0) {
            assert!(0x1::option::is_none<0x2::object::ID>(&v0.sqd1_cap_id), 3);
            0x1::option::fill<0x2::object::ID>(&mut v0.sqd1_cap_id, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg3));
        } else {
            assert!(0x1::option::is_none<0x2::object::ID>(&v0.sqd2_cap_id), 3);
            0x1::option::fill<0x2::object::ID>(&mut v0.sqd2_cap_id, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg3));
        };
    }

    public(friend) fun do_sign(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut LitePaymentPool, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw_payment_coins(arg1, arg9);
        let v2 = v1;
        let v3 = v0;
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg0, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg0, arg3, arg9), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg0, arg2, arg6, arg7, arg4), arg5, arg8, &mut v3, &mut v2, arg9);
        return_payment_coins(arg1, v3, v2);
    }

    public(friend) fun ensure_lite_account_registered(arg0: &mut LitePaymentPool, arg1: &vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_pool_active(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, v0)) {
            return
        };
        assert!(0x1::vector::length<u8>(&arg0.registrar_public_key) == 32, 6);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 8);
        let v1 = registration_permit_message(arg0, v0, arg2);
        assert!(0x2::ed25519::ed25519_verify(arg1, &arg0.registrar_public_key, &v1), 9);
        let v2 = LiteAccount{
            sqd1_cap_id : 0x1::option::none<0x2::object::ID>(),
            sqd2_cap_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::table::add<address, LiteAccount>(&mut arg0.lite_accounts, v0, v2);
    }

    entry fun evict_lite_account(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: address) {
        assert!(0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, arg2), 5);
        let LiteAccount {
            sqd1_cap_id : _,
            sqd2_cap_id : _,
        } = 0x2::table::remove<address, LiteAccount>(&mut arg0.lite_accounts, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LitePaymentPool{
            id                   : 0x2::object::new(arg0),
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            ika_balance          : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
            paused               : false,
            lite_accounts        : 0x2::table::new<address, LiteAccount>(arg0),
            registrar_public_key : b"",
        };
        0x2::transfer::public_share_object<LitePaymentPool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun mint_presign(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut LitePaymentPool, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg6: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        let (v0, v1) = withdraw_payment_coins(arg1, arg6);
        let v2 = v1;
        let v3 = v0;
        return_payment_coins(arg1, v3, v2);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg0, arg2, arg3, arg4, arg5, &mut v3, &mut v2, arg6)
    }

    fun registration_permit_message(arg0: &LitePaymentPool, arg1: address, arg2: u64) : vector<u8> {
        registration_permit_message_from_pool_id_bytes(0x2::object::id_bytes<LitePaymentPool>(arg0), arg1, arg2)
    }

    fun registration_permit_message_from_pool_id_bytes(arg0: vector<u8>, arg1: address, arg2: u64) : vector<u8> {
        let v0 = b"WAAP_LITE_REGISTRATION_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public(friend) fun return_payment_coins(arg0: &mut LitePaymentPool, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    entry fun set_pool_paused(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_registrar_public_key(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 7);
        arg0.registrar_public_key = arg2;
    }

    entry fun set_registrar_public_key_for_pool(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: vector<u8>) {
        set_registrar_public_key(arg0, arg1, arg2);
    }

    entry fun top_up_ika(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg2));
    }

    entry fun top_up_sui(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    entry fun unbind_dwallet_cap(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: address, arg3: u32) {
        assert_supported_lite_curve(arg3);
        assert!(0x2::table::contains<address, LiteAccount>(&arg0.lite_accounts, arg2), 5);
        let v0 = 0x2::table::borrow_mut<address, LiteAccount>(&mut arg0.lite_accounts, arg2);
        if (arg3 == 0) {
            assert!(0x1::option::is_some<0x2::object::ID>(&v0.sqd1_cap_id), 10);
            v0.sqd1_cap_id = 0x1::option::none<0x2::object::ID>();
        } else {
            assert!(0x1::option::is_some<0x2::object::ID>(&v0.sqd2_cap_id), 10);
            v0.sqd2_cap_id = 0x1::option::none<0x2::object::ID>();
        };
    }

    public fun withdraw_ika_balance(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, arg2), arg3)
    }

    public(friend) fun withdraw_payment_coins(arg0: &mut LitePaymentPool, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg1))
    }

    public fun withdraw_sui_balance(arg0: &mut LitePaymentPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

