module 0xd2278f606572495e88ed8b170d13980f61d6a337854971d9175bee3b4bb3502e::orderbooktool {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct OrderbookTool has store, key {
        id: 0x2::object::UID,
    }

    public fun generate_witness<T0>() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

