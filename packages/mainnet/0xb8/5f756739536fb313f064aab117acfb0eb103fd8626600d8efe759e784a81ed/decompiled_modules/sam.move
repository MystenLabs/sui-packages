module 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

