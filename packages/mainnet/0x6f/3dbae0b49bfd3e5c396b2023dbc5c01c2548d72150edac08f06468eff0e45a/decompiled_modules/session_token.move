module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::session_token {
    struct SessionToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        field: 0x1::option::Option<0x1::type_name::TypeName>,
        expiry_ms: u64,
        timeout_id: 0x2::object::ID,
        entity: address,
    }

    struct SessionTokenRule has drop {
        dummy_field: bool,
    }

    struct TimeOutDfKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct TimeOut<phantom T0> has store, key {
        id: 0x2::object::UID,
        expiry_ms: u64,
        access_token: 0x2::object::ID,
    }

    public fun assert_field_auth<T0: drop, T1: store + key>(arg0: &SessionToken<T1>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>) {
        assert!(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::nft_id<T0, T1>(arg1) == arg0.nft_id, 2);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.field) == 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::field<T0, T1>(arg1), 3);
    }

    public fun assert_parent_auth<T0: drop, T1: store + key>(arg0: &SessionToken<T1>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>) {
        assert!(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::nft_id<T0, T1>(arg1) == arg0.nft_id, 2);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.field), 4);
    }

    public fun confirm<T0: drop, T1: store + key>(arg0: &SessionToken<T1>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>) {
        if (0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::is_borrow_field<T0, T1>(arg1)) {
            assert_field_auth<T0, T1>(arg0, arg1);
        } else {
            assert_parent_auth<T0, T1>(arg0, arg1);
        };
        let v0 = SessionTokenRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::add_receipt<T0, T1, SessionTokenRule>(arg1, &v0);
    }

    public fun drop<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::drop_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, SessionTokenRule>(arg0, arg1);
    }

    public entry fun enforce<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, SessionTokenRule>(arg0, arg1);
    }

    public fun issue_session_token<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        issue_session_token_<T0>(arg0, arg1, arg2, arg3, 0x1::option::none<0x1::type_name::TypeName>(), arg4)
    }

    fun issue_session_token_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<T0>, arg2: address, arg3: u64, arg4: 0x1::option::Option<0x1::type_name::TypeName>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::to_id<T0>(arg1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_owner_address(arg0, 0x2::tx_context::sender(arg5));
        let v1 = 0x2::object::new(arg5);
        let v2 = TimeOut<T0>{
            id           : 0x2::object::new(arg5),
            expiry_ms    : arg3,
            access_token : 0x2::object::uid_to_inner(&v1),
        };
        let v3 = SessionToken<T0>{
            id         : v1,
            nft_id     : v0,
            field      : arg4,
            expiry_ms  : arg3,
            timeout_id : 0x2::object::id<TimeOut<T0>>(&v2),
            entity     : arg2,
        };
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg0, v0, &v2.id, arg5);
        let v4 = TimeOutDfKey{nft_id: v0};
        0x2::dynamic_field::add<TimeOutDfKey, TimeOut<T0>>(0x2::kiosk::uid_mut(arg0), v4, v2);
        0x2::transfer::public_transfer<SessionToken<T0>>(v3, arg2);
        0x2::object::uid_to_inner(&v1)
    }

    public fun issue_session_token_field<T0: store + key, T1: store>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        issue_session_token_<T0>(arg0, arg1, arg2, arg3, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg4);
    }

    // decompiled from Move bytecode v6
}

