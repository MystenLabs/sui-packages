module 0x4c9f4650b3b3075dcb589c76fc7b9346b25104c5d0bc759ed983b60ca1b99c2e::slapee {
    struct SLAPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAPEE>(arg0, 6, b"Slapee", b"Salpee", b"Slap pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731242427154.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLAPEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAPEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

