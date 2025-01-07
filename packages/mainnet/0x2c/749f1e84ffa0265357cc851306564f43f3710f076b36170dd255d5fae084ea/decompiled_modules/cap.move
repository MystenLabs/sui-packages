module 0x2c749f1e84ffa0265357cc851306564f43f3710f076b36170dd255d5fae084ea::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 6, b"CAP", b"CAPIBARNIA", x"496d20746865207065616b206f662065766f6c7574696f6e20796f7520617265206a757374206120636170696261726e69610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAP_TJ_Wt_BN_u_P_Ijoy_MN_9_VM_9_bdae1000b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

