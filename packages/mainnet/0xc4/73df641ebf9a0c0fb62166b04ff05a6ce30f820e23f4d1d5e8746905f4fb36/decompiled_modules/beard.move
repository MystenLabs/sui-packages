module 0xc473df641ebf9a0c0fb62166b04ff05a6ce30f820e23f4d1d5e8746905f4fb36::beard {
    struct BEARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARD>(arg0, 6, b"BEARD", b"BEARDED", x"57652061726520686f6e6f72656420746f2070726573656e7420746f20796f75204245415244454420e28093205468652053656e736174696f6e206f66205355492120200a200a47657420726561647920666f7220424541524445442c20746865206d656d6520746f6b656e20746861742077696c6c20626520726f6172696e67207468726f756768205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958313935.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

