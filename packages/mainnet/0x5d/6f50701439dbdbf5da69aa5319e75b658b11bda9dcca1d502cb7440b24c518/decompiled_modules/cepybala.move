module 0x5d6f50701439dbdbf5da69aa5319e75b658b11bda9dcca1d502cb7440b24c518::cepybala {
    struct CEPYBALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPYBALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPYBALA>(arg0, 6, b"CEPYBALA", b"CEPYBALA SUIBALA", b"Where Memes Meet Moonshots !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_235327_0341edb0f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPYBALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPYBALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

