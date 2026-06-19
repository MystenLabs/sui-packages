module 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

