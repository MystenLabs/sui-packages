module 0xac73072b94f14a87b23781c7004c77df6799fdee109f24271d4696bc4a6514a4::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x1::option::Option<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>,
        oapp: address,
        slot: 0x1::option::Option<0x2::object::ID>,
        backing: address,
        nft_type: vector<u8>,
    }

    struct Vault<T0: store + key> has key {
        id: 0x2::object::UID,
        version: u64,
        registry: 0x2::object::ID,
        cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp: address,
        nft: 0x1::option::Option<T0>,
        backing: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        route: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        bound: bool,
        paused: bool,
        phase: u8,
        announced: bool,
        ack_sent: bool,
        request: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        recipient: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct SlotCreated has copy, drop {
        registry: 0x2::object::ID,
        vault: 0x2::object::ID,
        nft: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct Funded has copy, drop {
        vault: 0x2::object::ID,
        nft: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct Bound has copy, drop {
        vault: 0x2::object::ID,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct PauseChanged has copy, drop {
        vault: 0x2::object::ID,
        paused: bool,
    }

    struct Released has copy, drop {
        vault: 0x2::object::ID,
        request: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        recipient: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    public fun lz_receive<T0: store + key>(arg0: &mut Vault<T0>, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        validate<T0>(arg0, arg1);
        let (v0, v1, _, _, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.cap, arg2));
        let v8 = v7;
        let v9 = v4;
        let v10 = if (v0 == 30102) {
            if (v1 == arg0.peer) {
                0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&v8)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v10, 7);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        process<T0>(arg0, &v9);
    }

    public fun backing<T0: store + key>(arg0: &Vault<T0>) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.backing
    }

    public fun bind<T0: store + key>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, arg4: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg5: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg6: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg7: &mut 0x2::tx_context::TxContext) {
        vault_admin<T0>(arg0, arg1);
        assert!(!arg0.bound && arg0.phase == 0, 5);
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2) == arg0.oapp && !0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&arg6), 6);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_peer(arg2, arg3, arg4, arg5, 30102, arg6, arg7);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_enforced_options(arg2, arg3, 30102, 1, x"00030100110100000000000000000000000000030d40");
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_enforced_options(arg2, arg3, 30102, 3, x"00030100110100000000000000000000000000030d40");
        arg0.peer = arg6;
        arg0.bound = true;
        let v0 = Bound{
            vault : 0x2::object::id<Vault<T0>>(arg0),
            peer  : arg6,
        };
        0x2::event::emit<Bound>(v0);
    }

    public fun confirm_quote<T0: store + key>(arg0: &Vault<T0>, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee) {
        validate<T0>(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_quote(arg1, &arg0.cap, arg2)
    }

    public fun confirm_send<T0: store + key>(arg0: &Vault<T0>, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt) {
        validate<T0>(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_lz_send(arg1, &arg0.cap, arg2)
    }

    public fun create_slot<T0: store + key>(arg0: &mut Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        registry_admin(arg0, arg1);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == arg0.nft_type, 2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.slot) && 0x1::option::is_some<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>(&arg0.cap), 3);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0>{
            id        : v0,
            version   : 1,
            registry  : 0x2::object::id<Registry>(arg0),
            cap       : 0x1::option::extract<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>(&mut arg0.cap),
            oapp      : arg0.oapp,
            nft       : 0x1::option::none<T0>(),
            backing   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_address(arg0.backing),
            route     : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_id(v1),
            peer      : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
            bound     : false,
            paused    : false,
            phase     : 0,
            announced : false,
            ack_sent  : false,
            request   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
            recipient : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
        };
        0x1::option::fill<0x2::object::ID>(&mut arg0.slot, v1);
        let v3 = SlotCreated{
            registry : 0x2::object::id<Registry>(arg0),
            vault    : v1,
            nft      : v2.backing,
        };
        0x2::event::emit<SlotCreated>(v3);
        0x2::transfer::share_object<Vault<T0>>(v2);
    }

    fun execution_options(arg0: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg1: u8, arg2: vector<u8>) : vector<u8> {
        let v0 = if (arg1 == 1) {
            1
        } else {
            3
        };
        let v1 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg0, 30102, v0, b"");
        assert!(0x1::vector::length<u8>(&v1) > 2, 12);
        let v2 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg0, 30102, v0, arg2);
        let v3 = if (0x1::vector::length<u8>(&v2) >= 22) {
            if (*0x1::vector::borrow<u8>(&v2, 0) == 0) {
                *0x1::vector::borrow<u8>(&v2, 1) == 3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 12);
        let v4 = 2;
        let v5 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            assert!(v4 + 4 <= 0x1::vector::length<u8>(&v2), 12);
            let v6 = (*0x1::vector::borrow<u8>(&v2, v4 + 1) as u64) * 256 + (*0x1::vector::borrow<u8>(&v2, v4 + 2) as u64);
            assert!(*0x1::vector::borrow<u8>(&v2, v4) == 1 && *0x1::vector::borrow<u8>(&v2, v4 + 3) == 1, 12);
            assert!((v6 == 17 || v6 == 33) && v4 + 3 + v6 <= 0x1::vector::length<u8>(&v2), 12);
            let v7 = 0;
            let v8 = 0;
            while (v8 < 16) {
                let v9 = v7 << 8;
                v7 = v9 | (*0x1::vector::borrow<u8>(&v2, v4 + 4 + v8) as u128);
                if (v6 == 33) {
                    assert!(*0x1::vector::borrow<u8>(&v2, v4 + 20 + v8) == 0, 12);
                };
                v8 = v8 + 1;
            };
            v5 = v5 + v7;
            let v10 = v4 + 3;
            v4 = v10 + v6;
        };
        assert!(v5 >= 200000, 12);
        v2
    }

    public fun fund<T0: store + key>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: T0) {
        vault_admin<T0>(arg0, arg1);
        assert!(!arg0.paused, 10);
        let v0 = if (arg0.phase == 0) {
            if (0x1::option::is_none<T0>(&arg0.nft)) {
                arg0.bound
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_id(0x2::object::id<T0>(&arg2)) == arg0.backing, 4);
        0x1::option::fill<T0>(&mut arg0.nft, arg2);
        arg0.phase = 1;
        let v1 = Funded{
            vault : 0x2::object::id<Vault<T0>>(arg0),
            nft   : arg0.backing,
        };
        0x2::event::emit<Funded>(v1);
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x485953e2eadf4aa02af950cf8e914fbd2b67523385e73c36118341459d8d45c4, 1);
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<VAULT>(&arg0, arg1);
        let v3 = new_registry(v0, v2, @0x46da2a9e15bd822ba0491d978947cc1bfb1fd30e6f813a5fb10b9b2b1d6a6ba, b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT", arg1);
        let v4 = AdminCap{
            id       : 0x2::object::new(arg1),
            registry : 0x2::object::id<Registry>(&v3),
        };
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Registry>(v3);
    }

    fun new_registry(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: address, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id       : 0x2::object::new(arg4),
            version  : 1,
            cap      : 0x1::option::some<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>(arg0),
            oapp     : arg1,
            slot     : 0x1::option::none<0x2::object::ID>(),
            backing  : arg2,
            nft_type : arg3,
        }
    }

    fun payload<T0: store + key>(arg0: &Vault<T0>, arg1: u8) : vector<u8> {
        if (arg1 == 1) {
            assert!(!arg0.paused, 10);
            let v1 = if (arg0.phase == 1) {
                if (0x1::option::is_some<T0>(&arg0.nft)) {
                    !arg0.announced
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 5);
            0xac73072b94f14a87b23781c7004c77df6799fdee109f24271d4696bc4a6514a4::codec::encode(1, arg0.route, arg0.backing, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32())
        } else {
            let v2 = if (arg1 == 3) {
                if (arg0.phase == 2) {
                    if (0x1::option::is_none<T0>(&arg0.nft)) {
                        !arg0.ack_sent
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 5);
            0xac73072b94f14a87b23781c7004c77df6799fdee109f24271d4696bc4a6514a4::codec::encode(3, arg0.route, arg0.backing, arg0.request, arg0.recipient)
        }
    }

    public fun payload_for_review<T0: store + key>(arg0: &Vault<T0>, arg1: u8) : vector<u8> {
        payload<T0>(arg0, arg1)
    }

    public fun phase<T0: store + key>(arg0: &Vault<T0>) : u8 {
        arg0.phase
    }

    fun process<T0: store + key>(arg0: &mut Vault<T0>, arg1: &vector<u8>) {
        let (v0, v1, v2, v3, v4) = 0xac73072b94f14a87b23781c7004c77df6799fdee109f24271d4696bc4a6514a4::codec::decode(arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = if (v0 == 2) {
            if (v1 == arg0.route) {
                v2 == arg0.backing
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 8);
        assert!(arg0.announced, 5);
        assert!(!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v6) && !0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v5), 8);
        if (arg0.phase == 2) {
            assert!(v6 == arg0.request && v5 == arg0.recipient, 9);
        } else {
            assert!(arg0.phase == 1 && 0x1::option::is_some<T0>(&arg0.nft), 5);
            arg0.phase = 2;
            arg0.request = v6;
            arg0.recipient = v5;
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.nft), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_address(&v5));
        };
        let v8 = Released{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            request   : v6,
            recipient : v5,
        };
        0x2::event::emit<Released>(v8);
    }

    public fun quote<T0: store + key>(arg0: &Vault<T0>, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        validate<T0>(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.cap, 30102, payload<T0>(arg0, arg2), execution_options(arg1, arg2, arg3), false, arg4)
    }

    public fun register<T0: store + key>(arg0: &Vault<T0>, arg1: &AdminCap, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : address {
        vault_admin<T0>(arg0, arg1);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::register_oapp(arg2, &arg0.cap, arg3, arg4)
    }

    fun registry_admin(arg0: &Registry, arg1: &AdminCap) {
        assert!(arg0.version == 1, 11);
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 1);
    }

    public fun route<T0: store + key>(arg0: &Vault<T0>) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.route
    }

    public fun send<T0: store + key>(arg0: &mut Vault<T0>, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u8, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        validate<T0>(arg0, arg1);
        if (arg2 == 1) {
            arg0.announced = true;
        } else {
            arg0.ack_sent = true;
        };
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send(arg1, &arg0.cap, 30102, payload<T0>(arg0, arg2), execution_options(arg1, arg2, arg3), arg4, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x1::option::some<address>(0x2::tx_context::sender(arg5)), arg5)
    }

    public fun set_paused<T0: store + key>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: bool) {
        vault_admin<T0>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PauseChanged{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    fun validate<T0: store + key>(arg0: &Vault<T0>, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) {
        assert!(arg0.version == 1, 11);
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1) == arg0.oapp, 6);
        assert!(arg0.bound && 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::get_peer(arg1, 30102) == arg0.peer, 7);
    }

    fun vault_admin<T0: store + key>(arg0: &Vault<T0>, arg1: &AdminCap) {
        assert!(arg0.version == 1, 11);
        assert!(arg1.registry == arg0.registry, 1);
    }

    // decompiled from Move bytecode v7
}

