module 0xbb2b6223491389e203db9317836728c78d80df3eeb51946a6614f62ffc0a37aa::hyperspace {
    struct HYPERSPACE has drop {
        dummy_field: bool,
    }

    struct Hyperspace has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPERSPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<HYPERSPACE>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<Hyperspace>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Hyperspace>>(v3, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Hyperspace>>(v2);
    }

    // decompiled from Move bytecode v6
}

