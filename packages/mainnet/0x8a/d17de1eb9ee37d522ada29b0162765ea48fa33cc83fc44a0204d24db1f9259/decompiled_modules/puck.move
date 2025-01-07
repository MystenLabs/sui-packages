module 0x8ad17de1eb9ee37d522ada29b0162765ea48fa33cc83fc44a0204d24db1f9259::puck {
    struct PUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCK>(arg0, 6, b"PUCK", b"Puck", b"Hi, Im Puck, I try to make a duck faces but end up looking meme-worthy instead.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puc_b40af733e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

