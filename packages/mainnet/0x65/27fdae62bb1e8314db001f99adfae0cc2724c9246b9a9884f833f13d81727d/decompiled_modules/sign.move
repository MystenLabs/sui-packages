module 0x6527fdae62bb1e8314db001f99adfae0cc2724c9246b9a9884f833f13d81727d::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

