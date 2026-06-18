module 0x2b318f3420f9e107cbc16951fc9025ce887beeb47ad5b94840e1f87bcb29c5e8::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

