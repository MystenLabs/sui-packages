module 0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations {
    struct Registry has key {
        id: 0x2::object::UID,
        anchors: 0x2::table::Table<0x2::object::ID, 0x2::object::UID>,
    }

    struct Attestation<T0: store> has key {
        id: 0x2::object::UID,
        data: T0,
        subject: 0x2::object::ID,
        created_at_ms: u64,
        revoked_at_ms: 0x1::option::Option<u64>,
    }

    struct Attested<phantom T0> has copy, drop {
        subject: 0x2::object::ID,
    }

    struct Revoked<phantom T0> has copy, drop {
        subject: 0x2::object::ID,
    }

    public fun add_display_field<T0: store>(arg0: &mut Registry, arg1: &mut 0x2::display_registry::Display<Attestation<T0>>, arg2: 0x1::internal::Permit<T0>, arg3: 0x2::transfer::Receiving<0x2::display_registry::DisplayCap<Attestation<T0>>>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>) {
        let v0 = 0x2::transfer::public_receive<0x2::display_registry::DisplayCap<Attestation<T0>>>(&mut arg0.id, arg3);
        0x1::vector::reverse<0x1::string::String>(&mut arg5);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 13906834865833115647);
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let v2 = 0x1::vector::pop_back<0x1::string::String>(&mut arg4);
            assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display_registry::fields<Attestation<T0>>(arg1), &v2), 13835058746771898369);
            0x2::display_registry::set<Attestation<T0>>(arg1, &v0, v2, 0x1::vector::pop_back<0x1::string::String>(&mut arg5));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg4);
        0x1::vector::destroy_empty<0x1::string::String>(arg5);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Attestation<T0>>>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun attest<T0: store>(arg0: &Registry, arg1: 0x1::internal::Permit<T0>, arg2: 0x2::object::ID, arg3: T0, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Attested<T0>{subject: arg2};
        0x2::event::emit<Attested<T0>>(v0);
        let v1 = Attestation<T0>{
            id            : 0x2::object::new(arg5),
            data          : arg3,
            subject       : arg2,
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            revoked_at_ms : 0x1::option::none<u64>(),
        };
        0x2::transfer::transfer<Attestation<T0>>(v1, 0x2::derived_object::derive_address<0x2::object::ID>(0x2::object::uid_to_inner(&arg0.id), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            anchors : 0x2::table::new<0x2::object::ID, 0x2::object::UID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun register_display<T0: store>(arg0: &Registry, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: 0x1::internal::Permit<T0>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new<Attestation<T0>>(arg1, 0x1::internal::permit<Attestation<T0>>(), arg5);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 13906834758458933247);
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::display_registry::set<Attestation<T0>>(&mut v3, &v2, 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg3);
        0x1::vector::destroy_empty<0x1::string::String>(arg4);
        0x2::display_registry::share<Attestation<T0>>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Attestation<T0>>>(v2, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun revoke<T0: store>(arg0: &mut Registry, arg1: 0x1::internal::Permit<T0>, arg2: 0x2::object::ID, arg3: 0x2::transfer::Receiving<Attestation<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, 0x2::object::UID>(&arg0.anchors, arg2)) {
            0x2::table::add<0x2::object::ID, 0x2::object::UID>(&mut arg0.anchors, arg2, 0x2::derived_object::claim<0x2::object::ID>(&mut arg0.id, arg2));
        };
        let v0 = 0x2::transfer::receive<Attestation<T0>>(0x2::table::borrow_mut<0x2::object::ID, 0x2::object::UID>(&mut arg0.anchors, arg2), arg3);
        assert!(arg2 == v0.subject, 13906834590955208703);
        assert!(0x1::option::is_none<u64>(&v0.revoked_at_ms), 13835339946870833155);
        0x1::option::fill<u64>(&mut v0.revoked_at_ms, 0x2::clock::timestamp_ms(arg4));
        let v1 = Revoked<T0>{subject: arg2};
        0x2::event::emit<Revoked<T0>>(v1);
        0x2::transfer::transfer<Attestation<T0>>(v0, 0x2::derived_object::derive_address<0x2::object::ID>(0x2::object::uid_to_inner(&arg0.id), arg2));
    }

    // decompiled from Move bytecode v7
}

