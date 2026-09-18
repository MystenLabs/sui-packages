module 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::adapter {
    struct Deployment has key {
        id: 0x2::object::UID,
        registry_id: 0x1::option::Option<0x2::object::ID>,
        treasury: vector<u8>,
    }

    struct StateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct State has store {
        public_key: vector<u8>,
        source: vector<u8>,
        treasury: vector<u8>,
    }

    struct Request has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        account_generation: u64,
        adapter_generation: u64,
        gross_amount: u64,
        message: vector<u8>,
        closed: bool,
        presign_cap_id: 0x2::object::ID,
        contribution_hash: vector<u8>,
    }

    struct Requested has copy, drop {
        request_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        gross_amount: u64,
        fee_amount: u64,
        net_amount: u64,
        treasury: vector<u8>,
        mint_recipient: address,
    }

    struct SigningRequested has copy, drop {
        request_id: 0x2::object::ID,
        attempt_id: 0x2::object::ID,
    }

    public fun new(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::BurnInputs, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<u8>(&arg3) && 0x1::vector::length<u8>(&arg3) <= 16384, 7);
        assert!(0x2::tx_context::sender(arg4) == 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0), 3);
        let v0 = Request{
            id                 : 0x2::object::new(arg4),
            account_id         : 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount>(arg0),
            account_generation : 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::generation(arg0),
            adapter_generation : 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_generation<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0),
            gross_amount       : 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::gross_amount(&arg1),
            message            : preview(arg0, &arg1),
            closed             : false,
            presign_cap_id     : arg2,
            contribution_hash  : 0x2::hash::blake2b256(&arg3),
        };
        let v1 = 0x2::object::id<Request>(&v0);
        let v2 = Requested{
            request_id     : v1,
            account_id     : 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount>(arg0),
            gross_amount   : 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::gross_amount(&arg1),
            fee_amount     : 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::fee_amount(),
            net_amount     : 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::net_amount(&arg1),
            treasury       : state(arg0).treasury,
            mint_recipient : 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0),
        };
        0x2::event::emit<Requested>(v2);
        0x2::transfer::share_object<Request>(v0);
        v1
    }

    public fun finalized(arg0: &Deployment) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.registry_id)
    }

    public fun account_treasury(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : vector<u8> {
        state(arg0).treasury
    }

    public fun approved_message(arg0: &Request) : vector<u8> {
        arg0.message
    }

    fun assert_available(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) {
        let v0 = if (!0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::paused(arg0)) {
            if (!0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::exhausted(arg0)) {
                if (0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_enabled<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0)) {
                    if (0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::cap_attached<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0)) {
                        !0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_exhausted<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0)
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
    }

    public fun attach(arg0: &Deployment, arg1: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.registry_id), 0);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.registry_id) == 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::registry_id(arg1), 2);
        assert!(arg0.treasury == arg5, 4);
        let v0 = 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::ika_wallet::public_key(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg2, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg3)), &arg3);
        0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::assert_source(&v0, &arg4);
        assert!(arg4 != arg5 && v0 != arg5, 4);
        0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::install_adapter<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg1, 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::new(), arg2, arg3, arg6);
        initialize_state(arg1, v0, arg4, arg5, arg6);
    }

    public fun cancel(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: &mut Request, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0), 3);
        assert!(arg1.account_id == 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount>(arg0), 9);
        assert!(!arg1.closed, 8);
        arg1.closed = true;
    }

    public fun closed(arg0: &Request) : bool {
        arg0.closed
    }

    fun consume(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: &mut Request, arg2: 0x2::object::ID, arg3: &vector<u8>) : vector<u8> {
        assert!(arg1.presign_cap_id == arg2 && arg1.contribution_hash == 0x2::hash::blake2b256(arg3), 10);
        arg1.closed = true;
        signing_message(arg0, arg1)
    }

    public fun crank(arg0: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: &mut Request, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg4: vector<u8>, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<u8>(&arg4) && 0x1::vector::length<u8>(&arg4) <= 16384, 7);
        let v0 = consume(arg0, arg1, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg3), &arg4);
        let v1 = 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::request_sign<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0, 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::new(), arg2, arg1.account_generation, arg1.adapter_generation, 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::next_sequence<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0), 0, 0, v0, arg3, arg4, arg5, arg6, arg7);
        let v2 = SigningRequested{
            request_id : 0x2::object::id<Request>(arg1),
            attempt_id : v1,
        };
        0x2::event::emit<SigningRequested>(v2);
        v1
    }

    public fun fee_amount() : u64 {
        0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::fee_amount()
    }

    public fun finalize(arg0: &mut Deployment, arg1: 0x2::package::UpgradeCap, arg2: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::Registry, arg3: vector<u8>) {
        assert!(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::finalized(arg2) && 0x1::option::is_none<0x2::object::ID>(&arg0.registry_id), 0);
        let v0 = 0x2::package::upgrade_package(&arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<Deployment>() && 0x2::package::version(&arg1) == 1, 1);
        assert!(0x1::vector::length<u8>(&arg3) == 32 && arg3 != 0x2::address::to_bytes(@0x0), 4);
        0x2::package::make_immutable(arg1);
        0x1::option::fill<0x2::object::ID>(&mut arg0.registry_id, 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::Registry>(arg2));
        arg0.treasury = arg3;
    }

    public fun gross_amount(arg0: &Request) : u64 {
        arg0.gross_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Deployment{
            id          : 0x2::object::new(arg0),
            registry_id : 0x1::option::none<0x2::object::ID>(),
            treasury    : b"",
        };
        0x2::transfer::share_object<Deployment>(v0);
    }

    fun initialize_state(arg0: &mut 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = StateKey{dummy_field: false};
        let v1 = State{
            public_key : arg1,
            source     : arg2,
            treasury   : arg3,
        };
        0x2::bag::add<StateKey, State>(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_state_mut<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0, 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::new(), arg4), v0, v1);
    }

    public fun net_amount(arg0: &Request) : u64 {
        arg0.gross_amount - fee_amount()
    }

    public fun preview(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: &0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::BurnInputs) : vector<u8> {
        assert_available(arg0);
        let v0 = state(arg0);
        0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message::encode(v0.public_key, v0.source, 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::owner(arg0), v0.treasury, arg1)
    }

    public fun public_key(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : vector<u8> {
        state(arg0).public_key
    }

    public fun route_version() : u64 {
        1
    }

    public fun signing_message(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount, arg1: &Request) : vector<u8> {
        assert!(arg1.account_id == 0x2::object::id<0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount>(arg0), 9);
        assert!(!arg1.closed, 8);
        assert_available(arg0);
        assert!(arg1.account_generation == 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::generation(arg0) && arg1.adapter_generation == 0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_generation<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0), 6);
        arg1.message
    }

    public fun source_token_account(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : vector<u8> {
        state(arg0).source
    }

    fun state(arg0: &0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::MultichainAccount) : &State {
        let v0 = StateKey{dummy_field: false};
        0x2::bag::borrow<StateKey, State>(0x5e405ce425064183db6f53f7577cc7f4714965c5926e03c0d16f29b108dd4c24::account::adapter_state<0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::Witness>(arg0, 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness::new()), v0)
    }

    public fun treasury(arg0: &Deployment) : vector<u8> {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

