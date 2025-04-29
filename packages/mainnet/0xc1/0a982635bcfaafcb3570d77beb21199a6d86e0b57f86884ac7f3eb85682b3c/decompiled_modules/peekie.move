module 0xc10a982635bcfaafcb3570d77beb21199a6d86e0b57f86884ac7f3eb85682b3c::peekie {
    struct PEEKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEKIE>(arg0, 6, b"PEEKIE", b"PEEKIEONSUI", x"247065656b69652069736e74206a75737420616e6f746865722063727970746f63757272656e63792e2049747320612070726f746573742c2061206469676974616c206465636c61726174696f6e207468617420736f6d65207468696e6773206172652070726963656c6573732e2e2e0a0a576520617265206d616b696e67207468652070726576696f7573206f776e657273207265677265742073656c6c696e6720535549206d6f7374206d656d6561626c652063617421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEEKIE_9d2473ce40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

