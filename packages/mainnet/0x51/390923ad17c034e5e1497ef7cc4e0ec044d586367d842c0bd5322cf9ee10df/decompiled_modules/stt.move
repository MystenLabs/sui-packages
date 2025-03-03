module 0x51390923ad17c034e5e1497ef7cc4e0ec044d586367d842c0bd5322cf9ee10df::stt {
    struct STT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STT>(arg0, 9, b"STT", b"Settrade", b"Settrade stock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9a575472d553fbb8313c1d959ebf587cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

