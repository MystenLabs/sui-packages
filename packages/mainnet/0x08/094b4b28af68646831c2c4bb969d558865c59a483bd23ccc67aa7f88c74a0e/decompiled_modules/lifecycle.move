module 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle {
    struct Construction {
        root: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation,
        root_id: 0x2::object::ID,
        fixed_origin: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin,
        request: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::Snapshot,
        actor: address,
        obligations: vector<Obligation>,
    }

    struct ParentDelivery {
        root: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation,
        root_id: 0x2::object::ID,
        fixed_origin: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin,
        actor: address,
        obligations: vector<Obligation>,
    }

    struct Obligation has copy, drop {
        root: 0x2::object::ID,
        origin: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin,
        fresh: bool,
    }

    struct Duty has copy, drop, store {
        namespace: 0x1::type_name::TypeName,
        name: vector<u8>,
        value: 0x1::type_name::TypeName,
        object: 0x2::object::ID,
        schema: u16,
    }

    struct Handover {
        root: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation,
        nodes: vector<Node>,
        duties: vector<Required>,
    }

    struct Node has copy, drop {
        soul: 0x2::object::ID,
        origin: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin,
        parent: 0x1::option::Option<0x2::object::ID>,
        name: vector<u8>,
        topology: 0x1::option::Option<u64>,
    }

    struct Required has copy, drop {
        soul: 0x2::object::ID,
        binding: Duty,
        acknowledged: 0x1::option::Option<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>,
        version: 0x1::option::Option<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>,
    }

    public fun new<T0: drop, T1: key>(arg0: T0, arg1: &T1, arg2: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::OriginRequest, arg3: &mut 0x2::tx_context::TxContext) : Construction {
        let v0 = 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_request<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, arg3);
        assert!(0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::operation(&v0) == 0, 11);
        let v1 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::new<T0, T1>(arg0, arg1, 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::version(&v0), 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::policy(&v0), 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::name(&v0), arg3);
        attested(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&v1), &v0);
        let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_id(&v1);
        let v3 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&v1));
        let v4 = Obligation{
            root   : v2,
            origin : v3,
            fresh  : true,
        };
        let v5 = 0x1::vector::empty<Obligation>();
        0x1::vector::push_back<Obligation>(&mut v5, v4);
        Construction{
            root         : v1,
            root_id      : v2,
            fixed_origin : v3,
            request      : v0,
            actor        : 0x2::tx_context::sender(arg3),
            obligations  : v5,
        }
    }

    fun ack_tree<T0, T1: store + key>(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &vector<u8>, arg2: u16, arg3: &mut vector<Required>) {
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(arg0, *arg1);
        if (0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0)) {
            let v1 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v0);
            let v2 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::value_type(&v1) == 0x1::type_name::with_defining_ids<T1>()) {
                if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(&v1) == arg2) {
                    handover_required(arg0, &v1)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 12);
            assert!(0x1::hash::sha3_256(0x1::bcs::to_bytes<T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(arg0, *arg1))) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v1), 12);
            let v3 = 0;
            while (v3 < 0x1::vector::length<Required>(arg3)) {
                if (0x1::vector::borrow<Required>(arg3, v3).soul == 0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0) && 0x1::vector::borrow<Required>(arg3, v3).binding == duty(&v1)) {
                    let v4 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_version(arg0, &v1);
                    assert!(0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v4) && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::installed_revision(0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v4)) > 0, 12);
                    0x1::vector::borrow_mut<Required>(arg3, v3).acknowledged = 0x1::option::some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v1);
                    0x1::vector::borrow_mut<Required>(arg3, v3).version = v4;
                };
                v3 = v3 + 1;
            };
        };
        let v5 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v6 = &v5;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v6)) {
            let v8 = 0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v6, v7);
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(v8) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::NestedSoulWitness>()) {
                ack_tree<T0, T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nested(arg0, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(v8)), arg1, arg2, arg3);
            };
            v7 = v7 + 1;
        };
    }

    public fun acknowledge_handover<T0: drop, T1: store + key>(arg0: &mut Handover, arg1: T0, arg2: vector<u8>, arg3: u16) {
        same_module<T0, T1>();
        current(arg0);
        let v0 = &mut arg0.duties;
        ack_tree<T0, T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg2, arg3, v0);
    }

    public fun assert_legacy_disabled(arg0: &0x2::kiosk::Kiosk) {
        let v0 = 0x1::bcs::to_bytes<0x2::kiosk::Kiosk>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 77, 14);
        let v1 = 0x2::bcs::new(v0);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = if (v2 <= 1) {
            let v4 = 0x2::bcs::into_remainder_bytes(v1);
            0x1::vector::is_empty<u8>(&v4)
        } else {
            false
        };
        assert!(v3, 14);
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v6 = if (0x2::bcs::peel_address(&mut v1) == 0x2::object::id_to_address(&v5)) {
            if (0x2::bcs::peel_u64(&mut v1) == 0x2::kiosk::profits_amount(arg0)) {
                if (0x2::bcs::peel_address(&mut v1) == 0x2::kiosk::owner(arg0)) {
                    0x2::bcs::peel_u32(&mut v1) == 0x2::kiosk::item_count(arg0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 14);
        assert!(v2 == 0, 13);
    }

    fun attested(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::Snapshot) {
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(arg0);
        let v1 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::producer(&v0) == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::producer(arg1)) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::source_type(&v0) == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::source_type(arg1)) {
                if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::source(&v0) == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::source(arg1)) {
                    if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::source_version(&v0) == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::version(arg1)) {
                        if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::source_hash(&v0) == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::policy(arg1)) {
                            0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::minted_by(&v0) == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::actor(arg1)
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
        assert!(v1, 9);
    }

    public fun begin_construction_handover(arg0: Construction, arg1: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg2: &0x2::tx_context::TxContext) : Handover {
        pinned_construction(&arg0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg2), 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.request, arg2);
        let Construction {
            root         : v0,
            root_id      : _,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : _,
        } = arg0;
        begin_creation_handover(v0)
    }

    fun begin_creation_handover(arg0: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation) : Handover {
        let v0 = 0x1::vector::empty<Node>();
        let v1 = 0x1::vector::empty<Required>();
        let v2 = &mut v0;
        let v3 = &mut v1;
        collect(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0), 0x1::option::none<0x2::object::ID>(), b"", 0, v2, v3);
        Handover{
            root   : arg0,
            nodes  : v0,
            duties : v1,
        }
    }

    public fun begin_handover(arg0: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul) : Handover {
        begin_creation_handover(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::hold_owned(arg0))
    }

    public fun begin_parent_handover(arg0: ParentDelivery, arg1: &0x2::tx_context::TxContext) : Handover {
        pinned_parent(&arg0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg1), 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations);
        let ParentDelivery {
            root         : v0,
            root_id      : _,
            fixed_origin : _,
            actor        : _,
            obligations  : _,
        } = arg0;
        begin_creation_handover(v0)
    }

    public fun borrow_construction(arg0: &Construction) : &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul {
        construction_ref(arg0)
    }

    public fun borrow_construction_mut(arg0: &mut Construction) : &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation {
        construction_mut(arg0)
    }

    fun closure(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &vector<Obligation>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Obligation>(arg1)) {
            let v1 = 0x1::vector::borrow<Obligation>(arg1, v0);
            let v2 = reachable_origin(arg0, v1.root);
            assert!(0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin>(&v2) && 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin>(v2) == v1.origin, 11);
            v0 = v0 + 1;
        };
    }

    fun collect(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<u8>, arg3: u64, arg4: &mut vector<Node>, arg5: &mut vector<Required>) {
        assert!(arg3 <= 16 && 0x1::vector::length<Node>(arg4) < 256, 7);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nesting_revision(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 12);
        let v1 = Node{
            soul     : 0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0),
            origin   : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(arg0),
            parent   : arg1,
            name     : arg2,
            topology : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nesting_revision(arg0),
        };
        0x1::vector::push_back<Node>(arg4, v1);
        let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v3 = &v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v3)) {
            let v5 = 0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v3, v4);
            if (handover_required(arg0, v5)) {
                let v6 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_version(arg0, v5);
                assert!(0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v6) && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::installed_revision(0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v6)) > 0, 12);
                let v7 = Required{
                    soul         : 0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0),
                    binding      : duty(v5),
                    acknowledged : 0x1::option::none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(),
                    version      : 0x1::option::none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(),
                };
                0x1::vector::push_back<Required>(arg5, v7);
            };
            v4 = v4 + 1;
        };
        let v8 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v9 = &v8;
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v9)) {
            let v11 = 0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v9, v10);
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(v11) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::NestedSoulWitness>()) {
                let v12 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nesting_revision(arg0);
                assert!(0x1::option::is_some<u64>(&v12), 12);
                collect(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nested(arg0, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(v11)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0)), 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_name(v11), arg3 + 1, arg4, arg5);
            };
            v10 = v10 + 1;
        };
    }

    public fun construction_id(arg0: &Construction) : 0x2::object::ID {
        pinned_construction(arg0);
        arg0.root_id
    }

    public fun construction_mut(arg0: &mut Construction) : &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation {
        pinned_construction(arg0);
        &mut arg0.root
    }

    public fun construction_ref(arg0: &Construction) : &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul {
        pinned_construction(arg0);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root)
    }

    public fun construction_snapshot(arg0: &Construction) : 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::Snapshot {
        pinned_construction(arg0);
        arg0.request
    }

    fun current(arg0: &Handover) : vector<Required> {
        let v0 = 0x1::vector::empty<Node>();
        let v1 = 0x1::vector::empty<Required>();
        let v2 = &mut v0;
        let v3 = &mut v1;
        collect(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), 0x1::option::none<0x2::object::ID>(), b"", 0, v2, v3);
        assert!(v0 == arg0.nodes && 0x1::vector::length<Required>(&v1) == 0x1::vector::length<Required>(&arg0.duties), 12);
        let v4 = &v1;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Required>(v4)) {
            let v6 = 0x1::vector::borrow<Required>(v4, v5);
            let v7 = &arg0.duties;
            let v8 = 0;
            let v9;
            while (v8 < 0x1::vector::length<Required>(v7)) {
                let v10 = 0x1::vector::borrow<Required>(v7, v8);
                if (v10.soul == v6.soul && v10.binding == v6.binding) {
                    v9 = true;
                    /* label 18 */
                    assert!(v9, 12);
                    v5 = v5 + 1;
                    /* goto 6 */
                    continue
                };
                v8 = v8 + 1;
            };
            v9 = false;
            /* goto 18 */
        };
        v1
    }

    fun declaration(arg0: bool) : vector<u8> {
        let v0 = b"soulidity.lifecycle/handover:v1";
        let v1 = if (arg0) {
            1
        } else {
            0
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        v0
    }

    fun declared(arg0: &vector<u8>) : bool {
        let v0 = b"soulidity.lifecycle/handover:v1";
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(&v0) + 1 || *0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(&v0)) > 1) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(&v0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun deliver(arg0: Construction, arg1: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg2: address, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        pinned_construction(&arg0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg3), 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations);
        assert!(arg2 == arg0.actor || !existing_protected(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations), 12);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.request, arg3);
        let Construction {
            root         : v0,
            root_id      : v1,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : _,
        } = arg0;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_deliver(v0, arg2);
        v1
    }

    public fun deliver_locked_authority(arg0: Construction, arg1: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg4: &0x2::transfer_policy::TransferPolicy<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>, arg5: &0x2::tx_context::TxContext) : 0x2::object::ID {
        pinned_construction(&arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.actor, 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations);
        assert!(!existing_protected(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations), 12);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.request, arg5);
        let Construction {
            root         : v0,
            root_id      : v1,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : _,
        } = arg0;
        let v6 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_lock(v0, arg2, arg3, arg4, arg5);
        assert!(v6 == v1, 9);
        v6
    }

    public fun deliver_parent(arg0: ParentDelivery, arg1: address, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        pinned_parent(&arg0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg2), 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations);
        assert!(arg1 == arg0.actor || !existing_protected(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations), 12);
        let ParentDelivery {
            root         : v0,
            root_id      : v1,
            fixed_origin : _,
            actor        : _,
            obligations  : _,
        } = arg0;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_deliver(v0, arg1);
        v1
    }

    fun duty(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor) : Duty {
        Duty{
            namespace : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(arg0),
            name      : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_name(arg0),
            value     : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::value_type(arg0),
            object    : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(arg0),
            schema    : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(arg0),
        }
    }

    fun existing_protected(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &vector<Obligation>) : bool {
        if (has_policy(arg0) && !fresh(arg0, arg1)) {
            return true
        };
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0)) {
            let v2 = 0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0, v1);
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(v2) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::NestedSoulWitness>() && existing_protected(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nested(arg0, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(v2)), arg1)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun finish_handover(arg0: Handover, arg1: address) : 0x2::object::ID {
        assert!(arg1 != @0x0, 5);
        validate(&arg0);
        let Handover {
            root   : v0,
            nodes  : _,
            duties : _,
        } = arg0;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_deliver(v0, arg1)
    }

    public fun finish_handover_lock_authority(arg0: Handover, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg3: &0x2::transfer_policy::TransferPolicy<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>, arg4: &0x2::tx_context::TxContext) : 0x2::object::ID {
        validate(&arg0);
        let Handover {
            root   : v0,
            nodes  : _,
            duties : _,
        } = arg0;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_lock(v0, arg1, arg2, arg3, arg4)
    }

    public fun finish_handover_place(arg0: Handover, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap) : 0x2::object::ID {
        validate(&arg0);
        let Handover {
            root   : v0,
            nodes  : _,
            duties : _,
        } = arg0;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_place_owned(v0, arg1, arg2)
    }

    public fun finish_handover_place_authority(arg0: Handover, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        validate(&arg0);
        let Handover {
            root   : v0,
            nodes  : _,
            duties : _,
        } = arg0;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_place_owned_authority(v0, arg1, arg2, arg3)
    }

    fun fresh(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &vector<Obligation>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<Obligation>(arg1)) {
            let v2 = 0x1::vector::borrow<Obligation>(arg1, v0);
            let v3 = if (v2.fresh) {
                if (v2.root == 0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0)) {
                    v2.origin == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(arg0)
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v1 = true;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = false;
        v1
    }

    public fun handover_id(arg0: &Handover) : 0x2::object::ID {
        0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root))
    }

    public fun handover_mut(arg0: &mut Handover) : &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation {
        &mut arg0.root
    }

    public fun handover_ref(arg0: &Handover) : &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul {
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root)
    }

    public fun handover_required(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor) : bool {
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_annotation(arg0, arg1);
        0x1::option::is_some<vector<u8>>(&v0) && declared(0x1::option::borrow<vector<u8>>(&v0))
    }

    fun has_policy(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul) : bool {
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v1)) {
            if (handover_required(arg0, 0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(v1, v2))) {
                v3 = true;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = false;
        v3
    }

    public fun install_creation_protected<T0: drop, T1: store + key>(arg0: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64) {
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_install_annotated<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg6, arg7, declaration(arg5));
    }

    public fun install_protected<T0: drop, T1: store + key>(arg0: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64) {
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::install_annotated<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg6, arg7, declaration(arg5));
    }

    fun lookup(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &Duty) : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor {
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0)) {
            if (duty(0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0, v1)) == *arg1) {
                return *0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0, v1)
            };
            v1 = v1 + 1;
        };
        abort 12
    }

    fun merge(arg0: &mut vector<Obligation>, arg1: vector<Obligation>) {
        while (!0x1::vector::is_empty<Obligation>(&arg1)) {
            0x1::vector::push_back<Obligation>(arg0, 0x1::vector::pop_back<Obligation>(&mut arg1));
        };
        0x1::vector::destroy_empty<Obligation>(arg1);
    }

    public fun nest_construction(arg0: &mut Construction, arg1: Construction, arg2: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        pinned_construction(arg0);
        pinned_construction(&arg1);
        assert!(arg0.actor == 0x2::tx_context::sender(arg4) && arg1.actor == arg0.actor, 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.obligations);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.request, arg4);
        let Construction {
            root         : v0,
            root_id      : _,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : v5,
        } = arg1;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_nest(&mut arg0.root, v0, arg3);
        let v6 = &mut arg0.obligations;
        merge(v6, v5);
    }

    public fun nest_into_delivery(arg0: &mut ParentDelivery, arg1: Construction, arg2: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        pinned_parent(arg0);
        pinned_construction(&arg1);
        assert!(arg0.actor == 0x2::tx_context::sender(arg4) && arg1.actor == arg0.actor, 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.obligations);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.request, arg4);
        let Construction {
            root         : v0,
            root_id      : _,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : v5,
        } = arg1;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_nest(&mut arg0.root, v0, arg3);
        let v6 = &mut arg0.obligations;
        merge(v6, v5);
    }

    public fun nest_into_parent(arg0: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: Construction, arg2: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg3: u64, arg4: &0x2::tx_context::TxContext) : ParentDelivery {
        pinned_construction(&arg1);
        assert!(arg1.actor == 0x2::tx_context::sender(arg4), 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.obligations);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.request, arg4);
        let v0 = 0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(&arg0);
        let v1 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(&arg0);
        let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::hold_owned(arg0);
        let Construction {
            root         : v3,
            root_id      : _,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : v8,
        } = arg1;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_nest(&mut v2, v3, arg3);
        let v9 = Obligation{
            root   : v0,
            origin : v1,
            fresh  : false,
        };
        let v10 = 0x1::vector::empty<Obligation>();
        0x1::vector::push_back<Obligation>(&mut v10, v9);
        let v11 = &mut v10;
        merge(v11, v8);
        ParentDelivery{
            root         : v2,
            root_id      : v0,
            fixed_origin : v1,
            actor        : 0x2::tx_context::sender(arg4),
            obligations  : v10,
        }
    }

    public fun nest_locked_authority(arg0: Construction, arg1: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg4: 0x2::object::ID, arg5: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin, arg6: u64, arg7: &0x2::tx_context::TxContext) : 0x2::object::ID {
        pinned_construction(&arg0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg7), 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations);
        assert!(!existing_protected(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.obligations), 12);
        0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::consume_delivery<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.request, arg7);
        let Construction {
            root         : v0,
            root_id      : v1,
            fixed_origin : _,
            request      : _,
            actor        : _,
            obligations  : _,
        } = arg0;
        let v6 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_nest_locked(v0, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(v6 == v1, 9);
        v6
    }

    public fun nest_parent_delivery(arg0: &mut Construction, arg1: ParentDelivery, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        pinned_construction(arg0);
        pinned_parent(&arg1);
        assert!(arg0.actor == 0x2::tx_context::sender(arg3) && arg1.actor == arg0.actor, 11);
        closure(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg1.root), &arg1.obligations);
        let ParentDelivery {
            root         : v0,
            root_id      : _,
            fixed_origin : _,
            actor        : _,
            obligations  : v4,
        } = arg1;
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_nest(&mut arg0.root, v0, arg2);
        let v5 = &mut arg0.obligations;
        merge(v5, v4);
    }

    public fun parent_id(arg0: &ParentDelivery) : 0x2::object::ID {
        pinned_parent(arg0);
        arg0.root_id
    }

    public fun parent_mut(arg0: &mut ParentDelivery) : &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Creation {
        pinned_parent(arg0);
        &mut arg0.root
    }

    public fun parent_ref(arg0: &ParentDelivery) : &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul {
        pinned_parent(arg0);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root)
    }

    fun pinned(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: 0x2::object::ID, arg2: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin) {
        assert!(0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0) == arg1 && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(arg0) == arg2, 9);
    }

    fun pinned_construction(arg0: &Construction) {
        pinned(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), arg0.root_id, arg0.fixed_origin);
        attested(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), &arg0.request);
        assert!(arg0.actor == 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::actor(&arg0.request), 11);
    }

    fun pinned_parent(arg0: &ParentDelivery) {
        pinned(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), arg0.root_id, arg0.fixed_origin);
    }

    public fun protected_removable_intent(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor) : 0x1::option::Option<bool> {
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_annotation(arg0, arg1);
        if (0x1::option::is_some<vector<u8>>(&v0) && declared(0x1::option::borrow<vector<u8>>(&v0))) {
            let v2 = 0x1::option::destroy_some<vector<u8>>(v0);
            0x1::option::some<bool>(*0x1::vector::borrow<u8>(&v2, 0x1::vector::length<u8>(&v2) - 1) == 1)
        } else {
            0x1::option::none<bool>()
        }
    }

    fun reachable_descriptor(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: 0x2::object::ID, arg2: &Duty) : 0x1::option::Option<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor> {
        if (0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0) == arg1) {
            return 0x1::option::some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(lookup(arg0, arg2))
        };
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0)) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0, v1)) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::NestedSoulWitness>()) {
                let v2 = reachable_descriptor(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nested(arg0, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0, v1))), arg1, arg2);
                if (0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v2)) {
                    return v2
                };
            };
            v1 = v1 + 1;
        };
        0x1::option::none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>()
    }

    fun reachable_origin(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: 0x2::object::ID) : 0x1::option::Option<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin> {
        if (0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0) == arg1) {
            return 0x1::option::some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(arg0))
        };
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0)) {
            let v2 = 0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0, v1);
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(v2) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::NestedSoulWitness>()) {
                assert!(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::value_type(v2) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(), 9);
                let v3 = reachable_origin(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nested(arg0, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(v2)), arg1);
                if (0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin>(&v3)) {
                    return v3
                };
            };
            v1 = v1 + 1;
        };
        0x1::option::none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin>()
    }

    fun reachable_version(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: 0x2::object::ID, arg2: &Duty) : 0x1::option::Option<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion> {
        if (0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0) == arg1) {
            let v0 = lookup(arg0, arg2);
            return 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_version(arg0, &v0)
        };
        let v1 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_page(arg0, 0, 64);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v1)) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v1, v2)) == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::NestedSoulWitness>()) {
                let v3 = reachable_version(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::nested(arg0, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(0x1::vector::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v1, v2))), arg1, arg2);
                if (0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v3)) {
                    return v3
                };
            };
            v2 = v2 + 1;
        };
        0x1::option::none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>()
    }

    fun same_module<T0, T1>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = if (!0x1::type_name::is_primitive(&v0)) {
            if (!0x1::type_name::is_primitive(&v1)) {
                if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
                    0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
    }

    fun validate(arg0: &Handover) {
        let v0 = current(arg0);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Required>(v1)) {
            let v3 = 0x1::vector::borrow<Required>(v1, v2);
            let v4 = 0;
            let v5 = false;
            while (v4 < 0x1::vector::length<Required>(&arg0.duties)) {
                let v6 = 0x1::vector::borrow<Required>(&arg0.duties, v4);
                let v7 = if (v6.soul == v3.soul) {
                    if (v6.binding == v3.binding) {
                        0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v6.acknowledged)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    let v8 = reachable_version(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), v3.soul, &v3.binding);
                    let v9 = if (*0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v6.acknowledged) == 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(reachable_descriptor(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::creation_ref(&arg0.root), v3.soul, &v3.binding))) {
                        if (0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v6.version)) {
                            if (0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v8)) {
                                *0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v6.version) == *0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::ModuleVersion>(&v8)
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    v5 = v9;
                };
                v4 = v4 + 1;
            };
            assert!(v5, 12);
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

