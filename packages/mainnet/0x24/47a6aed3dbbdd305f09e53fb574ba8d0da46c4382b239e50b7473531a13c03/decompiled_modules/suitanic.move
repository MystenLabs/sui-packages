module 0x2447a6aed3dbbdd305f09e53fb574ba8d0da46c4382b239e50b7473531a13c03::suitanic {
    struct SUITANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITANIC>(arg0, 6, b"SUITANIC", b"Sui Titanic", b"Sailing through the Sui Network with style. Just watch out for any icebergs! $SUITANIC is built to turn heads, not crash into them. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_81_8940a0844e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITANIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITANIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

