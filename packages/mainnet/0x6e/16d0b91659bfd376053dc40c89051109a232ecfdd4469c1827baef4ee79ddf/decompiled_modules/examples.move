module 0x6e16d0b91659bfd376053dc40c89051109a232ecfdd4469c1827baef4ee79ddf::examples {
    struct ExampleStruct has drop, store {
        dummy_field: bool,
    }

    struct SpecialTypesStruct has key {
        id: 0x2::object::UID,
        ascii_string: 0x1::ascii::String,
        utf8_string: 0x1::string::String,
        vector_of_u64: vector<u64>,
        vector_of_objects: vector<ExampleStruct>,
        id_field: 0x2::object::ID,
        address: address,
        option_some: 0x1::option::Option<u64>,
        option_none: 0x1::option::Option<u64>,
    }

    public fun create_example_struct() : ExampleStruct {
        ExampleStruct{dummy_field: false}
    }

    public fun special_types(arg0: 0x1::ascii::String, arg1: 0x1::string::String, arg2: vector<u64>, arg3: vector<ExampleStruct>, arg4: 0x2::object::ID, arg5: address, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = SpecialTypesStruct{
            id                : 0x2::object::new(arg8),
            ascii_string      : arg0,
            utf8_string       : arg1,
            vector_of_u64     : arg2,
            vector_of_objects : arg3,
            id_field          : arg4,
            address           : arg5,
            option_some       : arg6,
            option_none       : arg7,
        };
        0x2::transfer::share_object<SpecialTypesStruct>(v0);
    }

    // decompiled from Move bytecode v6
}

