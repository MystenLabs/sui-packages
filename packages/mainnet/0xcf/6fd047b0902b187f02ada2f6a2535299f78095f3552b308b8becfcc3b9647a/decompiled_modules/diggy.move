module 0xcf6fd047b0902b187f02ada2f6a2535299f78095f3552b308b8becfcc3b9647a::diggy {
    struct DIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGGY>(arg0, 6, b"DIGGY", b"TURBO DIGGY", x"57652061726520686f6e6f72656420746f2070726573656e7420746f20796f7520545552424f20444947475920e28093205468652053656e736174696f6e206f66205355492e0a200a47657420726561647920666f7220545552424f2044494747592c20746865206d656d6520746f6b656e20746861742077696c6c20626520726f6172696e67207468726f75676820535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963396871.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

