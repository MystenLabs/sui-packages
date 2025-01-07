module 0x2419d09c0b3961d4714c87ed85be1afff2ecb903fa8d3b837a5b9eb7a219dbce::butler {
    struct BUTLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTLER>(arg0, 6, b"Butler", b"Donald Trump", b"I'm coming back to butler", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3484_c946f6ada1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

