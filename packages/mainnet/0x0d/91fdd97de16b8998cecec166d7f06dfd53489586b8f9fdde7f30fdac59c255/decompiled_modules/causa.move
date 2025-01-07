module 0xd91fdd97de16b8998cecec166d7f06dfd53489586b8f9fdde7f30fdac59c255::causa {
    struct CAUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAUSA>(arg0, 6, b"CAUSA", b"Causa Sui", b"Ex Unitae ViresEns Causa Sui  Causa do Pepe  $CAUSA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hus_VPHRC_400x400_8ac1bfa52c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

