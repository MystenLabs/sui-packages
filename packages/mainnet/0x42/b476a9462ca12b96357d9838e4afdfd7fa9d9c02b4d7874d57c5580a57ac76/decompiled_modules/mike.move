module 0x42b476a9462ca12b96357d9838e4afdfd7fa9d9c02b4d7874d57c5580a57ac76::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKE>(arg0, 6, b"MIKE", b"Mike", b"Mike will be the king of the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032743_0c256a0b24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

