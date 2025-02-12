module 0xc0259b2d7a532b9cd82427e175705910e6f57045e114496596a82f6e72460d64::est35 {
    struct EST35 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST35, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST35>(arg0, 6, b"EST35", b"dnmsd", b"sfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1739371973296-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST35>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST35>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

