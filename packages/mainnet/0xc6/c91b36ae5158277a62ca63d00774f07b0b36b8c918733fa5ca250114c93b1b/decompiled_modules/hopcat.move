module 0xc6c91b36ae5158277a62ca63d00774f07b0b36b8c918733fa5ca250114c93b1b::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"HOPCATSUI", x"537569206d656d657320676574207265616479204f63746f62657220313220736f6d656f6e65200a68616e64736f6d652c206174686c657469632c207269636820616e6420736b696e6e792028746861742773206d65292077696c6c206d6f766520796f75206f7574206f6620796f7572207365617473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018210_ac72271278.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

