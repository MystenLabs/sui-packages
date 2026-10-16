module 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

