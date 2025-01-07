module 0xbe3530566e113a131159b85c07b473f8b8fef2700a1b32b35b9e13fe83b0df5b::nope {
    struct NOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOPE>(arg0, 9, b"NOPE", b"NOPE", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/nope-speech-bubble-text-talk-shape-vector-illustration-yellow-hand-drawn-quote-fashion-patch-badge-sticker-pin-icon-chat-slang-261961439.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

