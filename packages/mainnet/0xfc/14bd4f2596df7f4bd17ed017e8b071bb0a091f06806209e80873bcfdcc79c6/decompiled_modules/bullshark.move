module 0xfc14bd4f2596df7f4bd17ed017e8b071bb0a091f06806209e80873bcfdcc79c6::bullshark {
    struct Bullshark has drop {
        dummy_field: bool,
    }

    public fun bullshark(arg0: &0xfc14bd4f2596df7f4bd17ed017e8b071bb0a091f06806209e80873bcfdcc79c6::suifrens::AdminCap) : Bullshark {
        Bullshark{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

