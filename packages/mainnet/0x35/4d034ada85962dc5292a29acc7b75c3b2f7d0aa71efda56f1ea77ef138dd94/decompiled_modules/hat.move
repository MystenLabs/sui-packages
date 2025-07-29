module 0x354d034ada85962dc5292a29acc7b75c3b2f7d0aa71efda56f1ea77ef138dd94::hat {
    struct HAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAT>(arg0, 6, b"HAT", b"Horse Aff Traffy", b"HAT HAT is the value of the future, when you want to grow chaos in a certain way without reducing the decline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mg_Io_Ixc_X_400x400_8a6037e4d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

