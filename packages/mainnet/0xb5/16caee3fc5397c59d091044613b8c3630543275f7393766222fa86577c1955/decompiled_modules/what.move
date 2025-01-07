module 0xb516caee3fc5397c59d091044613b8c3630543275f7393766222fa86577c1955::what {
    struct WHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHAT>(arg0, 6, b"WHAT", b"What did you say", b"WHAT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ai_generated_8288688_1280_fb23a8131e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

