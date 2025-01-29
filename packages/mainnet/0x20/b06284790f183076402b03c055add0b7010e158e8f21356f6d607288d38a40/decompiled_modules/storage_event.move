module 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event {
    struct RemoveRecord<T0: copy + drop, T1: copy + drop> has copy, drop {
        name: 0x1::ascii::String,
        key1: 0x1::option::Option<T0>,
        key2: 0x1::option::Option<T1>,
    }

    struct SetRecord<T0: copy + drop, T1: copy + drop, T2: copy + drop> has copy, drop {
        name: 0x1::ascii::String,
        key1: 0x1::option::Option<T0>,
        key2: 0x1::option::Option<T1>,
        value: 0x1::option::Option<T2>,
    }

    public fun emit_remove_record<T0: copy + drop, T1: copy + drop>(arg0: 0x1::ascii::String, arg1: 0x1::option::Option<T0>, arg2: 0x1::option::Option<T1>) {
        let v0 = RemoveRecord<T0, T1>{
            name : arg0,
            key1 : arg1,
            key2 : arg2,
        };
        0x2::event::emit<RemoveRecord<T0, T1>>(v0);
    }

    public fun emit_set_record<T0: copy + drop, T1: copy + drop, T2: copy + drop>(arg0: 0x1::ascii::String, arg1: 0x1::option::Option<T0>, arg2: 0x1::option::Option<T1>, arg3: 0x1::option::Option<T2>) {
        let v0 = SetRecord<T0, T1, T2>{
            name  : arg0,
            key1  : arg1,
            key2  : arg2,
            value : arg3,
        };
        0x2::event::emit<SetRecord<T0, T1, T2>>(v0);
    }

    // decompiled from Move bytecode v6
}

