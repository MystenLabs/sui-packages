module 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::access_init {
    struct ACCESS_INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCESS_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::PackageAdmin>(0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::claim_package<ACCESS_INIT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

