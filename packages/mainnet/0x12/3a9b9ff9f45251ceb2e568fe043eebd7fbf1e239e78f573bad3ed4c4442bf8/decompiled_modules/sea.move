module 0x123a9b9ff9f45251ceb2e568fe043eebd7fbf1e239e78f573bad3ed4c4442bf8::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"Suifaring World", x"224966207765207361766520746865205365612c2077652073617665206f757220576f726c64222e20537569466172696e6720576f726c6420285345412920697320616e20656e7669726f6e6d656e74616c6c792064726976656e2063727970746f63757272656e63792070726f6a656374206f7065726174696e67206f6e20746865200a53554920626c6f636b636861696e20696e73706972656420627920746865204a6170616e657365206d65616e696e67206f6620225375692220287761746572292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757786199966.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

