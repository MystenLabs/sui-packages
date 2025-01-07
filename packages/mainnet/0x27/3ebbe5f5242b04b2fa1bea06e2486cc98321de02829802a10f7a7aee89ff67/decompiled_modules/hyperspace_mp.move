module 0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp {
    struct HYPERSPACE_MP has drop {
        dummy_field: bool,
    }

    struct Hyperspace_mp has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: HYPERSPACE_MP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<HYPERSPACE_MP>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<Hyperspace_mp>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Hyperspace_mp>>(v3, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Hyperspace_mp>>(v2);
    }

    // decompiled from Move bytecode v6
}

