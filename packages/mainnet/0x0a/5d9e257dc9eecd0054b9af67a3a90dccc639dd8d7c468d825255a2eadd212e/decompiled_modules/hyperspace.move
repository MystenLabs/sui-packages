module 0xa5d9e257dc9eecd0054b9af67a3a90dccc639dd8d7c468d825255a2eadd212e::hyperspace {
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

