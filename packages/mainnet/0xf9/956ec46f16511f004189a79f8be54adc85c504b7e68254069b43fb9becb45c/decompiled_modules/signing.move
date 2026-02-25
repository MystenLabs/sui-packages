module 0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::signing {
    struct SignRequested has copy, drop {
        request: u64,
        vaa_hash: vector<u8>,
        signature_id: 0x2::object::ID,
    }

    struct PresignRequested has copy, drop {
        request: u64,
        presign_bcs: vector<u8>,
    }

    struct MintingDWalletCreated has copy, drop {
        dwallet_cap_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
    }

    struct SigningState has key {
        id: 0x2::object::UID,
        minting_cap: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>,
        signature_algorithm: u32,
        hash_scheme: u32,
        curve: u32,
    }

    public(friend) fun create_minting_dwallet(arg0: &mut SigningState, arg1: &mut 0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::treasury::Treasury, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.minting_cap), 101);
        let v0 = 0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::dwallet_factory::create_shared_dwallet_with_treasury(arg1, arg2, arg3, arg0.curve, arg4, arg5, arg6, arg7, arg8);
        0x1::option::fill<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.minting_cap, v0);
        let v1 = MintingDWalletCreated{
            dwallet_cap_id : 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v0),
            dwallet_id     : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v0),
        };
        0x2::event::emit<MintingDWalletCreated>(v1);
    }

    public fun curve(arg0: &SigningState) : u32 {
        arg0.curve
    }

    public fun has_minting_cap(arg0: &SigningState) : bool {
        0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.minting_cap)
    }

    public fun hash_scheme(arg0: &SigningState) : u32 {
        arg0.hash_scheme
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SigningState{
            id                  : 0x2::object::new(arg0),
            minting_cap         : 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(),
            signature_algorithm : 0,
            hash_scheme         : 0,
            curve               : 2,
        };
        0x2::transfer::share_object<SigningState>(v0);
    }

    fun random_session_identifier(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1)), arg1)
    }

    public(friend) fun request_presign(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = random_session_identifier(arg0, arg5);
        let v1 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg0, arg1, 2, 0, v0, arg3, arg4, arg5);
        let v2 = PresignRequested{
            request     : arg2,
            presign_bcs : 0x2::bcs::to_bytes<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&v1),
        };
        0x2::event::emit<PresignRequested>(v2);
        0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(v1, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun request_sign(arg0: &SigningState, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.minting_cap), 100);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, arg4, arg9);
        let v1 = random_session_identifier(arg1, arg9);
        let v2 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg1, v0, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, 0x1::option::borrow<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.minting_cap), arg0.signature_algorithm, arg0.hash_scheme, arg2), arg3, v1, arg7, arg8, arg9);
        let v3 = SignRequested{
            request      : arg6,
            vaa_hash     : arg5,
            signature_id : v2,
        };
        0x2::event::emit<SignRequested>(v3);
        v2
    }

    public(friend) fun reset_minting_cap(arg0: &mut SigningState, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.minting_cap)) {
            0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.minting_cap), 0x2::tx_context::sender(arg1));
        };
    }

    public fun signature_algorithm(arg0: &SigningState) : u32 {
        arg0.signature_algorithm
    }

    public(friend) fun update_params(arg0: &mut SigningState, arg1: u32, arg2: u32, arg3: u32) {
        arg0.curve = arg1;
        arg0.signature_algorithm = arg2;
        arg0.hash_scheme = arg3;
    }

    // decompiled from Move bytecode v6
}

