module 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::access_init {
    struct ACCESS_INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCESS_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::access::PackageAdmin>(0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::access::claim_package<ACCESS_INIT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

