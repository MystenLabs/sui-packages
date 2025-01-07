module 0x46af93d499b5c882b3b37c26ab06718111f71bfcd82a43607d83ebc5612f8d81::ghal {
    struct GHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHAL>(arg0, 6, b"GHAL", b"Ghost Halloween", b"The Ghost Halloween token is not just a meme, it offers real utility on the SUI blockchain. Our token provides access to exclusive features and services, enhancing your cryptocurrency experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959906993.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

