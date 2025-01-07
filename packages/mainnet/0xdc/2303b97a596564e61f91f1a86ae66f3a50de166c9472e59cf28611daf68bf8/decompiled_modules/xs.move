module 0xdc2303b97a596564e61f91f1a86ae66f3a50de166c9472e59cf28611daf68bf8::xs {
    struct XS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XS>(arg0, 6, b"Xs", b"Xrpsanta", b"Santa coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000876944_14bfe97ba0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XS>>(v1);
    }

    // decompiled from Move bytecode v6
}

