module 0x6fc74d5c93fa931b3de170edf6c63f000c8e47120e3a18d7b4e907c027819fdc::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"JESUS", b"Jesus the Messiah", b"Ascension of Jesus with Christmas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/110000757933596_f0d8c72c6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

