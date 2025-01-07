module 0x5e340261d3ba740a0b16a317fb32c405d0067c6aeebaa7259b548872b5445e41::edm {
    struct EDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDM>(arg0, 6, b"EDM", b"Electric Dog Modish", b"$EDM, inspiring community to remember $DOGE through music", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vu_XA_s_DK_400x400_3a1b2b86a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

