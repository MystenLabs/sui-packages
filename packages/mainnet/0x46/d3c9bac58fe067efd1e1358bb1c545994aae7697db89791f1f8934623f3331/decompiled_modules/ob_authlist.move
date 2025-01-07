module 0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::ob_authlist {
    struct OB_AUTHLIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OB_AUTHLIST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<OB_AUTHLIST>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

