module 0xa92588889d9df8842751ebf8900a2775ba4a21363c830b73b41f9e4d2fd00f9f::bts61 {
    struct BTS61 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS61, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS61>(arg0, 6, b"BTS61", b"Biscuits The Seal", b"Biscuits for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045260_6433353e63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS61>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS61>>(v1);
    }

    // decompiled from Move bytecode v6
}

