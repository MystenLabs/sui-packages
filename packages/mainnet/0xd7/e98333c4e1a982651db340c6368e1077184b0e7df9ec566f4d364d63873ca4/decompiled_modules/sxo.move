module 0xd7e98333c4e1a982651db340c6368e1077184b0e7df9ec566f4d364d63873ca4::sxo {
    struct SXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXO>(arg0, 6, b"SXO", b"SUI Xterio", b"Powering the future of Web3 and AI Gaming | $80M+ raised ecosystem | ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XTER_ed57236d2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

