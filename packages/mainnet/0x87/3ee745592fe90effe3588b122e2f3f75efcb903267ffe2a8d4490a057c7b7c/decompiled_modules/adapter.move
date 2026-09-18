module 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::adapter {
    struct Deployment has key {
        id: 0x2::object::UID,
        registry_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct StateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct State has store {
        public_key: vector<u8>,
        source_token_account: vector<u8>,
        min_amount: u64,
        max_amount: u64,
    }

    struct AdapterAttached has copy, drop {
        account_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        public_key: vector<u8>,
        source_token_account: vector<u8>,
        mint_recipient: address,
    }

    struct BurnRequested has copy, drop {
        account_id: 0x2::object::ID,
        attempt_id: 0x2::object::ID,
        amount: u64,
        mint_recipient: address,
    }

    public fun finalized(arg0: &Deployment) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.registry_id)
    }

    public fun amount_bounds(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : (u64, u64) {
        (state(arg0).min_amount, state(arg0).max_amount)
    }

    public fun attach(arg0: &Deployment, arg1: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.registry_id), 0);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.registry_id) == 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::registry_id(arg1), 2);
        validate_bounds(arg5, arg6);
        let v0 = 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::ika_wallet::public_key(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg2, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg3)), &arg3);
        0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::message::assert_source(&v0, &arg4);
        0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::install_adapter<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg1, 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::new(), arg2, arg3, arg7);
        initialize_state(arg1, v0, arg4, arg5, arg6, arg7);
    }

    public fun crank(arg0: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u64, arg3: u64, arg4: u64, arg5: 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::message::BurnInputs, arg6: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg7: vector<u8>, arg8: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<u8>(&arg7) && 0x1::vector::length<u8>(&arg7) <= 16384, 7);
        let v0 = 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::request_sign<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0, 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::new(), arg1, arg2, arg3, arg4, 0, 0, signing_message(arg0, arg2, arg3, arg4, &arg5), arg6, arg7, arg8, arg9, arg10);
        let v1 = BurnRequested{
            account_id     : 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount>(arg0),
            attempt_id     : v0,
            amount         : 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::message::amount(&arg5),
            mint_recipient : 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0),
        };
        0x2::event::emit<BurnRequested>(v1);
        v0
    }

    public fun finalize(arg0: &mut Deployment, arg1: 0x2::package::UpgradeCap, arg2: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::Registry) {
        assert!(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::finalized(arg2) && 0x1::option::is_none<0x2::object::ID>(&arg0.registry_id), 0);
        let v0 = 0x2::package::upgrade_package(&arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<Deployment>(), 1);
        assert!(0x2::package::version(&arg1) == 1, 1);
        0x2::package::make_immutable(arg1);
        0x1::option::fill<0x2::object::ID>(&mut arg0.registry_id, 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::Registry>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Deployment{
            id          : 0x2::object::new(arg0),
            registry_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Deployment>(v0);
    }

    fun initialize_state(arg0: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = StateKey{dummy_field: false};
        let v1 = State{
            public_key           : arg1,
            source_token_account : arg2,
            min_amount           : arg3,
            max_amount           : arg4,
        };
        0x2::bag::add<StateKey, State>(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_state_mut<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0, 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::new(), arg5), v0, v1);
        let v2 = AdapterAttached{
            account_id           : 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount>(arg0),
            dwallet_id           : 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::dwallet_id<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0),
            public_key           : arg1,
            source_token_account : arg2,
            mint_recipient       : 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0),
        };
        0x2::event::emit<AdapterAttached>(v2);
    }

    public fun public_key(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : vector<u8> {
        state(arg0).public_key
    }

    public fun route_version() : u64 {
        1
    }

    public fun set_amount_bounds(arg0: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        validate_bounds(arg1, arg2);
        let v0 = StateKey{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<StateKey, State>(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_state_mut<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0, 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::new(), arg3), v0);
        v1.min_amount = arg1;
        v1.max_amount = arg2;
    }

    public fun signing_message(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: u64, arg2: u64, arg3: u64, arg4: &0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::message::BurnInputs) : vector<u8> {
        let v0 = if (!0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::paused(arg0)) {
            if (!0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::exhausted(arg0)) {
                if (0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_enabled<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0)) {
                    if (0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::cap_attached<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0)) {
                        !0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_exhausted<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = if (arg1 < 18446744073709551615) {
            if (arg2 < 18446744073709551615) {
                if (arg3 < 18446744073709551615) {
                    if (0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::generation(arg0) == arg1) {
                        if (0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_generation<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0) == arg2) {
                            0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::next_sequence<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0) == arg3
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 6);
        let v2 = state(arg0);
        let v3 = 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::message::amount(arg4);
        assert!(v3 >= v2.min_amount && v3 <= v2.max_amount, 4);
        0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::message::encode(v2.public_key, v2.source_token_account, 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0), arg4)
    }

    public fun source_token_account(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : vector<u8> {
        state(arg0).source_token_account
    }

    fun state(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : &State {
        let v0 = StateKey{dummy_field: false};
        0x2::bag::borrow<StateKey, State>(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_state<0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::Witness>(arg0, 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness::new()), v0)
    }

    fun validate_bounds(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg0 <= arg1, 3);
    }

    // decompiled from Move bytecode v7
}

