module 0x38f7820320ed4f68e275daf10554e0142eefa8b0212c83a7e74a39ecf69be47d::morud {
    struct MORUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORUD>(arg0, 6, b"MORUD", b"Morud", b"Bullieve in Something and Hodl $MORUD on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_30b3debc5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

