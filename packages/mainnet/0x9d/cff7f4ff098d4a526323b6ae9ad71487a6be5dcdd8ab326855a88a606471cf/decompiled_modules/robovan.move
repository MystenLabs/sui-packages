module 0x9dcff7f4ff098d4a526323b6ae9ad71487a6be5dcdd8ab326855a88a606471cf::robovan {
    struct ROBOVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOVAN>(arg0, 6, b"Robovan", b"Tesla Robovan", b"The future is autonomous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/robovan_facb49f9a7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

