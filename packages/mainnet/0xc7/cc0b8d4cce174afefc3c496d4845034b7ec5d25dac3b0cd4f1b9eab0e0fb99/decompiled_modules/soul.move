module 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    struct Soul has store, key {
        id: 0x2::object::UID,
        schema: u16,
        name: 0x1::string::String,
        revision: u64,
        origin: Origin,
        modules: vector<Descriptor>,
        editing: bool,
    }

    struct Origin has copy, drop, store {
        producer: 0x1::type_name::TypeName,
        source_type: 0x1::type_name::TypeName,
        source: 0x2::object::ID,
        source_version: u64,
        source_hash: vector<u8>,
        minted_by: address,
    }

    struct Descriptor has copy, drop, store {
        namespace: 0x1::type_name::TypeName,
        name: vector<u8>,
        value_type: 0x1::type_name::TypeName,
        object: 0x2::object::ID,
        schema: u16,
        removable: bool,
        body_hash: vector<u8>,
        semantic_hash: vector<u8>,
    }

    struct ModuleKey<phantom T0> has copy, drop, store {
        name: vector<u8>,
    }

    struct NestedSoulWitness has drop {
        dummy_field: bool,
    }

    struct ModuleVersionKey has copy, drop, store {
        namespace: 0x1::type_name::TypeName,
        name: vector<u8>,
    }

    struct ModuleVersion has copy, drop, store {
        installed: u64,
        updated: u64,
    }

    struct NestingVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ModuleAnnotationKey has copy, drop, store {
        namespace: 0x1::type_name::TypeName,
        name: vector<u8>,
    }

    struct Edit<phantom T0, phantom T1> {
        soul: 0x2::object::ID,
        object: 0x2::object::ID,
        name: vector<u8>,
        revision: u64,
    }

    struct Changed has copy, drop {
        soul: 0x2::object::ID,
        revision: u64,
        operation: u8,
        namespace: 0x1::type_name::TypeName,
        name: vector<u8>,
        object: 0x2::object::ID,
    }

    struct Manifest has copy, drop, store {
        domain: vector<u8>,
        soul: 0x2::object::ID,
        schema: u16,
        name: 0x1::string::String,
        revision: u64,
        origin: Origin,
        modules: vector<Descriptor>,
    }

    struct Creation {
        root: Soul,
        actor: address,
        fresh: bool,
    }

    struct CreationEdit {
        inner: Edit<NestedSoulWitness, Soul>,
    }

    struct SourceService<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        authority: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority,
        account: 0x2::object::ID,
        return_witness: 0x1::type_name::TypeName,
        root: 0x2::object::ID,
        value: 0x2::object::ID,
        name: vector<u8>,
        schema: u16,
        origin: Origin,
        revision: u64,
        expires: u64,
        binding: vector<u8>,
        busy: bool,
    }

    struct ServiceEdit<phantom T0, phantom T1> {
        service: 0x2::object::ID,
        actor: address,
        ticket: Edit<T0, T1>,
    }

    public fun new<T0: drop, T1: key>(arg0: T0, arg1: &T1, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : Creation {
        same_module<T0, T1>();
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::datatype_string(&v0);
        assert!(*0x1::ascii::as_bytes(&v1) == b"SoulProducer", 3);
        hash32(&arg3);
        assert!(arg2 > 0, 5);
        let v2 = Origin{
            producer       : 0x1::type_name::with_defining_ids<T0>(),
            source_type    : 0x1::type_name::with_defining_ids<T1>(),
            source         : 0x2::object::id<T1>(arg1),
            source_version : arg2,
            source_hash    : arg3,
            minted_by      : 0x2::tx_context::sender(arg5),
        };
        let v3 = Soul{
            id       : 0x2::object::new(arg5),
            schema   : 1,
            name     : arg4,
            revision : 0,
            origin   : v2,
            modules  : 0x1::vector::empty<Descriptor>(),
            editing  : false,
        };
        let v4 = NestingVersionKey{dummy_field: false};
        0x2::dynamic_field::add<NestingVersionKey, u64>(&mut v3.id, v4, 0);
        Creation{
            root  : v3,
            actor : 0x2::tx_context::sender(arg5),
            fresh : true,
        }
    }

    fun annotated(arg0: &mut Soul, arg1: &Descriptor, arg2: 0x1::option::Option<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            let v0 = 0x1::option::destroy_some<vector<u8>>(arg2);
            assert!(0x1::vector::length<u8>(&v0) <= 245760, 7);
            0x2::dynamic_field::add<ModuleAnnotationKey, vector<u8>>(&mut arg0.id, annotation_key(arg1), v0);
        };
    }

    fun annotation_key(arg0: &Descriptor) : ModuleAnnotationKey {
        ModuleAnnotationKey{
            namespace : arg0.namespace,
            name      : arg0.name,
        }
    }

    public fun assert_manifest(arg0: &Soul, arg1: u64, arg2: vector<u8>) {
        ready(arg0);
        cas(arg0, arg1);
        hash32(&arg2);
        assert!(manifest_hash(arg0) == arg2, 5);
    }

    public fun begin_nested_update(arg0: &mut Soul, arg1: 0x2::object::ID, arg2: u64) : (Soul, Edit<NestedSoulWitness, Soul>) {
        let v0 = NestedSoulWitness{dummy_field: false};
        begin_update<NestedSoulWitness, Soul>(arg0, v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1), arg2)
    }

    public fun begin_service_edit<T0: drop, T1: store + key>(arg0: T0, arg1: &mut SourceService<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (T1, ServiceEdit<T0, T1>) {
        let v0 = if (!arg1.busy) {
            if (arg1.revision == arg3) {
                0x2::clock::timestamp_ms(arg4) < arg1.expires
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        let v1 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::service_borrow_root<Soul>(arg2, &arg1.authority, arg1.root);
        assert!(v1.origin == arg1.origin, 9);
        let v2 = 0x1::option::destroy_some<Descriptor>(descriptor<T0>(v1, arg1.name));
        let v3 = borrow_module<T0, T1>(v1, arg1.name);
        let v4 = if (v2.schema == arg1.schema) {
            if (v2.object == arg1.value) {
                v2.body_hash == child_hash<T1>(v3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 9);
        let (v5, v6) = begin_update<T0, T1>(v1, arg0, arg1.name, arg3);
        arg1.busy = true;
        let v7 = ServiceEdit<T0, T1>{
            service : 0x2::object::id<SourceService<T0, T1>>(arg1),
            actor   : 0x2::tx_context::sender(arg5),
            ticket  : v6,
        };
        (v5, v7)
    }

    public fun begin_update<T0: drop, T1: store + key>(arg0: &mut Soul, arg1: T0, arg2: vector<u8>, arg3: u64) : (T1, Edit<T0, T1>) {
        ready(arg0);
        cas(arg0, arg3);
        same_module<T0, T1>();
        let v0 = 0x1::vector::borrow<Descriptor>(&arg0.modules, index<T0, T1>(arg0, &arg2)).object;
        let v1 = ModuleKey<T0>{name: arg2};
        let v2 = 0x2::dynamic_object_field::remove<ModuleKey<T0>, T1>(&mut arg0.id, v1);
        assert!(0x2::object::id<T1>(&v2) == v0, 9);
        arg0.editing = true;
        let v3 = Edit<T0, T1>{
            soul     : 0x2::object::id<Soul>(arg0),
            object   : v0,
            name     : arg2,
            revision : arg3,
        };
        (v2, v3)
    }

    public fun body_hash(arg0: &Descriptor) : vector<u8> {
        arg0.body_hash
    }

    public fun borrow_module<T0, T1: store + key>(arg0: &Soul, arg1: vector<u8>) : &T1 {
        ready(arg0);
        index<T0, T1>(arg0, &arg1);
        let v0 = ModuleKey<T0>{name: arg1};
        0x2::dynamic_object_field::borrow<ModuleKey<T0>, T1>(&arg0.id, v0)
    }

    fun cas(arg0: &Soul, arg1: u64) {
        assert!(arg0.revision == arg1, 1);
    }

    fun changed(arg0: &mut Soul, arg1: u8, arg2: &Descriptor) {
        arg0.revision = arg0.revision + 1;
        let v0 = Changed{
            soul      : 0x2::object::id<Soul>(arg0),
            revision  : arg0.revision,
            operation : arg1,
            namespace : arg2.namespace,
            name      : arg2.name,
            object    : arg2.object,
        };
        0x2::event::emit<Changed>(v0);
    }

    fun check_name(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0 && 0x1::vector::length<u8>(arg0) <= 64, 5);
    }

    fun child_hash<T0>(arg0: &T0) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 245760, 7);
        0x1::hash::sha3_256(v0)
    }

    public fun close_source_service<T0: drop, T1, T2>(arg0: T0, arg1: SourceService<T1, T2>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::tx_context::TxContext) : (0x2::object::ID, 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority) {
        assert!(!arg1.busy && arg1.return_witness == 0x1::type_name::with_defining_ids<T0>(), 9);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::assert_pair(arg2, &arg1.authority, arg3);
        let SourceService {
            id             : v0,
            authority      : v1,
            account        : v2,
            return_witness : _,
            root           : _,
            value          : _,
            name           : _,
            schema         : _,
            origin         : _,
            revision       : _,
            expires        : _,
            binding        : _,
            busy           : _,
        } = arg1;
        0x2::object::delete(v0);
        (v2, v1)
    }

    public fun commit_nested_update(arg0: &mut Soul, arg1: Edit<NestedSoulWitness, Soul>, arg2: Soul) {
        let v0 = NestedSoulWitness{dummy_field: false};
        commit_update<NestedSoulWitness, Soul>(arg0, arg1, v0, arg2, 1, manifest_hash(&arg2));
    }

    public fun commit_update<T0: drop, T1: store + key>(arg0: &mut Soul, arg1: Edit<T0, T1>, arg2: T0, arg3: T1, arg4: u16, arg5: vector<u8>) {
        same_module<T0, T1>();
        hash32(&arg5);
        let Edit {
            soul     : v0,
            object   : v1,
            name     : v2,
            revision : v3,
        } = arg1;
        let v4 = v2;
        let v5 = if (arg0.editing) {
            if (v0 == 0x2::object::id<Soul>(arg0)) {
                v1 == 0x2::object::id<T1>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 9);
        cas(arg0, v3);
        let v6 = index<T0, T1>(arg0, &v4);
        let v7 = *0x1::vector::borrow<Descriptor>(&arg0.modules, v6);
        assert!(v7.object == v1, 9);
        assert!(arg4 >= v7.schema, 10);
        v7.schema = arg4;
        v7.body_hash = child_hash<T1>(&arg3);
        v7.semantic_hash = arg5;
        let v8 = ModuleKey<T0>{name: v4};
        0x2::dynamic_object_field::add<ModuleKey<T0>, T1>(&mut arg0.id, v8, arg3);
        updated(arg0, &v7);
        *0x1::vector::borrow_mut<Descriptor>(&mut arg0.modules, v6) = v7;
        arg0.editing = false;
        changed(arg0, 2, &v7);
    }

    public fun creation_begin_nested_update(arg0: &mut Creation, arg1: 0x2::object::ID, arg2: u64) : (Creation, CreationEdit) {
        let v0 = &mut arg0.root;
        let (v1, v2) = begin_nested_update(v0, arg1, arg2);
        let v3 = Creation{
            root  : v1,
            actor : arg0.actor,
            fresh : arg0.fresh,
        };
        let v4 = CreationEdit{inner: v2};
        (v3, v4)
    }

    public fun creation_begin_update<T0: drop, T1: store + key>(arg0: &mut Creation, arg1: T0, arg2: vector<u8>, arg3: u64) : (T1, Edit<T0, T1>) {
        assert!(0x1::type_name::with_original_ids<T1>() != 0x1::type_name::with_original_ids<Soul>(), 3);
        let v0 = &mut arg0.root;
        begin_update<T0, T1>(v0, arg1, arg2, arg3)
    }

    public fun creation_commit_nested_update(arg0: &mut Creation, arg1: CreationEdit, arg2: Creation) {
        let CreationEdit { inner: v0 } = arg1;
        let Creation {
            root  : v1,
            actor : v2,
            fresh : v3,
        } = arg2;
        if (v3) {
            assert!(arg0.actor == @0x0 || v2 == arg0.actor, 3);
            arg0.actor = v2;
            arg0.fresh = true;
        };
        let v4 = &mut arg0.root;
        commit_nested_update(v4, v0, v1);
    }

    public fun creation_commit_update<T0: drop, T1: store + key>(arg0: &mut Creation, arg1: Edit<T0, T1>, arg2: T0, arg3: T1, arg4: u16, arg5: vector<u8>) {
        assert!(0x1::type_name::with_original_ids<T1>() != 0x1::type_name::with_original_ids<Soul>(), 3);
        let v0 = &mut arg0.root;
        commit_update<T0, T1>(v0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun creation_deliver(arg0: Creation, arg1: address) : 0x2::object::ID {
        assert!(arg1 != @0x0, 5);
        let Creation {
            root  : v0,
            actor : v1,
            fresh : v2,
        } = arg0;
        let v3 = v0;
        assert!(!v2 || arg1 == v1, 3);
        ready(&v3);
        0x2::transfer::public_transfer<Soul>(v3, arg1);
        0x2::object::id<Soul>(&v3)
    }

    public fun creation_deliver_sender(arg0: Creation, arg1: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.actor == 0x2::tx_context::sender(arg1) || arg0.actor == @0x0, 3);
        creation_deliver(arg0, 0x2::tx_context::sender(arg1))
    }

    public fun creation_id(arg0: &Creation) : 0x2::object::ID {
        0x2::object::id<Soul>(&arg0.root)
    }

    public fun creation_install<T0: drop, T1: store + key>(arg0: &mut Creation, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64) {
        assert!(0x1::type_name::with_original_ids<T1>() != 0x1::type_name::with_original_ids<Soul>(), 3);
        let v0 = &mut arg0.root;
        install<T0, T1>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun creation_install_annotated<T0: drop, T1: store + key>(arg0: &mut Creation, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64, arg8: vector<u8>) {
        assert!(0x1::type_name::with_original_ids<T1>() != 0x1::type_name::with_original_ids<Soul>(), 3);
        let v0 = &mut arg0.root;
        install_annotated<T0, T1>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun creation_lock(arg0: Creation, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg3: &0x2::transfer_policy::TransferPolicy<Soul>, arg4: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let Creation {
            root  : v0,
            actor : v1,
            fresh : v2,
        } = arg0;
        let v3 = v0;
        assert!(!v2 || v1 == 0x2::tx_context::sender(arg4), 3);
        ready(&v3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::lock_creation<Soul>(arg1, arg2, arg3, v3, arg4);
        0x2::object::id<Soul>(&v3)
    }

    public fun creation_nest(arg0: &mut Creation, arg1: Creation, arg2: u64) {
        let Creation {
            root  : v0,
            actor : v1,
            fresh : v2,
        } = arg1;
        if (v2) {
            assert!(arg0.actor == @0x0 || arg0.actor == v1, 3);
            arg0.actor = v1;
            arg0.fresh = true;
        };
        let v3 = &mut arg0.root;
        nest(v3, v0, arg2);
    }

    public fun creation_nest_locked(arg0: Creation, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg3: 0x2::object::ID, arg4: Origin, arg5: u64, arg6: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let Creation {
            root  : v0,
            actor : v1,
            fresh : v2,
        } = arg0;
        let v3 = v0;
        assert!(v2 && v1 == 0x2::tx_context::sender(arg6), 3);
        ready(&v3);
        let v4 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::borrow_locked_for_creation<Soul>(arg1, arg2, arg3, arg6);
        assert!(0x2::object::id<Soul>(v4) == arg3 && origin(v4) == arg4, 9);
        nest(v4, v3, arg5);
        0x2::object::id<Soul>(&v3)
    }

    public fun creation_nest_owned(arg0: &mut Creation, arg1: Soul, arg2: u64) {
        let v0 = &mut arg0.root;
        nest(v0, arg1, arg2);
    }

    public fun creation_place_owned(arg0: Creation, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap) : 0x2::object::ID {
        let Creation {
            root  : v0,
            actor : _,
            fresh : v2,
        } = arg0;
        let v3 = v0;
        assert!(!v2, 3);
        ready(&v3);
        0x2::kiosk::place<Soul>(arg1, arg2, v3);
        0x2::object::id<Soul>(&v3)
    }

    public fun creation_place_owned_authority(arg0: Creation, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let Creation {
            root  : v0,
            actor : _,
            fresh : v2,
        } = arg0;
        let v3 = v0;
        assert!(!v2, 3);
        ready(&v3);
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::place<Soul>(arg1, arg2, v3, arg3);
        0x2::object::id<Soul>(&v3)
    }

    public fun creation_ref(arg0: &Creation) : &Soul {
        &arg0.root
    }

    public fun descriptor<T0>(arg0: &Soul, arg1: vector<u8>) : 0x1::option::Option<Descriptor> {
        ready(arg0);
        let v0 = find<T0>(arg0, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<Descriptor>(*0x1::vector::borrow<Descriptor>(&arg0.modules, 0x1::option::destroy_some<u64>(v0)))
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<Descriptor>()
        }
    }

    fun find<T0>(arg0: &Soul, arg1: &vector<u8>) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Descriptor>(&arg0.modules)) {
            if (0x1::vector::borrow<Descriptor>(&arg0.modules, v0).namespace == 0x1::type_name::with_defining_ids<T0>() && 0x1::vector::borrow<Descriptor>(&arg0.modules, v0).name == *arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun finish_service_edit<T0: drop, T1: store + key>(arg0: T0, arg1: &mut SourceService<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: ServiceEdit<T0, T1>, arg4: T1, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        let ServiceEdit {
            service : v0,
            actor   : v1,
            ticket  : v2,
        } = arg3;
        let v3 = if (arg1.busy) {
            if (v0 == 0x2::object::id<SourceService<T0, T1>>(arg1)) {
                if (v1 == 0x2::tx_context::sender(arg6)) {
                    0x2::object::id<T1>(&arg4) == arg1.value
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 9);
        let v4 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::service_borrow_root<Soul>(arg2, &arg1.authority, arg1.root);
        assert!(v4.origin == arg1.origin, 9);
        commit_update<T0, T1>(v4, v2, arg0, arg4, arg1.schema, arg5);
        arg1.revision = revision(v4);
        arg1.busy = false;
    }

    fun hash32(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 5);
    }

    public fun hold_owned(arg0: Soul) : Creation {
        Creation{
            root  : arg0,
            actor : @0x0,
            fresh : false,
        }
    }

    fun index<T0, T1>(arg0: &Soul, arg1: &vector<u8>) : u64 {
        let v0 = find<T0>(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 4);
        let v1 = 0x1::option::destroy_some<u64>(v0);
        assert!(0x1::vector::borrow<Descriptor>(&arg0.modules, v1).value_type == 0x1::type_name::with_defining_ids<T1>(), 4);
        v1
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SOUL>(arg0, arg1);
    }

    public fun install<T0: drop, T1: store + key>(arg0: &mut Soul, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64) {
        install_declared<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<vector<u8>>());
    }

    public fun install_annotated<T0: drop, T1: store + key>(arg0: &mut Soul, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64, arg8: vector<u8>) {
        install_declared<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::some<vector<u8>>(arg8));
    }

    fun install_declared<T0: drop, T1: store + key>(arg0: &mut Soul, arg1: T0, arg2: vector<u8>, arg3: T1, arg4: u16, arg5: bool, arg6: vector<u8>, arg7: u64, arg8: 0x1::option::Option<vector<u8>>) {
        ready(arg0);
        cas(arg0, arg7);
        same_module<T0, T1>();
        check_name(&arg2);
        hash32(&arg6);
        assert!(arg4 > 0, 10);
        let v0 = find<T0>(arg0, &arg2);
        assert!(0x1::option::is_none<u64>(&v0), 6);
        assert!(0x1::vector::length<Descriptor>(&arg0.modules) < 64, 7);
        let v1 = Descriptor{
            namespace     : 0x1::type_name::with_defining_ids<T0>(),
            name          : arg2,
            value_type    : 0x1::type_name::with_defining_ids<T1>(),
            object        : 0x2::object::id<T1>(&arg3),
            schema        : arg4,
            removable     : arg5,
            body_hash     : child_hash<T1>(&arg3),
            semantic_hash : arg6,
        };
        let v2 = ModuleKey<T0>{name: arg2};
        0x2::dynamic_object_field::add<ModuleKey<T0>, T1>(&mut arg0.id, v2, arg3);
        installed(arg0, &v1);
        annotated(arg0, &v1, arg8);
        topology_changed(arg0, &v1);
        0x1::vector::push_back<Descriptor>(&mut arg0.modules, v1);
        changed(arg0, 0, &v1);
    }

    fun installed(arg0: &mut Soul, arg1: &Descriptor) {
        let v0 = arg0.revision + 1;
        let v1 = ModuleVersion{
            installed : v0,
            updated   : v0,
        };
        0x2::dynamic_field::add<ModuleVersionKey, ModuleVersion>(&mut arg0.id, version_key(arg1), v1);
    }

    public fun installed_revision(arg0: &ModuleVersion) : u64 {
        arg0.installed
    }

    public fun manifest(arg0: &Soul) : Manifest {
        ready(arg0);
        Manifest{
            domain   : b"soulidity/standard/manifest/v1",
            soul     : 0x2::object::id<Soul>(arg0),
            schema   : arg0.schema,
            name     : arg0.name,
            revision : arg0.revision,
            origin   : arg0.origin,
            modules  : arg0.modules,
        }
    }

    public fun manifest_hash(arg0: &Soul) : vector<u8> {
        let v0 = manifest(arg0);
        0x1::hash::sha3_256(0x1::bcs::to_bytes<Manifest>(&v0))
    }

    public fun minted_by(arg0: &Origin) : address {
        arg0.minted_by
    }

    public fun module_annotation(arg0: &Soul, arg1: &Descriptor) : 0x1::option::Option<vector<u8>> {
        ready(arg0);
        let v0 = &arg0.modules;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Descriptor>(v0)) {
            if (*0x1::vector::borrow<Descriptor>(v0, v1) == *arg1) {
                v2 = true;
                /* label 6 */
                assert!(v2, 9);
                let v3 = annotation_key(arg1);
                return if (0x2::dynamic_field::exists<ModuleAnnotationKey>(&arg0.id, v3)) {
                    0x1::option::some<vector<u8>>(*0x2::dynamic_field::borrow<ModuleAnnotationKey, vector<u8>>(&arg0.id, v3))
                } else {
                    0x1::option::none<vector<u8>>()
                }
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun module_count(arg0: &Soul) : u64 {
        ready(arg0);
        0x1::vector::length<Descriptor>(&arg0.modules)
    }

    public fun module_id(arg0: &Descriptor) : 0x2::object::ID {
        arg0.object
    }

    public fun module_name(arg0: &Descriptor) : vector<u8> {
        arg0.name
    }

    public fun module_page(arg0: &Soul, arg1: u64, arg2: u64) : vector<Descriptor> {
        ready(arg0);
        assert!(arg2 <= 64 && arg1 <= 0x1::vector::length<Descriptor>(&arg0.modules), 5);
        let v0 = if (arg2 < 0x1::vector::length<Descriptor>(&arg0.modules) - arg1) {
            arg1 + arg2
        } else {
            0x1::vector::length<Descriptor>(&arg0.modules)
        };
        let v1 = 0x1::vector::empty<Descriptor>();
        while (arg1 < v0) {
            0x1::vector::push_back<Descriptor>(&mut v1, *0x1::vector::borrow<Descriptor>(&arg0.modules, arg1));
            arg1 = arg1 + 1;
        };
        v1
    }

    public fun module_schema(arg0: &Descriptor) : u16 {
        arg0.schema
    }

    public fun module_version(arg0: &Soul, arg1: &Descriptor) : 0x1::option::Option<ModuleVersion> {
        ready(arg0);
        let v0 = &arg0.modules;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Descriptor>(v0)) {
            if (*0x1::vector::borrow<Descriptor>(v0, v1) == *arg1) {
                v2 = true;
                /* label 6 */
                assert!(v2, 9);
                let v3 = version_key(arg1);
                return if (0x2::dynamic_field::exists<ModuleVersionKey>(&arg0.id, v3)) {
                    0x1::option::some<ModuleVersion>(*0x2::dynamic_field::borrow<ModuleVersionKey, ModuleVersion>(&arg0.id, v3))
                } else {
                    0x1::option::none<ModuleVersion>()
                }
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun name(arg0: &Soul) : &0x1::string::String {
        &arg0.name
    }

    public fun namespace(arg0: &Descriptor) : 0x1::type_name::TypeName {
        arg0.namespace
    }

    public fun nest(arg0: &mut Soul, arg1: Soul, arg2: u64) {
        let v0 = 0x2::object::id<Soul>(&arg1);
        assert!(v0 != 0x2::object::id<Soul>(arg0), 9);
        let v1 = NestedSoulWitness{dummy_field: false};
        install<NestedSoulWitness, Soul>(arg0, v1, 0x1::bcs::to_bytes<0x2::object::ID>(&v0), arg1, 1, true, manifest_hash(&arg1), arg2);
    }

    public fun nested(arg0: &Soul, arg1: 0x2::object::ID) : &Soul {
        borrow_module<NestedSoulWitness, Soul>(arg0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1))
    }

    public fun nesting_revision(arg0: &Soul) : 0x1::option::Option<u64> {
        ready(arg0);
        let v0 = NestingVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NestingVersionKey>(&arg0.id, v0)) {
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<NestingVersionKey, u64>(&arg0.id, v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun open_source_service<T0: drop, T1: drop, T2: store + key>(arg0: T0, arg1: T1, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::Authority, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: u16, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::assert_pair(arg2, &arg3, arg12);
        same_module<T1, T2>();
        assert!(arg9 > 0x2::clock::timestamp_ms(arg11), 9);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::service_borrow_root<Soul>(arg2, &arg3, arg5);
        ready(v0);
        cas(v0, arg8);
        let v1 = 0x1::option::destroy_some<Descriptor>(descriptor<T1>(v0, arg6));
        let v2 = borrow_module<T1, T2>(v0, arg6);
        let v3 = if (v1.schema == arg7) {
            if (v1.body_hash == child_hash<T2>(v2)) {
                let v4 = module_annotation(v0, &v1);
                0x1::option::is_some<vector<u8>>(&v4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 9);
        let v5 = SourceService<T1, T2>{
            id             : 0x2::object::new(arg12),
            authority      : arg3,
            account        : arg4,
            return_witness : 0x1::type_name::with_defining_ids<T0>(),
            root           : arg5,
            value          : 0x2::object::id<T2>(v2),
            name           : arg6,
            schema         : arg7,
            origin         : v0.origin,
            revision       : arg8,
            expires        : arg9,
            binding        : arg10,
            busy           : false,
        };
        0x2::transfer::share_object<SourceService<T1, T2>>(v5);
        0x2::object::id<SourceService<T1, T2>>(&v5)
    }

    public fun origin(arg0: &Soul) : Origin {
        arg0.origin
    }

    public fun producer(arg0: &Origin) : 0x1::type_name::TypeName {
        arg0.producer
    }

    fun ready(arg0: &Soul) {
        assert!(arg0.schema == 1 && !arg0.editing, 2);
    }

    public fun removable(arg0: &Descriptor) : bool {
        arg0.removable
    }

    fun removed(arg0: &mut Soul, arg1: &Descriptor) {
        let v0 = annotation_key(arg1);
        if (0x2::dynamic_field::exists<ModuleAnnotationKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<ModuleAnnotationKey, vector<u8>>(&mut arg0.id, v0);
        };
        let v1 = version_key(arg1);
        if (0x2::dynamic_field::exists<ModuleVersionKey>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<ModuleVersionKey, ModuleVersion>(&mut arg0.id, v1);
        };
    }

    public fun revision(arg0: &Soul) : u64 {
        arg0.revision
    }

    fun same_module<T0, T1>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(!0x1::type_name::is_primitive(&v0) && !0x1::type_name::is_primitive(&v1), 3);
        assert!(0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1) && 0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1), 3);
    }

    public fun schema(arg0: &Soul) : u16 {
        arg0.schema
    }

    public fun semantic_hash(arg0: &Descriptor) : vector<u8> {
        arg0.semantic_hash
    }

    public fun service_binding<T0, T1>(arg0: &SourceService<T0, T1>) : vector<u8> {
        arg0.binding
    }

    public fun service_module<T0: drop, T1: store + key>(arg0: T0, arg1: &SourceService<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk) : &T1 {
        assert!(!arg1.busy, 9);
        let v0 = 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::service_borrow_root<Soul>(arg2, &arg1.authority, arg1.root);
        assert!(v0.origin == arg1.origin && revision(v0) == arg1.revision, 9);
        let v1 = 0x1::option::destroy_some<Descriptor>(descriptor<T0>(v0, arg1.name));
        let v2 = borrow_module<T0, T1>(v0, arg1.name);
        let v3 = if (v1.object == arg1.value) {
            if (v1.schema == arg1.schema) {
                v1.body_hash == child_hash<T1>(v2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 9);
        v2
    }

    public fun service_owner<T0, T1>(arg0: &SourceService<T0, T1>) : address {
        0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority::owner(&arg0.authority)
    }

    public fun service_revision<T0, T1>(arg0: &SourceService<T0, T1>) : u64 {
        arg0.revision
    }

    public fun service_root<T0, T1>(arg0: &SourceService<T0, T1>) : 0x2::object::ID {
        arg0.root
    }

    public fun source(arg0: &Origin) : 0x2::object::ID {
        arg0.source
    }

    public fun source_hash(arg0: &Origin) : vector<u8> {
        arg0.source_hash
    }

    public fun source_type(arg0: &Origin) : 0x1::type_name::TypeName {
        arg0.source_type
    }

    public fun source_version(arg0: &Origin) : u64 {
        arg0.source_version
    }

    fun topology_changed(arg0: &mut Soul, arg1: &Descriptor) {
        if (arg1.namespace == 0x1::type_name::with_defining_ids<NestedSoulWitness>()) {
            let v0 = NestingVersionKey{dummy_field: false};
            if (0x2::dynamic_field::exists<NestingVersionKey>(&arg0.id, v0)) {
                *0x2::dynamic_field::borrow_mut<NestingVersionKey, u64>(&mut arg0.id, v0) = arg0.revision + 1;
            } else {
                0x2::dynamic_field::add<NestingVersionKey, u64>(&mut arg0.id, v0, arg0.revision + 1);
            };
        };
    }

    public fun uninstall<T0, T1: store + key>(arg0: &mut Soul, arg1: vector<u8>, arg2: u64) : T1 {
        ready(arg0);
        cas(arg0, arg2);
        let v0 = index<T0, T1>(arg0, &arg1);
        let v1 = *0x1::vector::borrow<Descriptor>(&arg0.modules, v0);
        assert!(v1.removable, 8);
        let v2 = ModuleKey<T0>{name: arg1};
        let v3 = 0x2::dynamic_object_field::remove<ModuleKey<T0>, T1>(&mut arg0.id, v2);
        assert!(0x2::object::id<T1>(&v3) == v1.object, 9);
        removed(arg0, &v1);
        topology_changed(arg0, &v1);
        0x1::vector::remove<Descriptor>(&mut arg0.modules, v0);
        changed(arg0, 1, &v1);
        v3
    }

    public fun unnest(arg0: &mut Soul, arg1: 0x2::object::ID, arg2: u64) : Soul {
        uninstall<NestedSoulWitness, Soul>(arg0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1), arg2)
    }

    fun updated(arg0: &mut Soul, arg1: &Descriptor) {
        let v0 = version_key(arg1);
        if (0x2::dynamic_field::exists<ModuleVersionKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow_mut<ModuleVersionKey, ModuleVersion>(&mut arg0.id, v0).updated = arg0.revision + 1;
        } else {
            let v1 = ModuleVersion{
                installed : 0,
                updated   : arg0.revision + 1,
            };
            0x2::dynamic_field::add<ModuleVersionKey, ModuleVersion>(&mut arg0.id, v0, v1);
        };
    }

    public fun updated_revision(arg0: &ModuleVersion) : u64 {
        arg0.updated
    }

    public fun value_type(arg0: &Descriptor) : 0x1::type_name::TypeName {
        arg0.value_type
    }

    fun version_key(arg0: &Descriptor) : ModuleVersionKey {
        ModuleVersionKey{
            namespace : arg0.namespace,
            name      : arg0.name,
        }
    }

    // decompiled from Move bytecode v7
}

