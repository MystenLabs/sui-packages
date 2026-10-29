module 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::account {
    struct Account has key {
        id: 0x2::object::UID,
        kiosk: 0x2::object::ID,
        owner: address,
        authority: 0x1::option::Option<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>,
    }

    struct IngressKey has copy, drop, store {
        root: 0x2::object::ID,
    }

    struct IngressBinding has copy, drop, store {
        root: 0x2::object::ID,
        witness_original: 0x1::type_name::TypeName,
        witness_defining: 0x1::type_name::TypeName,
        value_original: 0x1::type_name::TypeName,
        value_defining: 0x1::type_name::TypeName,
        name: vector<u8>,
        module_id: 0x2::object::ID,
    }

    struct AccountHandover {
        account: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        actor: address,
        operation: u8,
        source: IngressBinding,
        inner: 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Handover,
    }

    struct SourceEdit<phantom T0, phantom T1: store + key> {
        account: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        actor: address,
        source: IngressBinding,
        schema: u16,
        origin: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin,
        revision: u64,
        ticket: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Edit<T0, T1>,
    }

    struct AccountServiceWitness has drop {
        dummy_field: bool,
    }

    struct FormsEdit<phantom T0, phantom T1: store + key, phantom T2, phantom T3: store + key> {
        account: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        actor: address,
        source: IngressBinding,
        journal: 0x2::object::ID,
        origin: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Origin,
        revision: u64,
        ticket: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Edit<T2, T3>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, Account) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = Account{
            id        : 0x2::object::new(arg0),
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            owner     : 0x2::tx_context::sender(arg0),
            authority : 0x1::option::some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::seal(&mut v2, v1, arg0)),
        };
        (v2, v3)
    }

    public fun owner(arg0: &Account) : address {
        arg0.owner
    }

    public fun add_extension<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: &mut 0x2::tx_context::TxContext) {
        assert_pair(arg1, arg2, arg3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::add_extension<T0>(arg0, arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3);
    }

    public fun assert_access(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut Account, arg2: &0x2::tx_context::TxContext) {
        assert_pair(arg0, arg1, arg2);
    }

    fun assert_collection<T0, T1: drop, T2: drop, T3>(arg0: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::Config<T0>, arg1: T1, arg2: T2) {
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::assert_role_types<T0, T1, T2>(arg0, 4);
        let v0 = 0x1::type_name::with_original_ids<T3>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_defining_ids<T3>();
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = if (!0x1::type_name::is_primitive(&v0)) {
            if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
                if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                    let v5 = 0x1::type_name::datatype_string(&v0);
                    if (*0x1::ascii::as_bytes(&v5) == b"Right") {
                        if (0x1::type_name::address_string(&v2) == 0x1::type_name::address_string(&v3)) {
                            0x1::type_name::module_string(&v2) == 0x1::type_name::module_string(&v3)
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
        assert!(v4, 2);
    }

    fun assert_forms_types<T0, T1, T2, T3>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_original_ids<T2>();
        let v3 = 0x1::type_name::with_original_ids<T3>();
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = 0x1::type_name::with_defining_ids<T1>();
        let v6 = 0x1::type_name::with_defining_ids<T2>();
        let v7 = 0x1::type_name::with_defining_ids<T3>();
        let v8 = if (0x1::type_name::module_string(&v0) == 0x1::ascii::string(b"character")) {
            if (0x1::type_name::datatype_string(&v0) == 0x1::ascii::string(b"ApplicationWitness")) {
                if (0x1::type_name::module_string(&v1) == 0x1::ascii::string(b"character")) {
                    if (0x1::type_name::datatype_string(&v1) == 0x1::ascii::string(b"ApplicationState")) {
                        if (0x1::type_name::module_string(&v2) == 0x1::ascii::string(b"forms")) {
                            if (0x1::type_name::datatype_string(&v2) == 0x1::ascii::string(b"Witness")) {
                                if (0x1::type_name::module_string(&v3) == 0x1::ascii::string(b"forms")) {
                                    0x1::type_name::datatype_string(&v3) == 0x1::ascii::string(b"Journal")
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
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 90);
        let v9 = if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
            if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v2)) {
                if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v3)) {
                    if (0x1::type_name::address_string(&v4) == 0x1::type_name::address_string(&v5)) {
                        if (0x1::type_name::address_string(&v4) == 0x1::type_name::address_string(&v6)) {
                            0x1::type_name::address_string(&v4) == 0x1::type_name::address_string(&v7)
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
        assert!(v9, 90);
        assert_nesting_namespace<T0, T1>();
        assert_nesting_namespace<T2, T3>();
    }

    public fun assert_legacy_disabled(arg0: &0x2::kiosk::Kiosk) {
        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::assert_legacy_disabled(arg0);
    }

    fun assert_nesting_namespace<T0, T1>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = if (!0x1::type_name::is_primitive(&v0)) {
            if (!0x1::type_name::is_primitive(&v1)) {
                if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
                    if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                        if (0x1::type_name::address_string(&v2) == 0x1::type_name::address_string(&v3)) {
                            0x1::type_name::module_string(&v2) == 0x1::type_name::module_string(&v3)
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
        assert!(v4, 2);
    }

    public fun assert_pair(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Account, arg2: &0x2::tx_context::TxContext) {
        assert_pair_inner(arg0, arg1, arg2);
    }

    fun assert_pair_inner(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Account, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg0) && 0x2::kiosk::owner(arg0) == arg1.owner, 2);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::assert_pair(arg0, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg1.authority), arg2);
    }

    fun assert_session(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Account, arg2: &AccountHandover, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert_pair(arg0, arg1, arg4);
        let v0 = if (arg2.account == 0x2::object::id<Account>(arg1)) {
            if (arg2.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg0)) {
                if (arg2.actor == 0x2::tx_context::sender(arg4)) {
                    if (arg2.operation == arg3) {
                        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::handover_id(&arg2.inner) == arg2.source.root
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
        assert!(v0, 2);
    }

    fun assert_source<T0: drop, T1: store + key>(arg0: T0, arg1: &AccountHandover) {
        assert!(source_binding<T0, T1>(arg0, 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::handover_ref(&arg1.inner), arg1.source.name) == arg1.source, 2);
    }

    public fun begin_forms_edit<T0: drop, T1: store + key, T2: drop, T3: store + key>(arg0: T0, arg1: T2, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut Account, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::tx_context::TxContext) : (T3, FormsEdit<T0, T1, T2, T3>) {
        assert_forms_types<T0, T1, T2, T3>();
        assert_pair(arg2, arg3, arg6);
        assert!(0x2::kiosk::is_locked(arg2, arg4) && !0x2::kiosk::is_listed(arg2, arg4), 90);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg3.authority), arg4, arg6);
        let v1 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T2>(v0, b"forms"));
        let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T2, T3>(v0, b"forms");
        let v3 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v0) == arg5) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(&v1) == 2) {
                if (!0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::removable(&v1)) {
                    0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v1) == 0x1::hash::sha3_256(0x1::bcs::to_bytes<T3>(v2))
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 90);
        let v4 = 0x2::object::id<T3>(v2);
        let (v5, v6) = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::begin_update<T2, T3>(v0, arg1, b"forms", arg5);
        let v7 = FormsEdit<T0, T1, T2, T3>{
            account  : 0x2::object::id<Account>(arg3),
            kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            actor    : 0x2::tx_context::sender(arg6),
            source   : source_binding<T0, T1>(arg0, v0, b"animacraft"),
            journal  : v4,
            origin   : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v0),
            revision : arg5,
            ticket   : v6,
        };
        (v5, v7)
    }

    public fun begin_source_deposit<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : AccountHandover {
        assert_pair(arg1, arg2, arg5);
        let v0 = source_binding<T0, T1>(arg0, &arg3, arg4);
        let v1 = IngressKey{root: v0.root};
        assert!(!0x2::dynamic_field::exists_<IngressKey>(&arg2.id, v1), 2);
        AccountHandover{
            account   : 0x2::object::id<Account>(arg2),
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            actor     : 0x2::tx_context::sender(arg5),
            operation : 0,
            source    : v0,
            inner     : 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::begin_handover(arg3),
        }
    }

    public fun begin_source_edit<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u16, arg6: u64, arg7: &0x2::tx_context::TxContext) : (T1, SourceEdit<T0, T1>) {
        assert_pair(arg1, arg2, arg7);
        assert_nesting_namespace<T0, T1>();
        assert!(0x2::kiosk::is_locked(arg1, arg3) && !0x2::kiosk::is_listed(arg1, arg3), 2);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg7);
        let v1 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(v0, arg4));
        let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(v0, arg4);
        let v3 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(&v1) == arg5) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v0) == arg6) {
                0x1::hash::sha3_256(0x1::bcs::to_bytes<T1>(v2)) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 2);
        let (v4, v5) = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::begin_update<T0, T1>(v0, arg0, arg4, arg6);
        let v6 = SourceEdit<T0, T1>{
            account  : 0x2::object::id<Account>(arg2),
            kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            actor    : 0x2::tx_context::sender(arg7),
            source   : source_binding_type<T0, T1>(v0, arg4),
            schema   : arg5,
            origin   : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v0),
            revision : arg6,
            ticket   : v5,
        };
        (v4, v6)
    }

    public fun begin_source_withdraw<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) : AccountHandover {
        assert_pair(arg1, arg2, arg4);
        let v0 = IngressKey{root: arg3};
        let v1 = *0x2::dynamic_field::borrow<IngressKey, IngressBinding>(&arg2.id, v0);
        let v2 = if (v1.witness_original == 0x1::type_name::with_original_ids<T0>()) {
            if (v1.witness_defining == 0x1::type_name::with_defining_ids<T0>()) {
                if (v1.value_original == 0x1::type_name::with_original_ids<T1>()) {
                    v1.value_defining == 0x1::type_name::with_defining_ids<T1>()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        let v3 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::take<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg4);
        assert!(source_binding<T0, T1>(arg0, &v3, v1.name) == v1, 2);
        AccountHandover{
            account   : 0x2::object::id<Account>(arg2),
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            actor     : 0x2::tx_context::sender(arg4),
            operation : 1,
            source    : v1,
            inner     : 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::begin_handover(v3),
        }
    }

    public fun borrow_for_collection<T0, T1: drop, T2: drop, T3: store + key>(arg0: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::Config<T0>, arg1: T1, arg2: T2, arg3: &mut 0x2::kiosk::Kiosk, arg4: &Account, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) : &mut T3 {
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::assert_role_types<T0, T1, T2>(arg0, 4);
        assert!(0x1::type_name::with_original_ids<T3>() == 0x1::type_name::with_original_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>() && 0x1::type_name::with_defining_ids<T3>() == 0x1::type_name::with_defining_ids<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(), 2);
        assert_pair(arg3, arg4, arg6);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_mut<T3>(arg3, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg4.authority), arg5, arg6)
    }

    public fun borrow_right<T0, T1: drop, T2: drop, T3: store + key>(arg0: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::Config<T0>, arg1: T1, arg2: T2, arg3: &mut 0x2::kiosk::Kiosk, arg4: &Account, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) : &T3 {
        assert_collection<T0, T1, T2, T3>(arg0, arg1, arg2);
        assert_pair(arg3, arg4, arg6);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow<T3>(arg3, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg4.authority), arg5, arg6)
    }

    public fun cap_id(arg0: &Account) : 0x2::object::ID {
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::cap_id(0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg0.authority))
    }

    public fun close_source_service<T0, T1>(arg0: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::SourceService<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: &0x2::tx_context::TxContext) {
        let v0 = if (arg2.owner == 0x2::tx_context::sender(arg3)) {
            if (arg2.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg1)) {
                0x1::option::is_none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = AccountServiceWitness{dummy_field: false};
        let (v2, v3) = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::close_source_service<AccountServiceWitness, T0, T1>(v1, arg0, arg1, arg3);
        assert!(v2 == 0x2::object::id<Account>(arg2), 2);
        0x1::option::fill<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&mut arg2.authority, v3);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = new(arg0);
        finalize(v0, v1, arg0)
    }

    public fun deliver_locked_account(arg0: 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Construction, arg1: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg2: &mut 0x2::kiosk::Kiosk, arg3: Account, arg4: &0x2::transfer_policy::TransferPolicy<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>, arg5: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_pair(arg2, &arg3, arg5);
        0x2::transfer::transfer<Account>(arg3, arg3.owner);
        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::deliver_locked_authority(arg0, arg1, arg2, 0x1::option::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&mut arg3.authority), arg4, arg5)
    }

    public fun deliver_locked_fresh_account(arg0: 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Construction, arg1: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg2: 0x2::kiosk::Kiosk, arg3: Account, arg4: &0x2::transfer_policy::TransferPolicy<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>, arg5: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = &mut arg2;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg2);
        deliver_locked_account(arg0, arg1, v0, arg3, arg4, arg5)
    }

    public fun disable_extension<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: &0x2::tx_context::TxContext) {
        assert_pair(arg1, arg2, arg3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::disable_extension<T0>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3);
    }

    public fun enable_extension<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: &0x2::tx_context::TxContext) {
        assert_pair(arg1, arg2, arg3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::enable_extension<T0>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3);
    }

    public fun finalize(arg0: 0x2::kiosk::Kiosk, arg1: Account, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = &mut arg0;
        let v1 = &mut arg1;
        assert_access(v0, v1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg0);
        0x2::transfer::transfer<Account>(arg1, 0x2::tx_context::sender(arg2));
        0x2::object::id<0x2::kiosk::Kiosk>(&arg0)
    }

    public fun finish_forms_edit<T0: drop, T1: store + key, T2: drop, T3: store + key>(arg0: T0, arg1: T2, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut Account, arg4: FormsEdit<T0, T1, T2, T3>, arg5: T3, arg6: &0x2::tx_context::TxContext) {
        assert_forms_types<T0, T1, T2, T3>();
        assert_pair(arg2, arg3, arg6);
        let FormsEdit {
            account  : v0,
            kiosk    : v1,
            actor    : v2,
            source   : v3,
            journal  : v4,
            origin   : v5,
            revision : v6,
            ticket   : v7,
        } = arg4;
        let v8 = v3;
        let v9 = if (v0 == 0x2::object::id<Account>(arg3)) {
            if (v1 == 0x2::object::id<0x2::kiosk::Kiosk>(arg2)) {
                if (v2 == 0x2::tx_context::sender(arg6)) {
                    if (0x2::object::id<T3>(&arg5) == v4) {
                        if (0x2::kiosk::is_locked(arg2, v8.root)) {
                            !0x2::kiosk::is_listed(arg2, v8.root)
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
        assert!(v9, 90);
        let v10 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg3.authority), v8.root, arg6);
        assert!(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v10) == v6 && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v10) == v5, 90);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::commit_update<T2, T3>(v10, v7, arg1, arg5, 2, 0x1::hash::sha3_256(0x1::bcs::to_bytes<T3>(&arg5)));
        assert!(source_binding_type<T0, T1>(v10, b"animacraft") == v8 && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v10) == v5, 90);
    }

    public fun finish_source_deposit<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: AccountHandover, arg4: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_session(arg1, arg2, &arg3, 0, arg4);
        assert_source<T0, T1>(arg0, &arg3);
        let AccountHandover {
            account   : _,
            kiosk     : _,
            actor     : _,
            operation : _,
            source    : v4,
            inner     : v5,
        } = arg3;
        let v6 = v4;
        let v7 = IngressKey{root: v6.root};
        0x2::dynamic_field::add<IngressKey, IngressBinding>(&mut arg2.id, v7, v6);
        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::finish_handover_place_authority(v5, arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg4)
    }

    public fun finish_source_edit<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: SourceEdit<T0, T1>, arg4: T1, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        assert_pair(arg1, arg2, arg6);
        assert_nesting_namespace<T0, T1>();
        let SourceEdit {
            account  : v0,
            kiosk    : v1,
            actor    : v2,
            source   : v3,
            schema   : v4,
            origin   : v5,
            revision : v6,
            ticket   : v7,
        } = arg3;
        let v8 = v3;
        let v9 = if (v0 == 0x2::object::id<Account>(arg2)) {
            if (v1 == 0x2::object::id<0x2::kiosk::Kiosk>(arg1)) {
                if (v2 == 0x2::tx_context::sender(arg6)) {
                    if (0x2::object::id<T1>(&arg4) == v8.module_id) {
                        if (0x2::kiosk::is_locked(arg1, v8.root)) {
                            !0x2::kiosk::is_listed(arg1, v8.root)
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
        assert!(v9, 2);
        let v10 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), v8.root, arg6);
        assert!(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v10) == v5 && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v10) == v6, 2);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::commit_update<T0, T1>(v10, v7, arg0, arg4, v4, arg5);
        assert!(source_binding_type<T0, T1>(v10, v8.name) == v8 && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v10) == v5, 2);
    }

    public fun finish_source_sale<T0: drop, T1: store + key>(arg0: T0, arg1: 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Handover, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut Account, arg4: &0x2::transfer_policy::TransferPolicy<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_pair(arg2, arg3, arg6);
        assert_nesting_namespace<T0, T1>();
        source_binding_type<T0, T1>(0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::handover_ref(&arg1), arg5);
        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::finish_handover_lock_authority(arg1, arg2, 0x1::option::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&mut arg3.authority), arg4, arg6)
    }

    public fun finish_source_withdraw<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: AccountHandover, arg4: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_session(arg1, arg2, &arg3, 1, arg4);
        assert_source<T0, T1>(arg0, &arg3);
        let AccountHandover {
            account   : _,
            kiosk     : _,
            actor     : _,
            operation : _,
            source    : v4,
            inner     : v5,
        } = arg3;
        let v6 = v4;
        let v7 = IngressKey{root: v6.root};
        assert!(0x2::dynamic_field::remove<IngressKey, IngressBinding>(&mut arg2.id, v7) == v6, 2);
        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::finish_handover(v5, 0x2::tx_context::sender(arg4))
    }

    public fun forms_exists<T0: drop, T1: store + key, T2: drop, T3: store + key>(arg0: T0, arg1: T2, arg2: &mut 0x2::kiosk::Kiosk, arg3: &Account, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) : bool {
        assert_forms_types<T0, T1, T2, T3>();
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T2>(source_root_read<T0, T1>(arg0, arg2, arg3, arg4, b"animacraft", arg5), b"forms");
        0x1::option::is_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v0)
    }

    public fun forms_read<T0: drop, T1: store + key, T2: drop, T3: store + key>(arg0: T0, arg1: T2, arg2: &mut 0x2::kiosk::Kiosk, arg3: &Account, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) : &T3 {
        assert_forms_types<T0, T1, T2, T3>();
        let v0 = source_root_read<T0, T1>(arg0, arg2, arg3, arg4, b"animacraft", arg5);
        let v1 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T2>(v0, b"forms"));
        let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T2, T3>(v0, b"forms");
        let v3 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(&v1) == 2) {
            if (!0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::removable(&v1)) {
                0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v1) == 0x1::hash::sha3_256(0x1::bcs::to_bytes<T3>(v2))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 90);
        v2
    }

    public fun from_native_cap(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : Account {
        Account{
            id        : 0x2::object::new(arg2),
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner     : 0x2::tx_context::sender(arg2),
            authority : 0x1::option::some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::seal(arg0, arg1, arg2)),
        }
    }

    public fun handover_mut(arg0: &mut AccountHandover) : &mut 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Handover {
        &mut arg0.inner
    }

    public fun handover_ref(arg0: &AccountHandover) : &0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Handover {
        &arg0.inner
    }

    public fun install_forms<T0: drop, T1: store + key, T2: drop, T3: store + key>(arg0: T0, arg1: T2, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut Account, arg4: 0x2::object::ID, arg5: T3, arg6: u64, arg7: &0x2::tx_context::TxContext) : u64 {
        assert_forms_types<T0, T1, T2, T3>();
        assert_pair(arg2, arg3, arg7);
        assert!(0x2::kiosk::is_locked(arg2, arg4) && !0x2::kiosk::is_listed(arg2, arg4), 90);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg2, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg3.authority), arg4, arg7);
        let v1 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v0) == arg6) {
            let v2 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T2>(v0, b"forms");
            0x1::option::is_none<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(&v2)
        } else {
            false
        };
        assert!(v1, 90);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::install<T2, T3>(v0, arg1, b"forms", arg5, 2, false, 0x1::hash::sha3_256(0x1::bcs::to_bytes<T3>(&arg5)), arg6);
        assert!(source_binding_type<T0, T1>(v0, b"animacraft") == source_binding<T0, T1>(arg0, v0, b"animacraft") && 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v0) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v0), 90);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v0)
    }

    public fun kiosk_id(arg0: &Account) : 0x2::object::ID {
        arg0.kiosk
    }

    public fun list_right<T0, T1: drop, T2: drop, T3: store + key>(arg0: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::Config<T0>, arg1: T1, arg2: T2, arg3: &mut 0x2::kiosk::Kiosk, arg4: &Account, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T3> {
        assert_collection<T0, T1, T2, T3>(arg0, arg1, arg2);
        assert_pair(arg3, arg4, arg6);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::list_exclusively<T3>(arg3, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg4.authority), arg5, arg6)
    }

    public fun list_source_sale<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul> {
        assert_pair(arg1, arg2, arg7);
        assert_nesting_namespace<T0, T1>();
        assert!(0x2::kiosk::is_locked(arg1, arg3) && !0x2::kiosk::is_listed(arg1, arg3), 2);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg7);
        source_binding_type<T0, T1>(v0, arg4);
        let v1 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(v0, arg4));
        let v2 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v0) == arg6) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(&v1) == arg5) {
                0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v1) == 0x1::hash::sha3_256(0x1::bcs::to_bytes<T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(v0, arg4)))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::list_exclusively<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg7)
    }

    public fun lock_right<T0, T1: drop, T2: drop, T3: store + key>(arg0: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics::Config<T0>, arg1: T1, arg2: T2, arg3: &mut 0x2::kiosk::Kiosk, arg4: &Account, arg5: &0x2::transfer_policy::TransferPolicy<T3>, arg6: T3, arg7: &0x2::tx_context::TxContext) {
        assert_collection<T0, T1, T2, T3>(arg0, arg1, arg2);
        assert_pair(arg3, arg4, arg7);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::lock<T3>(arg3, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg4.authority), arg5, arg6, arg7);
    }

    public fun nest_locked_source<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: 0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::Construction, arg6: 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin::CompletionAuthorization, arg7: u64, arg8: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_pair(arg1, arg2, arg8);
        assert_nesting_namespace<T0, T1>();
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg8);
        let v1 = source_binding<T0, T1>(arg0, v0, arg4);
        assert!(v1.root == arg3, 2);
        let v2 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(v0, arg4));
        assert!(0x1::hash::sha3_256(0x1::bcs::to_bytes<T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(v0, arg4))) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v2), 2);
        0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::nest_locked_authority(arg5, arg6, arg1, 0x1::option::borrow_mut<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&mut arg2.authority), arg3, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::origin(v0), arg7, arg8)
    }

    public fun open_source_service<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u16, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_pair(arg1, arg2, arg10);
        assert_nesting_namespace<T0, T1>();
        let v0 = AccountServiceWitness{dummy_field: false};
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::open_source_service<AccountServiceWitness, T0, T1>(v0, arg0, arg1, 0x1::option::extract<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&mut arg2.authority), 0x2::object::id<Account>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun place_source<T0: drop, T1: key, T2: store + key>(arg0: T0, arg1: &T1, arg2: &mut 0x2::kiosk::Kiosk, arg3: &Account, arg4: T2, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_original_ids<T2>();
        let v3 = if (!0x1::type_name::is_primitive(&v0)) {
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
        assert!(v3, 2);
        assert!(0x1::type_name::module_string(&v2) != 0x1::ascii::string(b"soul") || 0x1::type_name::datatype_string(&v2) != 0x1::ascii::string(b"Soul"), 2);
        assert_pair(arg2, arg3, arg5);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::place<T2>(arg2, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg3.authority), arg4, arg5);
    }

    public fun remove_extension<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: &0x2::tx_context::TxContext) {
        assert_pair(arg1, arg2, arg3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::remove_extension<T0>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3);
    }

    fun source_binding<T0: drop, T1: store + key>(arg0: T0, arg1: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg2: vector<u8>) : IngressBinding {
        source_binding_type<T0, T1>(arg1, arg2)
    }

    fun source_binding_type<T0, T1: store + key>(arg0: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul, arg1: vector<u8>) : IngressBinding {
        let v0 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(arg0, arg1));
        let v1 = if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::namespace(&v0) == 0x1::type_name::with_defining_ids<T0>()) {
            if (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::value_type(&v0) == 0x1::type_name::with_defining_ids<T1>()) {
                if (0x8094b4b28af68646831c2c4bb969d558865c59a483bd23ccc67aa7f88c74a0e::lifecycle::handover_required(arg0, &v0)) {
                    !0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::removable(&v0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        assert!(0x2::object::id<T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(arg0, arg1)) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(&v0), 2);
        IngressBinding{
            root             : 0x2::object::id<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg0),
            witness_original : 0x1::type_name::with_original_ids<T0>(),
            witness_defining : 0x1::type_name::with_defining_ids<T0>(),
            value_original   : 0x1::type_name::with_original_ids<T1>(),
            value_defining   : 0x1::type_name::with_defining_ids<T1>(),
            name             : arg1,
            module_id        : 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_id(&v0),
        }
    }

    public fun source_module<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : (&T1, u16) {
        assert_pair(arg1, arg2, arg5);
        assert_nesting_namespace<T0, T1>();
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg5);
        let v1 = source_binding<T0, T1>(arg0, v0, arg4);
        assert!(v1.root == arg3, 2);
        let v2 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(v0, arg4));
        let v3 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(v0, arg4);
        assert!(0x1::hash::sha3_256(0x1::bcs::to_bytes<T1>(v3)) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v2), 2);
        (v3, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::module_schema(&v2))
    }

    public fun source_root_read<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul {
        assert_pair(arg1, arg2, arg5);
        assert_nesting_namespace<T0, T1>();
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg5);
        let v1 = source_binding<T0, T1>(arg0, v0, arg4);
        assert!(v1.root == arg3, 2);
        let v2 = 0x1::option::destroy_some<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Descriptor>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::descriptor<T0>(v0, arg4));
        assert!(0x1::hash::sha3_256(0x1::bcs::to_bytes<T1>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::borrow_module<T0, T1>(v0, arg4))) == 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::body_hash(&v2), 2);
        v0
    }

    public fun source_root_snapshot<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Account, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : (u64, vector<u8>) {
        assert_pair(arg1, arg2, arg5);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::Soul>(arg1, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg2.authority), arg3, arg5);
        source_binding_type<T0, T1>(v0, arg4);
        (0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::revision(v0), 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul::manifest_hash(v0))
    }

    public fun take_external<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Account, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : T0 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::type_name::module_string(&v0) != 0x1::ascii::string(b"soul") || 0x1::type_name::datatype_string(&v0) != 0x1::ascii::string(b"Soul"), 2);
        assert_pair(arg0, arg1, arg3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::assert_legacy_disabled(arg0);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::take<T0>(arg0, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg1.authority), arg2, arg3)
    }

    public fun withdraw_profits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut Account, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_access(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::withdraw(arg0, 0x1::option::borrow<0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority>(&arg1.authority), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

