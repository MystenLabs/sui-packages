module 0xa4e248e8401cb0d59a56229ef37f1757f3e4988e772e7955fdfcbe4891412468::deecho {
    struct DEECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEECHO>(arg0, 6, b"DEECHO", b"DeEcho Coin", x"446563656e7472616c697a65642d414920536f6369616c0a50726f746f636f6c20262044617461204d696e6520427920537569204e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihrfufegbqywfhbwts4l3aarxmfe4ivexgwiiasehujclh5ojm37u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEECHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEECHO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

