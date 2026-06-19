module 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

