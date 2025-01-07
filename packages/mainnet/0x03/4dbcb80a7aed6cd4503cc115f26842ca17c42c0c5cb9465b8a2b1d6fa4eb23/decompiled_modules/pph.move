module 0x34dbcb80a7aed6cd4503cc115f26842ca17c42c0c5cb9465b8a2b1d6fa4eb23::pph {
    struct PPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPH>(arg0, 6, b"PPH", b"popoha", b"A zoo animal that brings joy to people, although it looks strange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d66a14c188972893170d6b08b04cf47_0fd592372d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

