module 0xfc14bd4f2596df7f4bd17ed017e8b071bb0a091f06806209e80873bcfdcc79c6::capy {
    struct Capy has drop {
        dummy_field: bool,
    }

    public fun capy(arg0: &0xfc14bd4f2596df7f4bd17ed017e8b071bb0a091f06806209e80873bcfdcc79c6::suifrens::AdminCap) : Capy {
        Capy{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

