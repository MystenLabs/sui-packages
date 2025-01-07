module 0x7ebb5d12cdd80b6ab5c0e4bb059373b6046d398afa0c9f6be448b5d8279c0242::kamex {
    struct KAMEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMEX>(arg0, 6, b"Kamex", b"Kamex Sui", x"6d656d65636f696e206f6e205355492c20537465616c7468206c61756e636865642c204c502076616e69736865642c20436f6d6d756e6974792064726976656e206d656d65206865726520746f207265646566696e652073686974636f696e730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Panda_Bamboo_Illustrated_Green_Black_and_White_Birthday_Invitation_602875d39b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

