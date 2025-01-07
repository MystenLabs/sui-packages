module 0x4f0361c05fd03248dc03c74f0cd0c20fd33d524f7d37227c2183e112c58e20e4::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIt up", b"Whatever you do in life, it isn't legendary unless you're doing it in a SUIte. So SUIte up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitup_092523cd5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

