module 0x6e16d0b91659bfd376053dc40c89051109a232ecfdd4469c1827baef4ee79ddf::other_module {
    struct StructFromOtherModule has store {
        dummy_field: bool,
    }

    struct AddedInAnUpgrade has copy, drop, store {
        dummy_field: bool,
    }

    public fun new() : StructFromOtherModule {
        StructFromOtherModule{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

