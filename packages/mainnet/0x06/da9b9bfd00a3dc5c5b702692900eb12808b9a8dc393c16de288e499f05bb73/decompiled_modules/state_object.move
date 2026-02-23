module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::state_object {
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

    public fun get_package_ids(arg0: &CCIPObjectRef) : vector<address> {
        arg0.package_ids
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
        let v3 = 0x1::type_name::get_with_original_ids<STATE_OBJECT>();
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::get_address(&v3));
        let v5 = 0x2::address::from_ascii_bytes(&v4);
        0x1::vector::push_back<address>(&mut v1.package_ids, v5);
        0x2::transfer::share_object<CCIPObjectRef>(v1);
        0x2::transfer::share_object<CCIPObject>(v0);
        0x2::transfer::transfer<CCIPObjectRefPointer>(v2, v5);
    }

    // decompiled from Move bytecode v6
}

