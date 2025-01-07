module 0x22d151c91d9be19c75723c786326f3b671c45341d5fd98b8cf7509f1c1ef194::access_init {
    struct ACCESS_INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCESS_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x38f6b4e64b0922d3ef9ac3c09a159c4ea08d93715ee96eec03624a243afe7db6::access::PackageAdmin>(0x38f6b4e64b0922d3ef9ac3c09a159c4ea08d93715ee96eec03624a243afe7db6::access::claim_package<ACCESS_INIT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

