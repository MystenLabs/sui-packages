module 0xcd0e75743bfb79b4612975be25ef960e1c6cfc4709a39aec991938d4e2b0e071::bcc8 {
    struct BCC8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCC8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCC8>(arg0, 6, b"BCC8", b"BCC", b"XDBHXCNCVN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5bf20540b18376a0c53adc382eead659_a8b8a08441.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCC8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCC8>>(v1);
    }

    // decompiled from Move bytecode v6
}

