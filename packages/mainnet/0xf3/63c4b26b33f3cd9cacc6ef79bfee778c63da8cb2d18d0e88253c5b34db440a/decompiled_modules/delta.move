module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::delta {
    struct DELTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELTA, arg1: &mut 0x2::tx_context::TxContext) {
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::registry::share(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::registry::new(arg1));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::treasury::share(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::treasury::new(arg1));
        0x2::transfer::public_transfer<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::admin::AdminCap>(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::admin::mint_admin_cap(arg1), 0x2::tx_context::sender(arg1));
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

