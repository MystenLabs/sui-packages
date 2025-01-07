module 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source {
    struct SourceConfig has store, key {
        id: 0x2::object::UID,
        source: 0x1::type_name::TypeName,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : SourceConfig {
        SourceConfig{
            id     : 0x2::object::new(arg0),
            source : 0x1::type_name::get<T0>(),
        }
    }

    public fun source(arg0: &SourceConfig) : 0x1::type_name::TypeName {
        arg0.source
    }

    public fun set_source<T0>(arg0: &mut SourceConfig) {
        arg0.source = 0x1::type_name::get<T0>();
    }

    // decompiled from Move bytecode v6
}

