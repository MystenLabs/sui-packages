module 0x4d92920a34eae4f966bbc9e66c1a8b84222c1c5cecc17763c2c2966181717eb2::mastodon {
    struct MASTODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASTODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASTODON>(arg0, 6, b"Mastodon", b"Petepeter", b"Bitcoin founder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022101_f917ca9f4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASTODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASTODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

