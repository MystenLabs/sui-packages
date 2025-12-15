module 0xc87a5215694ce6de7baddaaefd786dab6aa0a846f1be1805c8663faa73f9a3ad::lc {
    struct LC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LC>(arg0, 6, b"LC", b"LeonCoin", b"Just a coin minted by Leon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_06_02_125031_9d98ef8b13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LC>>(v1);
    }

    // decompiled from Move bytecode v6
}

