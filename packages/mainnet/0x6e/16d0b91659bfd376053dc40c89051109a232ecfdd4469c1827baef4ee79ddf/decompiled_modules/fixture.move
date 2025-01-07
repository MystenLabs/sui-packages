module 0x6e16d0b91659bfd376053dc40c89051109a232ecfdd4469c1827baef4ee79ddf::fixture {
    struct Dummy has store {
        dummy_field: bool,
    }

    struct WithGenericField<T0: store> has key {
        id: 0x2::object::UID,
        generic_field: T0,
    }

    struct Bar has copy, drop, store {
        value: u64,
    }

    struct WithTwoGenerics<T0: drop + store, T1: drop + store> has drop, store {
        generic_field_1: T0,
        generic_field_2: T1,
    }

    struct Foo<T0: drop + store> has key {
        id: 0x2::object::UID,
        generic: T0,
        reified_primitive_vec: vector<u64>,
        reified_object_vec: vector<Bar>,
        generic_vec: vector<T0>,
        generic_vec_nested: vector<WithTwoGenerics<T0, u8>>,
        two_generics: WithTwoGenerics<T0, Bar>,
        two_generics_reified_primitive: WithTwoGenerics<u16, u64>,
        two_generics_reified_object: WithTwoGenerics<Bar, Bar>,
        two_generics_nested: WithTwoGenerics<T0, WithTwoGenerics<u8, u8>>,
        two_generics_reified_nested: WithTwoGenerics<Bar, WithTwoGenerics<u8, u8>>,
        two_generics_nested_vec: vector<WithTwoGenerics<Bar, vector<WithTwoGenerics<T0, u8>>>>,
        dummy: Dummy,
        other: 0x6e16d0b91659bfd376053dc40c89051109a232ecfdd4469c1827baef4ee79ddf::other_module::StructFromOtherModule,
    }

    struct WithSpecialTypes<phantom T0, T1: store> has store, key {
        id: 0x2::object::UID,
        string: 0x1::string::String,
        ascii_string: 0x1::ascii::String,
        url: 0x2::url::Url,
        id_field: 0x2::object::ID,
        uid: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        option: 0x1::option::Option<u64>,
        option_obj: 0x1::option::Option<Bar>,
        option_none: 0x1::option::Option<u64>,
        balance_generic: 0x2::balance::Balance<T0>,
        option_generic: 0x1::option::Option<T1>,
        option_generic_none: 0x1::option::Option<T1>,
    }

    struct WithSpecialTypesAsGenerics<T0: store, T1: store, T2: store, T3: store, T4: store, T5: store, T6: store, T7: store> has store, key {
        id: 0x2::object::UID,
        string: T0,
        ascii_string: T1,
        url: T2,
        id_field: T3,
        uid: T4,
        balance: T5,
        option: T6,
        option_none: T7,
    }

    struct WithSpecialTypesInVectors<T0: store> has store, key {
        id: 0x2::object::UID,
        string: vector<0x1::string::String>,
        ascii_string: vector<0x1::ascii::String>,
        id_field: vector<0x2::object::ID>,
        bar: vector<Bar>,
        option: vector<0x1::option::Option<u64>>,
        option_generic: vector<0x1::option::Option<T0>>,
    }

    public fun create_bar(arg0: u64) : Bar {
        Bar{value: arg0}
    }

    public fun create_foo<T0: drop + store, T1: drop + store>(arg0: T0, arg1: vector<u64>, arg2: vector<Bar>, arg3: vector<T0>, arg4: vector<WithTwoGenerics<T0, u8>>, arg5: WithTwoGenerics<T0, Bar>, arg6: WithTwoGenerics<u16, u64>, arg7: WithTwoGenerics<Bar, Bar>, arg8: WithTwoGenerics<T0, WithTwoGenerics<u8, u8>>, arg9: WithTwoGenerics<Bar, WithTwoGenerics<u8, u8>>, arg10: vector<WithTwoGenerics<Bar, vector<WithTwoGenerics<T0, u8>>>>, arg11: &Bar, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = Dummy{dummy_field: false};
        let v1 = Foo<T0>{
            id                             : 0x2::object::new(arg12),
            generic                        : arg0,
            reified_primitive_vec          : arg1,
            reified_object_vec             : arg2,
            generic_vec                    : arg3,
            generic_vec_nested             : arg4,
            two_generics                   : arg5,
            two_generics_reified_primitive : arg6,
            two_generics_reified_object    : arg7,
            two_generics_nested            : arg8,
            two_generics_reified_nested    : arg9,
            two_generics_nested_vec        : arg10,
            dummy                          : v0,
            other                          : 0x6e16d0b91659bfd376053dc40c89051109a232ecfdd4469c1827baef4ee79ddf::other_module::new(),
        };
        0x2::transfer::transfer<Foo<T0>>(v1, 0x2::tx_context::sender(arg12));
    }

    public fun create_special<T0, T1: store>(arg0: 0x1::string::String, arg1: 0x1::ascii::String, arg2: 0x2::url::Url, arg3: 0x2::object::ID, arg4: 0x2::object::UID, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<Bar>, arg8: 0x1::option::Option<u64>, arg9: 0x2::balance::Balance<T0>, arg10: 0x1::option::Option<T1>, arg11: 0x1::option::Option<T1>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = WithSpecialTypes<T0, T1>{
            id                  : 0x2::object::new(arg12),
            string              : arg0,
            ascii_string        : arg1,
            url                 : arg2,
            id_field            : arg3,
            uid                 : arg4,
            balance             : arg5,
            option              : arg6,
            option_obj          : arg7,
            option_none         : arg8,
            balance_generic     : arg9,
            option_generic      : arg10,
            option_generic_none : arg11,
        };
        0x2::transfer::transfer<WithSpecialTypes<T0, T1>>(v0, 0x2::tx_context::sender(arg12));
    }

    public fun create_special_as_generics<T0: store, T1: store, T2: store, T3: store, T4: store, T5: store, T6: store, T7: store>(arg0: T0, arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5, arg6: T6, arg7: T7, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = WithSpecialTypesAsGenerics<T0, T1, T2, T3, T4, T5, T6, T7>{
            id           : 0x2::object::new(arg8),
            string       : arg0,
            ascii_string : arg1,
            url          : arg2,
            id_field     : arg3,
            uid          : arg4,
            balance      : arg5,
            option       : arg6,
            option_none  : arg7,
        };
        0x2::transfer::transfer<WithSpecialTypesAsGenerics<T0, T1, T2, T3, T4, T5, T6, T7>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun create_special_in_vectors<T0: store>(arg0: vector<0x1::string::String>, arg1: vector<0x1::ascii::String>, arg2: vector<0x2::object::ID>, arg3: vector<Bar>, arg4: vector<0x1::option::Option<u64>>, arg5: vector<0x1::option::Option<T0>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = WithSpecialTypesInVectors<T0>{
            id             : 0x2::object::new(arg6),
            string         : arg0,
            ascii_string   : arg1,
            id_field       : arg2,
            bar            : arg3,
            option         : arg4,
            option_generic : arg5,
        };
        0x2::transfer::transfer<WithSpecialTypesInVectors<T0>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun create_with_generic_field<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WithGenericField<T0>{
            id            : 0x2::object::new(arg1),
            generic_field : arg0,
        };
        0x2::transfer::transfer<WithGenericField<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_with_two_generics<T0: drop + store, T1: drop + store>(arg0: T0, arg1: T1) : WithTwoGenerics<T0, T1> {
        WithTwoGenerics<T0, T1>{
            generic_field_1 : arg0,
            generic_field_2 : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

