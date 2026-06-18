module 0xda06eea0ea1c09012d70aa31b9c12fd2d5ba5900d301dfff76aa33a2dfcbc47::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

