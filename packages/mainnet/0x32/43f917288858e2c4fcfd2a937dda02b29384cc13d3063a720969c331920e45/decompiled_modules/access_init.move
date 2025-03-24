module 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::access_init {
    struct ACCESS_INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCESS_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::PackageAdmin>(0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::claim_package<ACCESS_INIT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

