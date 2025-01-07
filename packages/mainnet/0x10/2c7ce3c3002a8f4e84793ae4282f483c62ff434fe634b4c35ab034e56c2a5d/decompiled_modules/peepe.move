module 0x102c7ce3c3002a8f4e84793ae4282f483c62ff434fe634b4c35ab034e56c2a5d::peepe {
    struct PEEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPE>(arg0, 6, b"PEEPE", b"Peepe", x"496e74726f647563696e6720506565706520746865206d656d6520636f696e206d616b696e67207761766573206f6e207468652053756920626c6f636b636861696e2120200a0a496e73706972656420627920506570652c205065657065206272696e6773206c617567687320616e64206c69717569642061737365747320746f207468652063727970746f20706f6f6c2e204469766520696e746f207468652050656570652073747265616d20616e642072696465207468652063757272656e7420746f206d656d6520676c6f727921200a0a4f6e6c79206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Peepet_1775446df4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

