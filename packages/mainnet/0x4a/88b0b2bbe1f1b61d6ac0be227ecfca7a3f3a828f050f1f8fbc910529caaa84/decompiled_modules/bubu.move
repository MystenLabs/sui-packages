module 0x4a88b0b2bbe1f1b61d6ac0be227ecfca7a3f3a828f050f1f8fbc910529caaa84::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BuBu", b"BUBU", x"492077696c6c20626974652e0a244275427520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Twitter_PFP_c3b80d79c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

