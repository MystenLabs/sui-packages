module 0xf7f97c6e98f48e9482a6c4cdecd6c867f088ae6becbb0dd7af1d04f3de6ea402::blof {
    struct BLOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOF>(arg0, 6, b"BLOF", b"Bloofoster", b"Bloo, once a homeless soul, was rescued from the streets then he goes to foster house where he met his new companions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUE_0dddefc6b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

