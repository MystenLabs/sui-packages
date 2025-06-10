module 0xdc1ba27ea8b9ada87731311925f08b530d7663308bc185b14bbaa7b18761ae::spb {
    struct SPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPB>(arg0, 9, b"SPB", b"Sui Piggybank", b"Just Sui piggybank", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/34d971567e45c8cb52d66fad34f1b880blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

