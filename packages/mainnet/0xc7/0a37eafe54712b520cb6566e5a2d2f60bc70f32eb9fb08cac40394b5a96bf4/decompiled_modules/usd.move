module 0xc70a37eafe54712b520cb6566e5a2d2f60bc70f32eb9fb08cac40394b5a96bf4::usd {
    struct USD has key {
        id: 0x2::object::UID,
    }

    public fun create_credit_registry(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: USD, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<USD>(arg0, decimals(), 0x1::string::utf8(b"USD"), 0x1::string::utf8(b"WaterX USD"), 0x1::string::utf8(x"5761746572582063726564697420756e697420e2809420313a31206261636b656420737461626c65636f696e206d696e746564206279207761746572785f637265646974206d6f64756c6573"), 0x1::string::utf8(b"https://token-metadata.bridge.xyz/images/usd.png"), arg3);
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::create_credit_registry<USD>(arg1, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<USD>>(0x2::coin_registry::finalize<USD>(v0, arg3), 0x2::tx_context::sender(arg3));
        let USD { id: v2 } = arg2;
        0x2::object::delete(v2);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = USD{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<USD>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

