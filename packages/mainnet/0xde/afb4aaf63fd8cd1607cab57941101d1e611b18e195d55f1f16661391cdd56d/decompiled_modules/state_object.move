module 0xdeafb4aaf63fd8cd1607cab57941101d1e611b18e195d55f1f16661391cdd56d::state_object {
    struct CCIPObject has key {
        id: 0x2::object::UID,
    }

    struct CCIPObjectRef has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
    }

    struct CCIPObjectRefPointer has store, key {
        id: 0x2::object::UID,
        ccip_object_id: address,
    }

    struct STATE_OBJECT has drop {
        dummy_field: bool,
    }

    public fun add_package_id(arg0: &mut CCIPObjectRef, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.package_ids, arg1);
    }

    fun init(arg0: STATE_OBJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CCIPObject{id: 0x2::object::new(arg1)};
        let v1 = CCIPObjectRef{
            id          : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"CCIPObjectRef"),
            package_ids : vector[],
        };
        let v2 = CCIPObjectRefPointer{
            id             : 0x2::object::new(arg1),
            ccip_object_id : 0x2::object::id_address<CCIPObject>(&v0),
        };
        let v3 = 0x1::type_name::with_original_ids<STATE_OBJECT>();
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v3));
        let v5 = 0x2::address::from_ascii_bytes(&v4);
        0x1::vector::push_back<address>(&mut v1.package_ids, v5);
        0x2::transfer::share_object<CCIPObjectRef>(v1);
        0x2::transfer::share_object<CCIPObject>(v0);
        0x2::transfer::transfer<CCIPObjectRefPointer>(v2, v5);
    }

    public fun remove_package_id(arg0: &mut CCIPObjectRef, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.package_ids, &arg1);
        assert!(v0, 1);
        0x1::vector::swap_remove<address>(&mut arg0.package_ids, v1);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"StateObject 1.6.0")
    }

    // decompiled from Move bytecode v6
}

