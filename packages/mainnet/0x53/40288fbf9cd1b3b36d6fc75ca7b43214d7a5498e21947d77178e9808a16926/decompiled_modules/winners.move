module 0x5340288fbf9cd1b3b36d6fc75ca7b43214d7a5498e21947d77178e9808a16926::winners {
    struct WINNERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNERS>(arg0, 6, b"Winners", b"Winners Dont Use Rug", x"53496d706c6573200a57696e6e65727320646f6e7420757365207275677320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949802388.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINNERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

