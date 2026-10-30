module 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording {
    struct Recording<phantom T0> has key {
        id: 0x2::object::UID,
        composition_id: 0x2::object::ID,
    }

    struct RecordingAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct RecordingRegistry has key {
        id: 0x2::object::UID,
    }

    struct RecordingKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingCreatedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        recording_admin_cap_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
    }

    public fun derive_address<T0>(arg0: &RecordingRegistry) : address {
        let v0 = RecordingKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<RecordingKey<T0>>(0x2::object::id<RecordingRegistry>(arg0), v0)
    }

    public fun new<T0: key, T1>(arg0: &mut RecordingRegistry, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T1>, arg3: 0x2::coin::TreasuryCap<T0>) : (Recording<T0>, RecordingAdminCap<T0>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T1>>(arg2);
        let v1 = RecordingKey<T0>{dummy_field: false};
        let v2 = Recording<T0>{
            id             : 0x2::derived_object::claim<RecordingKey<T0>>(&mut arg0.id, v1),
            composition_id : v0,
        };
        let v3 = RecordingAdminCapKey{dummy_field: false};
        let v4 = RecordingAdminCap<T0>{id: 0x2::derived_object::claim<RecordingAdminCapKey>(&mut v2.id, v3)};
        let v5 = RecordingCreatedEvent<T0>{
            recording_id           : 0x2::object::id<Recording<T0>>(&v2),
            recording_admin_cap_id : 0x2::object::id<RecordingAdminCap<T0>>(&v4),
            composition_id         : v0,
        };
        0x2::event::emit<RecordingCreatedEvent<T0>>(v5);
        (v2, v4, 0x359f4d59f103e34cc2f8720e2d1cd756878cf9ee99d1e2f343f0d9b7307404a5::share::mint<T0>(arg1, arg3, b"recording_share", b"RecordingShare", 6, 0x1::string::utf8(b"RSHARE"), 0x1::string::utf8(b"Recording Share"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 100000000000000))
    }

    public fun composition_id<T0>(arg0: &Recording<T0>) : 0x2::object::ID {
        arg0.composition_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecordingRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RecordingRegistry>(v0);
    }

    public fun share<T0>(arg0: Recording<T0>) {
        0x2::transfer::share_object<Recording<T0>>(arg0);
    }

    public fun uid<T0>(arg0: &Recording<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut Recording<T0>, arg1: &RecordingAdminCap<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

