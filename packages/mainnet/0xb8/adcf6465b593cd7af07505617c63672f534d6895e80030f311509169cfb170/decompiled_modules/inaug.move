module 0xb8adcf6465b593cd7af07505617c63672f534d6895e80030f311509169cfb170::inaug {
    struct INAUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: INAUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INAUG>(arg0, 6, b"INAUG", b"Official Inauguration Meme", b"It's clear who the king of the sea is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_031327_827_a8ac9f669f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INAUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INAUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

