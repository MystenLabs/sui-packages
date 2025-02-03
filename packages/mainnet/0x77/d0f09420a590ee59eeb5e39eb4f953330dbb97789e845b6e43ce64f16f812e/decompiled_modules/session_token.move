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
        abort 998
    }

    public fun assert_parent_auth<T0: drop, T1: store + key>(arg0: &SessionToken<T1>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>) {
        abort 998
    }

    public fun confirm<T0: drop, T1: store + key>(arg0: &SessionToken<T1>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>) {
        abort 998
    }

    public fun drop<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        abort 998
    }

    public entry fun enforce<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        abort 998
    }

    public fun issue_session_token<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 998
    }

    fun issue_session_token_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<T0>, arg2: address, arg3: u64, arg4: 0x1::option::Option<0x1::type_name::TypeName>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 998
    }

    public fun issue_session_token_field<T0: store + key, T1: store>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 998
    }

    // decompiled from Move bytecode v6
}

