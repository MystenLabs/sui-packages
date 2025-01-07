module 0x650489f233336b90e8d8f5a7de98c35759c48b910adc0be1046650b8879040bd::mokimeme {
    struct MOKIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKIMEME>(arg0, 6, b"Mokimeme", b"Moki is the memecoin sui", b"Kindly and memorable moki will become part of the sui community in the world following the trend ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036835_3b85ab65ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

