module 0xca2b0a04293d86a2e77dffe1d82245749bf693e584fc8bf4a42914ac6be597a4::briana {
    struct BRIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIANA>(arg0, 6, b"BRIANA", b"brianna dot ai", b"just stop..if you're not buying i'm not interested.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250115_171942_933_4364491798.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

