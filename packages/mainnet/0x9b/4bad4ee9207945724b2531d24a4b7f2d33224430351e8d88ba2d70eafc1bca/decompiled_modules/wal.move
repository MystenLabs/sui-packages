module 0x9b4bad4ee9207945724b2531d24a4b7f2d33224430351e8d88ba2d70eafc1bca::wal {
    struct WAL has key {
        id: 0x2::object::UID,
    }

    public fun create_credit_registry(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: WAL, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin_registry::MetadataCap<WAL> {
        let (v0, v1) = 0x2::coin_registry::new_currency<WAL>(arg0, decimals(), 0x1::string::utf8(b"WAL"), 0x1::string::utf8(b"WaterX WAL"), 0x1::string::utf8(x"5761746572582063726564697420756e697420e2809420313a31206261636b65642062792057414c2c206d696e746564206279207761746572785f637265646974206e61746976655f637573746f6479"), 0x1::string::utf8(b""), arg3);
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::create_credit_registry<WAL>(arg1, v1, arg3);
        let WAL { id: v2 } = arg2;
        0x2::object::delete(v2);
        0x2::coin_registry::finalize<WAL>(v0, arg3)
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WAL{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WAL>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

