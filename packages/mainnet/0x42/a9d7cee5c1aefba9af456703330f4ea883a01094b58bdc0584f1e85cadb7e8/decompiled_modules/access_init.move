module 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::access_init {
    struct ACCESS_INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCESS_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::PackageAdmin>(0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::claim_package<ACCESS_INIT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

