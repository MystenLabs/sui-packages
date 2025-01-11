module 0xb0b35bde43c8f45569334b454de90315f4ebfc35902103c3b462e956ea8b717a::aria {
    struct ARIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIA>(arg0, 6, b"Aria", b"ARIA SHOW LIVE", b"i love to talk crypto, games, and memes. nothing i say is financial advice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_054507_752_6b55b4d37a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

