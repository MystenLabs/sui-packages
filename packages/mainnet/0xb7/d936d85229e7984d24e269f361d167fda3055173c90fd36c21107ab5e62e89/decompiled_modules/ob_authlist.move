module 0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::ob_authlist {
    struct OB_AUTHLIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OB_AUTHLIST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<OB_AUTHLIST>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

