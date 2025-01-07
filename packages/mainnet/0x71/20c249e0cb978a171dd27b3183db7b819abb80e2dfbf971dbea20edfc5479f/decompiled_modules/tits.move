module 0x7120c249e0cb978a171dd27b3183db7b819abb80e2dfbf971dbea20edfc5479f::tits {
    struct TITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITS>(arg0, 6, b"TITS", b"wet tits", b"Oh, I'm soaked, I'm so wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/it_f43ce26ac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

