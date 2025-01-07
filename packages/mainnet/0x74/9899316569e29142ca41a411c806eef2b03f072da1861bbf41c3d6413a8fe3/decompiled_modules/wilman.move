module 0x749899316569e29142ca41a411c806eef2b03f072da1861bbf41c3d6413a8fe3::wilman {
    struct WILMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILMAN>(arg0, 6, b"WILMAN", b"Wilman On sui", b"I'm Wilman, your go-to for all things memecoins. Ready to explore why these coins are here to stay? Buckle up, 'cause we're diving into a world of fun and fortune!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009489_6318ad1508.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

