module 0x6b7724fd423fd0109e570d338522862c30bb4486918c83a60182288428326a34::ptrump {
    struct PTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRUMP>(arg0, 6, b"PTRUMP", b"Pepe Trump", x"5468652066726f6720697320696e20616c6c206f662075732e20546869732069732074686520677265617465737420344348414e206d656d65206f6620616c6c2074696d652e2054696d6520746f206d616b652050657065205472756d7020677265617420616761696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PTRUMP_7150c0963d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

