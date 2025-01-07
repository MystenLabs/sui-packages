module 0x5010c3fa6157046a8c815f1d340f2420583cc0ca9bedf4991a6a4f767e101b4::ikun {
    struct IKUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKUN>(arg0, 6, b"IKUN", b"Sui KUN", b"Chicken, you're too beautiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kunji_4a0eb70943.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

