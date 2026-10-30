module 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition {
    struct Composition<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct CompositionAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct CompositionRegistry has key {
        id: 0x2::object::UID,
    }

    struct CompositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositionAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositionCreatedEvent<phantom T0> has copy, drop {
        composition_id: 0x2::object::ID,
        composition_admin_cap_id: 0x2::object::ID,
    }

    public fun derive_address<T0>(arg0: &CompositionRegistry) : address {
        let v0 = CompositionKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<CompositionKey<T0>>(0x2::object::id<CompositionRegistry>(arg0), v0)
    }

    public fun new<T0: key>(arg0: &mut CompositionRegistry, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: 0x2::coin::TreasuryCap<T0>) : (Composition<T0>, CompositionAdminCap<T0>, 0x2::balance::Balance<T0>) {
        let v0 = CompositionKey<T0>{dummy_field: false};
        let v1 = Composition<T0>{id: 0x2::derived_object::claim<CompositionKey<T0>>(&mut arg0.id, v0)};
        let v2 = CompositionAdminCapKey{dummy_field: false};
        let v3 = CompositionAdminCap<T0>{id: 0x2::derived_object::claim<CompositionAdminCapKey>(&mut v1.id, v2)};
        let v4 = CompositionCreatedEvent<T0>{
            composition_id           : 0x2::object::id<Composition<T0>>(&v1),
            composition_admin_cap_id : 0x2::object::id<CompositionAdminCap<T0>>(&v3),
        };
        0x2::event::emit<CompositionCreatedEvent<T0>>(v4);
        (v1, v3, 0x359f4d59f103e34cc2f8720e2d1cd756878cf9ee99d1e2f343f0d9b7307404a5::share::mint<T0>(arg1, arg2, b"composition_share", b"CompositionShare", 6, 0x1::string::utf8(b"CSHARE"), 0x1::string::utf8(b"Composition Share"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 100000000000000))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CompositionRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<CompositionRegistry>(v0);
    }

    public fun share<T0>(arg0: Composition<T0>) {
        0x2::transfer::share_object<Composition<T0>>(arg0);
    }

    public fun uid<T0>(arg0: &Composition<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut Composition<T0>, arg1: &CompositionAdminCap<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

