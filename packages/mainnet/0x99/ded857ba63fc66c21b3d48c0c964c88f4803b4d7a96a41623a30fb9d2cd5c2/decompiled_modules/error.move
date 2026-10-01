module 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::error {
    public fun account_already_exists(arg0: u64) : u64 {
        abort arg0
    }

    public fun account_not_found(arg0: u64) : u64 {
        abort arg0
    }

    // decompiled from Move bytecode v7
}

