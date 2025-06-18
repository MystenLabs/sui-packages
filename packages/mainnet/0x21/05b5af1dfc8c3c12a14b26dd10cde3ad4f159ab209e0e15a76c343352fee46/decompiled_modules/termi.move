module 0x2105b5af1dfc8c3c12a14b26dd10cde3ad4f159ab209e0e15a76c343352fee46::termi {
    struct TERMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMI>(arg0, 6, b"TERMI", b"TermiAi", x"5445524d49204d656d6520636f696e207769746820746865207374726f6e676573740a5465726d696e61746f72206f6e2073756920436861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicbp7xkqgcdsc7xndbhgbqnfomfld77pd2vxxserd4656z6m4k66y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

