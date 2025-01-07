module 0xa34ae9065ebd30e34552a5fcde507520c8884530241e4bda9bd0d95eeff4a03f::other_module {
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

