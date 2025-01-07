module 0x959ee4d2189943d0e20e562b94f48a771e1fe88ea35284ba0ae5c7cd2905ecd5::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"Bubl", x"4255424c20f09faba7", x"427562626c696e67206f6e200a405375694e6574776f726b0a20746f206d616b65206672656e732e20436f6d696e6720736f6f6e2e20687474703a2f2f742e6d652f6275626c737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954523105.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

